import 'package:flutter/material.dart';
import 'package:graduation/Screens/Doses.dart';
import 'package:graduation/Screens/T5Images.dart';
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

class CalculDose extends StatefulWidget {
  @override
  _CalculDoseState createState() => _CalculDoseState();
}

class _CalculDoseState extends State<CalculDose> {
  final _formKey = GlobalKey<FormState>();
  String nomPatient = "";
  String nomMedicament = "";
  int posologie = 0;
  Patient selectedPatient;
  Medic selectedMedic;
  Reliquat selectedReliquat;
  double reliquat;
  double doseAdministrer;
  double volumeFinal;
  double volumeFinalInternal;
  int nbrFlacons;
  double minPoche;
  double maxPoche;

  DateTime doseCreated;

  _submit(BuildContext context) {
    final doseCubit = context.bloc<DosesCubit>();
    final reliquatCubit = context.bloc<ReliquatsCubit>();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      doseCreated = DateTime.now();
      final doseT = DosesCompanion(
          medicid: moor.Value(selectedMedic.medicID),
          patientid: moor.Value(selectedPatient.patientID),
          posolgie: moor.Value(posologie),
          date: moor.Value(doseCreated));
      doseCubit.doseDao.insertDose(doseT);
    }

    doseAdministrer = selectedPatient.surface * posologie;
    volumeFinal = doseAdministrer / selectedMedic.cI;
    volumeFinalInternal = volumeFinal;
    int numFlacon() {
      int nbrflacons = 0;
      while (nbrflacons * selectedMedic.presentation < volumeFinal) {
        nbrflacons++;
      }

      return nbrflacons;
    }

    nbrFlacons = numFlacon();
    reliquat = (nbrFlacons * selectedMedic.presentation) - volumeFinalInternal;
    minPoche = doseAdministrer / selectedMedic.cMax;
    maxPoche = doseAdministrer / selectedMedic.cMin;

    if (reliquat > 0) {
      final reliquatT = ReliquatsCompanion(
        medicid: moor.Value(selectedMedic.medicID),
        date: moor.Value(
            doseCreated.add(Duration(hours: selectedMedic.stabilite.toInt()))),
        quantite: moor.Value(reliquat),
      );
      reliquatCubit.reliquatDao.insertReliquat(reliquatT);
    }

    print(
        '${selectedPatient.patientID}, ${selectedPatient.nom}, ${selectedMedic.medicID}, $posologie, $doseCreated');
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
          'Calculer Une Dose',
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: BlocBuilder<DosesCubit, DosesState>(builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: boxDecorationT6(
                              radius: 12, showShadow: true, bgColor: t6white),
                          child: StreamBuilder<List<Patient>>(
                            stream: patientCubit.patientDao.watchAllPatients(),
                            builder: (context, snapshot) {
                              final patients = snapshot.data ?? List();

                              DropdownMenuItem<Patient> dropdownFromPatient(
                                  Patient patient) {
                                return DropdownMenuItem(
                                  value: patient,
                                  child: text(
                                      '${patient.nom} ${patient.prenom}',
                                      textColor: t5DarkNavy,
                                      fontSize: textSizeSMedium,
                                      fontFamily: fontMedium),
                                );
                              }

                              final dropdownMenuItems = patients
                                  .map(
                                      (patient) => dropdownFromPatient(patient))
                                  .toList();

                              return Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: DropdownButtonFormField(
                                  onChanged: (Patient patient) {
                                    setState(() {
                                      selectedPatient = patient;
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
                                  value: selectedPatient,
                                  items: dropdownMenuItems,
                                  validator: (input) => selectedPatient == null
                                      ? 'SVP SELECTIONEZ LE PATIENT'
                                      : null,
                                  onSaved: (input) => selectedPatient = input,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: boxDecorationT6(
                              radius: 12, showShadow: true, bgColor: t6white),
                          child: StreamBuilder<List<Medic>>(
                            stream: medicCubit.medicDao.watchAllMedics(),
                            builder: (context, snapshot) {
                              final medics = snapshot.data ?? List();

                              DropdownMenuItem<Medic> dropdownFromMedic(
                                  Medic medic) {
                                return DropdownMenuItem(
                                  value: medic,
                                  child: text(medic.medicNom,
                                      textColor: t5DarkNavy,
                                      fontSize: textSizeSMedium,
                                      fontFamily: fontMedium),
                                );
                              }

                              final dropdownMenuItems = medics
                                  .map((medic) => dropdownFromMedic(medic))
                                  .toList();

                              return Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: DropdownButtonFormField(
                                  onChanged: (Medic medic) {
                                    setState(() {
                                      selectedMedic = medic;
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
                                  value: selectedMedic,
                                  items: dropdownMenuItems,
                                  validator: (input) => selectedMedic == null
                                      ? 'SVP SELECTIONEZ LE MEDICAMENT'
                                      : null,
                                  onSaved: (input) => selectedMedic = input,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: boxDecorationT6(
                              radius: 12, showShadow: true, bgColor: t6white),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: textSizeMedium,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(26, 18, 4, 18),
                              hintText: "Posologie",
                              suffixText: 'mg/m²',
                              filled: true,
                              fillColor: t6white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: t6white, width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    color: t6white, width: 0.0),
                              ),
                            ),
                            validator: (input) => input.trim().isEmpty
                                ? 'Svp Entrez la Posolgie'
                                : null,
                            onSaved: (input) => posologie = int.parse(input),
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
                              'Calculer',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setModalState) {
                                      return DraggableScrollableSheet(
                                          initialChildSize: 0.65,
                                          maxChildSize: 1,
                                          minChildSize: 0.5,
                                          builder: (context, scrollController) {
                                            return Container(
                                              padding: EdgeInsets.only(top: 24),
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  color:
                                                      t5LayoutBackgroundWhite,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  24),
                                                          topRight:
                                                              Radius.circular(
                                                                  24))),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child:
                                                          SingleChildScrollView(
                                                        controller:
                                                            scrollController,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      top: 16,
                                                                      right:
                                                                          16),
                                                              decoration:
                                                                  boxDecoration(
                                                                      radius:
                                                                          16,
                                                                      showShadow:
                                                                          true,
                                                                      bgColor:
                                                                          t6white),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        16.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    text(
                                                                        'La dose a administrer:',
                                                                        textColor:
                                                                            t6textColorPrimary,
                                                                        fontFamily:
                                                                            fontMedium),
                                                                    text(
                                                                      ' ${doseAdministrer.toStringAsFixed(doseAdministrer.truncateToDouble() == doseAdministrer ? 0 : 2)} mg',
                                                                      textColor:
                                                                          t5DarkRed,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      top: 16,
                                                                      right:
                                                                          16),
                                                              decoration:
                                                                  boxDecoration(
                                                                      radius:
                                                                          16,
                                                                      showShadow:
                                                                          true,
                                                                      bgColor:
                                                                          t6white),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        16.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    text(
                                                                        'Le Volume Final:',
                                                                        textColor:
                                                                            t6textColorPrimary,
                                                                        fontFamily:
                                                                            fontMedium),
                                                                    text(
                                                                      ' ${volumeFinal.toStringAsFixed(volumeFinal.truncateToDouble() == volumeFinal ? 0 : 3)} ml',
                                                                      textColor:
                                                                          t5DarkRed,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      top: 16,
                                                                      right:
                                                                          16),
                                                              decoration:
                                                                  boxDecoration(
                                                                      radius:
                                                                          16,
                                                                      showShadow:
                                                                          true,
                                                                      bgColor:
                                                                          t6white),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        16.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        text(
                                                                            'Nombre de flacons necessaire',
                                                                            textColor:
                                                                                t6textColorPrimary,
                                                                            fontFamily:
                                                                                fontMedium),
                                                                        text('',
                                                                            textColor:
                                                                                t6textColorPrimary,
                                                                            fontFamily:
                                                                                fontMedium),
                                                                      ],
                                                                    ),
                                                                    text(
                                                                      ' ${nbrFlacons.toStringAsFixed(nbrFlacons.truncateToDouble() == nbrFlacons ? 0 : 3)} flacons de ${selectedMedic.medicNom}',
                                                                      textColor:
                                                                          t5DarkRed,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      top: 16,
                                                                      right:
                                                                          16),
                                                              decoration:
                                                                  boxDecoration(
                                                                      radius:
                                                                          16,
                                                                      showShadow:
                                                                          true,
                                                                      bgColor:
                                                                          t6white),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        16.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    text(
                                                                        'Reliquat:',
                                                                        textColor:
                                                                            t6textColorPrimary,
                                                                        fontFamily:
                                                                            fontMedium),
                                                                    text(
                                                                      ' ${reliquat.toStringAsFixed(reliquat.truncateToDouble() == reliquat ? 0 : 3)} ml',
                                                                      textColor:
                                                                          t5DarkRed,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      top: 16,
                                                                      right:
                                                                          16),
                                                              decoration:
                                                                  boxDecoration(
                                                                      radius:
                                                                          16,
                                                                      showShadow:
                                                                          true,
                                                                      bgColor:
                                                                          t6white),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        16.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    text(
                                                                        'La poche',
                                                                        textColor:
                                                                            t6textColorPrimary,
                                                                        fontFamily:
                                                                            fontMedium),
                                                                    text(
                                                                      '[${minPoche.toStringAsFixed(0)}, ${maxPoche.toStringAsFixed(0)}] ml',
                                                                      textColor:
                                                                          t5DarkRed,
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
                                  });

                              _submit(context);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          height: 60.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: t5DarkRed,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: FlatButton(
                            child: Text(
                              'Liste des Doses Précédentes',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DosesScreen(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
