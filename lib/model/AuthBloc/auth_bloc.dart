import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:virtant/repositories/userRepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository? userRepository;
  AuthBloc({@required this.userRepository}) : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    //add try catch
    if (event is AppStartedEvent) {
      yield AuthenticatingState();
      bool isSignedIn = await userRepository!.isSignedIn();
      if (isSignedIn) {
        bool isFirebaseSetUp = await userRepository!.isFirebaseSetUp();

        if (!isFirebaseSetUp) {
          yield AuthFirebaseSetUp();
        } else {
          yield AuthenticatedState(
              user: await userRepository!.getCurrentUser());
        }
        // print((await userRepository.getCurrentUser()).toString());
      } else {
        yield UnAuthenticatedState();
      }
    }
  }
}
