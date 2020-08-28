part of 'pages.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  CallScreen({@required this.call});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  StreamSubscription callStreamSubscription;

  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;

  TextEditingController nameController;
  TextEditingController doctorNameController;
  TextEditingController ageController;
  TextEditingController symptomController;
  TextEditingController currentCondition;
  String patientStatus = "";
  Timestamp dateTime;

  @override
  void initState() {
    super.initState();
    // addPostFrameCallback();
    initializeAgora();
    nameController = TextEditingController(text: widget.call.receiverName);
    nameController = TextEditingController(text: widget.call.callerName);
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
      // case 2:
      //   return SizedBox(
      //       child: Stack(
      //     children: <Widget>[
      //       _expandedVideoRow([views[1]]),
      //       Padding(
      //         padding: const EdgeInsets.fromLTRB(0, 28, 16, 0),
      //         child: Align(
      //             alignment: Alignment.topRight,
      //             child: Container(
      //                 height: 200,
      //                 width: 100,
      //                 child: Container(
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(12),
      //                     ),
      //                     child: _expandedVideoRow([views[0]])))),
      //       )
      //     ],
      //   ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
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

  /// Info panel to show logs
  // Widget _panel() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 48),
  //     alignment: Alignment.bottomCenter,
  //     child: FractionallySizedBox(
  //       heightFactor: 0.5,
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(vertical: 48),
  //         child: ListView.builder(
  //           reverse: true,
  //           itemCount: _infoStrings.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             if (_infoStrings.isEmpty) {
  //               return null;
  //             }
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 vertical: 3,
  //                 horizontal: 10,
  //               ),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Flexible(
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(
  //                         vertical: 2,
  //                         horizontal: 5,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: Colors.yellowAccent,
  //                         borderRadius: BorderRadius.circular(5),
  //                       ),
  //                       child: Text(
  //                         _infoStrings[index],
  //                         style: TextStyle(color: Colors.blueGrey),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  /// Toolbar layout
  // Widget _toolbar() {
  //   return Container(
  //     alignment: Alignment.bottomCenter,
  //     padding: const EdgeInsets.symmetric(vertical: 48),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         RawMaterialButton(
  //           onPressed: _onToggleMute,
  //           child: Icon(
  //             muted ? Icons.mic : Icons.mic_off,
  //             color: muted ? Colors.white : Colors.blueAccent,
  //             size: 20.0,
  //           ),
  //           shape: CircleBorder(),
  //           elevation: 2.0,
  //           fillColor: muted ? Colors.blueAccent : Colors.white,
  //           padding: const EdgeInsets.all(12.0),
  //         ),
  //         RawMaterialButton(
  //           onPressed: () => CallServices.endCall(
  //             call: widget.call,
  //           ),
  //           child: Icon(
  //             Icons.call_end,
  //             color: Colors.white,
  //             size: 35.0,
  //           ),
  //           shape: CircleBorder(),
  //           elevation: 2.0,
  //           fillColor: Colors.redAccent,
  //           padding: const EdgeInsets.all(15.0),
  //         ),
  //         // TODO : tambah timer selama call, lalu ditampilkan di chat screen berapa lama call after call finish
  //         RawMaterialButton(
  //           onPressed: _onSwitchCamera,
  //           child: Icon(
  //             Icons.switch_camera,
  //             color: Colors.blueAccent,
  //             size: 20.0,
  //           ),
  //           shape: CircleBorder(),
  //           elevation: 2.0,
  //           fillColor: Colors.white,
  //           padding: const EdgeInsets.all(12.0),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
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

          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Stack(
                children: <Widget>[
                  _viewRows(),
                  // _panel(),
                  // _toolbar(),
                  Container(
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
                          onPressed: () {
                            // TODO : review app and simpan data pasien (show dialog) oleh dokter
                            if (widget.call.callerStatus == "Patient" &&
                                widget.call.receiverStatus == "Doctor") {
                              showDialog<String>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return RatingDialog(
                                      icon: Image(
                                        image: NetworkImage(
                                            "${widget.call.receiverPhoto}"),
                                        height: 100,
                                      ), // set your own image/icon widget
                                      title: "Doctor Rating Consultation",
                                      description:
                                          "How was the consultation with dr. ${widget.call.receiverName}",
                                      submitButton: "SUBMIT",
                                      // alternativeButton:
                                      //     "Contact us instead?", // optional
                                      positiveComment:
                                          "We are so happy to hear :)", // optional
                                      negativeComment:
                                          "We're sad to hear :(", // optional
                                      accentColor: Colors.red, // optional
                                      onSubmitPressed: (int rating) async {
                                        print(
                                            "onSubmitPressed: rating = $rating");
                                        await UserServices.setDoctorRating(
                                            widget.call.receiverId,
                                            rating.toDouble());
                                      },
                                    );
                                  });

                              CallServices.endCall(
                                call: widget.call,
                              );

                              context
                                  .bloc<PageBloc>()
                                  .add(GoToMainPage(bottomNavBarIndex: 1));
                            } else if (widget.call.callerStatus == "Doctor" &&
                                widget.call.receiverStatus == "Patient") {
                              // TODO : show dialog for record patient record

                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: "Nama Pasien"),
                                      ),
                                      TextField(
                                        controller: doctorNameController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: "Nama Dokter"),
                                      ),
                                      TextField(
                                        controller: ageController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: "Umur Pasien"),
                                      ),
                                      TextField(
                                        controller: symptomController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: "Diagnosa Pasien"),
                                      ),
                                      Container(
                                        height: 50,
                                        child: Column(
                                          children: [
                                            Text("Patient Status"),
                                            RadioListTile(
                                                title: Text("Berobat Jalan"),
                                                value: "Berobat Jalan",
                                                groupValue: patientStatus,
                                                onChanged: (value) {
                                                  setState(() {
                                                    patientStatus = value;
                                                  });
                                                }),
                                            RadioListTile(
                                                title: Text("Rujuk Internal"),
                                                value: "Rujuk Internal",
                                                groupValue: patientStatus,
                                                onChanged: (value) {
                                                  setState(() {
                                                    patientStatus = value;
                                                  });
                                                }),
                                            RadioListTile(
                                                title: Text("Rujuk Lanjut"),
                                                value: "Rujuk Lanjut",
                                                groupValue: patientStatus,
                                                onChanged: (value) {
                                                  setState(() {
                                                    patientStatus = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: Column(
                                        children: [
                                          Text(dateTime == null
                                              ? "Pilih tanggal konsultasi"
                                              : "Tanggal Konsultasi = $dateTime"),
                                          RaisedButton(onPressed: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2010),
                                              lastDate: DateTime(2030),
                                            ).then((date) {
                                              setState(() {
                                                dateTime = Timestamp
                                                    .fromMillisecondsSinceEpoch(
                                                        date.millisecondsSinceEpoch);
                                              });
                                            });
                                          }),
                                        ],
                                      )),
                                      SizedBox(
                                        height: 45,
                                        width: 250,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            "Submit Patient ${widget.call.receiverName} History",
                                            style: whiteTextFont.copyWith(
                                              fontSize: 16,
                                              color: Color(0xFFBEBEBE),
                                            ),
                                          ),
                                          disabledColor: accentColor3,
                                          color: mainColor,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              CallServices.endCall(
                                call: widget.call,
                              );

                              context
                                  .bloc<PageBloc>()
                                  .add(GoToMainPage(bottomNavBarIndex: 1));
                            }
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
                  ),
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
