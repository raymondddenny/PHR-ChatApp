part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnWelcomePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegistrationPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegistrationUserPage extends PageState {
  final RegistrationUserData registrationUserData;
  OnRegistrationUserPage(this.registrationUserData);

  @override
  List<Object> get props => [];
}

class OnRegistrationDoctorPage extends PageState {
  final RegistrationUserData registrationUserData;
  OnRegistrationDoctorPage(this.registrationUserData);

  @override
  List<Object> get props => [];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationUserData registrationUserData;
  OnAccountConfirmationPage(this.registrationUserData);

  @override
  List<Object> get props => [];
}

class OnUserProfilePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnEditProfilePage extends PageState {
  final User user;

  OnEditProfilePage(this.user);
  @override
  List<Object> get props => [user];
}

class OnDoctorSelectedPage extends PageState {
  final DoctorType doctorType;
  OnDoctorSelectedPage(this.doctorType);
  @override
  List<Object> get props => [doctorType];
}

class OnChatScreenPage extends PageState {
  final User receiver;
  final User sender;
  OnChatScreenPage(this.receiver, this.sender);

  @override
  List<Object> get props => [receiver];
}

class OnCallScreenPage extends PageState {
  final Call call;
  OnCallScreenPage(this.call);
  @override
  List<Object> get props => [call];
}
