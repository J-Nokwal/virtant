import 'package:flutter/material.dart';
import 'package:virtant/model/CreateJoinClassBloc/createjoinclass_bloc.dart';
import 'package:virtant/screens/colors.dart';
import '../widgetTools.dart';

class SignUpBasicTeacherScreen extends StatelessWidget {
  final String displayName;

  const SignUpBasicTeacherScreen({Key key, @required this.displayName})
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
            child: SingleChildScrollView(
          child: PopContainer(
            height: 500,
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
                            Icons.account_circle,
                            color: purpleLight,
                          ),
                          labelText: 'Class Name'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: outlineFormInputBorder(),
                          focusColor: purpleDark,
                          focusedBorder: outlineFormInputBorder(),
                          labelStyle: TextStyle(color: purpleLight),
                          suffixIcon: Icon(
                            Icons.description,
                            color: purpleLight,
                          ),
                          labelText: 'Subject'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: outlineFormInputBorder(),
                          focusColor: purpleDark,
                          focusedBorder: outlineFormInputBorder(),
                          labelStyle: TextStyle(color: purpleLight),
                          suffixIcon: Icon(
                            Icons.description,
                            color: purpleLight,
                          ),
                          alignLabelWithHint: true,
                          labelText: 'Description'),
                      maxLines: 3,
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
                          "Create Class",
                          style: TextStyle(color: whitePure, fontSize: 20),
                        )),
                      ),
                      onTap: () {
                        //TODO implement controller
                        CreateJoinClassBloc().add(
                          CreateClassEvent(
                              className: 'className',
                              classSubject: 'classSubject',
                              classDescription: 'classDescription',
                              teacherName: 'teacherName'),
                        );
                      },
                    ),
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
