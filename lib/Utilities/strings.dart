import 'package:flutter/material.dart';
String defaultErrorLine = "Some Error has been occurred please try again";
String drawerPageDashBoardKey = "DashBoard";
String drawerPageMessageKey = "Messages";
String drawerPageConferencesKey = "All Talks";
String drawerPageSearchPersonKey = "Search Person";
String drawerPageAboutKey = "About";
String drawerPageCreateMeetKey = "Create Talks";
String drawerPageMyHostedMeetKey = "My Hosted Talks";
String drawerEditPageKey = "Edit Page";
String drawerNotificationsPageKey = "Notifications";

String fireStorageUserProfileImagesKey = "profile_images/";
String fireStorageAgendaImagesKey = "agenda_images/";

Map<String, Icon> normalUserDrawer = {
  drawerPageDashBoardKey: const Icon(
    Icons.dashboard,
    color: Colors.white,
  ),
  drawerPageMessageKey: const Icon(
    Icons.question_answer,
    color: Colors.white,
  ),
  drawerNotificationsPageKey: const Icon(
    Icons.notifications,
    color: Colors.white,
  ),
  drawerPageConferencesKey: const Icon(
    Icons.people,
    color: Colors.white,
  ),
  drawerPageSearchPersonKey: const Icon(
    Icons.search,
    color: Colors.white,
  ),
  drawerPageAboutKey: const Icon(
    Icons.question_mark,
    color: Colors.white,
  ),
};

Map<String, Icon> hostDrawer = {
  drawerPageCreateMeetKey: const Icon(
    Icons.create,
    color: Colors.white,
  ),
  drawerPageMyHostedMeetKey: const Icon(
    Icons.view_comfy_alt_outlined,
    color: Colors.white,
  ),
};

String imageTalkHostDrawerBackgroundKey =
    "https://firebasestorage.googleapis.com/v0/b/talkhost-3515b.appspot.com/o/talkhost_drawer_bk.png?alt=media&token=5e2854f2-b31f-4b90-8f20-cfca600ce9a1";
String defaultUserProfileImage =
    "https://firebasestorage.googleapis.com/v0/b/talkhost-3515b.appspot.com/o/default_user_profile.png?alt=media&token=581579d5-e375-425a-b234-5328ceb73d57";
String nothingFoundImageKey =
    "https://firebasestorage.googleapis.com/v0/b/talkhost-3515b.appspot.com/o/empty_state.png?alt=media&token=482ff548-39c7-4e18-9177-d31920690a56";
