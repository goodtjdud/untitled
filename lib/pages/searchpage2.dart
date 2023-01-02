import 'package:flutter/material.dart';

class SearchedPage extends StatelessWidget {
  SearchedPage({Key? key, required this.mediinfo})
      : super(key: key); //const였는데 tts때문에 뺌
  final Map mediinfo;

  // FlutterTts flutterTts = FlutterTts();
  // speak() {
  //   flutterTts.setLanguage("ko-KR");
  //   flutterTts.setSpeechRate(1.0);
  //   flutterTts.speak(mediinfo["약명"]);
  //   flutterTts.speak(mediinfo["제조사"]);
  //   flutterTts.speak(mediinfo["성분"]);
  //   flutterTts.speak(mediinfo["효능"]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mediinfo["약명"]),
      ),
      body: SafeArea(
        //padding 대신에 safearea로 하고
        //padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Text("품목명: ${mediinfo["약명"]}",
                style: TextStyle(fontSize: 20, fontFamily: 'SCDream4')),
            SizedBox(
              height: 20,
            ),
            Text("업체명: ${mediinfo["제조사"]}", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            Text("성분: ${mediinfo["성분"]}", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            Text("효능, 효과: ${mediinfo["효능"]}", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            Text("용법, 용량: ${mediinfo["복용"]}", style: TextStyle(fontSize: 20)),
          ]),
        ),
      ),
    );
  }
}
