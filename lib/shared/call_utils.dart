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
}
