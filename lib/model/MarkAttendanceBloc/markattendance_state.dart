part of 'markattendance_bloc.dart';

@immutable
abstract class MarkAttendanceState {}

class MarkAttendanceInitialState extends MarkAttendanceState {}

// class MarkAttendanceNotTakingAttenganceState extends MarkAttendanceState{}
class MarkAttendanceNowState extends MarkAttendanceState {}

class MarkAttendanceCompleteState extends MarkAttendanceState {}

class MarkAttendanceWaitingState extends MarkAttendanceState {}

class MarkAttendanceBluetoothRequestState extends MarkAttendanceState {}
