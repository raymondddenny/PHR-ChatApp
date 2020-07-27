import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:phr_skripsi_chat/models/models.dart';
import 'package:phr_skripsi_chat/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // intial bloc v6
  UserBloc() : super(UserInitial());

  // @override
  // UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLoad) {
      User user = await UserServices.getUser(event.id);

      yield UserLoaded(user);
    } else if (event is UserSignOut) {
      yield UserInitial();
    } else if (event is UpdateUserData) {
      // assign new update
      User updatedUser = (state as UserLoaded).user.copyWith(
          fullName: event.fullName,
          job: event.job,
          profileImage: event.profileImage);

      // update user in database
      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    }
  }
}
