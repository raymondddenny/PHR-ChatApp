part of 'pages.dart';

class DoctorRegistrationPage extends StatefulWidget {
  // untuk menyimpan data registrasi
  final RegistrationUserData registrationUserData;
  DoctorRegistrationPage(this.registrationUserData);

  @override
  _DoctorRegistrationPageState createState() => _DoctorRegistrationPageState();
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController noSipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.registrationUserData.fullName;
    emailController.text = widget.registrationUserData.email;
    jobController.text = widget.registrationUserData.job;
    noSipController.text = widget.registrationUserData.noSIP;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToRegistrationPage());
        return;
      },
      child: Scaffold(
        backgroundColor: accentColor5.withOpacity(0.1),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  // app bar
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToWelcomePage());
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 24, color: accentColor5),
                          ),
                        ),
                        Center(
                            child: Text(
                          "Create New\n Doctor Account",
                          style: whiteTextFont.copyWith(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                  Container(
                    height: 104,
                    width: 90,
                    child: Stack(
                      children: [
                        // container untuk background photo
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (widget.registrationUserData
                                            .profilePicture ==
                                        null
                                    ? AssetImage("images/user_default.png")
                                    : FileImage(widget
                                        .registrationUserData.profilePicture)),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationUserData.profilePicture ==
                                  null) {
                                widget.registrationUserData.profilePicture =
                                    await getImage();
                              } else {
                                widget.registrationUserData.profilePicture =
                                    null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage((widget
                                                  .registrationUserData
                                                  .profilePicture ==
                                              null
                                          ? "images/btn_add_photo.png"
                                          : "images/btn_delete_photo.png")))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    style: TextStyle(color: accentColor1),
                    controller: fullNameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor1)),
                        labelText: "Full Name",
                        labelStyle: TextStyle(color: accentColor1),
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: accentColor1)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: TextStyle(color: accentColor1),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor1)),
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: accentColor1),
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: accentColor1)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: TextStyle(color: accentColor1),
                    controller: jobController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor1)),
                        labelText: "Your Speciality, ex : Dokter Anak",
                        labelStyle: TextStyle(color: accentColor1),
                        hintText: "Your Speciality, ex : Dokter Anak",
                        hintStyle: TextStyle(color: accentColor1)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: TextStyle(color: accentColor1),
                    controller: noSipController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor1)),
                        labelText: "Nomor SIP",
                        labelStyle: TextStyle(color: accentColor1),
                        hintText: "Nomor SIP",
                        hintStyle: TextStyle(color: accentColor1)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: accentColor1),
                    controller: passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor1)),
                        labelText: "Password",
                        labelStyle: TextStyle(color: accentColor1),
                        hintText: "Password",
                        hintStyle: TextStyle(color: accentColor1)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: accentColor1),
                    controller: retypeController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor1)),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: accentColor1),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: accentColor1)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                      backgroundColor: mainColor,
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        // jika semua field kosong
                        if ((fullNameController.text.trim() == "" &&
                            emailController.text.trim() == "" &&
                            jobController.text.trim() == "" &&
                            noSipController.text.trim() == "" &&
                            passwordController.text.trim() == "" &&
                            retypeController.text.trim() == "")) {
                          Flushbar(
                            duration: Duration(milliseconds: 5500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: "Please fill all the text fields",
                          )..show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Flushbar(
                            duration: Duration(milliseconds: 4500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message:
                                "Email format wrong, please check email format again",
                          )..show(context);
                        } else if (passwordController.text !=
                            retypeController.text) {
                          Flushbar(
                            duration: Duration(milliseconds: 4500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: "Mismatch password and confirm password",
                          )..show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            duration: Duration(
                              milliseconds: 4500,
                            ),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message:
                                "Password is too short, please input password more than 6 character",
                          )..show(context);
                        } else {
                          // jika semua data validasi lolos
                          // isi registration data
                          // As a doctor
                          widget.registrationUserData.fullName =
                              fullNameController.text;
                          widget.registrationUserData.email =
                              emailController.text;
                          widget.registrationUserData.job = jobController.text;
                          widget.registrationUserData.noSIP =
                              noSipController.text;
                          widget.registrationUserData.password =
                              passwordController.text;
                          widget.registrationUserData.status = "Doctor";
                          // GOTO Confirmation Page
                          context.bloc<PageBloc>().add(GoToConfirmationPage(
                              widget.registrationUserData));
                        }
                      }),
                  SizedBox(
                    height: 30,
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
