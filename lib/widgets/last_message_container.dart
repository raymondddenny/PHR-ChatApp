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
            String time =
                DateFormat.jm().add_MMMd().format(message.timeStamp.toDate());
            return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: (message.type == "image")
                  ? Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.network(message.photoUrl),
                        ),
                        Text("Send a photo")
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          message.message,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: greyTextFont.copyWith(fontSize: 12),
                        ),
                        Flexible(
                          child: Text(
                            time,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: greyTextFont.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
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
