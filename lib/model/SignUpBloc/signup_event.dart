part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignupButtonPressedEvent extends SignUpEvent {
  final String email, password;

  SignupButtonPressedEvent({@required this.email, @required this.password});
}

class SignInButtonPressedEvent extends SignUpEvent {}

// class SignUpRoleButtonPressedEvent extends SignUpEvent {}
