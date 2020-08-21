part of 'models.dart';

class Message extends Equatable {
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final String type;
  final String message;
  final Timestamp timeStamp;
  final String photoUrl;

  Message(
      {this.senderId,
      this.receiverId,
      this.senderName,
      this.receiverName,
      this.type,
      this.message,
      this.timeStamp,
      this.photoUrl});

  // to perform send image message
  Message.imageMessage(
      {this.senderId,
      this.senderName,
      this.receiverName,
      this.receiverId,
      this.type,
      this.message,
      this.timeStamp,
      this.photoUrl});

  Message toMap() => Message(
        senderId: senderId ?? this.senderId,
        senderName: senderName ?? this.senderName,
        receiverName: receiverName ?? this.receiverName,
        receiverId: receiverId ?? this.receiverId,
        type: type ?? this.receiverId,
        message: message ?? this.message,
        timeStamp: timeStamp ?? this.timeStamp,
      );

  Message toImageMap() => Message(
        senderId: senderId ?? this.senderId,
        senderName: senderName ?? this.senderName,
        receiverName: receiverName ?? this.receiverName,
        receiverId: receiverId ?? this.receiverId,
        type: type ?? this.receiverId,
        message: message ?? this.message,
        timeStamp: timeStamp ?? this.timeStamp,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory Message.fromMap(Map<String, dynamic> mapData) {
    return Message(
      senderId: mapData['senderId'],
      senderName: mapData['senderName'],
      receiverName: mapData['receiverName'],
      receiverId: mapData['receiverId'],
      type: mapData['type'],
      message: mapData['message'],
      timeStamp: mapData['timeStamp'],
      photoUrl: mapData['photoUrl'],
    );
  }

  @override
  List<Object> get props => [
        senderId,
        senderName,
        receiverName,
        receiverId,
        type,
        message,
        timeStamp,
        photoUrl,
      ];
}
