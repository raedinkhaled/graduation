import 'package:bloc/bloc.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:meta/meta.dart';

part 'medics_state.dart';

class MedicsCubit extends Cubit<MedicsState> {

  final MedicDao medicDao;

  MedicsCubit(this.medicDao) : super(MedicsInitial());
}
