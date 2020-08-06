part of 'pages.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  CallScreen({@required this.call});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Call has been made"),
            FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.call_end,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await CallServices.endCall(call: widget.call);
                  context.bloc<PageBloc>().add(GoToMainPage());
                })
          ],
        ),
      ),
    );
  }
}
