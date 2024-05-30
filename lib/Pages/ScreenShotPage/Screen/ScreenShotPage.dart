// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../../../Constant/Screen.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class ScreenShotPage extends StatefulWidget {
  const ScreenShotPage({
    Key? key,
  });

  @override
  State<ScreenShotPage> createState() => _ScreenShotPageState();
}

class _ScreenShotPageState extends State<ScreenShotPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trackScreenShot();
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final ScreenCaptureEvent screenListener = ScreenCaptureEvent();
 StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
    var text;
List<File> file  = [];
  trackScreenShot(){
        screenListener.addScreenRecordListener((recorded) {
        ///Recorded was your record status (bool)
            text = recorded ? "Start Recording" : "Stop Recording";
    });

    screenListener.addScreenShotListener((filePath) {
        ///filePath only available for Android
            text = "Screenshot stored on : $filePath";
           
            setState(() {
               file.add(File(filePath));
              });
    });

    ///You can add multiple listener ^-^
    screenListener.addScreenRecordListener((recorded) {
        print("Hi i'm 2nd Screen Record listener");
    });
    screenListener.addScreenShotListener((filePath) {
        print("Wohooo i'm 2nd Screenshot listener");
    });

    screenListener.watch();
       
            setState(() {
              });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
       appBar: appbar("Screen Shot", scaffoldKey, theme, context),
        drawer: drawer3(context),
      body: Container(
         child: Column(
          children: [
            Text("Capture screen"),
         ListView.builder(
                        shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                            itemCount: file.length,
                            itemBuilder: (BuildContext context, int i) {
                              if (file[i].path
                                  .split('/')
                                  .last
                                  .contains("png")) {
                                return InkWell(
                                  onTap: (){
                                     final remoteImages =  selectedImgClicked(i);              
                                      SwipeImageGallery(
                                                          context: context,
                                                        children: remoteImages,
                                                          onSwipe: (index) {
                                                          },
                                                          overlayController:
                                                              overlayController,
                                                        ).show();
                                  },
                                  child: Container(
                                     padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.01,
                                      left: Screens.width(context) * 0.01,
                                      bottom: Screens.bodyheight(context) * 0.01,
                                      top: Screens.bodyheight(context) * 0.01,
                                    ),
                                     decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.09,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: Center(
                                                  child: Image.file(file[i]))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.6,
                                              // height: Screens.padingHeight(context) * 0.06,
                                              alignment:
                                                  Alignment.centerLeft,
                                              child: Text(
                                               file[i].path
                                                    .split('/')
                                                    .last,
                                                // overflow: TextOverflow.ellipsis,
                                              )),
                                          Container(
                                              width:
                                                  Screens.width(context) *
                                                      0.1,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: IconButton(
                                                  onPressed: () {
                                               //  fdp. removeselectedImg(i);
                                                      // fdp.files
                                                      //     .removeAt(i);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ])
                                      // )
                                      ),
                                );
                              }
                             
                                return InkWell(
                                    onTap: (){
                                   final remoteImages =  selectedImgClicked(i);              
                                      SwipeImageGallery(
                                                          context: context,
                                                        children: remoteImages,
                                                          onSwipe: (index) {
                                                          },
                                                          overlayController:
                                                              overlayController,
                                                        ).show();
                                  },
                                  child: Container(
                                     padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.01,
                                      left: Screens.width(context) * 0.01,
                                      bottom: Screens.bodyheight(context) * 0.01,
                                      top: Screens.bodyheight(context) * 0.01,
                                    ),
                                     decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.09,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: Center(
                                                  child: Image.file(file[i]))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.6,
                                              // height: Screens.padingHeight(context) * 0.06,
                                              alignment:
                                                  Alignment.centerLeft,
                                              child: Text(
                                               file[i].path
                                                    .split('/')
                                                    .last,
                                                // overflow: TextOverflow.ellipsis,
                                              )),
                                          Container(
                                              width:
                                                  Screens.width(context) *
                                                      0.1,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: IconButton(
                                                  onPressed: () {
                                               //  fdp. removeselectedImg(i);
                                                      // fdp.files
                                                      //     .removeAt(i);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ])
                                      // )
                                      ),
                                );
                            
                           
                            })
          ],
         ),
      ));
  }

    List<Image> selectedImgClicked(int inde) {
    List<Image> img = [];
    img.add(Image.file(file[inde]));
    for (int i = 0; i < file.length; i++) {
      if (file[i].path.split('/').last.contains("png") ||
          file[i].path.split('/').last.contains("jp")) {
        if (file[inde].path !=
            file[i].path) {
          img.add(Image.file(file[i]));
        }
      }
    }
    return img;
  }
}