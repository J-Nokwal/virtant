import 'package:flutter/material.dart';
import 'package:virtant/main.dart';
// import 'package:virtant/repositories/objectClasses.dart';
import 'package:virtant/screens/authScreens/signInScreen.dart';
import 'package:virtant/screens/authScreens/signUpBasicScreen.dart';
import 'package:virtant/screens/authScreens/signUpBasicStudent.dart';
import 'package:virtant/screens/authScreens/signUpBasicTeacher.dart';
import 'package:virtant/screens/authScreens/signUpScreen.dart';
import 'package:virtant/screens/debugScreen.dart';
import 'package:virtant/screens/homeScreens/homeScreen.dart';
import 'package:virtant/screens/homeScreens/settings.dart';
import 'package:virtant/screens/somethingWentWrong.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          // final args = settings.arguments;
          return MaterialPageRoute(builder: (_) => App());
        }
      case '/SignIn':
        {
          return MaterialPageRoute(builder: (_) => SignInScreen());
        }
      case '/signUp':
        {
          // final args = settings.arguments;
          return MaterialPageRoute(builder: (_) => SignUpScreen());
        }
      case '/SignUp/SignUpBasic':
        {
          // final args = settings.arguments;
          return MaterialPageRoute(builder: (_) => SignUpBasicScreen());
        }
      case '/SignUp/SignUpBasic/Teacher':
        {
          final args = settings.arguments;
          return MaterialPageRoute(
              builder: (_) =>
                  SignUpBasicTeacherScreen(displayName: args.toString()));
        }

      case '/SignUp/SignUpBasic/Student':
        {
          final args = settings.arguments;
          return MaterialPageRoute(
              builder: (_) =>
                  SignUpBasicStudentScreen(displayName: args.toString()));
        }

      case '/home':
        {
          // final args = settings.arguments as HomeData;
          return MaterialPageRoute(
              builder: (_) => HomeScreen(
                  // user: args.user,
                  // isTeacher: args.isTeacher,
                  ));
        }
      case '/home/settings':
        {
          // final args = settings.arguments as HomeData;
          return MaterialPageRoute(
              builder: (_) => SettingsScreen(
                  // user: args.user,
                  // isTeacher: args.isTeacher,
                  ));
        }
      case '/d':
        {
          final args = settings.arguments;
          return MaterialPageRoute(
              builder: (_) => DebugScreen(text: args.toString()));
        }
      default:
        {
          return MaterialPageRoute(builder: (_) => SomethingWentWrong());
        }
    }
  }
}
