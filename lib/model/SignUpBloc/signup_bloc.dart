import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:virtant/repositories/userRepository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignupState> {
  final UserRepository userRepository;
  SignUpBloc({@required this.userRepository}) : super(SignUpInitialState());

  @override
  Stream<SignupState> mapEventToState(
    SignUpEvent event,
  ) async* {
    try {
      if (event is SignupButtonPressedEvent) {
        yield SignUpLoadingState();
        User user = await userRepository.signUpUserWithEmailPass(
            email: event.email, pass: event.password);

        yield SignUpSuccessFullState(user: user);
      } else if (event is SignInButtonPressedEvent) {}
    } on Exception catch (e) {
      yield SignUpFailureState(message: e.toString());
    }
  }
}
