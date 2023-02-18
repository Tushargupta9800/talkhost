import 'package:flutter/material.dart';
import 'package:talkhost/Utilities/theme.dart';

class AppBarUtil extends StatelessWidget {
  final String title;

  const AppBarUtil({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeD.primaryColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                blurRadius: 25.0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
