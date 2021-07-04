part of 'attendancerecord_bloc.dart';

@immutable
abstract class AttendanceRecordState {}

class AttendanceRecordInitialState extends AttendanceRecordState {}

class AttendanceRecordBluetoothRequestState extends AttendanceRecordState {}

class AttendanceRecordingState extends AttendanceRecordState {}

class AttendanceRecordWaitingState extends AttendanceRecordState {}
