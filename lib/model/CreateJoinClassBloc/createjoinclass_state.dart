part of 'createjoinclass_bloc.dart';

@immutable
abstract class CreateJoinClassState {}

class CreateJoinClassInitialState extends CreateJoinClassState {}

class CreateJoinClassLoadingState extends CreateJoinClassState {}

class CreateClassSuccessFullState extends CreateJoinClassState {
  final String classId;

  CreateClassSuccessFullState({@required this.classId});
}

class JoinClassSuccessFullState extends CreateJoinClassState {}
