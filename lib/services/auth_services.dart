part of 'services.dart';

// class for authentication user , sign in and sign up
class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // method signUp user
  static Future<SignInSignUpResult> signUp(
      {String fullName,
      String job,
      String emailAdress,
      String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: emailAdress,
        password: password,
      );

      User user = result.user.convertToUser(fullName: fullName, job: job);

      // to store data to Firebase
      await UserServices.updateUser(user);
      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  // method signUp Doctor
  static Future<SignInSignUpResultDoctor> signUpDoctor(
      String fullName,
      String emailAdress,
      String password,
      String noSip,
      String speciality) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: emailAdress, password: password);
      Doctor doctor = result.user.convertToDoctor(
          doctorName: fullName, noSip: noSip, speciality: speciality);

      // store data to firebase
      await UserServices.createAndUpdateDoctor(doctor);
      return SignInSignUpResultDoctor(doctor: doctor);
    } catch (e) {
      return SignInSignUpResultDoctor(
          message: e.toString().split(',')[1].trim());
    }
  }

  // sign in services
  static Future<SignInSignUpResult> signIn(
      {String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // if success, create user
      User user = await result.user.fromFireStore();
      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignInSignUpResultDoctor> signInDoctor(
    String email,
    String password,
  ) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // if success, create doctors user
      Doctor doctor = await result.user.fromDoctorFireStore();
      return SignInSignUpResultDoctor(doctor: doctor);
    } catch (e) {
      return SignInSignUpResultDoctor(
          message: e.toString().split(',')[1].trim());
    }
  }

  // sign out services
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // reset password services
  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // to receive if there's change in user sign in/sign out status
  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class SignInSignUpResult {
  // this method is for check if there are errors happen when user sign in or sign up
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}

class SignInSignUpResultDoctor {
  // this method is for check if there are errors happen when user sign in or sign up
  final Doctor doctor;
  final String message;

  SignInSignUpResultDoctor({this.doctor, this.message});
}
