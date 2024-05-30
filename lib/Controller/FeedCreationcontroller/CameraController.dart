// ignore_for_file: use_build_context_synchronously, prefer_const_declarations, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:video_player/video_player.dart';

import '../VideoController.dart/VideoController.dart';
import 'CameraVideoPlayerPage.dart';

class CameraProv extends ChangeNotifier{
  CameraProv(){
    initCamera();
    calculate();
  }
// camer page func

   bool isLoading = true;
  late CameraController cameraController;
  bool isRecording = false;

  @override
  void dispose() {
    cameraController.dispose();
    
    super.dispose();
  }

  initCamera() async {
  final cameras = await availableCameras();
  final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
  cameraController = CameraController(back, ResolutionPreset.max);
  await cameraController.initialize();
   isLoading = false;
   notifyListeners();
}

bool videopause = false;
 bool isbackCamera = true;
 bool isfalseAvail = false;



  pause(){
     if (isRecording) {
      if(videopause == false){
         cameraController.pauseVideoRecording();
         videopause = true;
      }
      else if(videopause == true){
        cameraController.resumeVideoRecording();
         videopause = false;
      }
     }
     notifyListeners();
  }

  swipeCamera()async{
    if(isbackCamera == true){
         final cameras = await availableCameras();
  final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
  cameraController = CameraController(front, ResolutionPreset.max);
    await cameraController.initialize();
 
     isbackCamera = false;
   notifyListeners();
    }
    else if(isbackCamera == false)
    {
           final cameras = await availableCameras();
  final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
  cameraController = CameraController(back, ResolutionPreset.max);
    await cameraController.initialize();
   
     isbackCamera = true;
     notifyListeners();
    }
      notifyListeners();
  }

  flas()async{
    if(isfalseAvail == false){
      cameraController.setFlashMode(FlashMode.torch);
      isfalseAvail = true;
    }
    else if(isfalseAvail == true){
      cameraController.setFlashMode(FlashMode.off);
      isfalseAvail = false;
    }
    notifyListeners();
  }

  recordVideo(BuildContext context,CameraProv provl) async {
  if (isRecording) {
    final file = await cameraController.stopVideoRecording();
    stopTimer();
    isRecording = false;
    VideoPageState.filevc = file;
    // final route = MaterialPageRoute(
    //   fullscreenDialog: true,
    //   builder: (_) => VideoPage(filePath: file.path),
    // );
    // Navigator.push(context, route);
     //Navigator.pop(context);
    
      gotoVideoPAge(file.path,provl);
     
  } else {
    await cameraController.prepareForVideoRecording();
    await cameraController.startVideoRecording();
    startTimer();
    isRecording = true;
  }
    notifyListeners();
}

  //trimer
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 0);
   void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
        notifyListeners();
  }
  // Step 4
  void stopTimer() {
    countdownTimer!.cancel();
    notifyListeners();
  }

    void setCountDown() {
    final reduceSecondsBy = 1;
      final seconds = myDuration.inSeconds +  reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
      calculate();
      notifyListeners();
  }

String hours =''; 
String minutes =''; 
String seconds =''; 

calculate(){
      String strDigits(int n) => n.toString().padLeft(2, '0');
   // final days = strDigits( myDuration.inDays);
    // Step 7
     hours = strDigits(myDuration.inHours.remainder(24));
     minutes = strDigits(myDuration.inMinutes.remainder(60));
     seconds = strDigits(myDuration.inSeconds.remainder(60));
     notifyListeners();
}
 
 // back btn
  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
 Future<bool> onbackpress() {
       if (pageChanged == 1) {
        pageController.animateToPage(--pageChanged,
        duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      }else if(pageChanged == 0){
        
       return Future.value(true);
      }
    return Future.value(false);
  }

//    gotoVideoPAge() {
//  log("pageChanged: ${pageChanged}");
//       if (pageChanged == 0) {
//         pageController.animateToPage(++pageChanged,
//         duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//       }
//     notifyListeners();
//   }

  gotoVideoPAge(String path,CameraProv provl ) {
      Get.to(()=> VideoPage(filePath: path));
    notifyListeners();
  }


  // video page


}