import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/drawer_cubit.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/drawer_things.dart';

import '../../BLoCandLogic/Firestore/image_handler.dart';
import '../../Utilities/strings.dart';
import '../OnBoardingPages/on_boarding_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  void getimage() async {
    String bannerlink = await FirestoreImage.getImage(imageTalkHostDrawerBackgroundKey);
    log("banner link");
    print(bannerlink);
    String profileLink = await FirestoreImage.getImage(defaultUserProfileImage);
    log("user [profile image");
    print(profileLink);

  }

  @override
  void initState() {
    getimage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerCubit, DrawerState>(
      builder: (context, snapshot){
        return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                DrawerThings(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 5,
                  onPressedExit: () {
                    AuthState state = AuthState();
                    state.logout();
                    Navigator.of(context).popAndPushNamed(
                      OnBoardingPage.routeName,
                    );
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 4 * MediaQuery.of(context).size.width / 5,
                  color: Colors.white,
                  child:
                  getDrawerPageState(context: context).drawerPageBodyOption(),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
