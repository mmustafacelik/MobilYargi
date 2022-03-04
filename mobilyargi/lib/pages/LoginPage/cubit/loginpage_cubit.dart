import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loginpage_state.dart';

class LoginpageCubit extends Cubit<LoginpageState> {
  LoginpageCubit() : super(LoginpageInitial());
  var emailcontroller;
  var password;
  bool _isObscure = true;
}
