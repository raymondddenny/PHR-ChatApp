part of 'widgets.dart';

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // to prevent back to this page when back button been pressed
      onWillPop: () => Future.value(false),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              if (userState is UserLoaded) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                  child: userState.user.status == "Doctor"
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Message From Patient Yet.",
                              style: blackTextFont.copyWith(fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Message. Start your consultation now!",
                              style: blackTextFont.copyWith(fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: mainColor,
                              onPressed: () {
                                // context
                                //     .bloc<PageBloc>()
                                //     .add(GoToMainPage(bottomNavBarIndex: 0));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainPage(),
                                    ));
                              },
                              child: Text(
                                "Start Consultation Now",
                                style: whiteTextFont.copyWith(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
