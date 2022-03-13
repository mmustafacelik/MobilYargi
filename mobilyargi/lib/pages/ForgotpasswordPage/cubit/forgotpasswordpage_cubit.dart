import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgotpasswordpage_state.dart';

class ForgotpasswordpageCubit extends Cubit<ForgotpasswordpageState> {
  ForgotpasswordpageCubit() : super(ForgotpasswordpageInitial());
}
