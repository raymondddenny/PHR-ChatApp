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
  @override
  List<Object> get props => [];
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
  List<Object> get props => [receiver];
}

class GoToCallScreenPage extends PageEvent {
  final Call call;
  GoToCallScreenPage({this.call});

  @override
  List<Object> get props => [call];
}
