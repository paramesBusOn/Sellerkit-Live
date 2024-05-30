// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_constructors_in_immutables


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/FeedCreationcontroller/CameraVideoPlayerPage.dart';
import '../../../Controller/FeedCreationcontroller/CameraController.dart';
import 'CameraPage.dart';

class CameraPage extends StatefulWidget {
   CameraPage({Key? key,}) : super(key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {


  @override
  Widget build(BuildContext context) {
    
  
    final theme  = Theme.of(context);
     
      return ChangeNotifierProvider<CameraProv>(
                  create: (context) => CameraProv(),
                  builder: (context, child) {
                    return Consumer<CameraProv>(
                        builder: (BuildContext context, fdp, Widget? child) {
              if (fdp.isLoading) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
                  } else {
      return WillPopScope(
        onWillPop: fdp.onbackpress,
        child: Scaffold(
  body: SafeArea(
    child: CameraRecordVideoWidget(theme: theme, fdp: fdp)
    // PageView(
    //          physics: new NeverScrollableScrollPhysics(),
    //                           controller: fdp.pageController,
    //                           onPageChanged: (index) {
    //                             setState(() {
    //                              fdp.pageChanged = index;
    //                             });
    //                             print(fdp.pageChanged);
    //                           },
    //   children: [
    //     CameraRecordVideoWidget(theme: theme, fdp: fdp,),
    //     VideoPage(filePath: fdp.path, provl: fdp,)
    //   ],
    // ),
  ),
),
      );
    }
            }
          );
        }
      );
  }
}

