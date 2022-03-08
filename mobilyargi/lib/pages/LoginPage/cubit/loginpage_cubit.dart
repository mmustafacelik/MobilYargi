import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:mobilyargi/pages/RegisteryPage/cubit/registerypage_cubit.dart';

part 'loginpage_state.dart';

class LoginpageCubit extends Cubit<LoginpageState> {
  LoginpageCubit() : super(LoginpageInitial());
}
