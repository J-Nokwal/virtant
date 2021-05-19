import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtant/repositories/firestore.dart';
import 'package:virtant/repositories/userRepository.dart';
import 'package:virtant/screens/colors.dart';
import 'package:virtant/screens/debugScreen.dart';
import 'package:virtant/screens/homeScreens/attendanceScreen.dart';

class HomeScreen extends StatelessWidget {
  bool isTeacher = true;
  // final bool isTeacher;
  // final User user;
  final PageController _pageController = PageController();
  final GlobalKey<ConvexAppBarState> _appBarKey =
      GlobalKey<ConvexAppBarState>();
  // HomeScreen({Key key, @required this.user, this.isTeacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          AttendanceScreen(
            isTeacher: true,
          ),
          Center(child: Text(1.toString())),
          Center(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DebugScreen(text: 'dddd')));
                  },
                  child: Text(2.toString()))),
        ],
        onPageChanged: (index) {
          _appBarKey.currentState.animateTo(index);
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        key: _appBarKey,
        items: [
          TabItem(
              icon: Image(
                image: AssetImage('assets/images/attendance.png'),
              ),
              title: 'Attendance'),
          TabItem(
              icon: Image(
                image: AssetImage('assets/images/quiz.png'),
              ),
              title: 'Quiz  '),
          TabItem(
              icon: Image(
                image: AssetImage('assets/images/assignment.png'),
              ),
              title: 'Assignment'),
        ],
        activeColor: whitePure,
        style: TabStyle.flip,
        elevation: 10,
        height: 60,
        backgroundColor: purpleLight,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        },
      ),
    );
  }
}
