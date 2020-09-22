import 'package:flutter/material.dart';
import 'package:graduation/Screens/Patients.dart' as pat;
import 'package:graduation/Screens/colors.dart';
import 'package:graduation/Screens/constants.dart';
import 'package:graduation/Screens/dashboard.dart';
import 'package:graduation/Screens/editMedic.dart';
import 'package:graduation/Screens/extensions.dart';
import 'package:graduation/Screens/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/cubit/medics_cubit.dart';
import 'package:graduation/data/moor_database.dart';

class Medicaments extends StatefulWidget {
  @override
  _MedicamentsState createState() => _MedicamentsState();
}

class _MedicamentsState extends State<Medicaments> {
  var pages = [Dashboard(), pat.Patients(), Medicaments()];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final medicCubit = context.bloc<MedicsCubit>();
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
                  text("Les Medicaments",
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
                    child: BlocBuilder<MedicsCubit, MedicsState>(
                      builder: (context, state) {
                        if (state is MedicsInitial) {
                          return StreamBuilder(
                            stream: medicCubit.medicDao.watchAllMedics(),
                            builder:
                                (context, AsyncSnapshot<List<Medic>> snapshot) {
                              final medics = snapshot.data ?? List();
                              return ListView.builder(
                                itemCount: medics.length,
                                itemBuilder: (_, index) {
                                  final itemMedic = medics[index];
                                  return buildMedic(context, itemMedic,
                                      medicCubit.medicDao, medics.length);
                                },
                              );
                            },
                          );
                        }
                        return StreamBuilder(
                          stream: medicCubit.medicDao.watchAllMedics(),
                          builder:
                              (context, AsyncSnapshot<List<Medic>> snapshot) {
                            final medics = snapshot.data ?? List();
                            return ListView.builder(
                              itemCount: medics.length,
                              itemBuilder: (_, index) {
                                final itemMedic = medics[index];
                                return buildMedic(context, itemMedic,
                                    medicCubit.medicDao, medics.length);
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

Widget buildMedic(
    BuildContext context, Medic itemMedic, MedicDao medicDao, int value) {
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
                  builder: (_) => EditMedicScreen(medic: itemMedic),
                ),
              ),
              title: Text(
                '${itemMedic.medicNom.toUpperCase()}',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: textSizeMedium),
              ),
              subtitle: Text('${itemMedic.medicLab}'),
              trailing: Column(
                children: <Widget>[
                  text("Reliquats", fontSize: textSizeMedium, textColor: t5TextColorSecondary),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: boxDecoration(bgColor: t5DarkRed, radius: 16),
                    child: text("0.25 ml", fontSize: textSizeMedium, textColor: t5White),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
