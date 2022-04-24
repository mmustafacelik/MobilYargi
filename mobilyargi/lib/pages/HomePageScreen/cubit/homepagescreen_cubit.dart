import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homepagescreen_state.dart';

class HomepagescreenCubit extends Cubit<HomepagescreenState> {
  HomepagescreenCubit() : super(HomepagescreenInitial());
}
