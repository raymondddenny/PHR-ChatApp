part of 'pages.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Image(
              image: AssetImage("images/man.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: accentColor1.withOpacity(0.7),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 100.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Konsultasi dengan\ndokter jadi lebih\nmudah dan flexibel',
                    style: whiteTextFont.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 38.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedButton(
                      color: mainColor,
                      title: 'Get Started',
                      onPressed: () {
                        context.bloc<PageBloc>().add(GoToRegistrationPage());
                        // context.bloc<PageBloc>().add(
                        //     GoToRegistrationUserPage(RegistrationUserData()));
                      },
                    ),
                    RoundedButton(
                      color: accentColor2,
                      title: 'Sign in',
                      onPressed: () {
                        context.bloc<PageBloc>().add(GoToLoginPage());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
