part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

// state ketika data user sudah terload oleh aplikasi
class UserLoaded extends UserState {
  // user disini untuk menyimpan data user
  final User user;
  final List<User> userList;
  UserLoaded(this.user, {this.userList});

  @override
  List<Object> get props => [user];
}

// class AllUserLoaded extends UserState {
//   // user disini untuk menyimpan data user
//   // final User user;
//   final List<User> userList;
//   AllUserLoaded(this.userList);

//   @override
//   List<Object> get props => [userList];
// }
