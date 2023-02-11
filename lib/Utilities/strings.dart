import 'package:flutter/material.dart';

String defaultErrorLine = "Some Error has been occurred please try again";
String drawerPageDashBoardKey = "DashBoard";
String drawerPageMessageKey = "Messages";
String drawerPageConferencesKey = "Conferences";
String drawerPageSearchPersonKey = "Search Person";
String drawerPageAboutKey = "About";
String drawerPageCreateMeetKey = "Create Meet";
String drawerPageMyHostedMeetKey = "My Hosted Meet";
String drawerEditPageKey = "Edit Page";

Map<String, Icon> normalUserDrawer = {
  drawerPageDashBoardKey: const Icon(
    Icons.dashboard,
    color: Colors.white,
  ),
  drawerPageMessageKey: const Icon(
    Icons.question_answer,
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
    "Assets/Images/talkhost_drawer_bk.png";
String defaultUserProfileImage =
    "https://previews.123rf.com/images/triken/triken1608/triken160800029/61320775-male-avatar-profile-picture-default-user-avatar-guest-avatar-simply-human-head-vector-illustration-i.jpg";
