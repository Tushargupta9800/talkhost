import 'package:flutter/material.dart';

Widget pushButton({required String title, required Function onPressed}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple[100]!,
          spreadRadius: 10,
          blurRadius: 20,
        ),
      ],
    ),
    child: ElevatedButton(
      onPressed: ()=> onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        child: Center(
          child: Text(title),
        ),
      ),
    ),
  );
}

Widget mouseButton({required Widget child, required Function onPressed}){
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: ()=> onPressed(),
      child: child,
    ),
  );
}