part of 'pages.dart';

class PickupLayout extends StatefulWidget {
  final Widget scaffold;
  PickupLayout({this.scaffold});

  @override
  _PickupLayoutState createState() => _PickupLayoutState();
}

class _PickupLayoutState extends State<PickupLayout> {
  User caller;
  User receiver;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return StreamBuilder<DocumentSnapshot>(
            stream: CallServices.callStream(id: userState.user.id),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data != null) {
                Call call = Call.fromMap(snapshot.data.data);
                // get caller
                UserServices.getUser(call.callerId).then((value) {
                  print(value);
                  setState(() {
                    return caller = value;
                    // User(
                    //   value.id,
                    //   value.email,
                    //   alumnus: value.alumnus,
                    //   fullName: value.fullName,
                    //   job: value.job,
                    //   noSIP: value.noSIP,
                    //   profileImage: value.profileImage,
                    //   ratingNum: value.ratingNum,
                    //   state: value.state,
                    //   status: value.status,
                    //   tempatPraktek: value.tempatPraktek,
                    // );
                  });
                });
                // get receiver
                UserServices.getUser(call.receiverId).then((value) {
                  setState(() {
                    return receiver = value;
                    // User(
                    //   value.id,
                    //   value.email,
                    //   alumnus: value.alumnus,
                    //   fullName: value.fullName,
                    //   job: value.job,
                    //   noSIP: value.noSIP,
                    //   profileImage: value.profileImage,
                    //   ratingNum: value.ratingNum,
                    //   state: value.state,
                    //   status: value.status,
                    //   tempatPraktek: value.tempatPraktek,
                    // );
                  });
                });
                // to differentiate the caller and receiver
                // hasDialled true for caller, false for receiver
                if (call.hasDialled == false) {
                  // hasDialled false for receiver, then show pickup Screen
                  return PickUpScreen(
                    call: call,
                    caller: caller,
                    receiver: receiver,
                  );
                }
                // hasDialled true for caller, then dont show pickup screen
                return widget.scaffold;
              }
              return widget.scaffold;
            },
          );
        } else {
          return WelcomeIntroLogo();
        }
      },
    );
  }
}

class WelcomeIntroLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor5.withOpacity(0.1),
      body: Center(
        child: Container(
          child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.bounceInOut,
              child: Image(image: AssetImage("images/logo.png"))),
        ),
      ),
    );
  }
}
