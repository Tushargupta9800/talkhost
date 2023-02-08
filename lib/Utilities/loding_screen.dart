import 'package:flutter/material.dart';
import 'package:talkhost/Utilities/theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300]?.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(
          color: ThemeD.primaryColor,
        ),
      ),
    );
  }
}
