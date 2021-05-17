import 'package:flutter/material.dart';
import 'package:virtant/screens/colors.dart';

import '../widgetTools.dart';

class SignUpBasicScreen extends StatefulWidget {
  @override
  _SignUpBasicScreenState createState() => _SignUpBasicScreenState();
}

class _SignUpBasicScreenState extends State<SignUpBasicScreen> {
  bool _signUpAsTeacher = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/PagebackgroundImagefull.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
            child: SingleChildScrollView(
          child: PopContainer(
            height: 380,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Form(
                // key: _signInFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Virtant',
                      style: TextStyle(
                        fontSize: 40,
                        color: purpleDark,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: outlineFormInputBorder(),
                          focusColor: purpleDark,
                          focusedBorder: outlineFormInputBorder(),
                          labelStyle: TextStyle(color: purpleLight),
                          suffixIcon: Icon(
                            Icons.person,
                            color: purpleLight,
                          ),
                          labelText: 'Full Name'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'SignUp As A Techer?',
                          style: TextStyle(color: purpleLight, fontSize: 20),
                        ),
                        Switch(
                            value: _signUpAsTeacher,
                            activeColor: purpleLight,
                            onChanged: (bool newValue) {
                              setState(() {
                                _signUpAsTeacher = newValue;
                              });
                            }),
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: purpleLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          "Continue",
                          style: TextStyle(color: whitePure, fontSize: 20),
                        )),
                      ),
                      onTap: () {
                        //TODO implement controller for name
                        Navigator.of(context).pushNamed(
                            _signUpAsTeacher
                                ? '/SignUp/SignUpBasic/Teacher'
                                : '/SignUp/SignUpBasic/Student',
                            arguments: '');
                      },
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
