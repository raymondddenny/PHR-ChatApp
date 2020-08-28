part of 'pages.dart';

class SeeDoctorPage extends StatefulWidget {
  final User doctorUser;
  SeeDoctorPage({this.doctorUser});

  @override
  _SeeDoctorPageState createState() => _SeeDoctorPageState();
}

class _SeeDoctorPageState extends State<SeeDoctorPage> {
  String profilePath;
  File profileImageFile;

  @override
  void initState() {
    super.initState();
    profilePath = widget.doctorUser.profileImage;
  }

  @override
  Widget build(BuildContext context) {
    // set Theme
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.bloc<PageBloc>().add(
                    GoToMainPage(bottomNavBarIndex: 0),
                  );
            },
          ),
          title: Text(
            "Profile",
            style: blackTextFont.copyWith(fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          // padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 42, bottom: 20),
                    // height: 104,
                    // width: 90,
                    child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (profileImageFile != null)
                                    ? FileImage(profileImageFile)
                                    : (profilePath != "")
                                        ? NetworkImage(profilePath)
                                        : AssetImage("images/user_default.png"),
                                fit: BoxFit.cover))),
                  ),
                  Text(
                    widget.doctorUser.fullName,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(
                        fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.doctorUser.job,
                    style: greyTextFont.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alumnus",
                          style: greyTextFont,
                        ),
                        AbsorbPointer(
                          child: TextFormField(
                            style: blackTextFont.copyWith(
                                fontWeight: FontWeight.w400),
                            initialValue: widget.doctorUser.alumnus,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Tempat Praktik",
                          style: greyTextFont,
                        ),
                        AbsorbPointer(
                          child: TextFormField(
                            style: blackTextFont.copyWith(
                                fontWeight: FontWeight.w400),
                            initialValue: widget.doctorUser.tempatPraktek,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "No. SIP",
                          style: greyTextFont,
                        ),
                        AbsorbPointer(
                          child: TextFormField(
                            style: blackTextFont.copyWith(
                                fontWeight: FontWeight.w400),
                            initialValue: widget.doctorUser.noSIP,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        return SizedBox(
                          height: 45,
                          width: 250,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Start Consultation",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: accentColor7,
                              ),
                            ),
                            color: mainColor,
                            onPressed: () async {
                              context.bloc<PageBloc>().add(GoToChatScreenPage(
                                  receiver: widget.doctorUser,
                                  sender: userState.user));
                            },
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
