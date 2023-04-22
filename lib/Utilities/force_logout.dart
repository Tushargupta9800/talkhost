import 'package:flutter/material.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/Pages/OnBoardingPages/on_boarding_page.dart';
import 'package:talkhost/Utilities/routes.dart';

class ForceLogout extends StatefulWidget {
  const ForceLogout({Key? key}) : super(key: key);

  @override
  State<ForceLogout> createState() => _ForceLogoutState();
}

class _ForceLogoutState extends State<ForceLogout> {
  void forceLogout() async {
    AuthState state = AuthState();
    await state.logout().then((value) {
      navigateTo(
        context: context,
        route: OnBoardingPage.routeNamex,
        popThrough: true,
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Logging You Out");
  }
}
