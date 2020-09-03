part of 'pages.dart';

class PickUpScreen extends StatefulWidget {
  final Call call;
  final User caller;
  final User receiver;
  PickUpScreen({@required this.call, this.caller, this.receiver});

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  // bool isStop = true;
  // int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Incoming calls",
              style: blackTextFont.copyWith(fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            CachedImage(
              widget.call.callerPhoto,
              height: 200,
              width: 200,
              isRounded: true,
              radius: 180,
            ),
            SizedBox(
              height: 20,
            ),
            Text(widget.call.callerName,
                style: blackTextFont.copyWith(
                  fontSize: 20,
                )),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.call, color: Colors.green),
                    onPressed: () async {
                      bool getPermission = await Permissions
                          .cameraAndMicrophonePermissionsGranted();
                      if (getPermission) {
                        context.bloc<PageBloc>().add(GoToCallScreenPage(
                            call: widget.call,
                            sender: widget.caller,
                            receiver: widget.receiver));
                      }
                    }),
                SizedBox(
                  width: 25,
                ),
                IconButton(
                    icon: Icon(Icons.call_end, color: Colors.red),
                    onPressed: () async {
                      await CallServices.endCall(call: widget.call);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
