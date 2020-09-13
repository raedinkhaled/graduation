import 'package:bloc/bloc.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:meta/meta.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {

  final PatientDao patientDao;

  PatientCubit(this.patientDao) : super(PatientInitial());


}
