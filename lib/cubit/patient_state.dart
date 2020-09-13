part of 'patient_cubit.dart';

@immutable
abstract class PatientState {
  const PatientState();
}

class PatientInitial extends PatientState {
  const PatientInitial();
}

class PatientAdd extends PatientState {
  const PatientAdd();
}

class PatientEdit extends PatientState {
  const PatientEdit();
}
