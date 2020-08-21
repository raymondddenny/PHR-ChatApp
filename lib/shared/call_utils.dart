part of 'shared.dart';

class CallUtils {
  static bool hasCallMade;
  static Call call;

  static dial({User userCaller, User userReceiver, context}) async {
    call = Call(
      callerId: userCaller.id,
      callerName: userCaller.fullName,
      callerPhoto: userCaller.profileImage,
      receiverId: userReceiver.id,
      receiverName: userReceiver.fullName,
      receiverPhoto: userReceiver.profileImage,
      // generate random callRoomId
      callChannedId: randomAlphaNumeric(25),
    );

    bool callMade = await CallServices.makeCall(call: call);
    hasCallMade = callMade;

    call.hasDialled = true;

    // if (callMade) {
    //   // context.bloc<PageBloc>().add(GoToCallScreenPage(call: call));
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => CallScreen(call: call)));
    // }
  }

  static int stateToNum(UserStates userState) {
    switch (userState) {
      case UserStates.Offline:
        return 0;

      case UserStates.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserStates numToState(int number) {
    switch (number) {
      case 0:
        return UserStates.Offline;

      case 1:
        return UserStates.Online;

      default:
        return UserStates.Waiting;
    }
  }
}
