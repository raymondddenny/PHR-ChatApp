part of 'services.dart';

// Class for User services, to store user data and get user data
class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static CollectionReference _doctorCollection =
      Firestore.instance.collection('doctors');

  // create and update user
  static Future<void> updateUser(User user) async {
    _userCollection.document(user.id).setData({
      'email': user.email,
      'fullName': user.fullName,
      'job': user.job,
      'profileImage': user.profileImage ?? "no_pic"
    });
  }

  // check and get user from firestore
  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    return User(
      id,
      snapshot.data['email'],
      fullName: snapshot.data['fullName'],
      profileImage: snapshot.data['profileImage'],
      job: snapshot.data['job'],
    );
  }

  // create and update doctors
  static Future<void> createAndUpdateDoctor(Doctor doctor) async {
    _doctorCollection.document(doctor.id).setData({
      'email': doctor.email,
      'noSIP': doctor.noSip,
      'fullName': doctor.doctorName,
      'speciality': doctor.speciality,
      'rating': doctor.noSip,
      'profileImage': doctor.profileImage ?? "no_pic",
    });
  }

  // check and get doctors from firestore
  static Future<Doctor> getDoctor(String id) async {
    DocumentSnapshot snapshot = await _doctorCollection.document(id).get();
    return Doctor(
      id,
      snapshot.data['email'],
      noSip: snapshot.data['noSIP'],
      doctorName: snapshot.data['fullName'],
      speciality: snapshot.data['speciality'],
      rating: snapshot.data['rating'],
      profileImage: snapshot.data['profileImage'],
    );
  }

  // get all doctors
  // static Future<List<Doctor>> fetchAllDoctors() async {
  //   List<Doctor> doctorList = List<Doctor>();
  //   QuerySnapshot querySnapshot = await _doctorCollection.getDocuments();
  //   // for (var i = 0; i < querySnapshot.documents.length; i++) {
  //   //   doctorList.add(Doctor.fromMap(querySnapshot.documents[i].data));
  //   // }
  // }
}
