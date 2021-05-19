import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtant/model/CreateJoinClassBloc/createjoinclass_bloc.dart';
import 'package:virtant/screens/SplashScreen.dart';
import 'package:virtant/screens/colors.dart';
import '../widgetTools.dart';

class SignUpBasicTeacherScreen extends StatelessWidget {
  final String displayName;
  final TextEditingController _className = TextEditingController();
  final TextEditingController _classSubject = TextEditingController();
  final TextEditingController _classDescription = TextEditingController();
  SignUpBasicTeacherScreen({Key key, @required this.displayName})
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
            child: BlocProvider(
              create: (context) => CreateJoinClassBloc(),
              child: BlocConsumer<CreateJoinClassBloc, CreateJoinClassState>(
                listener: (context, state) {
                  if (state is CreateClassSuccessFullState) {
                    //implement popup
                    FlutterClipboard.copy(state.classId).then(
                        (value) => print('${state.classId} copy to clipboard'));
                    Navigator.of(context)
                        .popAndPushNamed('/d', arguments: 'teacher home page');
                  }
                },
                builder: (context, state) {
                  if (state is CreateJoinClassInitialState) {
                    return Padding(
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
                              controller: _className,
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
                              controller: _classSubject,
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
                              controller: _classDescription,
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
                            InkWell(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: purpleLight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: Text(
                                  "Create Class",
                                  style:
                                      TextStyle(color: whitePure, fontSize: 20),
                                )),
                              ),
                              onTap: () {
                                BlocProvider.of<CreateJoinClassBloc>(context)
                                    .add(
                                  CreateClassEvent(
                                      className: _className.text,
                                      classSubject: _classSubject.text,
                                      classDescription: _classDescription.text,
                                      teacherName: displayName),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is CreateClassSuccessFullState) {}
                  return SplashContainer();
                },
              ),
            ),
          ),
        )),
      ),
    );
  }
}
