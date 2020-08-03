import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phr_skripsi_chat/bloc/blocs.dart';
import 'package:phr_skripsi_chat/models/models.dart';
import 'package:phr_skripsi_chat/provider/providers.dart';
import 'package:phr_skripsi_chat/services/services.dart';
import 'package:phr_skripsi_chat/shared/shared.dart';
import 'package:phr_skripsi_chat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path/path.dart';

part 'welcome_page.dart';
part 'login_page.dart';
part 'wrapper.dart';
part 'main_page.dart';
part 'user_registration_page.dart';
part 'doctor_page.dart';
part 'account_confirmation_page.dart';
part 'hospital_page.dart';
part 'user_profile_page.dart';
part 'edit_profile.dart';
part 'doctor_selected_page_list.dart';
part 'chat_list_screen.dart';
part 'chat_list_page.dart';
part 'chat_screen.dart';
part 'registration_page.dart';
part 'doctor_registration_page.dart';
