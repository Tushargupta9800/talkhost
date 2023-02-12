import 'dart:developer';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utilities/strings.dart';
import '../../models/User.dart';
import '../Firestore/firestore_user.dart';
import '../Firestore/image_handler.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState());
}
