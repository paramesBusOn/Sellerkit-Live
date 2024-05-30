// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/FeedCreationcontroller/CameraController.dart';

class CameraRecordVideoWidget extends StatelessWidget {
  const CameraRecordVideoWidget({
    Key? key,
    required this.theme, required this.fdp,
  }) : super(key: key);

  final ThemeData theme;
  final CameraProv fdp;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context),
            child: CameraPreview(fdp.cameraController)),
          Positioned(
         //  left: Screens.width(context)*0.3,
          top: Screens.bodyheight(context)*0.01,
            child: Container(
              alignment: Alignment.topCenter,
               width: Screens.width(context),
              child: Text("${fdp.hours}:${fdp.minutes}:${fdp.seconds}",
              style: theme.textTheme.headline5?.copyWith(color: Colors.red),
              ),
            )),
          Positioned(
            top: Screens.bodyheight(context)*0.9,
             left: Screens.width(context)*0.02,
          right: Screens.width(context)*0.02,
            child: Container(
              width: Screens.width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    FloatingActionButton(
                      heroTag: "btn1",
                    backgroundColor: Colors.transparent.withOpacity(0.01),
                    child: Icon(Icons.cameraswitch),
                    onPressed: (){
                      fdp.swipeCamera();
                    } 
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Colors.red,
                    child: Icon(fdp.isRecording ? Icons.stop : Icons.circle),
                    onPressed: () => fdp.recordVideo(context,fdp),
                  ),
                   FloatingActionButton(
                    heroTag: "btn3",
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.flash_on ),
                    onPressed: () => fdp.flas(),
                  ),
                   FloatingActionButton(
                    heroTag: "btn4",
                    backgroundColor: Colors.transparent,
                    child: Icon(fdp.videopause? Icons.pause: Icons.stop),
                    onPressed: () => fdp.pause(),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}