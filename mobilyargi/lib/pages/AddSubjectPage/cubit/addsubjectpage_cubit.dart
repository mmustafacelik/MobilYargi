import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addsubjectpage_state.dart';

class AddsubjectpageCubit extends Cubit<AddsubjectpageState> {
  AddsubjectpageCubit() : super(AddsubjectpageInitial());
}
