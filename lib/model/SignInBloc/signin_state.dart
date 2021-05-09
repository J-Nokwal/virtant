part of 'signin_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInFailureState extends SignInState {
  final String message;

  SignInFailureState(this.message);
}

class SignInSuccessFullState extends SignInState {
  final User user;
  SignInSuccessFullState({@required this.user});
}

class SignUpButtonPressedState extends SignInState {}

class ForgotPasswordButtonPressedState extends SignInState {}
