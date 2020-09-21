part of 'pages.dart';

class ChatScreenPage extends StatefulWidget {
  final User receiver;
  final User sender;
  ChatScreenPage({this.receiver, this.sender});

  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  bool isConsultationDone = false;

  ImageUploadProvider _imageUploadProvider;
  @override
  Widget build(BuildContext context) {
    // set Theme
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return WillPopScope(onWillPop: () async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Konfirmasi selesai konsultasi",
              style: blackTextFont,
            ),
            content: Text(
              "Apakah anda sudah selesai melakukan konsultasi ?",
              style: greyTextFont,
            ),
            actions: [
              RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      isConsultationDone = true;
                      Navigator.pop(context);
                      if (widget.sender.status == "Patient") {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return RatingDialog(
                                icon: Image(
                                  image: NetworkImage(
                                      "${widget.receiver.profileImage}"),
                                  height: 100,
                                ), // set your own image/icon widget
                                title: "Doctor Rating Consultation",
                                description:
                                    "How was the consultation with dr. ${widget.receiver.fullName}",
                                submitButton: "SUBMIT",
                                // alternativeButton:
                                //     "Contact us instead?", // optional
                                positiveComment:
                                    "We are so happy to hear :)", // optional
                                negativeComment:
                                    "We're sad to hear :(", // optional
                                accentColor: Colors.red, // optional
                                onSubmitPressed: (int rating) async {
                                  print("onSubmitPressed: rating = $rating");
                                  await UserServices.setDoctorRating(
                                      widget.receiver.id, rating.toDouble());
                                },
                              );
                            });
                        context
                            .bloc<PageBloc>()
                            .add(GoToMainPage(bottomNavBarIndex: 0));
                      } else {
                        Call call = Call(
                          callerId: widget.sender.id,
                          callerName: widget.sender.fullName,
                          callerStatus: widget.sender.status,
                          receiverId: widget.receiver.id,
                          receiverName: widget.receiver.fullName,
                          receiverStatus: widget.receiver.status,
                        );
                        context
                            .bloc<PageBloc>()
                            .add(GoToHistoryPatientPage(call));
                      }
                    });
                  },
                  child: Text(
                    "Yes",
                    style: blackTextFont,
                  )),
              RaisedButton(
                  color: mainColor,
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "No",
                    style: whiteTextFont,
                  )),
            ],
            elevation: 24.0,
          );
        },
      );

      return;
    }, child: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
      return PickupLayout(
        scaffold: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Konfirmasi selesai konsultasi",
                          style: blackTextFont,
                        ),
                        content: Text(
                          "Apakah anda sudah selesai melakukan konsultasi ?",
                          style: greyTextFont,
                        ),
                        actions: [
                          RaisedButton(
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  isConsultationDone = true;
                                  Navigator.pop(context);
                                  if (widget.sender.status == "Patient") {
                                    showDialog<String>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return RatingDialog(
                                            icon: Image(
                                              image: NetworkImage(
                                                  "${widget.receiver.profileImage}"),
                                              height: 100,
                                            ), // set your own image/icon widget
                                            title: "Doctor Rating Consultation",
                                            description:
                                                "How was the consultation with dr. ${widget.receiver.fullName}",
                                            submitButton: "SUBMIT",
                                            // alternativeButton:
                                            //     "Contact us instead?", // optional
                                            positiveComment:
                                                "We are so happy to hear :)", // optional
                                            negativeComment:
                                                "We're sad to hear :(", // optional
                                            accentColor: Colors.red, // optional
                                            onSubmitPressed:
                                                (int rating) async {
                                              print(
                                                  "onSubmitPressed: rating = $rating");
                                              await UserServices
                                                  .setDoctorRating(
                                                      widget.receiver.id,
                                                      rating.toDouble());
                                            },
                                          );
                                        });
                                    context.bloc<PageBloc>().add(
                                        GoToMainPage(bottomNavBarIndex: 0));
                                  } else {
                                    Call call = Call(
                                      callerId: widget.sender.id,
                                      callerName: widget.sender.fullName,
                                      callerStatus: widget.sender.status,
                                      receiverId: widget.receiver.id,
                                      receiverName: widget.receiver.fullName,
                                      receiverStatus: widget.receiver.status,
                                    );
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToHistoryPatientPage(call));
                                  }
                                });
                              },
                              child: Text(
                                "Yes",
                                style: blackTextFont,
                              )),
                          RaisedButton(
                              color: mainColor,
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                "No",
                                style: whiteTextFont,
                              )),
                        ],
                        elevation: 24.0,
                      );
                    },
                  );
                },
              ),
              title: Column(
                children: [
                  Text(widget.receiver.fullName,
                      style: whiteTextFont.copyWith(fontSize: 18)),
                  Text(
                    widget.receiver.job,
                    style: greyTextFont.copyWith(fontSize: 14),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Container(
                    width: 48,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.receiver.profileImage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Flexible(
                  child: ChatMessageScreen(
                receiver: widget.receiver,
                sender: widget.sender,
              )),
              _imageUploadProvider.getViewState == ViewState.LOADING
                  ? Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 20),
                      child: CircularProgressIndicator(
                        backgroundColor: accentColor2,
                      ),
                    )
                  : Container(),
              SizedBox(height: 10),
              ChatBottomControl(
                receiver: widget.receiver,
                sender: widget.sender,
              ),
            ],
          ),
        ),
      );
    }));
  }
}

class ChatMessageScreen extends StatefulWidget {
  final User sender;
  final User receiver;

  ChatMessageScreen({this.sender, this.receiver});

  @override
  _ChatMessageScreenState createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  @override
  Widget build(BuildContext context) {
    String _currentUserId = widget.sender.id.toString();
    return StreamBuilder(
        stream: Firestore.instance
            .collection("messages")
            .document(_currentUserId)
            .collection(widget.receiver.id)
            .orderBy("timeStamp", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: SpinKitFadingCircle(
                color: accentColor2,
                size: 30,
              ),
            );
          }

          // return DashChat(messages: null, user: null, onSend: null);
          return ListView.builder(
              padding: EdgeInsets.all(defaultMargin),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              itemBuilder: (context, index) {
                return ChatMessageItem(
                    snapshot.data.documents[index], _currentUserId);
              });
        });
  }
}

class ChatMessageItem extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String _currentUserId;
  ChatMessageItem(this.documentSnapshot, this._currentUserId);

  @override
  _ChatMessageItemState createState() => _ChatMessageItemState();
}

bool isShowDate = false;

class _ChatMessageItemState extends State<ChatMessageItem> {
  setShowDate(bool val) {
    setState(() {
      isShowDate = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Message _message = Message.fromMap(widget.documentSnapshot.data);
    // var date = DateFormat.yMMMd().format(_message.timeStamp.toDate());
    // var dateNow = DateFormat.yMMMd().format(DateTime.now());
    // int check = 0;
    // if ((date == dateNow) && check > 0) {
    //   setShowDate(true);
    //   setState(() {
    //     check++;
    //   });
    // } else {
    //   setShowDate(false);
    // }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: (_message.senderId == widget._currentUserId)
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: (_message.senderId == widget._currentUserId)
            ? senderLayout(_message, context)
            : receiverLayout(_message, context),
      ),
    );
  }

  // to show the message from the sender
  Widget senderLayout(Message message, BuildContext context) {
    Radius messageRadius = Radius.circular(5);
    String time = DateFormat.jm().add_MMMd().format(message.timeStamp.toDate());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Center(
        //   child: Container(
        //     padding: EdgeInsets.all(3),
        //     decoration: BoxDecoration(
        //       color: Colors.grey[300],
        //       borderRadius: BorderRadius.circular(18),
        //     ),
        //     child: Text(date),
        //   ),
        // ),
        (message.type == "image")
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          // to see image in new page
                          builder: (context) => ViewImage(message)));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                      color: accentColor1,
                      borderRadius: BorderRadius.only(
                        bottomLeft: messageRadius,
                        topLeft: messageRadius,
                        bottomRight: messageRadius,
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: getMessage(message, context),
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: accentColor1,
                    borderRadius: BorderRadius.only(
                      bottomLeft: messageRadius,
                      topLeft: messageRadius,
                      bottomRight: messageRadius,
                    )),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: getMessage(message, context),
                ),
              ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            time,
            style: greyTextFont,
          ),
        ),
      ],
    );
  }

  // to show the message from the receiver
  Widget receiverLayout(Message message, BuildContext context) {
    Radius messageRadius = Radius.circular(5);
    String time = DateFormat.jm().format(message.timeStamp.toDate());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (message.type == "image")
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewImage(message)));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                      color: accentColor2,
                      borderRadius: BorderRadius.only(
                        bottomLeft: messageRadius,
                        topRight: messageRadius,
                        bottomRight: messageRadius,
                      )),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: getMessage(message, context)),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: accentColor2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: messageRadius,
                      topRight: messageRadius,
                      bottomRight: messageRadius,
                    )),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: getMessage(message, context)),
              ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            time,
            style: greyTextFont,
          ),
        ),
      ],
    );
  }

// Send Image
  getMessage(Message message, BuildContext context) {
    return (message.type == "image")
        ? (message.photoUrl != null)
            ? CachedImage(
                message.photoUrl,
                height: 250,
                width: 250,
                radius: 10,
              )
            : Text("no image url")
        : (message.type == "call")
            ? Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      Icons.call_end,
                      color: Colors.grey[300],
                      size: 38,
                    ),
                    Text(
                      message.callDuration,
                      style: greyTextFont.copyWith(
                          color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              )
            : Text(
                message.message,
                style: whiteTextFont.copyWith(fontSize: 16),
              );
  }
}

class ChatBottomControl extends StatefulWidget {
  final User receiver;
  final User sender;

  ChatBottomControl({this.receiver, this.sender});

  @override
  _ChatBottomControlState createState() => _ChatBottomControlState();
}

class _ChatBottomControlState extends State<ChatBottomControl> {
  TextEditingController textChatController = TextEditingController();

  bool isWriting = false;
  bool isStop = true;
  int counter = 0;
  bool showDate = false;

  setWritingTo(bool val) {
    setState(() {
      isWriting = val;
    });
  }

  ImageUploadProvider _imageUploadProvider;

  @override
  Widget build(BuildContext context) {
    final String receiverName = widget.receiver.fullName;
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return Container(
      // color: Colors.red,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 3.0,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, right: 8, top: 2),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 5,
                minLines: 1,
                controller: textChatController,
                style: blackTextFont,
                onChanged: (val) {
                  (val.length > 0 && val.trim() != "")
                      ? setWritingTo(true)
                      : setWritingTo(false);
                },
                decoration: InputDecoration(
                  hintText: (widget.receiver.status == "Doctor")
                      ? "Tulis pesan untuk dr.$receiverName ..."
                      : "Tulis pesan untuk $receiverName ...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
            ),
            // *image button
            (isWriting)
                ? Container()
                : Container(
                    padding: EdgeInsets.all(0),
                    width: 32,
                    child: IconButton(
                        icon: Icon(
                          Icons.image,
                          size: 28,
                          color: mainColor,
                        ),
                        onPressed: () async {
                          File selectedImage = await getImage();
                          uploadImageMessage(
                              image: selectedImage,
                              receiver: widget.receiver,
                              sender: widget.sender,
                              imageUploadProvider: _imageUploadProvider);
                        })),
            // *camera button
            (isWriting)
                ? Container()
                : Container(
                    padding: EdgeInsets.all(0),
                    width: 32,
                    child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 28,
                          color: mainColor,
                        ),
                        onPressed: () async {
                          File selectedImage = await getImageCamera();
                          uploadImageMessage(
                              image: selectedImage,
                              receiver: widget.receiver,
                              sender: widget.sender,
                              imageUploadProvider: _imageUploadProvider);
                        })),
            // *vidcall button
            (isWriting)
                ? Container()
                : Container(
                    padding: EdgeInsets.all(0),
                    width: 38,
                    child: IconButton(
                        icon: Icon(
                          Icons.video_call,
                          size: 32,
                          color: mainColor,
                        ),
                        onPressed: () async {
                          bool getPermission = await Permissions
                              .cameraAndMicrophonePermissionsGranted();
                          if (getPermission) {
                            await CallUtils.dial(
                              context: context,
                              userCaller: widget.sender,
                              userReceiver: widget.receiver,
                            );
                            bool hasCallMade = CallUtils.hasCallMade;
                            if (hasCallMade == true) {
                              Call call = CallUtils.call;
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => CallScreen(
                              //         call: call,
                              //       ),
                              //     ));
                              context.bloc<PageBloc>().add(GoToCallScreenPage(
                                  call: call,
                                  sender: widget.sender,
                                  receiver: widget.receiver));
                            }
                          } else {}
                        }),
                  ),
            // *send button
            (isWriting)
                ? Container(
                    width: 38,
                    margin: EdgeInsets.only(left: 10),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: mainColor),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 18,
                          color: accentColor2,
                        ),
                        onPressed: () {
                          sendMessage();
                        }),
                  )
                : Container(),
            SizedBox(
              width: 8,
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    var text = textChatController.text;
    Message _message = Message(
      receiverId: widget.receiver.id,
      senderId: widget.sender.id,
      message: text,
      timeStamp: Timestamp.now(),
      type: 'text',
      receiverName: widget.receiver.fullName,
      senderName: widget.sender.fullName,
    );

    // when send message tap
    setState(() {
      isWriting = false;
      textChatController.text = "";
      showDate = false;
    });

    MessageServices.addMessageToDb(_message, widget.sender, widget.receiver);
  }
}
