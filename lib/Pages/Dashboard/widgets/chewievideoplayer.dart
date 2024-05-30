import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:video_player/video_player.dart';

import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool? looping;

  VideoPlayerWidget({required this.videoPlayerController, this.looping});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  ChewieController? chewieController;

  @override
  void initState() {
    widget.  videoPlayerController.addListener(() {
     if(widget.videoPlayerController.value.isPlaying){
      setState(() {
       _formatDuration222(chewieController!.videoPlayerController.value.position);
     
      });
 
     }
  });
    super.initState();
    isplaying=false; 
    chewieController = ChewieController(
      aspectRatio: 16/9,
      useRootNavigator  :false,
    draggableProgressBar :false,
    allowMuting :false,
  showControls: false,
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      showOptions: false,
      looping: widget.looping ?? false,
      // Other options can be set as needed
    );
  
  }
bool isplaying=false;
bool showContainer = true;
bool showtimer = false;
String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${duration.inMinutes >= 10 ? duration.inMinutes : '0' + duration.inMinutes.toString()}:$twoDigitSeconds";
}
String position='';
String _formatDuration222(Duration duration) {
  // log("currentPosition ::"+duration.toString());
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return position="${duration.inMinutes >= 10 ? duration.inMinutes : '0' + duration.inMinutes.toString()}:$twoDigitSeconds";
}
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
 InkWell(
  onTap: (){
    setState(() {
      showContainer= !showContainer; 
    });
  },
   child: Chewie(
          controller: chewieController!,
        ),
 ),
      Visibility(
        visible: showContainer,
        child: Positioned(
          top: Screens.padingHeight(context)*0.07,
          left: Screens.width(context)*0.35,
          child: InkWell(
            onTap: (){
              if(isplaying==false){
                setState(() {
             showContainer= !showContainer;  
             showtimer =   !showContainer;  
               chewieController!.videoPlayerController.play();  
              isplaying=true;    
                });
              }else{
                setState(() {
                     isplaying=false;
       chewieController!.videoPlayerController.pause(); 
                });
              
              }
           
            },
            child: Container(
              height:Screens.padingHeight(context)*0.06 ,
              width:Screens.width(context)*0.2 ,
          
            decoration: BoxDecoration(
             color: Colors.black26,
              shape: BoxShape.circle
            ),
            child:isplaying==false? Icon(Icons.play_arrow,size: 30,):Icon(Icons.pause,size: 30,),
                ),
          )),
      ),

       Visibility(
        visible: showtimer,
        child: Positioned(
          bottom: Screens.padingHeight(context)*0.01,
          left: Screens.width(context)*0.15,
          child: InkWell(
      //       onTap: (){
      //         if(isplaying==false){
      //           setState(() {
      //        showContainer= !showContainer;     
      //  chewieController!.videoPlayerController.play();  
      //         isplaying=true;    
      //           });
      //         }else{
      //           setState(() {
      //                isplaying=false;
      //  chewieController!.videoPlayerController.pause(); 
      //           });
              
      //         }
           
      //       },
            child: Container(
              // height:Screens.padingHeight(context)*0.06 ,
              // width:Screens.width(context)*0.2 ,
          
            decoration: BoxDecoration(
             color: Colors.black26,
              // shape: BoxShape.circle
            ),
            child:Text("$position/${_formatDuration(chewieController!.videoPlayerController.value.duration)}",style: TextStyle(color: Colors.white),),
                ),
          )),
      )
      ],
     
    );
  }

  @override
  void dispose() {
    super.dispose();
    chewieController!.dispose();
    widget.videoPlayerController.dispose();
  }
}