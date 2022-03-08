import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'loginpage_state.dart';

class LoginpageCubit extends Cubit<LoginpageState> {
  LoginpageCubit() : super(LoginpageInitial());
}
