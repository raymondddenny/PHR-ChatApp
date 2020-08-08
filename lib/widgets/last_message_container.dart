part of 'widgets.dart';

class LastMessageContainer extends StatelessWidget {
  final stream;
  LastMessageContainer({@required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var docList = snapshot.data.documents;
          if (docList.isNotEmpty) {
            Message message = Message.fromMap(docList.last.data);
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                message.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: greyTextFont.copyWith(fontSize: 14),
              ),
            );
          }
          return Text(
            "No Message",
            style: greyTextFont.copyWith(fontSize: 14),
          );
        }
        return Text(
          ".....",
          style: greyTextFont.copyWith(fontSize: 14),
        );
      },
    );
  }
}
