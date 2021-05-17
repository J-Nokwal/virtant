import 'package:flutter/material.dart';
import 'package:virtant/main.dart';
import 'package:virtant/screens/authScreens/signInScreen.dart';
import 'package:virtant/screens/authScreens/signUpBasicScreen.dart';
import 'package:virtant/screens/authScreens/signUpBasicStudent.dart';
import 'package:virtant/screens/authScreens/signUpBasicTeacher.dart';
import 'package:virtant/screens/authScreens/signUpScreen.dart';
import 'package:virtant/screens/debugScreen.dart';
import 'package:virtant/screens/somethingWentWrong.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      // case '/':
      //   {
      //     return MaterialPageRoute(builder: (_) => SignUpBasicStudentScreen());
      //   }
      case '/':
        {
          return MaterialPageRoute(builder: (_) => App());
        }
      case '/SignIn':
        {
          return MaterialPageRoute(builder: (_) => SignInScreen());
        }
      case '/signUp':
        {
          return MaterialPageRoute(builder: (_) => SignUpScreen());
        }
      case '/SignUp/SignUpBasic':
        {
          return MaterialPageRoute(builder: (_) => SignUpBasicScreen());
        }
      case '/SignUp/SignUpBasic/Teacher':
        {
          return MaterialPageRoute(
              builder: (_) => SignUpBasicTeacherScreen(displayName: args));
        }

      case '/SignUp/SignUpBasic/Student':
        {
          return MaterialPageRoute(
              builder: (_) => SignUpBasicStudentScreen(displayName: args));
        }
      case '/d':
        {
          return MaterialPageRoute(builder: (_) => DebugScreen(text: args));
        }
      default:
        {
          return MaterialPageRoute(builder: (_) => SomethingWentWrong());
        }
    }
  }
}
