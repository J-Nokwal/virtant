import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtant/model/CreateJoinClassBloc/createjoinclass_bloc.dart';
import 'package:virtant/screens/SplashScreen.dart';
import 'package:virtant/screens/colors.dart';

import '../widgetTools.dart';

class SignUpBasicStudentScreen extends StatelessWidget {
  final String displayName;
  final TextEditingController _classUid = TextEditingController();
  final TextEditingController _rollNo = TextEditingController();
  SignUpBasicStudentScreen({Key key, @required this.displayName})
      : super(key: key);
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
          child: PopContainer(
            height: 370,
            child: BlocProvider(
              create: (context) => CreateJoinClassBloc(),
              child: BlocConsumer<CreateJoinClassBloc, CreateJoinClassState>(
                listener: (context, state) {
                  if (state is JoinClassSuccessFullState) {
                    Navigator.of(context)
                        .popAndPushNamed('/d', arguments: 'Student Home page');
                  }
                },
                builder: (context, state) {
                  if (state is CreateJoinClassInitialState) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
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
                                controller: _classUid,
                                decoration: InputDecoration(
                                    enabledBorder: outlineFormInputBorder(),
                                    focusColor: purpleDark,
                                    focusedBorder: outlineFormInputBorder(),
                                    labelStyle: TextStyle(color: purpleLight),
                                    suffixIcon: Icon(
                                      Icons.comment_outlined,
                                      color: purpleLight,
                                    ),
                                    labelText: 'Class Code'),
                                onEditingComplete: () {},
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _rollNo,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    enabledBorder: outlineFormInputBorder(),
                                    focusColor: purpleDark,
                                    focusedBorder: outlineFormInputBorder(),
                                    labelStyle: TextStyle(color: purpleLight),
                                    suffixIcon: Icon(
                                      Icons.subject,
                                      color: purpleLight,
                                    ),
                                    labelText: 'Roll No.'),
                                onEditingComplete: () {},
                              ),
                              SizedBox(height: 30),
                              GestureDetector(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: purpleLight,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Join Class",
                                    style: TextStyle(
                                        color: whitePure, fontSize: 20),
                                  )),
                                ),
                                onTap: () {
                                  BlocProvider.of<CreateJoinClassBloc>(context)
                                      .add(JoinClassEvent(
                                          classUid: _classUid.text,
                                          studentRollNo:
                                              int.parse(_rollNo.text),
                                          studentName: displayName));
                                },
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return SplashScreen();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
