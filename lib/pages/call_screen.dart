part of 'pages.dart';

class CallScreen extends StatefulWidget {
  final Call call;
  final User caller;
  final User receiver;

  CallScreen({@required this.call, this.caller, this.receiver});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  StreamSubscription callStreamSubscription;
  UserProvider userProvider;

  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool isCalling = true;
  DateTime startTime;
  String elapsed = '00:00:00';

  // void startTimeCall() {
  //   startTime = DateTime.now();
  // }
  void startTimeCall() {
    swatch.start();
  }

  Stopwatch swatch = Stopwatch();

  String showTimeCallDuration() {
    return elapsed = swatch.elapsed.inHours.toString().padLeft(2, "0") +
        "h:" +
        (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        "m:" +
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
        "s";
  }

  @override
  void initState() {
    super.initState();
    addPostFrameCallback(this.context);
    initializeAgora();
    // time call start
    startTimeCall();
  }

  addPostFrameCallback(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);

      callStreamSubscription =
          CallServices.callStream(id: userProvider.getUser.id)
              .listen((DocumentSnapshot ds) {
        // defining the logic
        switch (ds.data) {
          case null:
            // snapshot is null which means that call is hanged and documents are deleted
            // Navigator.pop(context);
            User caller = widget.caller;
            User receiver = widget.receiver;
            if (userProvider.getUser.id == widget.call.callerId) {
              context
                  .bloc<PageBloc>()
                  .add(GoToChatScreenPage(sender: caller, receiver: receiver));
            } else {
              context
                  .bloc<PageBloc>()
                  .add(GoToChatScreenPage(sender: receiver, receiver: caller));
            }

            break;

          default:
            break;
        }
      });
    });
  }

  Future<void> initializeAgora() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(null, widget.call.callChannedId, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'onUserJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUpdatedUserInfo = (AgoraUserInfo userInfo, int i) {
      setState(() {
        final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onRejoinChannelSuccess = (String string, int a, int b) {
      setState(() {
        final info = 'onRejoinChannelSuccess: $string';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onUserOffline = (int a, int b) {
      CallServices.endCall(call: widget.call);
      setState(() {
        final info = 'onUserOffline: a: ${a.toString()}, b: ${b.toString()}';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onRegisteredLocalUser = (String s, int i) {
      setState(() {
        final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onConnectionLost = () {
      setState(() {
        final info = 'onConnectionLost';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      // if call was picked

      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]]),
          ],
        ));
      // case 3:
      //   return Container(
      //       child: Column(
      //     children: <Widget>[
      //       _expandedVideoRow(views.sublist(0, 2)),
      //       _expandedVideoRow(views.sublist(2, 3))
      //     ],
      //   ));
      // case 4:
      //   return Container(
      //       child: Column(
      //     children: <Widget>[
      //       _expandedVideoRow(views.sublist(0, 2)),
      //       _expandedVideoRow(views.sublist(2, 4))
      //     ],
      //   ));
      default:
    }
    return Container();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () async {
              User receiver =
                  await UserServices.getUser(widget.call.receiverId);
              User sender = await UserServices.getUser(widget.call.callerId);
              elapsed = showTimeCallDuration();
              saveCall(receiver, sender);
              CallServices.endCall(call: widget.call);
              // Navigator.pop(this.context);
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    callStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: <Widget>[
              _viewRows(),
              // _panel(),
              _toolbar(),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   padding: const EdgeInsets.symmetric(vertical: 48),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       RawMaterialButton(
              //         onPressed: _onToggleMute,
              //         child: Icon(
              //           muted ? Icons.mic : Icons.mic_off,
              //           color: muted ? Colors.white : Colors.blueAccent,
              //           size: 20.0,
              //         ),
              //         shape: CircleBorder(),
              //         elevation: 2.0,
              //         fillColor: muted ? Colors.blueAccent : Colors.white,
              //         padding: const EdgeInsets.all(12.0),
              //       ),
              //       RawMaterialButton(
              //         onPressed: () async {
              //           User receiver =
              //               await UserServices.getUser(widget.call.receiverId);
              //           User sender =
              //               await UserServices.getUser(widget.call.callerId);
              //           elapsed = showTimeCallDuration();
              //           saveCall(receiver, sender);
              //           CallServices.endCall(call: widget.call);
              //           // Navigator.pop(context);
              //         },
              //         child: Icon(
              //           Icons.call_end,
              //           color: Colors.white,
              //           size: 35.0,
              //         ),
              //         shape: CircleBorder(),
              //         elevation: 2.0,
              //         fillColor: Colors.redAccent,
              //         padding: const EdgeInsets.all(15.0),
              //       ),
              //       RawMaterialButton(
              //         onPressed: _onSwitchCamera,
              //         child: Icon(
              //           Icons.switch_camera,
              //           color: Colors.blueAccent,
              //           size: 20.0,
              //         ),
              //         shape: CircleBorder(),
              //         elevation: 2.0,
              //         fillColor: Colors.white,
              //         padding: const EdgeInsets.all(12.0),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void saveCall(User receiver, User sender) {
    var text = (sender.status == "Doctor")
        ? "call by dr.${widget.call.callerName}"
        : "call by ${widget.call.callerName}";
    Message _message = Message(
        receiverId: widget.call.receiverId,
        senderId: widget.call.callerId,
        receiverName: widget.call.receiverName,
        senderName: widget.call.callerName,
        timeStamp: Timestamp.now(),
        message: text,
        callDuration: elapsed,
        type: "call");
    MessageServices.addMessageToDb(_message, sender, receiver);
  }
}
