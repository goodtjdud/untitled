import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:untitled/pages/takepicturescreen.dart';
import 'package:camera/camera.dart';
import 'package:untitled/pages/photopage.dart';
import 'package:untitled/pages/searchpage.dart';
import 'package:untitled/pages/settingpage.dart';

// void asdf() async {
//   // Ensure that plugin services are initialized so that `availableCameras()`
//   // can be called before `runApp()`
//   WidgetsFlutterBinding.ensureInitialized();
//   // Obtain a list of the available cameras on the device.
//   final cameras = await availableCameras();
//   final firstCamera = cameras[0];
//   // Get a specific camera from the list of available cameras.
// }



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  final firstCamera = cameras[0];

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Score",
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.black, fontSize:30),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: MainPage(),
      // Pass the appropriate camera to the TakePictureScreen widget.
    ),
  );
}


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;


  @override

  Widget build(BuildContext context) {

    final CameraDescription cameraa;
    cameraa = CameraDescription(name: '0',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 90);


      return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            SearchPage(),
            TakePictureScreen(camera: cameraa),
            SettingPage(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 110.6,
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.lightGreen[50],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: TextStyle(
              height: 1.6,
              fontSize:25,
              color: Colors.black,),
            unselectedLabelStyle: TextStyle(
              height: 1.6,
              fontSize:25,
              color: Colors.black54,
            ),// your text style
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size:32),
                label: "검색",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt, size:32),
                label: "촬영",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size:32),
                label: "설정",
              ),
            ],
          ),
        ),
      );
    }
  }



