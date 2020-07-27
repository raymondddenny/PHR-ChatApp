part of 'shared.dart';

// fungsi untuk mengambil gambar dari galery handphone
Future<File> getImage() async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  return File(image.path);
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
