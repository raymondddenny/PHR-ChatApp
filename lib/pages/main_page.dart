part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // untuk mengatur navigation bar
  int bottomNavbarIndex;
  // untuk mengatur pageview
  PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomNavbarIndex = 0;
    pageController = PageController(initialPage: bottomNavbarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // TestMainPage(),
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
    );
  }
}

// // Custom BottomNavBarClipper
// class BottomNavBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();

//     path.quadraticBezierTo(0, 20, 20, 20);
//     path.lineTo(size.width * 0.75, 20);

//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
