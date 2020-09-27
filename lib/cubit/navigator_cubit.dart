import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorState> {
  NavigatorCubit() : super(NavigatorInitial());

  var newIndex =0;

  setIndex(int n){
    newIndex=n;
  }
}
