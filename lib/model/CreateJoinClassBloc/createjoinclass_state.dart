part of 'createjoinclass_bloc.dart';

@immutable
abstract class CreateJoinClassState {}

class CreateJoinClassInitialState extends CreateJoinClassState {}

class CreateJoinClassLoadingState extends CreateJoinClassState {}

class CreateClassSuccessFullState extends CreateJoinClassState {
  final String? classId;
  final User? user;

  CreateClassSuccessFullState({@required this.classId, @required this.user});
}

class JoinClassSuccessFullState extends CreateJoinClassState {
  final User? user;

  JoinClassSuccessFullState({@required this.user});
}
