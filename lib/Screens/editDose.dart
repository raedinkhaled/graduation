import 'package:flutter/material.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/doses_cubit.dart';
import 'package:graduation/cubit/medics_cubit.dart';
import 'package:graduation/cubit/patient_cubit.dart';
import 'package:graduation/cubit/reliquats_cubit.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class EditDose extends StatefulWidget {
  @override
  _EditDoseState createState() => _EditDoseState();

  final Patient selectedPatient;
  final Medic selectedMedic;
  final int posologie;
  final double reliquat;
  final DateTime doseCreated;

  final double doseAdministrer;
  final double volumeFinal;
  final int nbrFlacons;
  final double minPoche;
  final double maxPoche;
  EditDose(
      {this.selectedPatient,
      this.selectedMedic,
      this.posologie,
      this.reliquat,
      this.doseCreated,
      this.doseAdministrer,
      this.volumeFinal,
      this.nbrFlacons,
      this.minPoche,
      this.maxPoche,});
}

class _EditDoseState extends State<EditDose> {
  ReliquatWithMedics selectedReliquat;
  double volumeFinalInternal;
  double myReliquat;

  @override
  void initState() {
    volumeFinalInternal = widget.volumeFinal;
    myReliquat = widget.reliquat;
    super.initState();
  }

  _saveIt(){
    final reliquatCubit = context.bloc<ReliquatsCubit>();
    if (myReliquat > 0) {
        final reliquatT = ReliquatsCompanion(
          medicid: moor.Value(widget.selectedMedic.medicID),
          date: moor.Value(widget.doseCreated
              .add(Duration(hours: widget.selectedMedic.stabilite.toInt()))),
          quantite: moor.Value(myReliquat),
        );
        reliquatCubit.reliquatDao.insertReliquat(reliquatT);
      }
      Navigator.pop(context);
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final patientCubit = context.bloc<PatientCubit>();
    final medicCubit = context.bloc<MedicsCubit>();
    final doseCubit = context.bloc<DosesCubit>();
    final reliquatCubit = context.bloc<ReliquatsCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: t5DarkNavy,
        title: Text(
          'Affichage de Dose',
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: BlocBuilder<DosesCubit, DosesState>(builder: (context, state) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                      decoration: boxDecoration(
                          radius: 16, showShadow: true, bgColor: t6white),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text('La dose a administrer:',
                                textColor: t6textColorPrimary,
                                fontFamily: fontMedium),
                            text(
                              ' ${widget.doseAdministrer.toStringAsFixed(widget.doseAdministrer.truncateToDouble() == widget.doseAdministrer ? 0 : 3)} mg',
                              textColor: t5DarkRed,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                      decoration: boxDecoration(
                          radius: 16, showShadow: true, bgColor: t6white),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text('Le Volume Final:',
                                textColor: t6textColorPrimary,
                                fontFamily: fontMedium),
                            text(
                              ' ${widget.volumeFinal.toStringAsFixed(widget.volumeFinal.truncateToDouble() == widget.volumeFinal ? 0 : 3)} ml',
                              textColor: t5DarkRed,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                      decoration: boxDecoration(
                          radius: 16, showShadow: true, bgColor: t6white),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                text('Nombre de flacons necessaire',
                                    textColor: t6textColorPrimary,
                                    fontFamily: fontMedium),
                                text('',
                                    textColor: t6textColorPrimary,
                                    fontFamily: fontMedium),
                              ],
                            ),
                            text(
                              ' ${widget.nbrFlacons.toStringAsFixed(widget.nbrFlacons.truncateToDouble() == widget.nbrFlacons ? 0 : 3)} flacons de ${widget.selectedMedic.medicNom}',
                              textColor: t5DarkRed,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                      decoration: boxDecoration(
                          radius: 16, showShadow: true, bgColor: t6white),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text('Le Reliquat:',
                                textColor: t6textColorPrimary,
                                fontFamily: fontMedium),
                            text(
                              ' ${widget.reliquat.toStringAsFixed(widget.reliquat.truncateToDouble() == widget.reliquat ? 0 : 3)} ml',
                              textColor: t5DarkRed,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                      decoration: boxDecoration(
                          radius: 16, showShadow: true, bgColor: t6white),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text('La poche',
                                textColor: t6textColorPrimary,
                                fontFamily: fontMedium),
                            text(
                          ' [${widget.minPoche.toStringAsFixed(0)},${widget.maxPoche.toStringAsFixed(0)}] ml',
                          textColor: t5DarkRed,
                        )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: text('Utilisez reliquat',
                            textColor: t6textColorPrimary,
                            fontFamily: fontSemibold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: boxDecorationT6(
                          radius: 12, showShadow: true, bgColor: t6white),
                      child: StreamBuilder<List<ReliquatWithMedics>>(
                        stream: reliquatCubit.reliquatDao.watchAllReliquats(),
                        builder: (context, snapshot) {
                          final reliquats = snapshot.data ?? List();

                          DropdownMenuItem<ReliquatWithMedics>
                              dropdownFromReliquat(
                                  ReliquatWithMedics reliquat) {
                            return DropdownMenuItem(
                              value: reliquat,
                              child: text(
                                  '${reliquat.reliquat.quantite} - ${reliquat.reliquat.date}',
                                  textColor: t5DarkNavy,
                                  fontSize: textSizeSMedium,
                                  fontFamily: fontMedium),
                            );
                          }

                          final dropdownMenuItems = reliquats
                              .map((reliquat) => dropdownFromReliquat(reliquat))
                              .toList();

                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: DropdownButtonFormField(
                              onChanged: (ReliquatWithMedics reliquat) {
                                setState(() {
                                  selectedReliquat = reliquat;
                                });
                              },
                              isExpanded: true,
                              isDense: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              value: selectedReliquat,
                              items: dropdownMenuItems,
                              onSaved: (input) => selectedReliquat = input,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: t5ColorPrimaryDark,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: FlatButton(
                        child: Text(
                          'Utiliser',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          final reliquatCubit = context.bloc<ReliquatsCubit>();
                          if (selectedReliquat != null) {
                            reliquatCubit.reliquatDao
                                .deleteReliquat(selectedReliquat.reliquat);
                            setState(() {
                              volumeFinalInternal = volumeFinalInternal -
                                  selectedReliquat.reliquat.quantite;
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: t5DarkNavy,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: FlatButton(
                        child: Text(
                          'Sauvegarder',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          _saveIt();
                        },
                      ),
                    )
                  ],
                ));
          }),
        ),
      ),
    );
  }
}


