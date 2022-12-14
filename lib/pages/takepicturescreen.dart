import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';




// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({
    super.key,
    required this.camera,
  });

  CameraDescription camera;


  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  int tapNumber = 0;
  Icon flash = Icon(Icons.flash_on_outlined,
    color: Colors.black,
    size: 40,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      getFloatingButtons(),

    );
  }
  Widget getFloatingButtons() {
    return
      Padding(
      padding: const EdgeInsets.only(bottom:20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        //?????? root app??? height??? 90???????????? SizedBox ???????????? ?????? ????????? Row ?????? ??????
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 45),
              IconButton(
                onPressed: () async{
                  //Take the Picture in a try / catch block.
                  // If anything goes wrong, catch the error.
                  try{
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    //Attempt to take a picture and get the file 'image'
                    // where it was saved.
                    final image = await _controller.takePicture();

                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            //Pass the automatically generated path to the DPS widget
                              imagePath: image.path,),
                      )
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                },
                icon: Icon(
                    Icons.camera,
                color: Colors.black,),
                  iconSize:100.0,
                padding: EdgeInsets.all(0.0),
                splashRadius: 45.0,
              ),

              // SizedBox(width: 120),
              IconButton(
                icon: flash,
                iconSize:45,
                padding: EdgeInsets.all(0.0),
                splashRadius: 25.0,
                onPressed: ()=> setState(() {
                 if (tapNumber == 0) {
                   _controller.setFlashMode(FlashMode.always);
                  tapNumber = 1;
                   flash = Icon(
                     Icons.flash_off_outlined,
                   );
                 print("flashmode on");}
                 else {
                  _controller.setFlashMode(FlashMode.off);
                  tapNumber = 0;
                  flash = Icon(
                    Icons.flash_on_outlined,
                  );
                 print("flashmode off");}
                },
                ),
                // onPressed: (){
                //   _controller.setFlashMode(FlashMode.always);
                //   // print('flashmode_is_on');
                // },
              ),
            ],
          ),
          // SizedBox(
          //   height: 90,
          // ),
        ],
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('????????? ??????????????????.')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}