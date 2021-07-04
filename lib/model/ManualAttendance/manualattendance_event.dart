part of 'manualattendance_bloc.dart';

@immutable
abstract class ManualAttendanceEvent {}

class ManualAttendanceUpdateEvent extends ManualAttendanceEvent {}

class ManualAttendanceStartEvent extends ManualAttendanceEvent {}

class ManualAttendanceStopEvent extends ManualAttendanceEvent {}
