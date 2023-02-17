import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/BLoCandLogic/OnBoardingPageLogic/on_boarding_page_cubit.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/decorations.dart';
import 'package:talkhost/Utilities/loding_screen.dart';
import 'package:talkhost/models/User.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  static String routeName = "/";

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  Widget _menuButton({required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: menuButtonDecoration(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          getOnBoardingPageBloc(context: context).setPage(title);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: (OnBoardingPageModel.pageOpen == title) ? 18 : 15,
              fontWeight: (OnBoardingPageModel.pageOpen == title)
                  ? FontWeight.bold
                  : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: glassyDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _menuButton(
                title: getOnBoardingPageState(context: context).homeKey,
              ),
              _menuButton(
                title: getOnBoardingPageState(context: context).contactUsKey,
              ),
              _menuButton(
                title: getOnBoardingPageState(context: context).aboutUsKey,
              ),
            ],
          ),
          Row(
            children: [
              _menuButton(
                title: getOnBoardingPageState(context: context).signInPageKey,
              ),
              _menuButton(
                title: getOnBoardingPageState(context: context).signUpPageKey,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingPageCubit, OnBoardingPageModel>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  menu(),
                  getOnBoardingPageBloc(context: context).getOnBoardingPage(),
                ],
              ),
              OnBoardingPageModel.loadingScreenVisibility
                  ? const LoadingScreen()
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
