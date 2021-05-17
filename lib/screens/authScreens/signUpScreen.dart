import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:virtant/model/SignUpBloc/signup_bloc.dart';
import 'package:virtant/repositories/userRepository.dart';
import 'package:virtant/screens/colors.dart';
import 'package:virtant/screens/widgetTools.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signInFormKey = GlobalKey<FormState>();

  bool _secureText = true;

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
              height: 500,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Form(
                  key: _signInFormKey,
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
                        height: 30,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: outlineFormInputBorder(),
                            focusColor: purpleDark,
                            focusedBorder: outlineFormInputBorder(),
                            labelStyle: TextStyle(color: purpleLight),
                            suffixIcon: Icon(
                              Icons.supervised_user_circle,
                              color: purpleLight,
                            ),
                            labelText: 'Email'),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: outlineFormInputBorder(),
                            focusColor: purpleDark,
                            focusedBorder: outlineFormInputBorder(),
                            labelStyle: TextStyle(color: purpleLight),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _secureText
                                    ? Icons.remove_red_eye
                                    : Icons.security,
                                color: purpleLight,
                              ),
                              onPressed: () => setState(() {
                                _secureText = !_secureText;
                              }),
                            ),
                            labelText: 'Password'),
                        obscureText: _secureText,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: outlineFormInputBorder(),
                            focusColor: purpleDark,
                            focusedBorder: outlineFormInputBorder(),
                            labelStyle: TextStyle(color: purpleLight),
                            suffixIcon: Icon(
                              Icons.security,
                              color: purpleLight,
                            ),
                            labelText: 'ConfirmPassword'),
                        obscureText: true,
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
                            "SignUp",
                            style: TextStyle(color: whitePure, fontSize: 20),
                          )),
                        ),
                        onTap: () {
                          // Impliment event
                          UserRepository userRepository = UserRepository();
                          SignUpBloc signUpBloc =
                              SignUpBloc(userRepository: userRepository);
                          signUpBloc.add(SignupButtonPressedEvent(
                              email: 'jagritnokwal9@gmail.com',
                              password: 'Manu1234'));
                        },
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: purpleLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            "SignIn",
                            style: TextStyle(color: whitePure, fontSize: 20),
                          )),
                        ),
                        onTap: () {
                          Navigator.of(context).popAndPushNamed('/SignIn');
                          // Impliment event
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
