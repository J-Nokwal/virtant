part of 'signin_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInButtonPressedEvent extends SignInEvent {
  final String? email, password;
  SignInButtonPressedEvent({
    @required this.email,
    @required this.password,
  });
}

class SignUpButtonPressedEventFromSignInScreen extends SignInEvent {}

class ForgotPasswordButtonPressedEvent extends SignInEvent {}
