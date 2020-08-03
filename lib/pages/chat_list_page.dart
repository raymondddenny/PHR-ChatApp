part of 'pages.dart';

class ChatListPage extends StatefulWidget {
  final String doctorSpeciality;

  ChatListPage(this.doctorSpeciality);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChatListContainer(doctorSpeciality: widget.doctorSpeciality));
  }
}

class ChatListContainer extends StatefulWidget {
  final String doctorSpeciality;

  ChatListContainer({this.doctorSpeciality});

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  // // get all doctors
  // Future fetchAllDoctors() async {
  //   var fireStore = Firestore.instance;
  //   QuerySnapshot querySnapshot =
  //       await fireStore.collection("users").getDocuments();
  //   return querySnapshot.documents;
  // }
  List<User> userList;
  User sender;
  @override
  Widget build(BuildContext context) {
    String queryDoctor = widget.doctorSpeciality;
    return Container(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            userList = userState.userList;
            sender = userState.user;
          }
          return buildSuggestion(queryDoctor, sender);
        },
      ),
    );
  }

  Widget buildSuggestion(String queryDoctor, User sender) {
    final List<User> suggestionList = queryDoctor.isEmpty
        ? []
        : userList.where((User user) {
            String _query = queryDoctor;
            String _getJob = user.job;
            bool matchJob = _getJob.contains(_query);
            return (matchJob);
          }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          User doctorType = User(
            suggestionList[index].id,
            suggestionList[index].email,
            fullName: suggestionList[index].fullName,
            job: suggestionList[index].job,
            profileImage: suggestionList[index].profileImage,
          );
          return Container(
            padding: EdgeInsets.only(
                top: defaultMargin, left: defaultMargin, right: defaultMargin),
            child: CustomChatTile(
                mini: false,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(doctorType.profileImage),
                ),
                title: Text(
                  doctorType.fullName,
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  doctorType.job,
                  style: greyTextFont,
                ),
                trailing: Icon(
                  Icons.navigate_next,
                  size: 35,
                ),
                onTap: () {
                  context.bloc<PageBloc>().add(
                      GoToChatScreenPage(receiver: doctorType, sender: sender));
                }),
          );
        });
  }
}
