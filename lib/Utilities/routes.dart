import 'package:flutter/material.dart';
import 'package:talkhost/Pages/DrawerPages/drawer.dart';
import 'package:talkhost/Pages/OnBoardingPages/on_boarding_page.dart';

final Map<String, WidgetBuilder> routes = {
  OnBoardingPage.routeName : (BuildContext context) => const OnBoardingPage(),
  DrawerPage.routeName : (BuildContext context) => const DrawerPage(),
};