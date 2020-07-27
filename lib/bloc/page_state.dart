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
  final RegistrationUserData registrationUserData;
  OnRegistrationPage(this.registrationUserData);

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
  List<Object> get props => [];
}
