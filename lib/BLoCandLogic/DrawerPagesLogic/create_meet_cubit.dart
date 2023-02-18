import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/BLoCandLogic/Firestore/image_handler.dart';
import 'package:talkhost/BLoCandLogic/Firestore/meeting_handler.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Pages/DrawerPages/extentions.dart';
import 'package:talkhost/Utilities/alertbox.dart';
import 'package:talkhost/Utilities/strings.dart';
import 'package:talkhost/models/post.dart';
import 'package:talkhost/models/user.dart';

part 'create_meet_state.dart';

class CreateMeetCubit extends Cubit<CreateMeetState>{
  CreateMeetCubit() : super(CreateMeetState());

  void changeNotificationAccess(bool val){
    state.notificationsOn = val;
    emit(state.copyWith(state));
  }

  void changeAlreadyHaveMeetLink(bool val){
    state.alreadyHaveMeetingLink = val;
    emit(state.copyWith(state));
  }

  void changePublicTalkOption(bool val){
    state.makeTalkPublic = val;
    emit(state.copyWith(state));
  }

  void clickOnSubmitButton(BuildContext context){
    state.listenChange();
    emit(state.copyWith(state));
    if(state.errorString == ""){
      state.clickOnSubmit(context);
    }
  }

  void onChoosingImageFile(BuildContext context) async {
    await state.chooseImage(context);
    emit(state.copyWith(state));
  }

}