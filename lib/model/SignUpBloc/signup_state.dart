part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignUpInitialState extends SignupState {}

class SignUpLoadingState extends SignupState {}

class SignUpSuccessFullState extends SignupState {
  final User user;

  SignUpSuccessFullState({@required this.user});
}

class SignUpFailureState extends SignupState {
  final String message;

  SignUpFailureState({@required this.message});
}
