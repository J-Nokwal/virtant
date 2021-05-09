part of 'createjoinclass_bloc.dart';

@immutable
abstract class CreateJoinClassState {}

class CreateJoinClassInitialState extends CreateJoinClassState {}

class CreateJoinClassLoadingState extends CreateJoinClassState {}

class CreateClassState extends CreateJoinClassState {}

class JoinClassState extends CreateJoinClassState {}

class CreateSuccessFullState extends CreateJoinClassState {}

class JoinSuccessFullState extends CreateJoinClassState {}
