part of 'pages.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  CallScreen({@required this.call});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  StreamSubscription callStreamSubscription;

  @override
  void dispose() {
    super.dispose();
    callStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            callStreamSubscription =
                CallServices.callStream(id: userState.user.id)
                    .listen((DocumentSnapshot ds) {
              switch (ds.data) {
                case null:
                  // snapshot is null which means no data, call is hanged and document in call is deleted
                  context.bloc<PageBloc>().add(GoToMainPage());
                  break;
                default:
                  break;
              }
            });
          });

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
        } else {
          return SpinKitFadingCircle();
        }
      },
    );
  }
}
