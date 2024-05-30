import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sellerkit/Pages/Dashboard/widgets/chewievideoplayer.dart';
import 'package:video_player/video_player.dart';

import '../../../Constant/Screen.dart';
import '../../../Widgets/Appbar.dart';
class VideoPlayer2 extends StatefulWidget {
  const VideoPlayer2({Key? key,required this.data1,required this.data2,required this.data3 }) : super(key: key);
final String data1;
final String data2;
final String data3;
  @override
  State<VideoPlayer2> createState() => _VideoPlayer2State();
}

class _VideoPlayer2State extends State<VideoPlayer2> {
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     final themes = Theme.of(context);
    return Scaffold(
       key: scaffoldKey,
appBar: appbar("Video Player", scaffoldKey,themes,context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
    widget. data1.toString().toLowerCase().contains(".mp4")?    
    Container(
                                                                 width: Screens
                                                                            .width(
                                                                                context) ,
                                                                    height: Screens
                                                                            .bodyheight(
                                                                                context) *
                                                                        0.30,
                                          //  width: Screens.width(
                                          //                                 context) *
                                          //                             0.52,
                                          //                         height: Screens
                                          //                                 .bodyheight(
                                          //                                     context) *
                                          //                             0.135,
                                         // color: Colors.red,
                                          child: 
                                            VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget. data1))
                                      )
                                          // HtmlWidget(
                                          //   '''<video width="300" height="700" controls preview>
                                          //    <source src="${widget. data1}" type="video/mp4">
                                          //    </video>''',
                                          // ),
                                        ):Container(),
                                        SizedBox(
                                          height: Screens.padingHeight(context)*0.02,
                                        ),
                                 widget. data2.toString().toLowerCase().contains(".mp4")?   Container(
                                                                 width: Screens
                                                                            .width(
                                                                                context) ,
                                                                    height: Screens
                                                                            .bodyheight(
                                                                                context) *
                                                                        0.30,
                                          //  width: Screens.width(
                                          //                                 context) *
                                          //                             0.52,
                                          //                         height: Screens
                                          //                                 .bodyheight(
                                          //                                     context) *
                                          //                             0.135,
                                         // color: Colors.red,
                                          child:   VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.data2))
                                      )
                                          // HtmlWidget(
                                          //   '''<video width="300" height="700" controls preview>
                                          //    <source src="${widget.data2}" type="video/mp4">
                                          //    </video>''',
                                          // ),
                                        ):Container(),
      
                                        SizedBox(
                                          height: Screens.padingHeight(context)*0.02,
                                        ),
                                 widget. data3.toString().toLowerCase().contains(".mp4")?     Container(
                                                                 width: Screens
                                                                            .width(
                                                                                context) ,
                                                                    height: Screens
                                                                            .bodyheight(
                                                                                context) *
                                                                        0.30,
                                          //  width: Screens.width(
                                          //                                 context) *
                                          //                             0.52,
                                          //                         height: Screens
                                          //                                 .bodyheight(
                                          //                                     context) *
                                          //                             0.135,
                                         // color: Colors.red,
                                          child: 
                                          VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.data3))
                                      )
                                          // HtmlWidget(
                                          //   '''<video width="300" height="700" controls preview>
                                          //    <source src="${widget.data3}" type="video/mp4">
                                          //    </video>''',
                                          // ),
                                        ):Container()
      
          ]),
        ),
      ),
    );
  }
}