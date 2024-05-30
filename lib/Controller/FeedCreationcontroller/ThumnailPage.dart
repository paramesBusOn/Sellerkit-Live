// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ThumnailPage extends StatefulWidget {
  final String filePath;
   ThumnailPage({Key? key, required this.filePath}) : super(key: key);

  @override
  ThumnailPageState createState() =>ThumnailPageState();
}

class ThumnailPageState extends State<ThumnailPage> {

  @override
  void initState() {
    super.initState();
    print("path: "+widget.filePath.toString());
  }

  @override
  Widget build(BuildContext context) {
            return 
            Scaffold(
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
  }

  static XFile? filevc;
     late VideoPlayerController videoPlayerController;

  Future initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await videoPlayerController.initialize();
    // await videoPlayerController.setLooping(false);
  
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }
}
