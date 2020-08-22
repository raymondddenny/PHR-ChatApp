part of 'pages.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set Theme
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());

        return;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  context.bloc<PageBloc>().add(GoToMainPage());
                }),
            title: Text("Profile"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (_, userState) {
                    // check user state loaded or not
                    if (userState is UserLoaded) {
                      User user = userState.user;
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 74, bottom: 10),
                            width: 150,
                            height: 150,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: SpinKitFadingCircle(
                                      color: accentColor2,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 120,
                                  // height: 120,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: (user.profileImage != "no_pic")
                                              ? NetworkImage(user.profileImage)
                                              : AssetImage(
                                                  "images/user_default.png"),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            userState.user.fullName,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            userState.user.job,
                            style: greyTextFont.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                Column(
                  children: [
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => UserProfileMenuListTile(
                          userProfileMenuTitle: "Edit Profile",
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToEditProfilePage(
                                (userState as UserLoaded).user));
                          },
                          leadingIcon: Icon(
                            Icons.person,
                            color: accentColor2,
                          )),
                    ),
                    DashDivider(),
                    BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                      if (userState is UserLoaded) {
                        return UserProfileMenuListTileMenu(
                            userProfileMenuTitle: "Sign Out",
                            onTap: () {
                              context.bloc<UserBloc>().add(UserSignOut());
                              AuthServices.signOut();
                              UserServices.setUserState(
                                  userId: userState.user.id,
                                  userStates: UserStates.Offline);
                              context.bloc<PageBloc>().add(GoToWelcomePage());
                            },
                            leadingIcon: Icon(
                              Icons.exit_to_app,
                              color: accentColor2,
                            ));
                      } else {
                        return SizedBox();
                      }
                    }),
                    // UserProfileMenuListTile(
                    //     userProfileMenuTitle: "Sign Out",
                    //     onTap: () {
                    //       context.bloc<UserBloc>().add(UserSignOut());
                    //       AuthServices.signOut();
                    //       context.bloc<PageBloc>().add(GoToWelcomePage());
                    //     },
                    //     leadingIcon: Icon(
                    //       Icons.exit_to_app,
                    //       color: accentColor2,
                    //     )),
                    DashDivider(),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class DashDivider extends StatelessWidget {
  const DashDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 16),
      child: generateDashedDivider(
          MediaQuery.of(context).size.width - 2 * defaultMargin),
    );
  }
}

class UserProfileMenuListTile extends StatelessWidget {
  final String userProfileMenuTitle;
  final Function onTap;
  final Icon leadingIcon;

  UserProfileMenuListTile(
      {@required this.userProfileMenuTitle,
      @required this.onTap,
      @required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leadingIcon,
      title: Text(
        userProfileMenuTitle,
        style: blackTextFont.copyWith(fontSize: 16),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: accentColor2,
      ),
    );
  }
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
