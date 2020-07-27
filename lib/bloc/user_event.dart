part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  final String id;

  UserLoad({this.id});

  @override
  List<Object> get props => [id];
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
