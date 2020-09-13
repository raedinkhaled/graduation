import 'package:flutter/material.dart';
import 'package:graduation/Screens/T5Images.dart';
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/dashboard.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:graduation/Widgets/BottomBar.dart';
import 'package:graduation/Widgets/GridListDashboard.dart';
import 'package:graduation/Widgets/ListModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/cubit/patient_cubit.dart';
import 'package:graduation/data/moor_database.dart';

class Patients extends StatefulWidget {
  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  

  var pages = [Dashboard(), Patients()];
  
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
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
                    child: BlocBuilder<PatientCubit, PatientState>(
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
