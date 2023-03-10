import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/drawer_cubit.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/drawer_things.dart';
import 'package:talkhost/Utilities/loding_screen.dart';
import '../../Utilities/routes.dart';
import '../OnBoardingPages/on_boarding_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  static const String routeNamex = "/home";

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerCubit, DrawerState>(builder: (context, snapshot) {
      return Stack(
        children: [
          Scaffold(
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
                      navigateTo(
                        context: context,
                        route: OnBoardingPage.routeNamex,
                        enablePopAndPush: true,
                      );
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: 4 * MediaQuery.of(context).size.width / 5,
                    color: Colors.white,
                    child: getDrawerPageState(context: context)
                        .drawerPageBodyOption(),
                  ),
                ],
              ),
            ),
          ),
          (getDrawerPageState(context: context).getLoadingStatus())
              ? const LoadingScreen()
              : Container(),
        ],
      );
    });
  }
}
