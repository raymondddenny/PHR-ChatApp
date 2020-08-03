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
    String receiverId,
    String senderId,
    ImageUploadProvider imageUploadProvider}) async {
// set loading when user already pick image
  imageUploadProvider.setToLoading();
  // get urlImage
  String imageMsgUrl = await uploadImage(image);
  // hide loading
  imageUploadProvider.setToIdle();

  setImageMessage(imageMsgUrl, receiverId, senderId, imageUploadProvider);
}

void setImageMessage(String imageMsgUrl, String receiverId, String senderId,
    ImageUploadProvider imageUploadProvider) async {
  CollectionReference _messageCollection =
      Firestore.instance.collection('messages');
  Message _message;
  _message = Message.imageMessage(
    message: "IMAGE",
    receiverId: receiverId,
    senderId: senderId,
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
    'timeStamp': map.timeStamp,
    'type': map.type,
    'photoUrl': map.photoUrl,
  });
}
