part of 'models.dart';

class Call {
  String callerId;
  String callerName;
  String callerPhoto;
  String receiverId;
  String receiverName;
  String receiverPhoto;
  String callChannedId;
  // true for caller, false for receiver
  bool hasDialled;

  Call(
      {this.callerId,
      this.callerName,
      this.callerPhoto,
      this.receiverId,
      this.receiverName,
      this.receiverPhoto,
      this.callChannedId,
      this.hasDialled});

// to map
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap["caller_id"] = call.callerId;
    callMap["caller_name"] = call.callerName;
    callMap["caller_photo"] = call.callerPhoto;
    callMap["receiver_id"] = call.receiverId;
    callMap["receiver_name"] = call.receiverName;
    callMap["receiver_photo"] = call.receiverPhoto;
    callMap["call_channel_id"] = call.callChannedId;
    callMap["has_dialled"] = call.hasDialled;
    return callMap;
  }
  // Call toMap() => Call(
  //       callerId: callerId ?? this.callerId,
  //       callerName: callerName ?? this.callerName,
  //       callerPhoto: callerPhoto ?? this.callerPhoto,
  //       receiverId: receiverId ?? this.receiverId,
  //       receiverName: receiverName ?? this.receiverName,
  //       receiverPhoto: receiverPhoto ?? this.receiverPhoto,
  //       hasDialled: hasDialled ?? this.hasDialled,
  //     );

  // from Map
  factory Call.fromMap(Map<String, dynamic> mapData) {
    return Call(
      callerId: mapData['caller_id'],
      callerName: mapData['caller_name'],
      callerPhoto: mapData['caller_photo'],
      receiverId: mapData['receiver_id'],
      receiverName: mapData['receiver_name'],
      receiverPhoto: mapData['receiver_photo'],
      callChannedId: mapData['call_channel_id'],
      hasDialled: mapData['has_dialled'],
    );
  }
}
