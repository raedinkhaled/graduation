part of 'password_cubit.dart';

@immutable
abstract class PasswordState {
  const PasswordState();
}

class PasswordInitial extends PasswordState {
  const PasswordInitial();
}

class PasswordCorrect extends PasswordState {
  const PasswordCorrect();
}

class PasswordWrong extends PasswordState {
  final String message;
  const PasswordWrong(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PasswordWrong && o.message == message;
  }
}
