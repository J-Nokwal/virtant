import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manualattendance_event.dart';
part 'manualattendance_state.dart';

class ManualAttendanceBloc
    extends Bloc<ManualAttendanceEvent, ManualAttendanceState> {
  ManualAttendanceBloc() : super(ManualAttendanceInitialState());

  @override
  Stream<ManualAttendanceState> mapEventToState(
    ManualAttendanceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
