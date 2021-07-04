import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtant/model/AuthBloc/auth_bloc.dart';
import 'package:virtant/repositories/userRepository.dart';
import 'package:virtant/routeGenerator.dart';
import 'package:virtant/screens/SplashScreen.dart';
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
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: App(),
    // );
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
        // return MyApp();
        if (snapshot.connectionState == ConnectionState.done) {
          return MyAppp();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        return DebugScreen(
            text:
                'App class error'); // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}

class MyAppp extends StatelessWidget {
  // defaultApp can be remove later
  // App class do the same
  // FirebaseApp defaultApp = Firebase.app();

  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(userRepository: userRepository)..add(AppStartedEvent()),
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        // Navigator.of(context).popAndPushNamed('/home');
        if (state is AuthenticatedState) {
          Navigator.of(context).popAndPushNamed('/home');
        } else if (state is UnAuthenticatedState) {
          Navigator.of(context).popAndPushNamed('/SignIn');
        } else if (state is AuthFirebaseSetUp) {
          Navigator.of(context).popAndPushNamed('/SignUp/SignUpBasic');
        }
      }, builder: (context, state) {
        if (state is AuthenticatingState) {
          return SplashScreen();
        }
        return DebugScreen(text: 'Class MyApp debug Screen');
      }),
    );
  }
}
