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

    addToContact(senderId: message.senderId, receiverId: message.receiverId);

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

  static DocumentReference getContactsDocument({String of, String forContact}) {
    return UserServices._userCollection
        .document(of)
        .collection("contacts")
        .document(forContact);
  }

  static void addToContact({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId, receiverId, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  static Future<void> addToSenderContacts(
      String senderId, String receiverId, currentTime) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: receiverId).get();
    if (!senderSnapshot.exists) {
      // tidak ada data
      Contact receiverContact = Contact(id: receiverId, addedOn: currentTime);

      var receiverMap = receiverContact.toMap(receiverContact);

      await getContactsDocument(of: senderId, forContact: receiverId)
          .setData(receiverMap);
    }
  }

  static Future<void> addToReceiverContacts(
      String senderId, String receiverId, currentTime) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: senderId).get();
    if (!receiverSnapshot.exists) {
      // tidak ada data
      Contact senderContact = Contact(id: senderId, addedOn: currentTime);

      var senderMap = senderContact.toMap(senderContact);

      await getContactsDocument(of: receiverId, forContact: senderId)
          .setData(senderMap);
    }
  }

  static Stream<QuerySnapshot> fetchContacts({String userId}) {
    return UserServices._userCollection
        .document(userId)
        .collection("contacts")
        .snapshots();
  }

  static Stream<QuerySnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) {
    return _messageCollection
        .document(senderId)
        .collection(receiverId)
        .orderBy("timeStamp")
        .snapshots();
  }
}
