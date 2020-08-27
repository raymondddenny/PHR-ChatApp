part of 'providers.dart';

class UserProvider with ChangeNotifier {
  User _user;
  List<User> _userList;

  User get getUser => _user;
  List<User> get getUserList => _userList;

  Future<void> refreshUser() async {
    User user = await UserServices.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
