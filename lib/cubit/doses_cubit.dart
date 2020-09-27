import 'package:bloc/bloc.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:meta/meta.dart';

part 'doses_state.dart';

class DosesCubit extends Cubit<DosesState> {
 final DoseDao doseDao;

  DosesCubit(this.doseDao) : super(DosesInitial());


  
}
