import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Debug2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text('debug'),
          onPressed: () async {
            Map<String, dynamic> a;
            final FirebaseFirestore firestoreInstance =
                FirebaseFirestore.instance;
            final User user = FirebaseAuth.instance.currentUser;
            var aaa = firestoreInstance
                .collection('class')
                .doc('N8YnmoJS8nSNCdosKyxp');

            aaa.get().then((value) async {
              a = value['studentsData'];
              a.addAll({'ukyv': 'sdsd'});
              aaa.update({'studentsData': a});
              aaa.collection('attendance').doc('adasd').set(a);
            });
          },
        ),
      ),
    );
  }
}
