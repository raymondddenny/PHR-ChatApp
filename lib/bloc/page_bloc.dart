import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phr_skripsi_chat/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  // intial bloc v6
  PageBloc() : super(OnInitialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToWelcomePage) {
      yield OnWelcomePage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage(bottomNavBarindex: event.bottomNavBarIndex);
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage();
    } else if (event is GoToRegistrationUserPage) {
      yield OnRegistrationUserPage(event.registrationUserData);
    } else if (event is GoToRegistrationDoctorPage) {
      yield OnRegistrationDoctorPage(event.registrationUserData);
    } else if (event is GoToConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationUserData);
    } else if (event is GoToUserProfilePage) {
      yield OnUserProfilePage();
    } else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    } else if (event is GoToDoctorSelectedPage) {
      yield OnDoctorSelectedPage(event.doctorType);
    } else if (event is GoToChatScreenPage) {
      yield OnChatScreenPage(event.receiver, event.sender);
    } else if (event is GoToCallScreenPage) {
      yield OnCallScreenPage(event.call);
    } else if (event is GoToChatListScreenPage) {
      yield OnChatListScreenPage();
    }
  }
}
