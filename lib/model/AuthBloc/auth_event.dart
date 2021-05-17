part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStartedEvent extends AuthEvent {
  AppStartedEvent() {
    print('app staerted event added by me');
  }
}
