import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class HomeData {
  final User user;
  final bool isTeacher;

  HomeData({@required this.user, @required this.isTeacher});
}
