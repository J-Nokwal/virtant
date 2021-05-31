import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  final bool isTeacher;

  const AttendanceScreen({Key key, @required this.isTeacher}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isTeacher) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pageUpperCircle.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              onStretchTrigger: null,
              expandedHeight: 150.0,
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              backgroundColor: Colors.transparent,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings_rounded),
                  tooltip: 'notifications',
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.fromLTRB(40, 20, 20, 20),
                collapseMode: CollapseMode.pin,
                title: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amber),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Name'),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('class')
                    .doc('N8YnmoJS8nSNCdosKyxp')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Container(
                      child: Text(snapshot.data['noOfStudents'].toString()));
                },
              ),
              Container(height: 140, color: Colors.transparent),
              Container(height: 140, color: Colors.transparent),
              Container(height: 140, color: Colors.green),
              Container(height: 140, color: Colors.amber),
              Container(height: 140, color: Colors.green),
            ]))
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
