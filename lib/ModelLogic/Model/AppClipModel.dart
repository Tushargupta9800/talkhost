import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Demo());
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String deviceInfo = '';

  @override
  void initState() {
    DeviceInfoPlugin().iosInfo.then((info) {
      setState(() {
        deviceInfo = '${info.name} on ${info.systemName} version '
            '${info.systemVersion}';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('App Clip'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(deviceInfo),
              const Padding(padding: EdgeInsets.only(top: 18)),
              const FlutterLogo(size: 128),
            ],
          ),
        ),
      ),
    );
  }
}