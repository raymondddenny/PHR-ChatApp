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
      'status': user.status ?? ""
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

  static void setUserState(
      {@required String userId, @required UserStates userStates}) {
    int stateNum = CallUtils.stateToNum(userStates);

    _userCollection.document(userId).updateData({
      "state": stateNum,
    });
  }

  static Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();
}
