import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtant/model/SignUpBloc/signup_bloc.dart';
import 'package:virtant/screens/SplashScreen.dart';
import 'package:virtant/screens/colors.dart';
import 'package:virtant/screens/widgetTools.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signInFormKey = GlobalKey<FormState>();

  bool _secureText = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();
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
              child: BlocProvider(
                create: (context) => SignUpBloc(),
                child: BlocConsumer<SignUpBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessFullState) {
                      Navigator.of(context)
                          .popAndPushNamed('/SignUp/SignUpBasic');
                    }
                  },
                  builder: (context, state) {
                    if (state is SignUpInitialState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
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
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
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
                                controller: _password,
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
                                controller: _passwordConfirm,
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
                                    style: TextStyle(
                                        color: whitePure, fontSize: 20),
                                  )),
                                ),
                                onTap: () {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignupButtonPressedEvent(
                                          email: _email.text,
                                          password: _password.text,
                                          passwordConfirm:
                                              _passwordConfirm.text));
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
                                    style: TextStyle(
                                        color: whitePure, fontSize: 20),
                                  )),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .popAndPushNamed('/SignIn');
                                },
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      );
                    }

                    return SplashContainer();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
