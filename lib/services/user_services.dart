part of 'services.dart';

// Class for User services, to store user data and get user data
class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  // create and update user
  static Future<void> updateUser(User user) async {
    await _userCollection.document(user.id).setData({
      'uid': user.id,
      'email': user.email,
      'fullName': user.fullName,
      'job': user.job,
      'profileImage': user.profileImage ?? "no_pic",
      'noSIP': user.noSIP ?? "",
      'status': user.status ?? "",
      'state': user.state ?? 1,
      'ratingNum': user.ratingNum ?? 0.0,
      'alumnus': user.alumnus ?? "",
      'tempatPraktek': user.tempatPraktek ?? "",
    });
  }

  static Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await AuthServices._auth.currentUser();
    return currentUser;
  }

  static Future<User> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();
    DocumentSnapshot documentSnapshot =
        await _userCollection.document(currentUser.uid).get();
    return User.fromMap(documentSnapshot.data);
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
      noSIP: snapshot.data['noSIP'],
      status: snapshot.data['status'],
      ratingNum: snapshot.data['ratingNum'],
      state: snapshot.data['state'],
      alumnus: snapshot.data['alumnus'],
      tempatPraktek: snapshot.data['tempatPraktek'],
    );
  }

  static Future<List<User>> getAllUser() async {
    List<User> userList = List<User>();
    QuerySnapshot querySnapshot = await _userCollection.getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      userList.add(User.fromMap(querySnapshot.documents[i].data));
    }
    return userList;
  }

  static Future<List<User>> getAllContact(String doctorId) async {
    List<User> userList = List<User>();
    DocumentSnapshot documentSnapshot =
        await _userCollection.document(doctorId).get();
    for (var i = 0; i < documentSnapshot.data.length; i++) {
      userList.add(User.fromMap(documentSnapshot.data[i]));
    }
    return userList;
  }
  // static Future<List<User>> getAllUser() async {
  //   List<User> userList = List<User>();
  //   QuerySnapshot querySnapshot = await _userCollection.getDocuments();
  //   for (var i = 0; i < querySnapshot.documents.length; i++) {
  //     userList.add(User.fromMap(querySnapshot.documents[i].data));
  //   }
  //   return userList;
  // }

  //   static Future<List<User>> getAllUserDoctor(String job) async {
  //   List<User> userList = List<User>();
  //   QuerySnapshot querySnapshot = await _userCollection.getDocuments();
  //   for (var i = 0; i < querySnapshot.documents.length; i++) {
  //     userList.add(User.fromMap(querySnapshot.documents[i].data));
  //   }
  //   return userList;
  // }

  static Future<void> setUserState(
      {@required String userId, @required UserStates userStates}) async {
    int stateNum = CallUtils.stateToNum(userStates);

    await _userCollection.document(userId).updateData({
      'state': stateNum,
    });
  }

  // for rating
  static Future<void> setDoctorRating(
      String userId, double newRatingNum) async {
    DocumentSnapshot snapshot = await _userCollection.document(userId).get();
    double ratingNum = snapshot.data['ratingNum'];
    if (ratingNum <= 0) {
      ratingNum = ratingNum + newRatingNum;
    } else {
      ratingNum = ((ratingNum + newRatingNum) / 2).toDouble();
    }
    // ratingNum = newRatingNum;

    await _userCollection.document(userId).updateData({
      'ratingNum': ratingNum,
    });
  }

  static Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();

  static Future<List<User>> fetchLastRatingDoctor() async {
    QuerySnapshot qshot = await _userCollection.getDocuments();
    return qshot.documents
        .map((value) => User(
              value.data['uid'],
              value.data['email'],
              fullName: value.data['fullName'],
              job: value.data['job'],
              profileImage: value.data['profileImage'],
              noSIP: value.data['noSIP'],
              status: value.data['status'],
              ratingNum: value.data['ratingNum'],
              state: value.data['state'],
              alumnus: value.data['alumnus'],
              tempatPraktek: value.data['tempatPraktek'],
            ))
        .toList();
  }

  // static Stream<List<User>> fetchLastRatingDoctor() {
  //   Stream<QuerySnapshot> stream = _userCollection.snapshots();
  //   return stream.map((queryDoctor) => queryDoctor.documents
  //       .map((doc) => User(
  //             doc.data['id'],
  //             doc.data['email'],
  //             fullName: doc.data['fullName'],
  //             job: doc.data['job'],
  //             profileImage: doc.data['profileImage'],
  //             noSIP: doc.data['noSIP'],
  //             status: doc.data['status'],
  //             ratingNum: doc.data['ratingNum'],
  //             state: doc.data['state'],
  //             alumnus: doc.data['alumnus'],
  //             tempatPraktek: doc.data['tempatPraktek'],
  //           ))
  //       .toList());
  // }
}
