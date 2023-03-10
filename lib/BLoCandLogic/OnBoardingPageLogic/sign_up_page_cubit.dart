import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';

import '../../Pages/DrawerPages/drawer.dart';
import '../../Utilities/alertbox.dart';
import '../../Utilities/routes.dart';
import '../../Utilities/simple_functions.dart';
import '../Authentication/auth_state.dart';

part 'sign_up_page_model.dart';

class SignUpPageCubit extends Cubit<SignUpPageModel>{
  SignUpPageCubit() : super(SignUpPageModel());

  void changeVisibility(){
    state.passwordVisibility = !state.passwordVisibility;
    emit(state.copyWith());
  }

  void gotLoginStatus(bool loginStatus, BuildContext context) {
    if (loginStatus) {
      state.openDrawer(context);
    }
    else {
      showAlertDialog(context,);
    }
  }

  Future<bool> onPressedGoogleButton(BuildContext context) async {
    bool loginStatus = await state.onPressedGoogleSignedIn(context);
    if (context.mounted) {
      gotLoginStatus(loginStatus, context);
    }
    return loginStatus;
  }

  Future<bool> onPressedSignUpButton(BuildContext context) async {
    bool loginStatus = await state.onPressedSignUpButton(context);
    if (context.mounted) {
      gotLoginStatus(loginStatus, context);
    }
    return loginStatus;
  }

}