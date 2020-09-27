import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Screens/Medics.dart';
import 'package:graduation/Screens/Patients.dart' as pat;
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/dashboard.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/medics_cubit.dart';
import 'package:graduation/cubit/reliquats_cubit.dart';
import 'package:graduation/data/moor_database.dart';

class Reliquats extends StatefulWidget {
  @override
  _ReliquatsState createState() => _ReliquatsState();
  
}

class _ReliquatsState extends State<Reliquats> {
  var pages = [Dashboard(), pat.Patients(), Medicaments()];
  
  @override
  Widget build(BuildContext context) {
    final reliquatCubit = context.bloc<ReliquatsCubit>();
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    return Stack(
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
                  text("Les Reliquats",
                      textColor: t5White,
                      fontSize: textSizeNormal,
                      fontFamily: fontMedium)
                ],
              ),
              /* SvgPicture.asset(
                    t5_options,
                    width: 25,
                    height: 25,
                    color: t5White,
                  )*/
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: BlocBuilder<ReliquatsCubit, ReliquatsState>(
                      builder: (context, state) {
                        if (state is ReliquatsInitial) {
                          return StreamBuilder(
                            stream: reliquatCubit.reliquatDao.watchAllReliquats(),
                            builder: (context,
                                AsyncSnapshot<List<ReliquatWithMedics>> snapshot) {
                              final reliquats = snapshot.data ?? List();
                              return ListView.builder(
                                itemCount: reliquats.length,
                                itemBuilder: (_, index) {
                                  final itemReliquat = reliquats[index];
                                  return buildReliquat(context, itemReliquat,
                                      reliquatCubit.reliquatDao, reliquats.length);
                                },
                              );
                            },
                          );
                        }
                        return StreamBuilder(
                          stream: reliquatCubit.reliquatDao.watchAllReliquats(),
                          builder:
                              (context, AsyncSnapshot<List<ReliquatWithMedics>> snapshot) {
                            final reliquats = snapshot.data ?? List();
                            return ListView.builder(
                              itemCount: reliquats.length,
                              itemBuilder: (_, index) {
                                final itemReliquat = reliquats[index];
                                return buildReliquat(context, itemReliquat,
                                    reliquatCubit.reliquatDao, reliquats.length);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildReliquat(BuildContext context, ReliquatWithMedics itemReliquat,
    ReliquatDao reliquatDao, int value) {
      
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      children: <Widget>[
        Container(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => null,
                ),
              ),
              title: Text(
                '${itemReliquat.medic.medicNom} ${itemReliquat.reliquat.quantite} ml',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: textSizeMedium),
              ),
              subtitle: Text(
                  'Expire le ${itemReliquat.reliquat.date}'),
            ),
          ),
        ),
      ],
    ),
  );
}
