part of 'services.dart';

class CallServices {
  static CollectionReference _callCollection =
      Firestore.instance.collection('call');

  static Future<bool> makeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await _callCollection.document(call.callerId).setData(hasDialledMap);
      await _callCollection.document(call.receiverId).setData(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> endCall({Call call}) async {
    try {
      await _callCollection.document(call.callerId).delete();
      await _callCollection.document(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Stream<DocumentSnapshot> callStream({String id}) =>
      _callCollection.document(id).snapshots();
}
