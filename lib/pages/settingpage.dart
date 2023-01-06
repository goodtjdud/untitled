import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
                height: 50,
                child: Text("음성 안내")),
            SizedBox(
                height: 50,
                child: Text("앱 안내 듣기")),
            SizedBox(
                height: 50,
                child: Text("SettingPage")),

          ],
        ),
      ),
    );
  }
}
