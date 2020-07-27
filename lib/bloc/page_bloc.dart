import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phr_skripsi_chat/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  // intial bloc v6
  PageBloc() : super(OnInitialPage());

  //// ==== OLD Version ====
  //// @override
  //// PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToWelcomePage) {
      yield OnWelcomePage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationUserData);
    } else if (event is GoToConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationUserData);
    } else if (event is GoToUserProfilePage) {
      yield OnUserProfilePage();
    } else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    } else if (event is GoToDoctorSelectedPage) {
      yield OnDoctorSelectedPage(event.doctorType);
    }
  }
}
