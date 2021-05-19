import 'package:flutter/material.dart';
import 'package:virtant/repositories/userRepository.dart';

class DebugScreen extends StatelessWidget {
  final String text;

  DebugScreen({Key key, @required this.text}) : super(key: key);
  // final UserRepository userRepository = UserRepository();
  // final TextEditingController a = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('tittle here'),
                                content: Text('contents here'),
                              );
                            });
                      },
                      child: Text('pop up  message')),
                  ElevatedButton(
                      onPressed: () async {
                        // await userRepository.signOut();
                        Navigator.of(context).popAndPushNamed('/');
                      },
                      child: Text('sign Out')),
                  // TextField(
                  //   controller: a,
                  // ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       if (a.text == '') {
                  //         print('object');
                  //       }
                  //       print(a.text);
                  //     },
                  //     child: Text('controller experiiment'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
