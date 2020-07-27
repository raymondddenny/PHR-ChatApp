part of 'pages.dart';

class ChatListPage extends StatefulWidget {
  final String doctorSpeciality;

  ChatListPage(this.doctorSpeciality);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Doctor> doctorList;
  String query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
        if (userState is UserLoaded) {
          return ChatListContainer();
        } else {
          return SpinKitFadingCircle(
            color: accentColor2,
            size: 50,
          );
        }
      }),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(defaultMargin),
          itemCount: 2,
          itemBuilder: (context, index) {
            return CustomChatTile(
              mini: false,
              onTap: () {},
              leading: Container(
                constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
                child: Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: accentColor3,
                      backgroundImage: AssetImage("images/doctor.png"),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: onlineDotColor,
                            border: Border.all(
                              color: accentColor4,
                              width: 1,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              title: Text(
                "Dr. Raisa",
                style: blackTextFont.copyWith(fontSize: 19),
              ),
              subtitle: Text(
                "Halo Pak Denny,sdkskdksksdadks",
                style: blackTextFont.copyWith(
                  color: accentColor3,
                  fontSize: 14,
                ),
              ),
              trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onPressed: () {}),
            );
          }),
    );
  }
}
