part of 'models.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String type;
  final String message;
  final Timestamp timeStamp;
  final String photoUrl;

  Message(
      {this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timeStamp,
      this.photoUrl});

  // to perform send image message
  Message.imageMessage(
      {this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timeStamp,
      this.photoUrl});

  Message toMap() => Message(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        type: type ?? this.receiverId,
        message: message ?? this.message,
        timeStamp: timeStamp ?? this.timeStamp,
      );

  Message toImageMap() => Message(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        type: type ?? this.receiverId,
        message: message ?? this.message,
        timeStamp: timeStamp ?? this.timeStamp,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory Message.fromMap(Map<String, dynamic> mapData) {
    return Message(
      senderId: mapData['senderId'],
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
        receiverId,
        type,
        message,
        timeStamp,
        photoUrl,
      ];
}

// var map = Map<String, dynamic>();
// map['senderId'] = this.senderId;
// map['receiverId'] = this.receiverId;
// map['type'] = this.type;
