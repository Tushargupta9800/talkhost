import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:talkhost/Pages/DrawerPages/about_page.dart';
import 'package:talkhost/Pages/DrawerPages/conferences_page.dart';
import 'package:talkhost/Pages/DrawerPages/create_meet_page.dart';
import 'package:talkhost/Pages/DrawerPages/dashboard_page.dart';
import 'package:talkhost/Pages/DrawerPages/edit_profile.dart';
import 'package:talkhost/Pages/DrawerPages/message_page.dart';
import 'package:talkhost/Pages/DrawerPages/my_meet_page.dart';
import 'package:talkhost/Pages/DrawerPages/search_person_page.dart';
import 'package:talkhost/Utilities/strings.dart';

import '../../Pages/DrawerPages/notifications_page.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerState());

  void changePage(String key){
    state.changePage(key);
    emit(DrawerState());
  }

}
