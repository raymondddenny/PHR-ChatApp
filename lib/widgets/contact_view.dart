part of 'widgets.dart';

class ContactView extends StatelessWidget {
  final Contact contact;

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserServices.getUser(contact.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
          return ViewLayout(
            contact: user,
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  ViewLayout({this.contact});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return CustomChatTile(
            mini: false,
            onTap: () {
              context.bloc<PageBloc>().add(GoToChatScreenPage(
                  receiver: contact, sender: userState.user));
            },
            leading: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: [
                  CachedImage(
                    contact.profileImage,
                    radius: 80,
                    isRounded: true,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 48,
                    child: OnlineDotIndicator(
                      uid: contact.id,
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              contact.fullName,
              style: blackTextFont.copyWith(
                fontSize: 19,
              ),
            ),
            subtitle: LastMessageContainer(
              stream: MessageServices.fetchLastMessageBetween(
                  senderId: userState.user.id, receiverId: contact.id),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
