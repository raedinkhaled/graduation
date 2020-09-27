import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Screens/login.dart';
import 'package:graduation/cubit/doses_cubit.dart';
import 'package:graduation/cubit/medics_cubit.dart';
import 'package:graduation/cubit/password_cubit.dart';
import 'package:graduation/cubit/patient_cubit.dart';
import 'package:graduation/cubit/reliquats_cubit.dart';
import 'package:graduation/data/moor_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PasswordCubit(PasswordDao(db)),
        ),
        BlocProvider(
          create: (context) => PatientCubit(PatientDao(db)),
        ),
        BlocProvider(
          create: (context) => MedicsCubit(MedicDao(db)),
        ),
        BlocProvider(
          create: (context) => DosesCubit(DoseDao(db)),
        ),
        BlocProvider(
          create: (context) => ReliquatsCubit(ReliquatDao(db)),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MediCalc',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginScreen()),
    );
  }
}
