import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:virtant/repositories/firestore.dart';

part 'markattendance_event.dart';
part 'markattendance_state.dart';

class MarkAttendanceBloc
    extends Bloc<MarkAttendanceEvent, MarkAttendanceState> {
  final ClassFirestore? classFirestore;
  MarkAttendanceBloc({@required this.classFirestore})
      : super(MarkAttendanceWaitingState());

  @override
  Stream<MarkAttendanceState> mapEventToState(
    MarkAttendanceEvent event,
  ) async* {
    // TODO: implement alreadyMarkde attendance function
    bool alreadyMarked = true;
    bool isTakingAttendance =
        await classFirestore!.isTakingattendance(isTeacher: false);
    if (event is MarkAttendanceInitialEvent) {
      if (isTakingAttendance) {
        if (alreadyMarked) {
          yield MarkAttendanceCompleteState();
          // ignore: dead_code
        } else {
          yield MarkAttendanceNowState();
        }
      } else {
        yield MarkAttendanceInitialState();
      }
    } else if (event is MarkAttendanceButtonPressed) {
      yield MarkAttendanceBluetoothRequestState();
      yield MarkAttendanceWaitingState();
      yield MarkAttendanceCompleteState();
    }
  }
}
