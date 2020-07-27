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
  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}
