import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:virtant/repositories/firestore.dart';
import 'package:virtant/repositories/userRepository.dart';

part 'attendancerecord_event.dart';
part 'attendancerecord_state.dart';

class AttendanceRecordBloc
    extends Bloc<AttendanceRecordEvent, AttendanceRecordState> {
  final ClassFirestore? classFirestore;
  AttendanceRecordBloc({@required this.classFirestore})
      : super(AttendanceRecordInitialState());

  @override
  Stream<AttendanceRecordState> mapEventToState(
    AttendanceRecordEvent event,
  ) async* {
    bool isTakingAttendance =
        await classFirestore.isTakingattendance(isTeacher: true);
    if (event is AttendanceRecordButtonPressEvent) {
      if (isTakingAttendance) {
        yield AttendanceRecordWaitingState();
        classFirestore.stopTakingAttendance();
        yield AttendanceRecordInitialState();
      } else {
        yield AttendanceRecordBluetoothRequestState();
        //TODO: add bluetooth module
        Future.delayed(const Duration(seconds: 2));
        yield AttendanceRecordWaitingState();
        classFirestore.startTakingAttendance();
        yield AttendanceRecordingState();
      }
    }
  }
}
