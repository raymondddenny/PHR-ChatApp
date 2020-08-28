part of 'shared.dart';

// fungsi untuk mengambil gambar dari galery handphone
Future<File> getImage() async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  return File(image.path);
}

Future<File> getImageCamera() async {
  var imageCam = await ImagePicker().getImage(source: ImageSource.camera);
  return File(imageCam.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  // referensi ini akan diarahkan ke object pada firebase storage, dengan nama filename diatas
  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);

  // upload file
  StorageUploadTask task = ref.putFile(image);

  // setelah upload, mengembalikan storage taskSnapshot
  StorageTaskSnapshot snapshot = await task.onComplete;

  // return download URL
  return await snapshot.ref.getDownloadURL();
}

void uploadImageMessage(
    {File image,
    User receiver,
    User sender,
    ImageUploadProvider imageUploadProvider}) async {
// set loading when user already pick image
  imageUploadProvider.setToLoading();
  // get urlImage
  String imageMsgUrl = await uploadImage(image);
  // hide loading
  imageUploadProvider.setToIdle();

  setImageMessage(imageMsgUrl, receiver, sender, imageUploadProvider);
}

void setImageMessage(String imageMsgUrl, User receiver, User sender,
    ImageUploadProvider imageUploadProvider) async {
  CollectionReference _messageCollection =
      Firestore.instance.collection('messages');
  Message _message;
  _message = Message.imageMessage(
    message: "IMAGE",
    receiverId: receiver.id,
    senderName: sender.fullName,
    receiverName: receiver.fullName,
    senderId: sender.id,
    photoUrl: imageMsgUrl,
    timeStamp: Timestamp.now(),
    type: "image",
  );

  var map = _message.toImageMap();

  // set the data to database
  await _messageCollection
      .document(map.senderId)
      .collection(map.receiverId)
      .add({
    'message': map.message,
    'senderId': map.senderId,
    'receiverId': map.receiverId,
    'senderName': map.senderName,
    'receiverName': map.receiverName,
    'timeStamp': map.timeStamp,
    'type': map.type,
    'photoUrl': map.photoUrl,
  });

  await _messageCollection
      .document(map.receiverId)
      .collection(map.senderId)
      .add({
    'message': map.message,
    'senderId': map.senderId,
    'receiverId': map.receiverId,
    'senderName': map.senderName,
    'receiverName': map.receiverName,
    'timeStamp': map.timeStamp,
    'type': map.type,
    'photoUrl': map.photoUrl,
  });
}

// Future<String> selectDate(BuildContext context, DateTime dateTime) async {
//   var date = DateTime.now().toString();
//   var dateParse = DateTime.parse(date);
//   var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

//   return formattedDate;
// }

// Future<String> selectTime(BuildContext context, TimeOfDay time) async{
//   TimeOfDay picked = await
// }
