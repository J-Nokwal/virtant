import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ClassFirestore {
  final User? user;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  ClassFirestore({@required this.user});

  Future<bool> isTeacher() async {
    try {
      return this
          .firestoreInstance
          .collection('class')
          .doc(user?.uid)
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

  Future<String?> createClass(
      {@required String? teacherName,
      @required String? classDescription,
      @required String? className,
      @required String? teacherBlueAddress,
      @required String? teacherBlueName}) async {
    DocumentReference classDoc =
        firestoreInstance.collection('class').doc(user?.uid);
    classDoc.set({
      'classDescription': classDescription,
      'className': className,
      'teacherName': teacherName,
      'isRecordingAttendance': false,
      'teacherBlueAddress': teacherBlueAddress,
      'teacherBlueName': teacherBlueName,
      'noOfStudents': 0
    });
    // these below dont work like that so directly implent when creating document
    classDoc.collection('quiz');
    classDoc.collection('assignment');
    classDoc.collection('classStudents');
    classDoc.collection('attendance');
    return user?.uid;
  }

  Future<bool> joinClass(
      {@required String? classUid,
      @required String? studentName,
      @required int? studentRollNo}) async {
    DocumentReference studentDoc =
        firestoreInstance.collection('students').doc(user?.uid);
    DocumentReference classReference =
        firestoreInstance.collection('class').doc(classUid);
    studentDoc.set({
      'studentName': studentName,
      'classUid': classReference,
      'studentRollNo': studentRollNo
    });

    classReference.get().then((value) async {
      Map<String, dynamic> a = value['studentsData'];
      a.addAll({
        // remove roll no field
        user!.uid: {
          'studentName': studentName,
          'studentRollNo': studentRollNo,
          'isPresent': false
        }
      });
      classReference.update({'studentsData': a});
    });

    return true;
  }

  Stream<DocumentSnapshot> getClassDetails() {
    // uncomment after debuging and comment line below
    return firestoreInstance.collection('class').doc(user?.uid).snapshots();
    // print("kkkk,${user.uid}");
    // return firestoreInstance
    //     .collection('class')
    //     .doc("IlXTMCWwlyeJXBV6c2OyoWjN5hG2")
    //     .snapshots();
  }

  Future<void> startTakingAttendance() async {
    // String date = DateTime.now().toString().split(' ')[0];
    DocumentReference classRefenrence =
        firestoreInstance.collection('class').doc(user?.uid);
    classRefenrence.update({'isRecordingAttendance': true});
    // DocumentReference attendanceDateDocSnapshot =
    //     await classRefenrence.collection('attendance').doc(date);
    // if (!attendanceDateDocSnapshot.exists){
    //   attendanceDateDocSnapshot.
    // }
  }

  Future<void> stopTakingAttendance() async {
    DocumentReference classRefenrence =
        firestoreInstance.collection('class').doc(user?.uid);
    classRefenrence.update({'isRecordingAttendance': false});
  }

  Future<void> markAttendance() async {
    String? date = DateTime.now().toString().split(' ')[0];
    firestoreInstance.collection('students').doc(user?.uid).get().then((value) {
      DocumentReference classRefenrence = value['classUid'];
      classRefenrence.collection('attendance').doc(date).update({
        user!.uid: {
          'studentName': user?.displayName,
          'isPresent': true,
          'timeStamp': FieldValue.serverTimestamp(),
        }
      });
    });
  }

  Future<bool> isTakingattendance({@required bool? isTeacher}) async {
    DocumentSnapshot classSnapShort;
    if (isTeacher!) {
      classSnapShort =
          await firestoreInstance.collection('class').doc(user?.uid).get();
    } else {
      DocumentSnapshot studentSnapShot =
          await firestoreInstance.collection('students').doc(user?.uid).get();
      classSnapShort = await firestoreInstance
          .collection('class')
          .doc(studentSnapShot['classUid'])
          .get();
    }
    return classSnapShort["isRecordingAttendance"];
  }

  // to add viewAttendance from teacherside and student side
  // to add manual mark attendance

  Future<void> createAssignment({
    @required String? assignmentName,
    @required String? assignmentdiscription,
    @required int? assignmentMaxMarks,
    @required DateTime? assignmentFinishTime,
    String assignmentLink = '',
  }) async {
    String date = DateTime.now().toString().split(' ')[0];
    firestoreInstance
        .collection('class')
        .doc(user?.uid)
        .collection('assignment')
        .doc(date)
        .set({
      'discription': assignmentdiscription,
      'title': assignmentName,
      'endTime': assignmentFinishTime?.microsecondsSinceEpoch,
      'documentLink': assignmentLink,
      'maxMarks': assignmentMaxMarks
    });
  }

  // ignore: missing_return
  Future<DocumentReference?> getclassUid() async {
    firestoreInstance.collection('students').doc(user?.uid).get().then((value) {
      DocumentReference classRefenrence = value['classUid'];
      return classRefenrence;
    });
  }

  // ignore: missing_return
  Stream<QuerySnapshot?> getAssignments(
      {@required DocumentReference? classRefenrence}) {
    return classRefenrence!.collection('assignment').snapshots();
  }

  Future<void> submitAssignment(
      {@required String? documentLink,
      @required int? assignmentMaxMarks,
      @required DocumentReference? assignmentReference}) async {
    firestoreInstance
        .collection('students')
        .doc(user?.uid)
        .collection('assignment')
        .doc(assignmentReference?.id)
        .set({
      'documentlink': documentLink,
      'marks': -1,
      'given': true,
      'maxMarks': assignmentMaxMarks
    });
  }

  // to view assignments from both side
  Future<void> createQuiz() async {}
  Future<void> giveQuiz() async {}
  // to view result from both side
  // to add feedback fxn
}
