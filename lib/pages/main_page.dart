part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;

  MainPage({this.bottomNavBarIndex = 0});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  // untuk mengatur navigation bar
  int bottomNavbarIndex;
  // untuk mengatur pageview
  PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomNavbarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavbarIndex);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            UserServices.setUserState(
                userId: userState.user.id, userStates: UserStates.Online);
            return Container();
          } else {
            return SpinKitFadingCircle(
              color: accentColor2,
              size: 50,
            );
          }
        },
      );
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId;
    BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          currentUserId = userState.user.id;
          return null;
        } else {
          return null;
        }
      },
    );

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? UserServices.setUserState(
                userId: currentUserId, userStates: UserStates.Online)
            : print("resumed state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? UserServices.setUserState(
                userId: currentUserId, userStates: UserStates.Offline)
            : print("Inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? UserServices.setUserState(
                userId: currentUserId, userStates: UserStates.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? UserServices.setUserState(
                userId: currentUserId, userStates: UserStates.Offline)
            : print("Detached state");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        body: Stack(
          children: [
            Container(
              color: mainColor,
            ),
            SafeArea(child: Container(color: Colors.white)),
            PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  bottomNavbarIndex = index;
                });
              },
              children: [
                DoctorPage(DoctorType()),
                ChatListScreen(),
                HospitalPage(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          color: mainColor,
          buttonBackgroundColor: mainColor,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 200),
          animationCurve: Curves.bounceInOut,
          index: bottomNavbarIndex,
          items: <Widget>[
            Icon(
              Icons.perm_contact_calendar,
              size: 28,
              color: accentColor2,
            ),
            Icon(
              Icons.chat,
              size: 28,
              color: accentColor2,
            ),
            Icon(
              Icons.map,
              size: 28,
              color: accentColor2,
            ),
          ],
          onTap: (index) {
            setState(() {
              bottomNavbarIndex = index;
              pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }
}
