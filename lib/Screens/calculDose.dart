import 'package:flutter/material.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/cubit/doses_cubit.dart';
import 'package:graduation/cubit/medics_cubit.dart';
import 'package:graduation/cubit/patient_cubit.dart';
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
  DateTime doseCreated;
  

  _submit(BuildContext context) {
    final doseCubit = context.bloc<DosesCubit>();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      doseCreated = DateTime.now();
      final doseT = DosesCompanion(
          medicid: moor.Value(selectedMedic.medicID),
          patientid: moor.Value(selectedPatient.patientID),
          posolgie: moor.Value(posologie),
          date: moor.Value(doseCreated)
          );
      doseCubit.doseDao.insertDose(doseT);
    }

    

    print(
        '${selectedPatient.patientID}, ${selectedPatient.nom}, ${selectedMedic.medicID}, $posologie, $doseCreated');
  }

  @override
  Widget build(BuildContext context) {
    final patientCubit = context.bloc<PatientCubit>();
    final medicCubit = context.bloc<MedicsCubit>();
    final doseCubit = context.bloc<DosesCubit>();
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
          child:
              BlocConsumer<DosesCubit, DosesState>(listener: (context, state) {
            if (state is ModalBottom) {
              double doseAdministrer = selectedPatient.surface * posologie;
              double volumeFinal = doseAdministrer / selectedMedic.cI;
              int nbrFlacons = volumeFinal ~/ selectedMedic.presentation;
              double reliquat = (nbrFlacons* selectedMedic.presentation) - volumeFinal;
              double minPoche = doseAdministrer / selectedMedic.cMax;
              double maxPoche = doseAdministrer / selectedMedic.cMin;  

              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return DraggableScrollableSheet(
                        initialChildSize: 0.65,
                        maxChildSize: 1,
                        minChildSize: 0.5,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        text(
                                            'La dose a administrer est: $doseAdministrer mg',
                                            textColor: t5DarkNavy,
                                            fontSize: textSizeSMedium,
                                            fontFamily: fontMedium),
                                        text(
                                            'Le Volume Final est: $volumeFinal ml',
                                            textColor: t5DarkNavy,
                                            fontSize: textSizeSMedium,
                                            fontFamily: fontMedium),
                                        text(
                                            'Vous Avez Besoin de: $nbrFlacons flacons de ${selectedMedic.medicNom}',
                                            textColor: t5DarkNavy,
                                            fontSize: textSizeSMedium,
                                            fontFamily: fontMedium),
                                        text(
                                            'Le reliquat de cette preparation est: $reliquat',
                                            textColor: t5DarkNavy,
                                            fontSize: textSizeSMedium,
                                            fontFamily: fontMedium),
                                      text(
                                            'La poche utilise doit etre entre: $minPoche et $maxPoche',
                                            textColor: t5DarkNavy,
                                            fontSize: textSizeSMedium,
                                            fontFamily: fontMedium)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  });
            }
          }, builder: (context, state) {
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
                              doseCubit.moveStateToBottom();
                              _submit(context);
                            },
                          ),
                        ),
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
