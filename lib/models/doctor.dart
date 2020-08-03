part of 'models.dart';

class Doctor extends Equatable {
  final String id;
  final String email;
  final String doctorName;
  // SIP : surat ijin praktek
  final String noSip;
  final String profileImage;
  final String speciality;
  final int rating;

  Doctor(this.id, this.email,
      {this.noSip,
      this.profileImage,
      this.doctorName,
      this.speciality,
      this.rating});

  Doctor copyWith(
          {String doctorName,
          String speciality,
          String noSip,
          int rating,
          String profileImage}) =>
      Doctor(
        this.id,
        this.email,
        noSip: noSip ?? this.noSip,
        doctorName: doctorName ?? this.doctorName,
        speciality: speciality ?? this.speciality,
        rating: rating ?? this.rating,
        profileImage: profileImage ?? this.profileImage,
      );

  @override
  List<Object> get props => [
        id,
        email,
        noSip,
        doctorName,
        speciality,
        rating,
        profileImage,
      ];
}
