part of 'markattendance_bloc.dart';

@immutable
abstract class MarkAttendanceEvent {}

class MarkAttendanceButtonPressed extends MarkAttendanceEvent {}

class MarkAttendanceInitialEvent extends MarkAttendanceEvent {}
