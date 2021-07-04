part of 'createjoinclass_bloc.dart';

@immutable
abstract class CreateJoinClassEvent {}

class JoinClassEvent extends CreateJoinClassEvent {
  final String? classUid, studentName;
  final int? studentRollNo;

  JoinClassEvent({
    @required this.classUid,
    @required this.studentRollNo,
    @required this.studentName,
  });
}

class CreateClassEvent extends CreateJoinClassEvent {
  final String? className, classDescription, classSubject, teacherName;

  CreateClassEvent({
    @required this.className,
    @required this.classSubject,
    @required this.classDescription,
    @required this.teacherName,
  });
}
