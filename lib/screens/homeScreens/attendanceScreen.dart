import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtant/model/AttendanceRecord/attendancerecord_bloc.dart';
import 'package:virtant/repositories/firestore.dart';
import 'package:virtant/screens/SplashScreen.dart';
import 'package:virtant/screens/colors.dart';

class AttendanceScreen extends StatelessWidget {
  final bool? isTeacher;
  final User? _user = FirebaseAuth.instance.currentUser;

  AttendanceScreen({Key? key, @required this.isTeacher}) : super(key: key) {
    print("AttendanceScreen class initialize");
  }

  @override
  Widget build(BuildContext context) {
    ClassFirestore _classFirestore = ClassFirestore(user: _user);
    if (isTeacher) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<AttendanceRecordBloc>(
            create: (BuildContext context) =>
                AttendanceRecordBloc(classFirestore: _classFirestore)
                  ..add(AttendanceRecordButtonPressEvent()),
          ),
        ],
        child: Container(
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
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home/settings');
                    },
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
                  stream: _classFirestore.getClassDetails(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 70,
                        color: whitePink,
                        child: SplashContainer(),
                      );
                    } else
                      return Center(
                        child: Container(
                          // margin: EdgeInsets.only(left: 32, right: 32),
                          width: 354,
                          height: 200,
                          decoration: BoxDecoration(
                              color: whitePure,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: Row(
                                  // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 160,
                                      child: Text(
                                        snapshot.data["className"],
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 15, color: grayDark),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      alignment: Alignment.topRight,
                                      width: 160,
                                      child: Text(
                                        snapshot.data["subjectName"],
                                        textAlign: TextAlign.right,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 15, color: grayDark),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(
                                thickness: 1.2,
                              ),
                              SizedBox(height: 5),
                              // Text(snapshot.data["teacherBlueAddress"].toString()),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Students",
                                      style: TextStyle(
                                          fontSize: 20, color: grayDark),
                                    ),
                                    Text(
                                      snapshot.data["noOfStudents"].toString(),
                                      style: TextStyle(
                                          fontSize: 20, color: grayDark),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Students present",
                                      style: TextStyle(
                                          fontSize: 20, color: grayDark),
                                    ),
                                    Text(
                                      snapshot.data["noOfStudents"].toString(),
                                      style: TextStyle(
                                          fontSize: 20, color: grayDark),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                BlocConsumer<AttendanceRecordBloc, AttendanceRecordState>(
                  listener: (context, state) {
                    print(state.toString());
                  },
                  builder: (context, state) {
                    return Center(
                        child: Container(
                      width: 354,
                      height: 70,
                      decoration: BoxDecoration(
                          color: purpleLight,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          Semantics(
                            onLongPressHint: "Start Attendance",
                          );
                          Feedback.forLongPress(context);
                          BlocProvider.of<AttendanceRecordBloc>(context)
                            ..add(AttendanceRecordButtonPressEvent());
                        },
                        onLongPress: () {
                          Feedback.forTap(context);
                        },
                        child: Text(
                          "Start Attendance",
                          style: TextStyle(fontSize: 20, color: whitePink),
                        ),
                      ),
                    ));
                  },
                ),
                Container(height: 140, color: Colors.transparent),
                Container(height: 140, color: Colors.green),
                Container(height: 140, color: Colors.amber),
                Container(height: 140, color: Colors.green),
              ]))
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
