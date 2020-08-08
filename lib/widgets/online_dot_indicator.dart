part of 'widgets.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;
  OnlineDotIndicator({@required this.uid});
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: UserServices.getUserStream(uid: uid),
      builder: (context, snapshot) {
        User user;

        if (snapshot.hasData && snapshot.data.data != null) {
          user = User.fromMap(snapshot.data.data);
        }

        return Container(
          height: 10,
          width: 10,
          margin: EdgeInsets.only(right: 8, top: 8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: getColor(user?.state)),
        );
      },
    );
  }

  getColor(int state) {
    switch (CallUtils.numToState(state)) {
      case UserStates.Offline:
        return Colors.red;
        break;
      case UserStates.Online:
        return Colors.green;
        break;
      default:
        return Colors.orange;
    }
  }
}
