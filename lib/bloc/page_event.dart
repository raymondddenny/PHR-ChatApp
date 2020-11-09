part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToWelcomePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  final bottomNavBarIndex;
  GoToMainPage({this.bottomNavBarIndex = 0});
  @override
  List<Object> get props => [bottomNavBarIndex];
}

class GoToRegistrationPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRegistrationUserPage extends PageEvent {
  final RegistrationUserData registrationUserData;
  GoToRegistrationUserPage(this.registrationUserData);
  @override
  List<Object> get props => [];
}

class GoToRegistrationDoctorPage extends PageEvent {
  final RegistrationUserData registrationUserData;
  GoToRegistrationDoctorPage(this.registrationUserData);
  @override
  List<Object> get props => [];
}

class GoToConfirmationPage extends PageEvent {
  final RegistrationUserData registrationUserData;
  GoToConfirmationPage(this.registrationUserData);
  @override
  List<Object> get props => [];
}

class GoToUserProfilePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToUserProfilePageMenu extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToEditProfilePage extends PageEvent {
  final User user;

  GoToEditProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

class GoToDoctorSelectedPage extends PageEvent {
  final DoctorType doctorType;
  GoToDoctorSelectedPage(this.doctorType);
  @override
  List<Object> get props => [doctorType];
}

class GoToChatScreenPage extends PageEvent {
  final User receiver;
  final User sender;
  GoToChatScreenPage({this.receiver, this.sender});
  @override
  List<Object> get props => [receiver, sender];
}

class GoToCallScreenPage extends PageEvent {
  final Call call;
  final User sender;
  final User receiver;
  GoToCallScreenPage({this.call, this.sender, this.receiver});

  @override
  List<Object> get props => [call, sender, receiver];
}

class GoToChatListScreenPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSeeDoctorPage extends PageEvent {
  final User user;
  GoToSeeDoctorPage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToHistoryPatientPage extends PageEvent {
  final Call call;
  GoToHistoryPatientPage(this.call);
  @override
  List<Object> get props => [call];
}

class GoToDoctorRatingPage extends PageEvent {
  final Call call;
  GoToDoctorRatingPage(this.call);
  @override
  List<Object> get props => [call];
}

class GoToPatientListMedicalRecordPage extends PageEvent {
  final User user;
  GoToPatientListMedicalRecordPage(this.user);
  @override
  List<Object> get props => [user];
}
