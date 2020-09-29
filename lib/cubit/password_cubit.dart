import 'package:bloc/bloc.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:meta/meta.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final PasswordDao dao;
  bool isCorrectPass = false;
  PasswordCubit(this.dao) : super(PasswordInitial());
  String appPass;
  initializePass(){
    dao.getAllPasswords().then((myPassword) {
      appPass = myPassword[0].pass;
    });
  }
  checkPass(String filledPass) {
    print(appPass);
    if (filledPass == appPass) {
      isCorrectPass = true;
    } else {
      isCorrectPass=false;
    }
  }

  bool checkedPass(String filledPass) {
    print(appPass);
    if (filledPass == appPass) {
      return true;
    } else {
      return false;
    }
  }
}
