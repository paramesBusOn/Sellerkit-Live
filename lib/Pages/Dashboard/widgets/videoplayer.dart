import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../Constant/Screen.dart';
import '../../../Widgets/Appbar.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer(
      {Key? key, required this.data1,})
      : super(key: key);
  final String data1;
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: appbar("Video Player", scaffoldKey, themes, context),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Container(
                  // color: Colors.black,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.30,
                  child: HtmlWidget(
                    '''<video width="300" height="700" controls preview>
                                               <source src="${widget.data1}" type="video/mp4">
                                               </video>''',
                  ),
                              ),
                            ]),
                )),
      ),
    );
  }
}