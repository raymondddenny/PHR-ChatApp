part of 'models.dart';

class RegistrationUserData {
  String fullName;
  String email;
  String password;
  String job;
  File profilePicture;

  RegistrationUserData(
      {this.fullName,
      this.email,
      this.password,
      this.job,
      this.profilePicture});
}
