import 'package:bloc/bloc.dart';
import 'package:graduation/data/moor_database.dart';
import 'package:meta/meta.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final PasswordDao _dao;
  bool isCorrectPass = false;
  PasswordCubit(this._dao) : super(PasswordInitial());
  String appPass;
  initializePass(){
    _dao.getAllPasswords().then((myPassword) {
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
}
