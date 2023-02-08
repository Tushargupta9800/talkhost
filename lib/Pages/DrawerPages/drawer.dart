import 'package:flutter/material.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/Utilities/drawer_things.dart';

import '../OnBoardingPages/on_boarding_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            DrawerThings(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 5,
              onPressedExit: (){
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
              color: Colors.blue,

            ),
          ],
        ),
      ),
    );
  }
}
