import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'loginpage_state.dart';

class LoginpageCubit extends Cubit<LoginpageState> {
  LoginpageCubit() : super(LoginpageInitial(baslangicDegeri: true));

  void isVisibleChange() {
    emit(MyisVisibleState(isVisibleDegeri: false));
  }
}
