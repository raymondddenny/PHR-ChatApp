import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phr_skripsi_chat/bloc/blocs.dart';
import 'package:phr_skripsi_chat/models/models.dart';
import 'package:phr_skripsi_chat/pages/pages.dart';
import 'package:phr_skripsi_chat/provider/providers.dart';
import 'package:phr_skripsi_chat/services/services.dart';
import 'package:random_string/random_string.dart';

part 'shared_value.dart';
part 'constants.dart';
part 'shared_methods.dart';
part 'call_utils.dart';
