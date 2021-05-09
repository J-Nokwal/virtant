part of 'createjoinclass_bloc.dart';

@immutable
abstract class CreateJoinClassEvent {}

class JoinClassEvent extends CreateJoinClassEvent {
  final String studentName;

  JoinClassEvent({@required this.studentName});
}

class CreateClassEvent extends CreateJoinClassEvent {
  final String teacherName;

  CreateClassEvent({@required this.teacherName});
}

class JoinClassFinalEvent extends CreateJoinClassEvent {
  final String classUid;
  final int studentRollNo;

  JoinClassFinalEvent({@required this.classUid, @required this.studentRollNo});
}

class CreateClassFinalEvent extends CreateJoinClassEvent {
  final String className, classDescription;

  CreateClassFinalEvent({
    @required this.className,
    @required this.classDescription,
  });
}
