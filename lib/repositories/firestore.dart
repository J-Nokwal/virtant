import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ClassFirestore {
  final User user;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  ClassFirestore({@required this.user});

  Future<bool> isTeacher() async {
    try {
      return this
          .firestoreInstance
          .collection('class')
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          return true;
        } else
          return false;
      });
    } catch (e) {
      return false;
    }
  }

  Future<String> createClass(
      {@required String teacherName, @required String className}) async {
    DocumentReference classDoc =
        firestoreInstance.collection('class').doc(user.uid);
    classDoc.set({
      'className': className,
      'teacherNmae': teacherName,
      'isRecordingAttendance': false
    });
    classDoc.collection('quiz');
    classDoc.collection('assignment');
    classDoc.collection('classStudents');
    classDoc.collection('attendance');
    return user.uid.toString();
  }

  Future<bool> joinClass(
      {@required String classUid, @required String studentName}) async {
    DocumentReference studentDoc =
        firestoreInstance.collection('students').doc(user.uid);
    studentDoc.set({'studentName': studentName, 'classUid': classUid});
    studentDoc.collection('assignment');
    studentDoc.collection('quiz');
    studentDoc.collection('attendance');
    return true;
  }
}
