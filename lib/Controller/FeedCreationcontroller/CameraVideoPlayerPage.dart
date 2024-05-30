// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../VideoController.dart/VideoController.dart';
import 'FeedCrtController.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
   VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {

  @override
  void initState() {
    super.initState();
    print("path: "+widget.filePath.toString());
  }

  @override
  Widget build(BuildContext context) {
    // return 
   
    // ChangeNotifierProvider<VideoController>(
    //               create: (context) => VideoController(),
    //               builder: (context, child) {
    //                 return Consumer<VideoController>(
    //                     builder: (BuildContext context, provl, Widget? child) {
            return 
            Scaffold(
               appBar: AppBar(
      title: const Text('Preview'),
      elevation: 0,
      backgroundColor: Colors.black26,
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
           Navigator.pop(context);
           Navigator.pop(context);
           videoSelected();

          },
        )
      ],
    ),
    extendBodyBehindAppBar: true,
              body: FutureBuilder(
                future:initVideoPlayer(),
                builder: (context, state) {
                  if (state.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return VideoPlayer(videoPlayerController);
                  }
                },
              ),
            );
    //       }
    //     );
    //   }
    // );
  }

  static XFile? filevc;
     late VideoPlayerController videoPlayerController;

  Future initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(false);
    await videoPlayerController.play();
    //setState(() {});
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  videoSelected(){
    //FeedCreationProv.vidfile.add(filevc!) ;
    FeedCreationProv.files.add(File(filevc!.path));
    FeedCreationProv.videoSelected = true;
    setState(() {});
  }
}
