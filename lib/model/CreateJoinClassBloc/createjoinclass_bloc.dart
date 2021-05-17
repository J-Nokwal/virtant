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
//TODO Implement CreateClassSuccessFullState end result
//TODO Implement JoinClassSuccessFullState end result
  @override
  Stream<CreateJoinClassState> mapEventToState(
    CreateJoinClassEvent event,
  ) async* {
    final User user = await userRepository.getCurrentUser();
    final ClassFirestore classFirestore = ClassFirestore(user: user);
    String name;
    if (event is CreateClassEvent) {
      yield CreateJoinClassLoadingState();
      Bluetooth bluetooth = Bluetooth();
      String teacherBlueAddress = await bluetooth.getAddres();
      String teacherBlueName = await bluetooth.getName();
      await classFirestore.createClass(
          teacherBlueName: teacherBlueName,
          teacherBlueAddress: teacherBlueAddress,
          teacherName: user.displayName,
          className: event.className,
          classDescription: event.classDescription);
      await userRepository.updateUserName(userName: name);
      yield CreateClassSuccessFullState();
    } else if (event is JoinClassEvent) {
      yield CreateJoinClassLoadingState();
      await classFirestore.joinClass(
          classUid: event.classUid,
          studentName: user.displayName,
          studentRollNo: event.studentRollNo);
      await userRepository.updateUserName(userName: name);
      yield JoinClassSuccessFullState();
    }
  }
}
