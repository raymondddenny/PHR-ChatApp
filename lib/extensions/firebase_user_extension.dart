part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser(
          {String fullName = "No Name",
          String job = "No Job",
          String noSIP = "No NoSIP",
          String status = "",
          int state = 1,
          double ratingNum = 0.0}) =>
      User(this.uid, this.email,
          fullName: fullName,
          job: job,
          noSIP: noSIP,
          status: status,
          state: state,
          ratingNum: ratingNum);

  // Doctor convertToDoctor(
  //         {String doctorName = "No Name",
  //         String noSip,
  //         String speciality,
  //         int rating = 3}) =>
  //     Doctor(
  //       this.uid,
  //       this.email,
  //       noSip: noSip,
  //       doctorName: doctorName,
  //       rating: rating,
  //       speciality: speciality,
  //     );

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
