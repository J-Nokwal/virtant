import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtant/model/SignInBloc/signin_bloc.dart';
import 'package:virtant/repositories/userRepository.dart';
import 'package:virtant/screens/SplashScreen.dart';
import 'package:virtant/screens/colors.dart';
import 'package:virtant/screens/widgetTools.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();
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
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccessFullState) {
              Navigator.of(context).pushReplacementNamed('/d',
                  arguments: 'this is home page in debug screen');
            } else if (state is SignInFirebaseNotSetUpState) {
              Navigator.of(context).pushReplacementNamed('/SignUp/SignUpBasic');
            } else if (state is SignInFailureState) {}
          },
          builder: (context, state) {
            if (state is SignInInitialState) {
              return Center(
                child: SingleChildScrollView(
                  child: PopContainer(
                    height: 430,
                    child: BlocProvider(
                      create: (context) =>
                          SignInBloc(userRepository: userRepository),
                      child: Padding(
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
                                    "Login",
                                    style: TextStyle(
                                        color: whitePure, fontSize: 20),
                                  )),
                                ),
                                onTap: () {
                                  // TODO add controller support
                                  SignInBloc(userRepository: userRepository)
                                      .add(SignInButtonPressedEvent(
                                          email: 'email',
                                          password: 'password'));
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
                                    "Sign Up",
                                    style: TextStyle(
                                        color: whitePure, fontSize: 20),
                                  )),
                                ),
                                onTap: () {
                                  Navigator.of(context).popAndPushNamed(
                                      '/signUp',
                                      arguments: '');
                                  // Impliment event
                                },
                              ),
                              SizedBox(height: 15),
                              GestureDetector(
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: redMightBe),
                                ),
                                onTap: () {
                                  // impliment forgot password
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
