import 'package:bloc/bloc.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:meta/meta.dart';

part 'reliquats_state.dart';

class ReliquatsCubit extends Cubit<ReliquatsState> {
  final ReliquatDao reliquatDao;

  ReliquatsCubit(this.reliquatDao) : super(ReliquatsInitial());
}
