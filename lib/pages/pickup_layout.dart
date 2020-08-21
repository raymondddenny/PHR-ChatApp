part of 'pages.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  PickupLayout({this.scaffold});

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

                // to differentiate the caller and receiver
                // hasDialled true for caller, false for receiver
                if (call.hasDialled == false) {
                  // hasDialled false for receiver, then show pickup Screen
                  return PickUpScreen(call: call);
                }
                // hasDialled true for caller, then dont show pickup screen
                return scaffold;
              }
              return scaffold;
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
