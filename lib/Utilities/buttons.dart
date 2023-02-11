import 'package:flutter/material.dart';
import 'package:talkhost/Utilities/theme.dart';

Widget pushButton({required String title, required Function onPressed}) {
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
      onPressed: () => onPressed(),
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

class MouseButtonSTF extends StatefulWidget {
  final Widget child;
  final Function onPressed;

  const MouseButtonSTF({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  State<MouseButtonSTF> createState() => _MouseButtonSTFState();
}

class _MouseButtonSTFState extends State<MouseButtonSTF> {

  Color buttonColor = ThemeD.primaryColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          buttonColor = Colors.purpleAccent;
        });
      },
      onExit: (event){
        setState(() {
          buttonColor = ThemeD.primaryColor;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onPressed(),
        child: Container(
          color: buttonColor,
          child: widget.child,
        ),
      ),
    );
  }
}

Widget mouseButton({required Widget child, required Function onPressed}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () => onPressed(),
      child: child,
    ),
  );
}
