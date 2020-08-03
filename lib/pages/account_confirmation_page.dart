part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationUserData registrationUserData;

  AccountConfirmationPage(this.registrationUserData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSignInUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        (widget.registrationUserData.status == "Doctor")
            ? context
                .bloc<PageBloc>()
                .add(GoToRegistrationDoctorPage(widget.registrationUserData))
            : context
                .bloc<PageBloc>()
                .add(GoToRegistrationUserPage(widget.registrationUserData));
        return;
      },
      child: Scaffold(
        backgroundColor: accentColor1.withOpacity(0.8),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 90),
                    height: 66,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToRegistrationUserPage(
                                      widget.registrationUserData));
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 24, color: Colors.white),
                          ),
                        ),
                        Center(
                            child: Text(
                          "Confirm New\nAccount",
                          style: whiteTextFont.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (widget.registrationUserData.profilePicture !=
                                  null)
                              ? FileImage(
                                  widget.registrationUserData.profilePicture)
                              : AssetImage("images/user_default.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Text(
                    "Welcome",
                    style: whiteTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    (widget.registrationUserData.status == "Doctor")
                        ? "dr.${widget.registrationUserData.fullName}"
                        : "${widget.registrationUserData.fullName}",
                    style: whiteTextFont.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  (isSignInUp)
                      ? SpinKitCircle(
                          color: accentColor2,
                          size: 45,
                        )
                      : SizedBox(
                          height: 45,
                          width: 250,
                          child: RaisedButton(
                              color: accentColor2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                "Create My Account",
                                style: whiteTextFont.copyWith(fontSize: 20),
                              ),
                              onPressed: () async {
                                setState(() {
                                  isSignInUp = true;
                                });

                                // gambar akan disimpan sementara, karena proses upload akan memakan waktu lama
                                imageFileToUpload =
                                    widget.registrationUserData.profilePicture;

                                SignInSignUpResult result =
                                    await AuthServices.signUp(
                                  emailAdress:
                                      widget.registrationUserData.email,
                                  fullName:
                                      widget.registrationUserData.fullName,
                                  job: widget.registrationUserData.job,
                                  password:
                                      widget.registrationUserData.password,
                                  noSIP: widget.registrationUserData.noSIP,
                                  status: widget.registrationUserData.status,
                                );

                                // check authresult
                                if (result.user == null) {
                                  setState(() {
                                    isSignInUp = false;
                                    // tampilkan pesan error
                                    Flushbar(
                                      duration: Duration(milliseconds: 4500),
                                      backgroundColor: accentColor2,
                                      flushbarPosition: FlushbarPosition.TOP,
                                      message: result.message,
                                    )..show(context);
                                  });
                                }
                              }),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
