import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepository {
  FirebaseAuth firebaseAuth;

  UserRepository() {
    this.firebaseAuth = FirebaseAuth.instance;
  }

  // sign up with email
  Future<User> signUpUserWithEmailPass(String email, String pass) async {
    try {
      var authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print("REPO : ${authResult.user.email}");
      await authResult.user.sendEmailVerification();
      return authResult.user;
    } on PlatformException catch (e) {
      String authError = "";
      switch (e.code) {
        case ErrorCodes.ERROR_C0DE_NETWORK_ERROR:
          authError = ErrorMessages.ERROR_C0DE_NETWORK_ERROR;
          break;
        case ErrorCodes.ERROR_USER_NOT_FOUND:
          authError = ErrorMessages.ERROR_USER_NOT_FOUND;
          break;
        case ErrorCodes.ERROR_TOO_MANY_REQUESTS:
          authError = ErrorMessages.ERROR_TOO_MANY_REQUESTS;
          break;
        case ErrorCodes.ERROR_INVALID_EMAIL:
          authError = ErrorMessages.ERROR_INVALID_EMAIL;
          break;
        case ErrorCodes.ERROR_CODE_USER_DISABLED:
          authError = ErrorMessages.ERROR_CODE_USER_DISABLED;
          break;
        case ErrorCodes.ERROR_CODE_WRONG_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WRONG_PASSWORD;
          break;
        case ErrorCodes.ERROR_CODE_EMAIL_ALREADY_IN_USE:
          authError = ErrorMessages.ERROR_CODE_EMAIL_ALREADY_IN_USE;
          break;
        case ErrorCodes.ERROR_OPERATION_NOT_ALLOWED:
          authError = ErrorMessages.ERROR_OPERATION_NOT_ALLOWED;
          break;
        case ErrorCodes.ERROR_CODE_WEAK_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WEAK_PASSWORD;
          break;
        default:
          authError = ErrorMessages.DEFAULT;
          break;
      }
      throw Exception(authError);
    }
  }

  // sign in with email and password
  Future<User> signInEmailAndPassword(String email, String password) async {
    try {
      var authresult = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authresult.user;
    } on PlatformException catch (e) {
      String authError = "";
      switch (e.code) {
        case ErrorCodes.ERROR_C0DE_NETWORK_ERROR:
          authError = ErrorMessages.ERROR_C0DE_NETWORK_ERROR;
          break;
        case ErrorCodes.ERROR_USER_NOT_FOUND:
          authError = ErrorMessages.ERROR_USER_NOT_FOUND;
          break;
        case ErrorCodes.ERROR_TOO_MANY_REQUESTS:
          authError = ErrorMessages.ERROR_TOO_MANY_REQUESTS;
          break;
        case ErrorCodes.ERROR_INVALID_EMAIL:
          authError = ErrorMessages.ERROR_INVALID_EMAIL;
          break;
        case ErrorCodes.ERROR_CODE_USER_DISABLED:
          authError = ErrorMessages.ERROR_CODE_USER_DISABLED;
          break;
        case ErrorCodes.ERROR_CODE_WRONG_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WRONG_PASSWORD;
          break;
        case ErrorCodes.ERROR_CODE_EMAIL_ALREADY_IN_USE:
          authError = ErrorMessages.ERROR_CODE_EMAIL_ALREADY_IN_USE;
          break;
        case ErrorCodes.ERROR_OPERATION_NOT_ALLOWED:
          authError = ErrorMessages.ERROR_OPERATION_NOT_ALLOWED;
          break;
        case ErrorCodes.ERROR_CODE_WEAK_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WEAK_PASSWORD;
          break;
        default:
          authError = ErrorMessages.DEFAULT;
          break;
      }
      throw Exception(authError);
    }
  }

  // sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // check signIn
  Future<bool> isSignedIn() async {
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  // get current user
  Future<User> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  bool isVerified() {
    return FirebaseAuth.instance.currentUser.emailVerified;
  }
}

class ErrorCodes {
  static const String ERROR_C0DE_NETWORK_ERROR = "FirebaseException";
  static const String ERROR_USER_NOT_FOUND = "ERROR_USER_NOT_FOUND";
  static const String ERROR_TOO_MANY_REQUESTS = "ERROR_TOO_MANY_REQUESTS";
  static const String ERROR_INVALID_EMAIL = "ERROR_INVALID_EMAIL";
  static const String ERROR_CODE_USER_DISABLED = "ERROR_CODE_USER_DISABLED";
  static const String ERROR_CODE_WRONG_PASSWORD = "ERROR_CODE_WRONG_PASSWORD";
  static const String ERROR_CODE_EMAIL_ALREADY_IN_USE =
      "ERROR_CODE_EMAIL_ALREADY_IN_USE";
  static const String ERROR_OPERATION_NOT_ALLOWED =
      "ERROR_OPERATION_NOT_ALLOWED";
  static const String ERROR_CODE_WEAK_PASSWORD = "ERROR_CODE_WEAK_PASSWORD";
}

class ErrorMessages {
  static const String ERROR_C0DE_NETWORK_ERROR =
      "Network Error! Check internet connection.";
  static const String ERROR_USER_NOT_FOUND = "User Not Found!";
  static const String ERROR_TOO_MANY_REQUESTS = "Too Many Requests!";
  static const String ERROR_INVALID_EMAIL = "Invalid Email!";
  static const String ERROR_CODE_USER_DISABLED = "User is Banned!";
  static const String ERROR_CODE_WRONG_PASSWORD = "Wrong Password!";
  static const String ERROR_CODE_EMAIL_ALREADY_IN_USE =
      "This email is already in use!";
  static const String ERROR_OPERATION_NOT_ALLOWED = "Operation not allowed";
  static const String ERROR_CODE_WEAK_PASSWORD = "Weak password!";
  static const String DEFAULT = "Unknown error!";
}

class CustomException {
  String message;

  CustomException(this.message);
}
