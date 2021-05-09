part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class UnAuthenticatedState extends AuthState {}

class AuthenticatedState extends AuthState {
  final User user;

  AuthenticatedState({@required this.user});
}

class AuthFirebaseSetUp extends AuthState {}
