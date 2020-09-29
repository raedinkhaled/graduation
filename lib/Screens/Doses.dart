import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation/Screens/Medics.dart';
import 'package:graduation/Screens/Patients.dart' as pat;
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/dashboard.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/doses_cubit.dart';
import 'package:graduation/cubit/medics_cubit.dart';
import 'package:graduation/cubit/reliquats_cubit.dart';
import 'package:graduation/data/moor_database.dart';

class DosesScreen extends StatefulWidget {
  @override
  _DosesScreenState createState() => _DosesScreenState();
}

class _DosesScreenState extends State<DosesScreen> {
  @override
  Widget build(BuildContext context) {
    final doseCubit = context.bloc<DosesCubit>();
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
                      text("Historique Des Doses Calculé",
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
                                stream: doseCubit.doseDao.watchAllDoses(),
                                builder: (context,
                                    AsyncSnapshot<
                                            List<DoseWithMedicsAndPatients>>
                                        snapshot) {
                                  final doses = snapshot.data ?? List();
                                  return ListView.builder(
                                    itemCount: doses.length,
                                    itemBuilder: (_, index) {
                                      final itemDose = doses[index];
                                      return buildDose(context, itemDose,
                                          doseCubit.doseDao, doses.length);
                                    },
                                  );
                                },
                              );
                            }
                            return StreamBuilder(
                              stream: doseCubit.doseDao.watchAllDoses(),
                              builder: (context,
                                  AsyncSnapshot<List<DoseWithMedicsAndPatients>>
                                      snapshot) {
                                final doses = snapshot.data ?? List();
                                return ListView.builder(
                                  itemCount: doses.length,
                                  itemBuilder: (_, index) {
                                    final itemDose = doses[index];
                                    return buildDose(context, itemDose,
                                        doseCubit.doseDao, doses.length);
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
        ),
      ),
    );
  }
}

Widget buildDose(BuildContext context, DoseWithMedicsAndPatients itemDose,
    DoseDao doseDao, int value) {
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
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return DraggableScrollableSheet(
                          initialChildSize: 0.65,
                          maxChildSize: 1,
                          minChildSize: 0.5,
                          builder: (context, scrollController) {
                            return Container(
                              padding: EdgeInsets.only(top: 24),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: t5LayoutBackgroundWhite,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: t5ViewColor,
                                    width: 50,
                                    height: 3,
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, top: 16, right: 16),
                                              decoration: boxDecoration(
                                                  radius: 16,
                                                  showShadow: true,
                                                  bgColor: t6white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                  children: <Widget>[
                                                    text(
                                                        'Nom:',
                                                        textColor:
                                                            t6textColorPrimary,
                                                        fontFamily: fontMedium),
                                                    text(
                                                      ' ${itemDose.patient.nom}',
                                                      textColor: t5DarkRed,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, top: 16, right: 16),
                                              decoration: boxDecoration(
                                                  radius: 16,
                                                  showShadow: true,
                                                  bgColor: t6white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                  children: <Widget>[
                                                    text(
                                                        'Prenom:',
                                                        textColor:
                                                            t6textColorPrimary,
                                                        fontFamily: fontMedium),
                                                    text(
                                                      ' ${itemDose.patient.prenom}',
                                                      textColor: t5DarkRed,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, top: 16, right: 16),
                                              decoration: boxDecoration(
                                                  radius: 16,
                                                  showShadow: true,
                                                  bgColor: t6white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    text(
                                                        'La dose a administrer:',
                                                        textColor:
                                                            t6textColorPrimary,
                                                        fontFamily: fontMedium),
                                                    text(
                                                      ' ${(itemDose.patient.surface * itemDose.dose.posolgie).toStringAsFixed((itemDose.patient.surface * itemDose.dose.posolgie).truncateToDouble() == (itemDose.patient.surface * itemDose.dose.posolgie) ? 0 : 2)} mg',
                                                      textColor: t5DarkRed,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, top: 16, right: 16),
                                              decoration: boxDecoration(
                                                  radius: 16,
                                                  showShadow: true,
                                                  bgColor: t6white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    text(
                                                        'Volume a Administrer:',
                                                        textColor:
                                                            t6textColorPrimary,
                                                        fontFamily: fontMedium),
                                                    text(
                                                      ' ${((itemDose.patient.surface * itemDose.dose.posolgie) / itemDose.medic.cI).toStringAsFixed(((itemDose.patient.surface * itemDose.dose.posolgie) / itemDose.medic.cI).truncateToDouble() == ((itemDose.patient.surface * itemDose.dose.posolgie) / itemDose.medic.cI) ? 0 : 3)} ml',
                                                      textColor: t5DarkRed,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    });
              },
              title: Text(
                '${itemDose.patient.nom} ${itemDose.patient.prenom}',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: textSizeMedium),
              ),
              subtitle: Text(
                  '${itemDose.medic.medicNom} - Posologie: ${itemDose.dose.posolgie}'),
            ),
          ),
        ),
      ],
    ),
  );
}
