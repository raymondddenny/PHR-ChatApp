part of 'pages.dart';

class ChatListScreen extends StatelessWidget {
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
            body: ChatListScreenContainer()));
  }
}

class ChatListScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return Container(
            margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                top: 12,
                bottom: defaultMargin),
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    MessageServices.fetchContacts(userId: userState.user.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var docList = snapshot.data.documents;
                    if (docList.isEmpty) {
                      return QuietBox();
                    }
                    return ListView.builder(
                        itemCount: docList.length,
                        itemBuilder: (_, index) {
                          Contact contact =
                              Contact.fromMap(docList[index].data);
                          return ContactView(contact);
                        });
                  } else {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: accentColor2,
                        size: 50,
                      ),
                    );
                  }
                }),
          );
        } else {
          return SpinKitFadingCircle(color: accentColor2);
        }
      },
    );
  }
}
