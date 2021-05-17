import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {
  final String text;

  const DebugScreen({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
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
                  child: Text('pop up  message'))
            ],
          ),
        ),
      ),
    );
  }
}
