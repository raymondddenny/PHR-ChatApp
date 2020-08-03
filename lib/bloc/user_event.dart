part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  final String id;
  final List<User> userList;

  UserLoad({this.id, this.userList});

  @override
  List<Object> get props => [id, userList];
}

class UserSignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserData extends UserEvent {
  final String fullName;
  final String job;
  final String profileImage;

  UpdateUserData({this.fullName, this.job, this.profileImage});

  @override
  List<Object> get props => [fullName, job, profileImage];
}
