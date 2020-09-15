import 'package:flutter/material.dart';
import 'package:graduation/Screens/T5Images.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/dashboard.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/Widgets/ListModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/cubit/patient_cubit.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class Patients extends StatefulWidget {
  @override
  _PatientsState createState() => _PatientsState();

  final Patient mypatient;
  Patients({this.mypatient});
}

class _PatientsState extends State<Patients> {
  var pages = [Dashboard(), Patients()];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String nom = "";
  String prenom = "";
  double taille = 0;
  double poids = 0;
  double surfacecorp = 0;

  _delete() {}

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
      if (widget.mypatient == null) {
        patientCubit.patientDao.insertPatient(patienT);
        //  Provider.of<PatientDao>(context, listen: false).insertPatient(patienT);
      } else {
        final updatedPatient = widget.mypatient.copyWith(
            nom: nom,
            prenom: prenom,
            poids: poids,
            taille: taille,
            surface: surfacecorp);
        //  Provider.of<PatientDao>(context, listen: false)
        //  .updatePatient(updatedPatient);
      }
      Navigator.pop(context);
    }
  }

  List<Category> mFavouriteList;
  addPatientSheet(BuildContext aContext) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: DraggableScrollableSheet(
                initialChildSize: 0.85,
                maxChildSize: 1,
                minChildSize: 0.5,
                builder:
                    (BuildContext context, ScrollController scrollController) {
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
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () => FocusScope.of(context).unfocus(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 40.0),
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
                                                widget.mypatient == null
                                                    ? 'Ajouter'
                                                    : 'Modifier',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                              onPressed: () => _submit(context),
                                            ),
                                          ),
                                          widget.mypatient != null
                                              ? Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 0.0),
                                                  height: 60.0,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
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
                                                    onPressed: _delete,
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
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final patientCubit = context.bloc<PatientCubit>();
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
                  text("Les Patients",
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
                    child: BlocConsumer<PatientCubit, PatientState>(
                      listener: (context, state) {
                        if (state is PatientAdd) {
                          addPatientSheet(context);
                        }
                      },
                      builder: (context, state) {
                        if (state is PatientInitial) {
                          return StreamBuilder(
                            stream: patientCubit.patientDao.watchAllPatients(),
                            builder: (context,
                                AsyncSnapshot<List<Patient>> snapshot) {
                              final patients = snapshot.data ?? List();
                              return ListView.builder(
                                itemCount: patients.length,
                                itemBuilder: (_, index) {
                                  final itemPatient = patients[index];
                                  return buildPatient(context, itemPatient,
                                      patientCubit.patientDao, patients.length);
                                },
                              );
                            },
                          );
                        }
                        return StreamBuilder(
                          stream: patientCubit.patientDao.watchAllPatients(),
                          builder:
                              (context, AsyncSnapshot<List<Patient>> snapshot) {
                            final patients = snapshot.data ?? List();
                            return ListView.builder(
                              itemCount: patients.length,
                              itemBuilder: (_, index) {
                                final itemPatient = patients[index];
                                return buildPatient(context, itemPatient,
                                    patientCubit.patientDao, patients.length);
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

Widget buildPatient(BuildContext context, Patient itemPatient,
    PatientDao patientDao, int value) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      children: <Widget>[
        Card(
          elevation: 2,
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
              '${itemPatient.nom} ${itemPatient.prenom}',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            subtitle: Text(
                '${itemPatient.taille.toStringAsFixed(2)} cm • ${itemPatient.poids.toStringAsFixed(2)} kg'),
          ),
        ),
      ],
    ),
  );
}
