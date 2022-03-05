part of 'loginpage_cubit.dart';

@immutable
abstract class LoginpageState {
  final bool isVisible;
  const LoginpageState({required this.isVisible});
}

class LoginpageInitial extends LoginpageState {
  LoginpageInitial({required bool baslangicDegeri})
      : super(isVisible: baslangicDegeri);
}

class MyisVisibleState extends LoginpageState {
  MyisVisibleState({required bool isVisibleDegeri})
      : super(isVisible: isVisibleDegeri);
}
