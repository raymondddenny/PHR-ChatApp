part of 'models.dart';

// equatable use for check if the object are the same
class User extends Equatable {
  final String id;
  final String noSIP;
  final String profileImage;
  final String email;
  final String fullName;
  final String job;
  final int state;
  // status = patient atau doctor
  final String status;

  User(this.id, this.email,
      {this.fullName,
      this.profileImage,
      this.job,
      this.state,
      this.noSIP,
      this.status});

  // copy user property dengan yang bisa diubah
  User copyWith({String fullName, String job, String profileImage}) => User(
        this.id,
        this.email,
        fullName: fullName ?? this.fullName,
        job: job ?? this.job,
        profileImage: profileImage ?? this.profileImage,
        state: state ?? this.state,
        noSIP: noSIP ?? this.noSIP,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [
        id,
        email,
        fullName,
        job,
        profileImage,
        state,
        noSIP,
        status,
      ];

  factory User.fromMap(Map<String, dynamic> mapData) {
    return User(mapData['uid'], mapData['email'],
        fullName: mapData['fullName'],
        job: mapData['job'],
        noSIP: mapData['noSIP'],
        profileImage: mapData['profileImage'],
        state: mapData['state'],
        status: mapData['status']);
  }
}
