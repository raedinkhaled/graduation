import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/cubit/patient_cubit.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPatientScreen extends StatefulWidget {
  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
  final Patient patient;
  EditPatientScreen({this.patient});
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  TextEditingController _tailleController = TextEditingController();
  TextEditingController _poidsController = TextEditingController();
  TextEditingController _surfaceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String nom = "";
  String prenom = "";
  double taille = 0;
  double poids = 0;
  double surfacecorp = 0;

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      nom = widget.patient.nom;
      prenom = widget.patient.prenom;
      taille = widget.patient.taille;
      poids = widget.patient.poids;
      surfacecorp = widget.patient.surface;

      _tailleController.text = taille.toString();
      _poidsController.text = poids.toString();
    }
    _updateSurface();
  }

  void _updateSurface() {
    setState(() {
      surfacecorp = sqrt((poids * taille) / 3600);
      _surfaceController.text = surfacecorp.toStringAsFixed(2);
    });
  }

  _submit(BuildContext context) {
    final patientCubit = context.bloc<PatientCubit>();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$nom , $prenom , $poids , $taille , $surfacecorp');

      final patienT = PatientsCompanion(
          nom: moor.Value(nom),
          prenom: moor.Value(prenom),
          poids: moor.Value(poids),
          taille: moor.Value(taille),
          surface: moor.Value(surfacecorp));
      if (widget.patient == null) {
        patientCubit.patientDao.insertPatient(patienT);
      } else {
        final updatedPatient = widget.patient.copyWith(
            nom: nom,
            prenom: prenom,
            poids: poids,
            taille: taille,
            surface: surfacecorp);
       patientCubit.patientDao.updatePatient(updatedPatient);
      }
      Navigator.pop(context);
    }
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _tailleController.dispose();
    _poidsController.dispose();
    _surfaceController.dispose();
    super.dispose();
  }

  _delete(BuildContext context) {
    final patientCubit = context.bloc<PatientCubit>();
    patientCubit.patientDao.deletePatient(widget.patient);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: t5DarkNavy ,
        title: Text(
          widget.patient == null ? 'Ajouter Patient' : 'Modifier Patient',
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            decoration: boxDecorationT6(
                                                radius: 12,
                                                showShadow: true,
                                                bgColor: t6white),
                                            child: TextFormField(
                                              style: TextStyle(
                                                fontSize: textSizeMedium,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        26, 18, 4, 18),
                                                hintText: "Nom",
                                                filled: true,
                                                fillColor: t6white,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                      color: t6white,
                                                      width: 0.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                      color: t6white,
                                                      width: 0.0),
                                                ),
                                              ),
                                              validator: (input) => input
                                                      .trim()
                                                      .isEmpty
                                                  ? 'Svp Entrez le Nom du Patient'
                                                  : null,
                                              onSaved: (input) => nom = input,
                                              initialValue: nom,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            decoration: boxDecorationT6(
                                                radius: 12,
                                                showShadow: true,
                                                bgColor: t6white),
                                            child: TextFormField(
                                              style: TextStyle(
                                                fontSize: textSizeMedium,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        26, 18, 4, 18),
                                                hintText: "Prenom",
                                                filled: true,
                                                fillColor: t6white,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                      color: t6white,
                                                      width: 0.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                      color: t6white,
                                                      width: 0.0),
                                                ),
                                              ),
                                              validator: (input) => input
                                                      .trim()
                                                      .isEmpty
                                                  ? 'Svp Entrez le Prenom du Patient'
                                                  : null,
                                              onSaved: (input) =>
                                                  prenom = input,
                                              initialValue: prenom,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 15, right: 5),
                                                  decoration: boxDecorationT6(
                                                      radius: 12,
                                                      showShadow: true,
                                                      bgColor: t6white),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        _poidsController,
                                                    onChanged: (content) {
                                                      setState(() {
                                                        surfacecorp = sqrt((double
                                                                    .parse(
                                                                        content) *
                                                                double.parse(
                                                                    _tailleController
                                                                        .text)) /
                                                            3600);
                                                        _surfaceController
                                                                .text =
                                                            surfacecorp
                                                                .toStringAsFixed(
                                                                    2);
                                                      });
                                                    },
                                                    style: TextStyle(
                                                      fontSize: textSizeMedium,
                                                    ),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              26, 18, 4, 18),
                                                      hintText: "Poids",
                                                      suffixText: 'kg',
                                                      filled: true,
                                                      fillColor: t6white,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: t6white,
                                                                width: 0.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: t6white,
                                                                width: 0.0),
                                                      ),
                                                    ),
                                                    validator: (input) => input
                                                            .trim()
                                                            .isEmpty
                                                        ? 'Svp Entrez le Poids du Patient'
                                                        : null,
                                                    onSaved: (input) => poids =
                                                        double.parse(input),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 15, left: 5),
                                                  decoration: boxDecorationT6(
                                                      radius: 12,
                                                      showShadow: true,
                                                      bgColor: t6white),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        _tailleController,
                                                    onChanged: (content) {
                                                      setState(() {
                                                        surfacecorp = sqrt((double
                                                                    .parse(
                                                                        content) *
                                                                double.parse(
                                                                    _poidsController
                                                                        .text)) /
                                                            3600);
                                                        _surfaceController
                                                                .text =
                                                            surfacecorp
                                                                .toStringAsFixed(
                                                                    2);
                                                      });
                                                    },
                                                    style: TextStyle(
                                                      fontSize: textSizeMedium,
                                                    ),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              26, 18, 4, 18),
                                                      hintText: "Taille",
                                                      suffixText: 'cm',
                                                      filled: true,
                                                      fillColor: t6white,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: t6white,
                                                                width: 0.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: t6white,
                                                                width: 0.0),
                                                      ),
                                                    ),
                                                    validator: (input) => input
                                                            .trim()
                                                            .isEmpty
                                                        ? 'Svp Entrez la Taille du Patient'
                                                        : null,
                                                    onSaved: (input) => taille =
                                                        double.parse(input),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            decoration: boxDecorationT6(
                                                radius: 12,
                                                showShadow: true,
                                                bgColor: t6white),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: _surfaceController,
                                              readOnly: true,
                                              style: TextStyle(
                                                fontSize: textSizeMedium,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        26, 18, 4, 18),
                                                hintText: "Surface Corporelle",
                                                suffixText: 'm²',
                                                filled: true,
                                                fillColor: t6white,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                      color: t6white,
                                                      width: 0.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                      color: t6white,
                                                      width: 0.0),
                                                ),
                                              ),
                                              validator: (input) => input
                                                      .trim()
                                                      .isEmpty
                                                  ? 'Svp Entrez la Taille du Patient'
                                                  : null,
                                              onSaved: (input) => surfacecorp =
                                                  double.parse(input),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            height: 60.0,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: t5ColorPrimaryDark,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            child: FlatButton(
                                              child: Text(
                                                widget.patient == null
                                                    ? 'Ajouter'
                                                    : 'Modifier',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                              onPressed: () => _submit(context),
                                            ),
                                          ),
                                          widget.patient != null
                                              ? Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 0.0),
                                                  height: 60.0,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: t5DarkRed,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0)),
                                                  child: FlatButton(
                                                    child: Text(
                                                      'Supprimer',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0),
                                                    ),
                                                    onPressed: () => _delete(context),
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}