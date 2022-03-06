import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registerypage_state.dart';

class RegisterypageCubit extends Cubit<RegisterypageState> {
  RegisterypageCubit() : super(RegisterypageInitial());
}
