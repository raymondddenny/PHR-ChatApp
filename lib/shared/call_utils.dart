part of 'shared.dart';

class CallUtils {
  static bool hasCallMade;
  static Future<bool> hasCall;
  static Call call;

  static dial({User userCaller, User userReceiver, context}) async {
    call = Call(
      callerId: userCaller.id,
      callerName: userCaller.fullName,
      callerPhoto: userCaller.profileImage,
      callerStatus: userCaller.status,
      receiverId: userReceiver.id,
      receiverName: userReceiver.fullName,
      receiverStatus: userReceiver.status,
      receiverPhoto: userReceiver.profileImage,
      // generate random callRoomId
      callChannedId: randomAlphaNumeric(25),
    );

    bool callMade = await CallServices.makeCall(call: call);
    call.hasDialled = true;
    hasCallMade = callMade;
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
        break;
      case 1:
        return UserStates.Online;
        break;
      default:
        return UserStates.Waiting;
    }
  }
}
