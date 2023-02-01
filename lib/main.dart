
import 'package:flutter/material.dart';
import '../pages/takepicturescreen.dart';
import 'package:camera/camera.dart';
import 'package:untitled/pages/searchpage.dart';
import 'package:untitled/pages/settingpage.dart';



void main() async{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Score",
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
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
  Future<CameraDescription> cameraA() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    return firstCamera;
  }





  @override



  Widget build(BuildContext context) {



      return Scaffold(
        body:
        IndexedStack(
          index: _selectedIndex,
          children:
          [
            SearchPage(),
            FutureBuilder(
                future: cameraA(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return CircularProgressIndicator();
                  }
                  else if (snapshot.hasError) {
                    return Center(
                        child: Text("Error: ${snapshot.error}")
                    );
                  }
                  else {
                    final theCamera = snapshot.data;
                    return TakePictureScreen(camera: theCamera);
                  }
                }),
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



