part of 'providers.dart';

class UserProvider with ChangeNotifier {
  User _user;

  User get getUser => _user;

  // refreshUser() async {
  //   User user = await UserServices.getUserDetails();
  //   _user = user;
  //   notifyListeners();
  // }
}
