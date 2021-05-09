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
      {@required String teacherName,
      @required String classDescription,
      @required String className,
      @required String teacherBlueAddress,
      @required String teacherBlueName}) async {
    DocumentReference classDoc =
        firestoreInstance.collection('class').doc(user.uid);
    classDoc.set({
      'classDescription': classDescription,
      'className': className,
      'teacherNmae': teacherName,
      'isRecordingAttendance': false,
      'teacherBlueAddress': teacherBlueAddress,
      'teacherBlueName': teacherBlueName
    });
    classDoc.collection('quiz');
    classDoc.collection('assignment');
    classDoc.collection('classStudents');
    classDoc.collection('attendance');
    return user.uid.toString();
  }

  Future<bool> joinClass(
      {@required String classUid,
      @required String studentName,
      @required int studentRollNo}) async {
    DocumentReference studentDoc =
        firestoreInstance.collection('students').doc(user.uid);

    studentDoc.set({
      'studentName': studentName,
      'classUid': classUid,
      'studentRollNo': studentRollNo
    });
    studentDoc.collection('assignment');
    studentDoc.collection('quiz');
    studentDoc.collection('attendance');
    firestoreInstance
        .collection('class')
        .doc(classUid)
        .collection('classStudents')
        .doc(user.uid);
    firestoreInstance
        .collection('class')
        .doc(classUid)
        .update({'noOfStudents': FieldValue.increment(1)});

    return true;
  }

  Future<void> startTakingAttendance() async {}
  Future<void> markAttendance() async {}
  // to add viewAttendance from teacherside and student side
  // to add manual mark attendance
  Future<void> createAssignment() async {}
  Future<void> submitAssignment() async {}
  // to view assignments from both side
  Future<void> createQuiz() async {}
  Future<void> giveQuiz() async {}
  // to view result from both side
  // to add feedback fxn
}
