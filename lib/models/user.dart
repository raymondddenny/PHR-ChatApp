part of 'models.dart';

// equatable use for check if the object are the same
class User extends Equatable {
  final String id;
  final String profileImage;
  final String email;
  final String fullName;
  final String job;

  User(this.id, this.email, {this.fullName, this.profileImage, this.job});

  // copy user property dengan yang bisa diubah
  User copyWith({String fullName, String job, String profileImage}) =>
      User(this.id, this.email,
          fullName: fullName ?? this.fullName,
          job: job ?? this.job,
          profileImage: profileImage ?? this.profileImage);

  @override
  List<Object> get props => [
        id,
        email,
        fullName,
        job,
        profileImage,
      ];
}
