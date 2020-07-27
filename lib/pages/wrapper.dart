part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get firebase user current status
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    // check user login status
    // if user not login
    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToWelcomePage)) {
        prevPageEvent = GoToWelcomePage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        //before go to main page, load user from firebase
        context.bloc<UserBloc>().add(UserLoad(id: firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    // if there's change
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) => (state is OnWelcomePage)
          ? WelcomePage()
          : (state is OnLoginPage)
              ? LoginPage()
              : (state is OnRegistrationPage)
                  ? RegistrationPage(state.registrationUserData)
                  : (state is OnAccountConfirmationPage)
                      ? AccountConfirmationPage(state.registrationUserData)
                      : (state is OnUserProfilePage)
                          ? UserProfilePage()
                          : (state is OnEditProfilePage)
                              ? EditProfilePage(state.user)
                              : (state is OnDoctorSelectedPage)
                                  ? DoctorSelectedPageList(state.doctorType)
                                  : MainPage(),
    );
  }
}
