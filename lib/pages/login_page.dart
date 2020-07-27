part of 'pages.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoggingIn = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () {
        //when press back from login page, goto welcome page
        context.bloc<PageBloc>().add(GoToWelcomePage());
        return;
      },
      child: Scaffold(
        backgroundColor: accentColor5.withOpacity(0.1),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset("images/logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 40),
                    child: Text(
                      "Masuk dan mulai\nberkonsultasi",
                      textAlign: TextAlign.center,
                      style: whiteTextFont.copyWith(
                          fontSize: 28, color: Colors.white),
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailController,
                    style: TextStyle(color: accentColor1),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: accentColor1)),
                        labelText: "Email address",
                        labelStyle: TextStyle(color: accentColor1),
                        hintText: "Email address",
                        hintStyle: TextStyle(color: accentColor1)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordController,
                    style: TextStyle(color: accentColor1),
                    obscureText: true,
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
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        "Forgot password? ",
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Get now! ",
                        style: pinkTextFont.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: isLoggingIn
                          ? SpinKitCircle(
                              color: accentColor2,
                            )
                          : FloatingActionButton(
                              child: Icon(
                                Icons.arrow_forward,
                                color: (isEmailValid && isPasswordValid)
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                              backgroundColor: (isEmailValid && isPasswordValid)
                                  ? mainColor
                                  : accentColor3,
                              onPressed: (isEmailValid && isPasswordValid)
                                  ? () async {
                                      setState(() {
                                        isLoggingIn = true;
                                      });

                                      SignInSignUpResult result =
                                          await AuthServices.signIn(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);

                                      if (result.user == null) {
                                        setState(() {
                                          isLoggingIn = false;
                                        });

                                        // jika ada error
                                        Flushbar(
                                          duration: Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor: accentColor2,
                                          message: result.message,
                                        )..show(context);
                                      }
                                    }
                                  : null),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Start fresh now ? ",
                        style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(
                              GoToRegistrationPage(RegistrationUserData()));
                        },
                        child: Text(
                          "Sign up",
                          style: pinkTextFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
