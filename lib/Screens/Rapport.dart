import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/doses_cubit.dart';
import 'package:graduation/cubit/reliquats_cubit.dart';
import 'package:graduation/data/moor_database.dart';

class Rapport extends StatefulWidget {
  @override
  _RapportState createState() => _RapportState();
}

class _RapportState extends State<Rapport> {
  static DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  @override
  Widget build(BuildContext context) {
    final doseCubit = context.bloc<DosesCubit>();
    final reliquatCubit = context.bloc<ReliquatsCubit>();
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    return Scaffold(
      backgroundColor: t5DarkNavy,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 70,
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 16),
                      text("Rapport Fin Journee",
                          textColor: t5White,
                          fontSize: textSizeNormal,
                          fontFamily: fontMedium)
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 100),
              child: Container(
                padding: EdgeInsets.only(top: 28),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: t5LayoutBackgroundWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: boxDecoration(
                              radius: 10, showShadow: true, bgColor: t5White),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: width / 7,
                                  width: width / 7,
                                  margin: EdgeInsets.only(bottom: 4, top: 8),
                                  padding: EdgeInsets.all(width / 30),
                                  decoration: boxDecoration(
                                      bgColor: t5ColorPrimaryDark, radius: 10),
                                  child: FutureBuilder<int>(
                                    future:
                                        doseCubit.doseDao.getUsedMedicsToday(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      if (snapshot.hasData) {
                                        return text("${snapshot.data}",
                                            fontFamily: fontBold,
                                            fontSize: textSizeMedium,
                                            textColor: t5White,
                                            isCentered: true);
                                      }
                                      return SizedBox(height: 0.1);
                                    },
                                  )),
                              text("Medicament Utilise",
                                  fontSize: textSizeMedium,
                                  fontFamily: fontBold)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: BlocBuilder<ReliquatsCubit, ReliquatsState>(
                          builder: (context, state) {
                            if (state is ReliquatsInitial) {
                              return StreamBuilder(
                                stream: reliquatCubit.reliquatDao.watchStats(),
                                builder: (context,
                                    AsyncSnapshot<List<ReliquatWithMedics>>
                                        snapshot) {
                                  final stats = snapshot.data ?? List();
                                  return ListView.builder(
                                    itemCount: stats.length,
                                    itemBuilder: (_, index) {
                                      final itemStat = stats[index];
                                      return buildStat(
                                          context,
                                          itemStat,
                                          reliquatCubit.reliquatDao,
                                          stats.length);
                                    },
                                  );
                                },
                              );
                            }
                            return StreamBuilder(
                              stream: reliquatCubit.reliquatDao.watchStats(),
                              builder: (context,
                                  AsyncSnapshot<List<ReliquatWithMedics>>
                                      snapshot) {
                                final stats = snapshot.data ?? List();
                                return ListView.builder(
                                  itemCount: stats.length,
                                  itemBuilder: (_, index) {
                                    final itemStat = stats[index];
                                    return buildStat(
                                        context,
                                        itemStat,
                                        reliquatCubit.reliquatDao,
                                        stats.length);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildStat(BuildContext context, ReliquatWithMedics itemStat,
    ReliquatDao reliquatDao, int value) {
  final reliquatCubit = context.bloc<ReliquatsCubit>();
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      decoration: boxDecoration(radius: 16, showShadow: true),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text(
                  "Medicament",
                  textColor: t5TextColorPrimary,
                  fontSize: textSizeMedium,
                  fontFamily: fontSemibold,
                ),
                Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration:boxDecoration(bgColor: t5SkyBlue, radius: 16),
                              child: text("${itemStat.medic.medicNom}", fontSize: textSizeMedium, textColor: t5White),
                            ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text(
                  "Reliquat",
                  textColor: t5TextColorPrimary,
                  fontSize: textSizeMedium,
                  fontFamily: fontSemibold,
                ),
                FutureBuilder<double>(
                    future: reliquatCubit.reliquatDao.getSum(itemStat.medic),
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration:
                              boxDecoration(bgColor: t5DarkRed, radius: 16),
                          child: text("${snapshot.data.toStringAsFixed(2)} ml",
                              fontSize: textSizeMedium, textColor: t5White),
                        );
                      }
                      return SizedBox(
                        height: 1,
                      );
                    },
                  )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


