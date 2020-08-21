part of 'models.dart';

class RegistrationUserData {
  String uid;
  String fullName;
  String email;
  String password;
  String job;
  String noSIP;
  int state;
  String status;
  File profilePicture;

  RegistrationUserData(
      {this.uid,
      this.fullName,
      this.email,
      this.password,
      this.job,
      this.profilePicture,
      this.noSIP,
      this.state,
      this.status});
}
