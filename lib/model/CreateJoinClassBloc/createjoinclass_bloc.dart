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
  final UserRepository userRepository;
  final User user;
  CreateJoinClassBloc({@required this.user, @required this.userRepository})
      : super(CreateJoinClassInitialState());

  @override
  Stream<CreateJoinClassState> mapEventToState(
    CreateJoinClassEvent event,
  ) async* {
    final ClassFirestore classFirestore = ClassFirestore(user: user);
    if (event is CreateClassEvent) {
      yield CreateJoinClassLoadingState();
      await userRepository.updateUserName(userName: event.teacherName);
      yield CreateClassState();
    } else if (event is JoinClassEvent) {
      yield CreateJoinClassLoadingState();
      await userRepository.updateUserName(userName: event.studentName);
      yield JoinClassState();
    } else if (event is CreateClassFinalEvent) {
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
      yield CreateSuccessFullState();
    } else if (event is JoinClassFinalEvent) {
      yield CreateJoinClassLoadingState();
      await classFirestore.joinClass(
          classUid: event.classUid,
          studentName: user.displayName,
          studentRollNo: event.studentRollNo);
      yield JoinSuccessFullState();
    }
  }
}
