import 'package:talkhost/Utilities/debuggin_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/Pages/DrawerPages/drawer.dart';
import 'package:talkhost/Utilities/secrets.dart';
import 'package:talkhost/Utilities/simple_functions.dart';

import '../../Utilities/alertbox.dart';
import '../../Utilities/routes.dart';
import '../get_bloc.dart';

part 'sign_in_page_model.dart';

class SignInPageCubit extends Cubit<SignInPageModel> {
  SignInPageCubit() : super(SignInPageModel());

  void changeVisibility() {
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

  Future<bool> onPressedLoginButton(BuildContext context) async {
    bool loginStatus = await state.onPressedLoginButton(context);
    if(context.mounted) {
      gotLoginStatus(loginStatus, context);
    }
    return loginStatus;
  }
}
