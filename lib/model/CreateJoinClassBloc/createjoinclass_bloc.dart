import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:virtant/repositories/bluetooth.dart';
import 'package:virtant/repositories/firestore.dart';
import 'package:virtant/repositories/userRepository.dart';

part 'createjoinclass_event.dart';
part 'createjoinclass_state.dart';

class CreateJoinClassBloc
    extends Bloc<CreateJoinClassEvent, CreateJoinClassState> {
  final UserRepository userRepository = UserRepository();

  CreateJoinClassBloc() : super(CreateJoinClassInitialState());

  @override
  Stream<CreateJoinClassState> mapEventToState(
    CreateJoinClassEvent event,
  ) async* {
    final User user = await userRepository.getCurrentUser();
    final ClassFirestore classFirestore = ClassFirestore(user: user);
    if (event is CreateClassEvent) {
      yield CreateJoinClassLoadingState();
      Bluetooth bluetooth = Bluetooth();
      String teacherBlueAddress = await bluetooth.getAddres();
      String teacherBlueName = await bluetooth.getName();
      await classFirestore.createClass(
          teacherBlueName: teacherBlueName,
          teacherBlueAddress: teacherBlueAddress,
          teacherName: event.teacherName,
          className: event.className,
          classDescription: event.classDescription);
      await userRepository.updateUserName(userName: event.teacherName);

      yield CreateClassSuccessFullState(classId: user.uid, user: user);
    } else if (event is JoinClassEvent) {
      yield CreateJoinClassLoadingState();
      await classFirestore.joinClass(
          classUid: event.classUid,
          studentName: event.studentName,
          studentRollNo: event.studentRollNo);
      await userRepository.updateUserName(userName: event.studentName);
      yield JoinClassSuccessFullState(user: user);
    }
  }
}
