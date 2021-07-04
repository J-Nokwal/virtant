part of 'manualattendance_bloc.dart';

@immutable
abstract class ManualAttendanceState {}

class ManualAttendanceInitialState extends ManualAttendanceState {}

class ManualAttendanceWaitingState extends ManualAttendanceState {}

class ManualAttendanceDetailsState extends ManualAttendanceState {}
