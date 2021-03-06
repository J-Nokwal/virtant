import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:virtant/repositories/userRepository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository? userRepository;
  SignInBloc({@required this.userRepository}) : super(SignInInitialState());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // expand on Exception format

    try {
      if (event is SignInButtonPressedEvent) {
        yield SignInLoadingState();
        User? user = await userRepository?.signInEmailAndPassword(
            event.email!, event.password!);
        bool isSignedIn = await userRepository!.isSignedIn();
        if (isSignedIn) {
          bool isFirebaseSetUp = await userRepository!.isFirebaseSetUp();
          if (!isFirebaseSetUp) {
            yield SignInFirebaseNotSetUpState();
          } else
            yield SignInSuccessFullState(user: user);
        }
      } else if (event is SignUpButtonPressedEventFromSignInScreen) {
        yield SignUpButtonPressedFromSignInScreenState();
      } else if (event is ForgotPasswordButtonPressedEvent)
        yield ForgotPasswordButtonPressedState();
    } on Exception catch (e) {
      yield SignInFailureState(e.toString());
    }
  }
}
