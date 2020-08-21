part of 'pages.dart';

class PickUpScreen extends StatelessWidget {
  final Call call;
  PickUpScreen({@required this.call});

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
              call.callerPhoto,
              height: 200,
              width: 200,
              isRounded: true,
              radius: 180,
            ),
            SizedBox(
              height: 20,
            ),
            Text(call.callerName,
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
                    onPressed: () async => await Permissions
                            .cameraAndMicrophonePermissionsGranted()
                        ? context
                            .bloc<PageBloc>()
                            .add(GoToCallScreenPage(call: call))
                        : {}),
                SizedBox(
                  width: 25,
                ),
                IconButton(
                    icon: Icon(Icons.call_end, color: Colors.red),
                    onPressed: () async {
                      await CallServices.endCall(call: call);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
