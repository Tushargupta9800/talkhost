import 'package:flutter/material.dart';
import 'package:talkhost/Pages/DrawerPages/drawer.dart';
import 'package:talkhost/Pages/OnBoardingPages/on_boarding_page.dart';

void navigateTo({required BuildContext context, required String route, bool popThrough = false, bool enablePopAndPush = false}){

  if(popThrough){
    while(context.mounted && Navigator.of(context).canPop()){
      Navigator.pop(context);
    }
  }
  if(context.mounted && enablePopAndPush){
    // Navigator.pop(context);
  }

  switch(route){
    case OnBoardingPage.routeNamex:
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OnBoardingPage()));
      break;
    case DrawerPage.routeNamex:
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawerPage()));
      break;
    default:
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OnBoardingPage()));
  }
}