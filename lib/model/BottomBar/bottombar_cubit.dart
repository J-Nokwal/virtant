import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottombar_state.dart';

class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(0);
  void atIndex(int index) => emit(index);
  // void bottomBarHome() => emit(0);
  // void bottomBarQuiz() => emit(1);
  // void bottomBarAssignment() => emit(2);
}
