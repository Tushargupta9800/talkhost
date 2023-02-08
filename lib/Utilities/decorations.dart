import 'package:flutter/material.dart';
import 'package:talkhost/Utilities/theme.dart';

BoxDecoration glassyDecoration(){
  return BoxDecoration(
    color: ThemeD.primaryColor,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10.0,
        spreadRadius: 5.0,
        offset: Offset(5.0, 5.0),
      ),
    ],
  );
}

BoxDecoration menuButtonDecoration(){
  return BoxDecoration(
    color: ThemeD.secondaryColor,
    borderRadius: BorderRadius.circular(10),
  );
}

TextStyle drawerUserInfoTextDecoration(){
  return const TextStyle(
    fontSize: 18,
    color: Colors.white,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600
  );
}