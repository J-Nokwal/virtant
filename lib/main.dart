import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtant/model/AuthBloc/auth_bloc.dart';
import 'package:virtant/repositories/userRepository.dart';
import 'package:virtant/routeGenerator.dart';
import 'package:virtant/screens/SplashScreen.dart';
import 'package:virtant/screens/authScreens/signInScreen.dart';
import 'package:virtant/screens/debugScreen.dart';
import 'package:virtant/screens/somethingWentWrong.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',

      // initialRoute: '/SignUp/SignUpBasic',
      // initialRoute: '/signUp'
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyAppp();
        }

        return SplashScreen(); // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}

class MyAppp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(userRepository: userRepository)..add(AppStartedEvent()),
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthenticatingState) {
          return SplashScreen();
        } else if (state is UnAuthenticatedState) {
          return SignInScreen();
        } else if (state is AuthFirebaseSetUp) {
          return DebugScreen(text: 'AuthFirebaseSetUp44444444444444444444');
        } else if (state is AuthenticatedState) {
          return DebugScreen(
              text: 'AuthenticatedState4666666666666666666666666');
        }
        return DebugScreen(text: 'bloc screen7777777777777777777777777777');
      }),
    );
  }
}
