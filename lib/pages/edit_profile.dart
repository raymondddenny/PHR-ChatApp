part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  // get current login user
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String profilePath;
  File profileImageFile;
  bool isDataEdited = false;
  bool isUpdating = false;
  TextEditingController nameController;
  TextEditingController jobController;
  TextEditingController alumnusController;
  TextEditingController tempatPraktekController;

  @override
  void initState() {
    super.initState();
    profilePath = widget.user.profileImage;
    nameController = TextEditingController(text: widget.user.fullName);
    jobController = TextEditingController(text: widget.user.job);
    alumnusController = TextEditingController(text: widget.user.alumnus);
    tempatPraktekController =
        TextEditingController(text: widget.user.tempatPraktek);
  }

  @override
  Widget build(BuildContext context) {
    // set Theme
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () {
        (widget.user.status == "Doctor")
            ? context.bloc<PageBloc>().add(GoToMainPage(
                  bottomNavBarIndex: 1,
                ))
            : context.bloc<PageBloc>().add(GoToUserProfilePage());

        return;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                (widget.user.status == "Doctor")
                    ? context.bloc<PageBloc>().add(GoToMainPage(
                          bottomNavBarIndex: 1,
                        ))
                    : context.bloc<PageBloc>().add(GoToUserProfilePage());
              },
            ),
            title: Text("Edit Profile"),
            centerTitle: true,
          ),
          body: (widget.user.status == "Patient")
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 42, bottom: 10),
                            height: 104,
                            width: 90,
                            child: Stack(
                              children: [
                                Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: (profileImageFile != null)
                                                ? FileImage(profileImageFile)
                                                : (profilePath != "no_pic")
                                                    ? NetworkImage(profilePath)
                                                    : AssetImage(
                                                        "images/user_default.png"),
                                            fit: BoxFit.cover))),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (profilePath == "no_pic") {
                                          profileImageFile = await getImage();

                                          if (profileImageFile != null) {
                                            profilePath =
                                                basename(profileImageFile.path);
                                          }
                                        } else {
                                          profileImageFile = null;
                                          profilePath = "no_pic";
                                        }

                                        setState(() {
                                          isDataEdited = (nameController.text
                                                          .trim() !=
                                                      widget.user.fullName ||
                                                  profilePath !=
                                                      widget
                                                          .user.profileImage ||
                                                  jobController.text.trim() !=
                                                      widget.user.job)
                                              ? true
                                              : false;
                                        });
                                      },
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage((profilePath ==
                                                        "no_pic")
                                                    ? "images/btn_add_photo.png"
                                                    : "images/btn_delete_photo.png"))),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          AbsorbPointer(
                            child: TextField(
                              controller:
                                  TextEditingController(text: widget.user.id),
                              style:
                                  blackTextFont.copyWith(color: accentColor3),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "User ID"),
                            ),
                          ),
                          SizedBox(height: 30),
                          AbsorbPointer(
                            child: TextField(
                              controller: TextEditingController(
                                  text: widget.user.email),
                              style:
                                  blackTextFont.copyWith(color: accentColor3),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "User Email"),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: nameController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited =
                                    (text.trim() != widget.user.fullName ||
                                            profilePath !=
                                                widget.user.profileImage ||
                                            jobController.text.trim() !=
                                                widget.user.job)
                                        ? true
                                        : false;
                              });
                            },
                            style: blackTextFont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Full Name",
                              hintText: "Full Name",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: jobController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited =
                                    (text.trim() != widget.user.fullName ||
                                            profilePath !=
                                                widget.user.profileImage ||
                                            jobController.text.trim() !=
                                                widget.user.job)
                                        ? true
                                        : false;
                              });
                            },
                            style: blackTextFont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: (widget.user.status == "Patient")
                                  ? "Your Job"
                                  : "Your Speciality",
                              hintText: "Your Job",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 250,
                            height: 45,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(MdiIcons.alertCircle,
                                      color: Colors.white, size: 20),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Change Password",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: (isUpdating)
                                            ? Color(0xFFBEBEBE)
                                            : Colors.white),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    MdiIcons.alertCircle,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                              disabledColor: Color(0xFFE4E4E4),
                              color: Colors.red[400],
                              onPressed: (isUpdating)
                                  ? null
                                  : () async {
                                      await AuthServices.resetPassword(
                                          widget.user.email);
                                      Flushbar(
                                        duration: Duration(milliseconds: 8000),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: accentColor2,
                                        message:
                                            "The link to change your password has been sent to ${widget.user.email}",
                                      )..show(context);
                                    },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          (isUpdating)
                              ? SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: SpinKitFadingCircle(
                                    color: accentColor2,
                                  ),
                                )
                              : SizedBox(
                                  height: 45,
                                  width: 250,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Update my profile",
                                      style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: (isDataEdited)
                                            ? accentColor7
                                            : Color(0xFFBEBEBE),
                                      ),
                                    ),
                                    disabledColor: accentColor3,
                                    color: mainColor,
                                    onPressed: (isDataEdited)
                                        ? () async {
                                            setState(() {
                                              isUpdating = true;
                                            });
                                            if (profileImageFile != null) {
                                              profilePath = await uploadImage(
                                                  profileImageFile);
                                            }

                                            context
                                                .bloc<UserBloc>()
                                                .add(UpdateUserData(
                                                  fullName: nameController.text,
                                                  profileImage: profilePath,
                                                  job: jobController.text,
                                                ));
                                            context
                                                .bloc<PageBloc>()
                                                .add(GoToUserProfilePage());
                                          }
                                        : null,
                                  ),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 42, bottom: 10),
                            height: 104,
                            width: 90,
                            child: Stack(
                              children: [
                                Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: (profileImageFile != null)
                                                ? FileImage(profileImageFile)
                                                : (profilePath != "no_pic")
                                                    ? NetworkImage(profilePath)
                                                    : AssetImage(
                                                        "images/user_default.png"),
                                            fit: BoxFit.cover))),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (profilePath == "no_pic") {
                                          profileImageFile = await getImage();

                                          if (profileImageFile != null) {
                                            profilePath =
                                                basename(profileImageFile.path);
                                          }
                                        } else {
                                          profileImageFile = null;
                                          profilePath = "no_pic";
                                        }

                                        setState(() {
                                          isDataEdited = (nameController.text
                                                          .trim() !=
                                                      widget.user.fullName ||
                                                  profilePath !=
                                                      widget
                                                          .user.profileImage ||
                                                  jobController.text.trim() !=
                                                      widget.user.job)
                                              ? true
                                              : false;
                                        });
                                      },
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage((profilePath ==
                                                        "no_pic")
                                                    ? "images/btn_add_photo.png"
                                                    : "images/btn_delete_photo.png"))),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          AbsorbPointer(
                            child: TextField(
                              controller:
                                  TextEditingController(text: widget.user.id),
                              style:
                                  blackTextFont.copyWith(color: accentColor3),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "User ID"),
                            ),
                          ),
                          SizedBox(height: 30),
                          AbsorbPointer(
                            child: TextField(
                              controller: TextEditingController(
                                  text: widget.user.email),
                              style:
                                  blackTextFont.copyWith(color: accentColor3),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "User Email"),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: nameController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited =
                                    (text.trim() != widget.user.fullName ||
                                            profilePath !=
                                                widget.user.profileImage ||
                                            jobController.text.trim() !=
                                                widget.user.job)
                                        ? true
                                        : false;
                              });
                            },
                            style: blackTextFont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Full Name",
                              hintText: "Full Name",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: jobController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited =
                                    (text.trim() != widget.user.fullName ||
                                            profilePath !=
                                                widget.user.profileImage ||
                                            jobController.text.trim() !=
                                                widget.user.job)
                                        ? true
                                        : false;
                              });
                            },
                            style: blackTextFont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: (widget.user.status == "Patient")
                                  ? "Your Job"
                                  : "Your Speciality",
                              hintText: "Your Job",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: alumnusController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited =
                                    (text.trim() != widget.user.fullName ||
                                            profilePath !=
                                                widget.user.profileImage ||
                                            jobController.text.trim() !=
                                                widget.user.job)
                                        ? true
                                        : false;
                              });
                            },
                            style: blackTextFont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Alumnus",
                              hintText: "Alumnus",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: tempatPraktekController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited =
                                    (text.trim() != widget.user.fullName ||
                                            profilePath !=
                                                widget.user.profileImage ||
                                            jobController.text.trim() !=
                                                widget.user.job)
                                        ? true
                                        : false;
                              });
                            },
                            style: blackTextFont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Tempat Praktek",
                              hintText: "Tempat Praktek",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 250,
                            height: 45,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(MdiIcons.alertCircle,
                                      color: Colors.white, size: 20),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Change Password",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: (isUpdating)
                                            ? Color(0xFFBEBEBE)
                                            : Colors.white),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    MdiIcons.alertCircle,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                              disabledColor: Color(0xFFE4E4E4),
                              color: Colors.red[400],
                              onPressed: (isUpdating)
                                  ? null
                                  : () async {
                                      await AuthServices.resetPassword(
                                          widget.user.email);
                                      Flushbar(
                                        duration: Duration(milliseconds: 8000),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: accentColor2,
                                        message:
                                            "The link to change your password has been sent to ${widget.user.email}",
                                      )..show(context);
                                    },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          (isUpdating)
                              ? SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: SpinKitFadingCircle(
                                    color: accentColor2,
                                  ),
                                )
                              : SizedBox(
                                  height: 45,
                                  width: 250,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Update my profile",
                                      style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: (isDataEdited)
                                            ? accentColor7
                                            : Color(0xFFBEBEBE),
                                      ),
                                    ),
                                    disabledColor: accentColor3,
                                    color: mainColor,
                                    onPressed: (isDataEdited)
                                        ? () async {
                                            setState(() {
                                              isUpdating = true;
                                            });
                                            if (profileImageFile != null) {
                                              profilePath = await uploadImage(
                                                  profileImageFile);
                                            }

                                            context
                                                .bloc<UserBloc>()
                                                .add(UpdateUserData(
                                                  fullName: nameController.text,
                                                  profileImage: profilePath,
                                                  job: jobController.text,
                                                  alumnus:
                                                      alumnusController.text,
                                                  tempatPraktek:
                                                      tempatPraktekController
                                                          .text,
                                                ));
                                            context
                                                .bloc<PageBloc>()
                                                .add(GoToUserProfilePage());
                                          }
                                        : null,
                                  ),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
