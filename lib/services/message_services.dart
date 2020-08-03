part of 'services.dart';

class MessageServices {
  static CollectionReference _messageCollection =
      Firestore.instance.collection('messages');

  static Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add({
      'message': message.message,
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'timeStamp': message.timeStamp,
      'type': message.type,
    });

    return await _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add({
      'message': message.message,
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'timeStamp': message.timeStamp,
      'type': message.type,
    });
  }
}
