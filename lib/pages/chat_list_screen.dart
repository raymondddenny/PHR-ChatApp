part of 'pages.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Messages",
              style: blackTextFont.copyWith(
                fontSize: 28,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              return ChatListScreenContainer(userState.user);
            } else {
              return SpinKitFadingCircle(
                color: accentColor2,
                size: 50,
              );
            }
          })),
    );
  }
}

class ChatListScreenContainer extends StatelessWidget {
  final User user;
  ChatListScreenContainer(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 12,
          bottom: defaultMargin),
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (_, index) {
            return CustomChatTile(
              mini: false,
              onTap: () {
                // ChatScreen();
                // TODO : struktur database untuk dokter, apakah di user atau di buat collection baru,
                // TODO : connect data user dan data dokter yang pernah di chat bagaimana ?
              },
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
                        ),
                      ),
                    )
                  ],
                ),
              ),
              title: Text(
                "dr.Denny Raymond",
                style: blackTextFont.copyWith(
                  fontSize: 19,
                ),
              ),
              subtitle: Expanded(
                child: Text(
                  "Baik bu, terima kasih banyak atas waktunya. Selamat Sore",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            );
          }),
    );
  }
}
