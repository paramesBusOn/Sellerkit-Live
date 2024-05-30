// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
// import 'package:any_link_preview/any_link_preview.dart';
import 'dart:async';
import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:sellerkit/Pages/Dashboard/widgets/chewievideoplayer.dart';

import 'package:video_player/video_player.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sellerkit/Pages/Dashboard/widgets/videoplayer2.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import '../../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';
import '../../../Widgets/NetworkPDFViewer.dart';
//import 'package:simple_url_preview/simple_url_preview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FeedContainerNew extends StatefulWidget {
  FeedContainerNew({
    Key? key,
    required this.selected,
    required this.feedData,
    required this.pvdDSBD,
  }) : super(key: key);

  FeedsModalData feedData;
  String selected;
  DashBoardController pvdDSBD;
  @override
  State<FeedContainerNew> createState() => FeedContainerNewState();
}

class FeedContainerNewState extends State<FeedContainerNew> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shadowColor: Colors.red,
      child: Stack(
        children: [
          Container(
            width: Screens.width(context),
            // height: Screens.bodyheight(context) * 0.55,
            decoration: BoxDecoration(
                  // color: Colors.red.shade200
                ),
            padding: EdgeInsets.only(
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
              left: Screens.width(context) * 0.006,
              right: Screens.width(context) * 0.01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context),
                  //  color: Colors.yellow.shade200,
                  height: Screens.bodyheight(context) * 0.08,
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.01,
                      right: Screens.width(context) * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print("sdsdasd: ");
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => WEBV()));
                        },
                        child: Container(
                          width: Screens.width(context) * 0.1,
                          decoration: BoxDecoration(
                              //    color: Colors.blueAccent,
                              shape: BoxShape.circle,
                             image:widget.feedData.ProfilePic!.isEmpty? DecorationImage(
                                  image: //Image.network(widget.feedData.ProfilePic!),
                                      AssetImage("Assets/usericon.png",),
                                  fit: BoxFit.contain): DecorationImage(
                                  image: //Image.network(widget.feedData.ProfilePic!),
                                      NetworkImage(widget.feedData.ProfilePic!),
                                  fit: BoxFit.cover)),

                          // child:
                          // Image.network(widget.feedData.ProfilePic!=null?widget.feedData.ProfilePic!:''),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.78,
                        //   color: Colors.blueAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: Screens.bodyheight(context) * 0.03,
                              width: Screens.width(context) * 0.8,
                              child: Text(
                                "${widget.feedData.createdUserName}",
                                style: theme.textTheme.bodyText2?.copyWith(),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              height: Screens.bodyheight(context) * 0.04,
                              width: Screens.width(context) * 0.8,
                              //     color: Colors.red,
                              child: Text(
                                widget.pvdDSBD.config.subtractDateTime(widget
                                    .feedData.leadcheckdata2!.CreatedDate!),
                                style: theme.textTheme.bodyText2
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: Screens.width(context),
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.01,
                      right: Screens.width(context) * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print("sdsdasd: ");
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => WEBV()));
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.feedData.leadcheckdata2!.Title}",
                            style: theme.textTheme.subtitle1,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: ExpandableText(
                          '${widget.feedData.leadcheckdata2!.Description}',
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                          expandText: 'more',
                          collapseText: 'less',
                          maxLines: 2,
                          linkColor: theme.primaryColor,
                        ),
                      ),

                      //media type
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),

                                 widget.feedData.leadcheckdata2!.MediaURL1!.isEmpty&&
                                 widget.feedData.leadcheckdata2!.MediaURL2!.isEmpty&&
                                 widget.feedData.leadcheckdata2!.MediaURL3!.isEmpty?
                                 Container():
                                      Container(
                                        // alignment: Alignment.topLeft,
                                          // color: Colors.red,
                                          width: Screens.width(context),
                                          // height: Screens.bodyheight(context)*0.5,
                                          child: widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?
                                                          InkWell(
                                                            onTap: (){
                                                             
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width: Screens.width(context),
                                                                                                                  height: Screens.padingHeight(context)*0.3,
                                                                                                                   child:
                                                                                                                    VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.feedData.leadcheckdata2!.MediaURL1))
                                      )
                                                                                                    //                 HtmlWidget(
                                                                                                    //   '''<video width="300" height="700" controls preview>
                                                                                                    //    <source src="${widget.feedData.leadcheckdata2!.MediaURL1}" type="video/mp4">
                                                                                                    //    </video>''',
                                                                                                    // ),
                                                                                                 
                                                                ),
                                                              Positioned(
                                                                top: 50,
                                                                bottom: 50,
                                                                left: Screens.width(context)*0.4,
                                                                child:InkWell(
                                                                  onTap: (){
 Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer2(
                                                                data1: widget.feedData.leadcheckdata2!.MediaURL1!,
                                                                data2: widget.feedData.leadcheckdata2!.MediaURL2!,
                                                                data3:widget.feedData.leadcheckdata2!.MediaURL3! ,
                                                              )));
                                                                  },
                                                                  child: Container(
                                                                    child: CircleAvatar(
                                                                      radius: Screens.bodyheight(context)*0.05,
                                                                      backgroundColor: Colors.white,
                                                                    child: const Text('2+',),
                                                                    ),
                                                                  ),
                                                                )
                                                                )
                                                              ],
                                                            ),
                                                          ):
                                                         
                                              widget.feedData.leadcheckdata2!
                                                              .MediaURL1 ==
                                                          "" &&
                                                      widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL2 ==
                                                          "" &&
                                                      widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3 ==
                                                          ""
                                                  ? Container()
                                                 : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                      widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL1! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3! ==''?Container():widget.feedData.leadcheckdata2!.MediaURL1! ==''?Container():        
                                                           Container(
                                                             width: widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL2! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3! !=''||widget.feedData.leadcheckdata2!.MediaURL2! ==''?Screens.width(context)*0.9:Screens.width(context)*0.46,
                                                    height: Screens.padingHeight(context)*0.24,
                                                   
                                                        // color: Colors.pink,
                                                        child:
                                   
                                                       widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?
                                                            widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".com")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".net")
                                                          ? Container(
                                                            //  width: Screens.width(
                                                            //           context) *
                                                            //       0.52,
                                                            //   height: Screens
                                                            //           .bodyheight(
                                                            //               context) *
                                                            //       0.135,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                              child:
                                                                  AnyLinkPreview(
                                                                link:
                                                                    "${widget.feedData.leadcheckdata2!.MediaURL3}",
                                                                displayDirection:
                                                                    UIDirection
                                                                        .uiDirectionHorizontal,
                                                                cache: Duration(
                                                                    seconds: 1),
                                                                showMultimedia:
                                                                    false,
                                                                errorWidget:
                                                                    Container(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  child: Text(
                                                                      'Oops!'),
                                                                ),
                                                                urlLaunchMode:
                                                                    LaunchMode
                                                                        .externalApplication,
                                                                onTap: () {
                                                                  print(
                                                                      "sASasAS");
                                                                  widget.pvdDSBD.launchUrlInBrowser(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL3!); //"https://www.google.com"
                                                                },
                                                                // errorImage: _errorImage,
                                                              ),
                                                            )
                                                          :
                                                          widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".doc") ||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".xlsx")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?
                                                              InkWell(
                                  onTap:widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?(){
                                                                Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL3, appbarreq: true,title: 'PDF',));

                                                              }: () {
                                    print("object");
                                    widget.pvdDSBD.launchUrlInBrowser(
                                        widget.feedData.leadcheckdata2!.MediaURL3!);
                                    //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
                                  },
                                  child: Container(
                                      // width: Screens.width(
                                      //                                 context) *
                                      //                             0.52,
                                      //                         height: Screens
                                      //                                 .bodyheight(
                                      //                                     context) *
                                      //                             0.135,
                                      child: widget.feedData.leadcheckdata2!.MediaURL3!
                                              .toString()
                                              .toLowerCase()
                                              .contains(".pdf")
                                          ?Stack(
     children: [ Container(
                                              // width: Screens.width(context) *
                                              //     0.3,
                                              // height: Screens.bodyheight(
                                              //         context) *
                                              //     0.15,
                                              padding: EdgeInsets.all(5),
                                              color: Colors.grey[200],
                                              child: PDFViewerFromUrl(
                                                        url: widget.feedData.leadcheckdata2!.MediaURL3,
                                                        appbarreq: false,
                                                        title: 'PDF',
                                                      ),
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //       image: DecorationImage(
                                              //           image: AssetImage(
                                              //               'Assets/pdfimg.png'),
                                              //           fit: BoxFit.cover)),
                                              // ),
                                            ),Positioned(child: InkWell(
        onTap: (){
  Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL3, appbarreq: true,title: 'PDF',));
        },
        child: Container(
          width: Screens.width(context),
          height: Screens.padingHeight(context),
        ),
      ))
                                             ],
                                          )
                                          : widget.feedData.leadcheckdata2!.MediaURL3!
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(".doc")
                                              ? Container(
                                                // width:
                                                //     Screens.width(context) *
                                                //         0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'Assets/wordimg.jpg'),
                                                          fit: BoxFit
                                                              .cover)),
                                                ),
                                              )
                                              : widget.feedData.leadcheckdata2!.MediaURL3!
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(".xlsx")
                                                  ? Container(
                                                    // width: Screens.width(
                                                    //         context) *
                                                    //     0.3,
                                                    // height:
                                                    //     Screens.bodyheight(
                                                    //             context) *
                                                    //         0.15,
                                                    padding:
                                                        EdgeInsets.all(5),
                                                    color: Colors.grey[200],
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'Assets/pdfimg.png'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  )
                                                  : widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".doc")
                                                      ? Container(
                                                        // width: Screens.width(
                                                        //         context) *
                                                        //     0.3,
                                                        // height: Screens
                                                        //         .bodyheight(
                                                        //             context) *
                                                        //     0.15,
                                                        padding:
                                                            EdgeInsets.all(
                                                                5),
                                                        color: Colors
                                                            .grey[200],
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'Assets/xcelomg.png'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      )
                                                      : Container()),
                                ):

                                                          InkWell(
                                                              onTap: () {
                                                                final remoteImages =
                                                                    [
                                                                 
                                                                  // Image.network(widget
                                                                  //     .feedData
                                                                  //     .leadcheckdata2!
                                                                  //     .MediaURL2!),
                                                                      Image.network(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL3!),
                                                                 
                                                                ];
                                                                SwipeImageGallery(
                                                                  context:
                                                                      context,
                                                                  children:
                                                                      remoteImages,
                                                                  onSwipe:
                                                                      (index) {
                                                                    print(
                                                                        "Swiped");
                                                                    // overlayController.add(OverlayExample(
                                                                    //   title: '${index + 1}/${remoteImages.length}',
                                                                    // ));
                                                                  },
                                                                  overlayController:
                                                                      overlayController,
                                                                  // initialOverlay: OverlayExample(
                                                                  //   title: '1/${remoteImages.length}',
                                                                  // ),
                                                                ).show();
                                                              },
                                                              child: Container(
                                                                // width: Screens
                                                                //         .width(
                                                                //             context) *
                                                                //     0.40,
                                                                // height: Screens
                                                                //         .bodyheight(
                                                                //             context) *
                                                                //     0.27,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(widget.feedData.leadcheckdata2!.MediaURL3!),
                                                                            fit: BoxFit.contain))),
                                                              ),
                                                            )
                                                         
                                                       
                                                        // DATTATTATTA
                                                       
                                                      :   widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL1
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".com")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL1
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".net")
                                                          ? Container(
                                                           
                                                              // width: Screens
                                                              //           .width(
                                                              //               context) *
                                                              //       0.44,
                                                              //   height: Screens
                                                              //           .bodyheight(
                                                              //               context) *
                                                              //       0.27,
                                                                // padding:
                                                                //     EdgeInsets
                                                                //         .all(2),
                                                              child:
                                                                  AnyLinkPreview(
                                                                link:
                                                                    "${widget.feedData.leadcheckdata2!.MediaURL1}",
                                                                displayDirection:
                                                                    UIDirection
                                                                        .uiDirectionHorizontal,
                                                                cache: Duration(
                                                                    seconds: 1),
                                                                showMultimedia:
                                                                    false,
                                                                errorWidget:
                                                                    Container(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  child: Text(
                                                                      'Oops!'),
                                                                ),
                                                                urlLaunchMode:
                                                                    LaunchMode
                                                                        .externalApplication,
                                                                onTap: () {
                                                                  print(
                                                                      "sASasAS");
                                                                  widget.pvdDSBD.launchUrlInBrowser(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL1!); //"https://www.google.com"
                                                                },
                                                                // errorImage: _errorImage,
                                                              ),
                                                            )
                                                          : widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL1
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".doc") ||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL1
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".xlsx")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL1
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?
                                                              InkWell(
                                  onTap:widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL1
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?(){
                                                                Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL1, appbarreq: true,title: 'PDF',));

                                                              }: () {
                                    print("object");
                                    widget.pvdDSBD.launchUrlInBrowser(
                                        widget.feedData.leadcheckdata2!.MediaURL1!);
                                    //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
                                  },
                                  child: Container(
                                      // width: Screens
                                      //                                   .width(
                                      //                                       context) *
                                      //                               0.40,
                                      //                           height: Screens
                                      //                                   .bodyheight(
                                      //                                       context) *
                                      //                               0.27,
                                      child: widget.feedData.leadcheckdata2!.MediaURL1!
                                              .toString()
                                              .toLowerCase()
                                              .contains(".pdf")
                                          ? Stack(
                                            children: [ Container(
                                              // width: Screens.width(context) *
                                              //     0.3,
                                              // height: Screens.bodyheight(
                                              //         context) *
                                              //     0.15,
                                              padding: EdgeInsets.all(5),
                                              color: Colors.grey[200],
                                              child: PDFViewerFromUrl(
                                                        url: widget.feedData.leadcheckdata2!.MediaURL1,
                                                        appbarreq: false,
                                                        title: 'PDF',
                                                      ),
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //       image: DecorationImage(
                                              //           image: AssetImage(
                                              //               'Assets/xcelomg.png'),
                                              //           fit: BoxFit.cover)
                                              //           ),
                                              // ),
                                             ),
                                             Positioned(child: InkWell(
        onTap: (){
  Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL1, appbarreq: true,title: 'PDF',));
        },
        child: Container(
          width: Screens.width(context),
          height: Screens.padingHeight(context),
        ),
      ))
                                             ],
                                          )
                                          : widget.feedData.leadcheckdata2!.MediaURL1!
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(".doc")
                                              ? Container(
                                                // width:
                                                //     Screens.width(context) *
                                                //         0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'Assets/wordimg.jpg'),
                                                          fit: BoxFit
                                                              .cover)),
                                                ),
                                              )
                                              : widget.feedData.leadcheckdata2!.MediaURL1!
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(".xlsx")
                                                  ? Container(
                                                    // width: Screens.width(
                                                    //         context) *
                                                    //     0.3,
                                                    // height:
                                                    //     Screens.bodyheight(
                                                    //             context) *
                                                    //         0.15,
                                                    padding:
                                                        EdgeInsets.all(5),
                                                    color: Colors.grey[200],
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'Assets/xcelomg.png'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  )
                                                  : widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".doc")
                                                      ? Container(
                                                        // width: Screens.width(
                                                        //         context) *
                                                        //     0.3,
                                                        // height: Screens
                                                        //         .bodyheight(
                                                        //             context) *
                                                        //     0.15,
                                                        padding:
                                                            EdgeInsets.all(
                                                                5),
                                                        color: Colors
                                                            .grey[200],
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'Assets/xcelomg.png'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      )
                                                      : Container()),
                                ):InkWell(
                                                              onTap: () {
                                                                final remoteImages =
                                                                    [
                                                                  Image.network(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL1!),
                                                                  // Image.network(widget
                                                                  //     .feedData
                                                                  //     .leadcheckdata2!
                                                                  //     .MediaURL2!),
                                                                   
                                                                 
                                                                ];
                                                                SwipeImageGallery(
                                                                  context:
                                                                      context,
                                                                  children:
                                                                      remoteImages,
                                                                  onSwipe:
                                                                      (index) {
                                                                    print(
                                                                        "Swiped");
                                                                    // overlayController.add(OverlayExample(
                                                                    //   title: '${index + 1}/${remoteImages.length}',
                                                                    // ));
                                                                  },
                                                                  overlayController:
                                                                      overlayController,
                                                                  // initialOverlay: OverlayExample(
                                                                  //   title: '1/${remoteImages.length}',
                                                                  // ),
                                                                ).show();
                                                              },
                                                              child: Container(
                                                                // alignment: Alignment.centerLeft,
                                                                //  color: Colors.yellow,
                                                                // width: Screens
                                                                //         .width(
                                                                //             context) ,
                                                                // height: Screens
                                                                //         .bodyheight(
                                                                //             context) *
                                                                //     0.30,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Container(
                                                                  
                                                                    decoration: BoxDecoration(
                                                                     
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(widget.feedData.leadcheckdata2!.MediaURL1!),
                                                                           fit: BoxFit.contain ))),
                                                              ),
                                                            ),

                                                          ),
                                                          SizedBox(
                                                            width: Screens.width(context)*0.01,
                                                          ),
                                                   widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL2! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3! !=''?Container():
                                                          widget.feedData.leadcheckdata2!.MediaURL2! ==''?Container():    
                                                            Container(
                                                             width:widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL1! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL1! =='' ?Screens.width(context)*0.9: Screens.width(context)*0.46,
                                                    height: Screens.padingHeight(context)*0.24,
                                                        // color: Colors.blue,
                                                    child:   widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?
                                                            widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".com")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".net")
                                                          ? Container(
                                                            //  width: Screens.width(
                                                            //           context) *
                                                            //       0.52,
                                                            //   height: Screens
                                                            //           .bodyheight(
                                                            //               context) *
                                                            //       0.135,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                              child:
                                                                  AnyLinkPreview(
                                                                link:
                                                                    "${widget.feedData.leadcheckdata2!.MediaURL3}",
                                                                displayDirection:
                                                                    UIDirection
                                                                        .uiDirectionHorizontal,
                                                                cache: Duration(
                                                                    seconds: 1),
                                                                showMultimedia:
                                                                    false,
                                                                errorWidget:
                                                                    Container(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  child: Text(
                                                                      'Oops!'),
                                                                ),
                                                                urlLaunchMode:
                                                                    LaunchMode
                                                                        .externalApplication,
                                                                onTap: () {
                                                                  print(
                                                                      "sASasAS");
                                                                  widget.pvdDSBD.launchUrlInBrowser(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL3!); //"https://www.google.com"
                                                                },
                                                                // errorImage: _errorImage,
                                                              ),
                                                            )
                                                          :
                                                          widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".doc") ||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".xlsx")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?
                                                              InkWell(
                                  onTap:widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?(){
                                                                Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL3, appbarreq: true,title: 'PDF',));

                                                              }: () {
                                    print("object");
                                    widget.pvdDSBD.launchUrlInBrowser(
                                        widget.feedData.leadcheckdata2!.MediaURL3!);
                                    //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
                                  },
                                  child: Container(
                                      // width: Screens.width(
                                      //                                 context) *
                                      //                             0.52,
                                      //                         height: Screens
                                      //                                 .bodyheight(
                                      //                                     context) *
                                      //                             0.135,
                                      child: widget.feedData.leadcheckdata2!.MediaURL3!
                                              .toString()
                                              .toLowerCase()
                                              .contains(".pdf")
                                          ? Stack(
                                            children: [
                                              Container(
                                                // width: Screens.width(context) *
                                                //     0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: PDFViewerFromUrl(
              url: widget.feedData.leadcheckdata2!.MediaURL3,
              appbarreq: false,
              title: 'PDF',
            ),
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //       image: DecorationImage(
                                                //           image: AssetImage(
                                                //               'Assets/pdfimg.png'),
                                                //           fit: BoxFit.cover)),
                                                // ),
                                              ),Positioned(child: InkWell(
        onTap: (){
  Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL3, appbarreq: true,title: 'PDF',));
        },
        child: Container(
          width: Screens.width(context),
          height: Screens.padingHeight(context),
        ),
      ))
                                            ],
                                          )
                                          : widget.feedData.leadcheckdata2!.MediaURL3!
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(".doc")
                                              ? Container(
                                                // width:
                                                //     Screens.width(context) *
                                                //         0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'Assets/wordimg.jpg'),
                                                          fit: BoxFit
                                                              .cover)),
                                                ),
                                              )
                                              : widget.feedData.leadcheckdata2!.MediaURL3!
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(".xlsx")
                                                  ? Container(
                                                    // width: Screens.width(
                                                    //         context) *
                                                    //     0.3,
                                                    // height:
                                                    //     Screens.bodyheight(
                                                    //             context) *
                                                    //         0.15,
                                                    padding:
                                                        EdgeInsets.all(5),
                                                    color: Colors.grey[200],
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'Assets/xcelomg.png'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  )
                                                  : widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".doc")
                                                      ? Container(
                                                        // width: Screens.width(
                                                        //         context) *
                                                        //     0.3,
                                                        // height: Screens
                                                        //         .bodyheight(
                                                        //             context) *
                                                        //     0.15,
                                                        padding:
                                                            EdgeInsets.all(
                                                                5),
                                                        color: Colors
                                                            .grey[200],
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'Assets/xcelomg.png'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      )
                                                      : Container()),
                                ):

                               
                                                         





                                                          InkWell(
                                                              onTap: () {
                                                                final remoteImages =
                                                                    [
                                                                  // Image.network(widget
                                                                  //     .feedData
                                                                  //     .leadcheckdata2!
                                                                  //     .MediaURL1!),
                                                                 
                                                                      Image.network(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL3!),
                                                                 
                                                                ];
                                                                SwipeImageGallery(
                                                                  context:
                                                                      context,
                                                                  children:
                                                                      remoteImages,
                                                                  onSwipe:
                                                                      (index) {
                                                                    print(
                                                                        "Swiped");
                                                                    // overlayController.add(OverlayExample(
                                                                    //   title: '${index + 1}/${remoteImages.length}',
                                                                    // ));
                                                                  },
                                                                  overlayController:
                                                                      overlayController,
                                                                  // initialOverlay: OverlayExample(
                                                                  //   title: '1/${remoteImages.length}',
                                                                  // ),
                                                                ).show();
                                                              },
                                                              child: Container(
                                                                // width: Screens
                                                                //         .width(
                                                                //             context) *
                                                                //     0.40,
                                                                // height: Screens
                                                                //         .bodyheight(
                                                                //             context) *
                                                                //     0.27,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(widget.feedData.leadcheckdata2!.MediaURL3!),
                                                                            fit: BoxFit.contain))),
                                                              ),
                                                            )
                                                         
                                                       
                                                        // DATTATTATTA
                                                       
                                                      : widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL2
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".com")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL2
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".net")
                                                          ? Container(
                                                              // width: Screens.width(
                                                              //         context) *
                                                              //     0.44,
                                                              // height: Screens
                                                              //         .bodyheight(
                                                              //             context) *
                                                              //     0.135,
                                                                // padding:
                                                                //     EdgeInsets
                                                                //         .all(2),
                                                              child:
                                                                  AnyLinkPreview(
                                                                link:
                                                                    "${widget.feedData.leadcheckdata2!.MediaURL2}",
                                                                displayDirection:
                                                                    UIDirection
                                                                        .uiDirectionHorizontal,
                                                                cache: Duration(
                                                                    seconds: 1),
                                                                showMultimedia:
                                                                    false,
                                                                errorWidget:
                                                                    Container(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  child: Text(
                                                                      'Oops!'),
                                                                ),
                                                                urlLaunchMode:
                                                                    LaunchMode
                                                                        .externalApplication,
                                                                onTap: () {
                                                                  print(
                                                                      "sASasAS");
                                                                  widget.pvdDSBD.launchUrlInBrowser(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL2!); //"https://www.google.com"
                                                                },
                                                                // errorImage: _errorImage,
                                                              ),
                                                            )
                                                          :
                                                          widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL2
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".doc") ||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL2
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".xlsx")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL2
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?
                                                              InkWell(
                                  onTap: widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL2
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?(){
                                                                Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL2, appbarreq: true,title: 'PDF',));

                                                              }:() {
                                    print("object");
                                    widget.pvdDSBD.launchUrlInBrowser(
                                        widget.feedData.leadcheckdata2!.MediaURL2!);
                                    //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
                                  },
                                  child: Container(
                                      // width: Screens.width(
                                      //                                 context) *
                                      //                             0.52,
                                      //                         height: Screens
                                      //                                 .bodyheight(
                                      //                                     context) *
                                      //                             0.135,
                                      child: widget.feedData.leadcheckdata2!.MediaURL2!
                                              .toString()
                                              .toLowerCase()
                                              .contains(".pdf")
                                          ? Stack(
                                            children: [
                                              Container(
                                                // width: Screens.width(context) *
                                                //     0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: PDFViewerFromUrl(
              url: widget.feedData.leadcheckdata2!.MediaURL2,
              appbarreq: false,
              title: 'PDF',
            ),
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //       image: DecorationImage(
                                                //           image: AssetImage(
                                                //               'Assets/pdfimg.png'),
                                                //           fit: BoxFit.cover)),
                                                // ),
                                              ),Positioned(child: InkWell(
        onTap: (){
  Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL2, appbarreq: true,title: 'PDF',));
        },
        child: Container(
          width: Screens.width(context),
          height: Screens.padingHeight(context),
        ),
      ))
                                            ],
                                          )
                                          : widget.feedData.leadcheckdata2!.MediaURL2!
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(".doc")
                                              ? Container(
                                                // width:
                                                //     Screens.width(context) *
                                                //         0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'Assets/wordimg.jpg'),
                                                          fit: BoxFit
                                                              .cover)),
                                                ),
                                              )
                                              : widget.feedData.leadcheckdata2!.MediaURL2!
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(".xlsx")
                                                  ? Container(
                                                    // width: Screens.width(
                                                    //         context) *
                                                    //     0.3,
                                                    // height:
                                                    //     Screens.bodyheight(
                                                    //             context) *
                                                    //         0.15,
                                                    padding:
                                                        EdgeInsets.all(5),
                                                    color: Colors.grey[200],
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'Assets/xcelomg.png'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  )
                                                  : widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".doc")
                                                      ? Container(
                                                        // width: Screens.width(
                                                        //         context) *
                                                        //     0.3,
                                                        // height: Screens
                                                        //         .bodyheight(
                                                        //             context) *
                                                        //     0.15,
                                                        padding:
                                                            EdgeInsets.all(
                                                                5),
                                                        color: Colors
                                                            .grey[200],
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'Assets/xcelomg.png'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      )
                                                      : Container()),
                                ):

                                                          InkWell(
                                                              onTap: () {
                                                                final remoteImages =
                                                                    [
                                                                  // Image.network(widget
                                                                  //     .feedData
                                                                  //     .leadcheckdata2!
                                                                  //     .MediaURL1!),
                                                                  Image.network(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL2!),
                                                                     
                                                                 
                                                                ];
                                                                SwipeImageGallery(
                                                                  context:
                                                                      context,
                                                                  children:
                                                                      remoteImages,
                                                                  onSwipe:
                                                                      (index) {
                                                                    print(
                                                                        "Swiped");
                                                                    // overlayController.add(OverlayExample(
                                                                    //   title: '${index + 1}/${remoteImages.length}',
                                                                    // ));
                                                                  },
                                                                  overlayController:
                                                                      overlayController,
                                                                  // initialOverlay: OverlayExample(
                                                                  //   title: '1/${remoteImages.length}',
                                                                  // ),
                                                                ).show();
                                                              },
                                                              child: Container(
                                                                // color: Colors.amber,
                                                                //  width: Screens
                                                                //         .width(
                                                                //             context) ,
                                                                // height: Screens
                                                                //         .bodyheight(
                                                                //             context) *
                                                                //     0.30,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(widget.feedData.leadcheckdata2!.MediaURL2!),
                                                                            fit: BoxFit.contain))),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                       SizedBox(
                                                            height: Screens.padingHeight(context)*0.01,
                                                          ),
                                                         widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?InkWell(
                                                            onTap: (){
                                                             
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width: Screens.width(context),
                                                                                                                  height: Screens.padingHeight(context)*0.3,
                                                                                                                   child: 
                                                                                                                    VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.feedData.leadcheckdata2!.MediaURL1!.isEmpty?widget.feedData.leadcheckdata2!.MediaURL2:widget.feedData.leadcheckdata2!.MediaURL1))
                                      )
                                                                                                    //                HtmlWidget(
                                                                                                    //   '''<video width="300" height="700" controls preview>
                                                                                                    //    <source src="${widget.feedData.leadcheckdata2!.MediaURL1!.isEmpty?widget.feedData.leadcheckdata2!.MediaURL2:widget.feedData.leadcheckdata2!.MediaURL1}" type="video/mp4">
                                                                                                    //    </video>''',
                                                                                                    // ),
                                                                                                 
                                                                ),
                                                              Positioned(
                                                                top: 50,
                                                                bottom: 50,
                                                                left: Screens.width(context)*0.4,
                                                                child:InkWell(
                                                                  onTap: (){
                                                                                 
 Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer2(
                                                                data1: widget.feedData.leadcheckdata2!.MediaURL1!,
                                                                data2: widget.feedData.leadcheckdata2!.MediaURL2!,
                                                                data3:widget.feedData.leadcheckdata2!.MediaURL3! ,
                                                              )));
                                                                  },
                                                                  child: Container(
                                                                    child: CircleAvatar(
                                                                      radius: Screens.bodyheight(context)*0.05,
                                                                      backgroundColor: Colors.white,
                                                                    child: const Text('1+',),
                                                                    ),
                                                                  ),
                                                                )
                                                                )
                                                              ],
                                                            ),
                                                          ): widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?InkWell(
                                                            onTap: (){
                                                             
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width: Screens.width(context),
                                                                                                                  height: Screens.padingHeight(context)*0.3,
                                                                                                                   child: 
                                                                                                                   VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.feedData.leadcheckdata2!.MediaURL2!))
                                      )
                                                                                                    //                HtmlWidget(
                                                                                                    //   '''<video width="300" height="700" controls preview>
                                                                                                    //    <source src="${widget.feedData.leadcheckdata2!.MediaURL2!}" type="video/mp4">
                                                                                                    //    </video>''',
                                                                                                    // ),
                                                                                                 
                                                                ),
                                                              Positioned(
                                                                top: 50,
                                                                bottom: 50,
                                                                left: Screens.width(context)*0.4,
                                                                child:InkWell(
                                                                 
                                                                  onTap: (){
                                                                    log(" data1: widget.feedData.leadcheckdata2!.MediaURL1!::"+ widget.feedData.leadcheckdata2!.MediaURL1!.toString());
                                                 
 Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer2(
                                                                data1: widget.feedData.leadcheckdata2!.MediaURL1,
                                                                data2: widget.feedData.leadcheckdata2!.MediaURL2,
                                                                data3:widget.feedData.leadcheckdata2!.MediaURL3 ,
                                                              )));
                                                                  },
                                                                  child: Container(
                                                                    child: CircleAvatar(
                                                                      radius: Screens.bodyheight(context)*0.05,
                                                                      backgroundColor: Colors.white,
                                                                    child: const Text('1+',),
                                                                    ),
                                                                  ),
                                                                )
                                                                )
                                                              ],
                                                            ),
                                                          ):widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?InkWell(
                                                            onTap: (){
                                                             
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width: Screens.width(context),
                                                                                                                  height: Screens.padingHeight(context)*0.3,
                                                                                                                   child:
                                                                                                                   VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.feedData.leadcheckdata2!.MediaURL1!))
                                      )
                                                                                                                   
                                                                                                    //                 HtmlWidget(
                                                                                                    //   '''<video width="300" height="700" controls preview>
                                                                                                    //    <source src="${widget.feedData.leadcheckdata2!.MediaURL1!}" type="video/mp4">
                                                                                                    //    </video>''',
                                                                                                    // ),
                                                                                                 
                                                                ),
                                                              Positioned(
                                                                top: 50,
                                                                bottom: 50,
                                                                left: Screens.width(context)*0.4,
                                                                child:InkWell(
                                                                 
                                                                  onTap: (){
                                                                    log(" data1: widget.feedData.leadcheckdata2!.MediaURL1!::"+ widget.feedData.leadcheckdata2!.MediaURL1!.toString());
                                                 
 Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer2(
                                                                data1: widget.feedData.leadcheckdata2!.MediaURL1,
                                                                data2: widget.feedData.leadcheckdata2!.MediaURL2,
                                                                data3:widget.feedData.leadcheckdata2!.MediaURL3 ,
                                                              )));
                                                                  },
                                                                  child: Container(
                                                                    child: CircleAvatar(
                                                                      radius: Screens.bodyheight(context)*0.05,
                                                                      backgroundColor: Colors.white,
                                                                    child: const Text('1+',),
                                                                    ),
                                                                  ),
                                                                )
                                                                )
                                                              ],
                                                            ),
                                                          ):

                                                         
                                              widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")|| widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?  
                                                           Container(
                                                    width: Screens.width(context),
                                                    height: Screens.padingHeight(context)*0.2,
                                                        // color: Colors.amber,    
                                                        child:  widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?
                                                          Container(
                                                             width: Screens
                                                                        .width(
                                                                            context) ,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.20,
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
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.feedData.leadcheckdata2!.MediaURL3))
                                      )
                                      // HtmlWidget(
                                      //   '''<video width="300" height="700" controls preview>
                                      //    <source src="${widget.feedData.leadcheckdata2!.MediaURL3}" type="video/mp4">
                                      //    </video>''',
                                      // ),
                                    ):widget.feedData.leadcheckdata2!.MediaURL2!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?
                                                          Container(
                                                             width: Screens
                                                                        .width(
                                                                            context) ,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.20,
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
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.feedData.leadcheckdata2!.MediaURL2))
                                      )
                                      //  HtmlWidget(
                                      //   '''<video width="300" height="700" controls preview>
                                      //    <source src="${widget.feedData.leadcheckdata2!.MediaURL2}" type="video/mp4">
                                      //    </video>''',
                                      // ),
                                    ):widget.feedData.leadcheckdata2!.MediaURL1!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".mp4")?
                                                          Container(
                                                             width: Screens
                                                                        .width(
                                                                            context) ,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.20,
                                     
                                     // color: Colors.red,
                                      child:
                                     VideoPlayerWidget(
                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.feedData.leadcheckdata2!.MediaURL1))
                                      )
            // )
                                      //  HtmlWidget(
                                      //   '''<video width="300" height="700" controls preview>
                                      //    <source src="${widget.feedData.leadcheckdata2!.MediaURL1}" type="video/mp4">
                                      //    </video>''',
                                      // ),
                                    ):Container()
                                                          ):widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3!.isEmpty?Container():
                                                          Container(
                                                            width: Screens.width(context),
                                                            // color: Colors.amber,
                                                            child: widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".com")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".net")
                                                          ? Container(
                                                             width: Screens.width(
                                                                      context) *
                                                                  0.52,
                                                              height: Screens
                                                                      .bodyheight(
                                                                          context) *
                                                                  0.135,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                              child:
                                                                  AnyLinkPreview(
                                                                link:
                                                                    "${widget.feedData.leadcheckdata2!.MediaURL3}",
                                                                displayDirection:
                                                                    UIDirection
                                                                        .uiDirectionHorizontal,
                                                                cache: Duration(
                                                                    seconds: 1),
                                                                showMultimedia:
                                                                    false,
                                                                errorWidget:
                                                                    Container(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  child: Text(
                                                                      'Oops!'),
                                                                ),
                                                                urlLaunchMode:
                                                                    LaunchMode
                                                                        .externalApplication,
                                                                onTap: () {
                                                                  print(
                                                                      "sASasAS");
                                                                  widget.pvdDSBD.launchUrlInBrowser(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL3!); //"https://www.google.com"
                                                                },
                                                                // errorImage: _errorImage,
                                                              ),
                                                            )
                                                          :
                                                          widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".doc") ||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".xlsx")||widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?
                                                              InkWell(
                                  onTap: widget
                                                              .feedData
                                                              .leadcheckdata2!
                                                              .MediaURL3
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(".pdf")?(){
                                                                Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL3, appbarreq: true,title: 'PDF',));

                                                              }:() {
                                    print("object");
                                    widget.pvdDSBD.launchUrlInBrowser(
                                        widget.feedData.leadcheckdata2!.MediaURL3!);
                                    //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
                                  },
                                  child: Container(
                                    // color:Colors.amber,
                                      width: Screens.width(
                                                                      context),
                                                              height: Screens
                                                                      .bodyheight(
                                                                          context) *0.20,
                                      child: widget.feedData.leadcheckdata2!.MediaURL3!
                                              .toString()
                                              .toLowerCase()
                                              .contains(".pdf")
                                          ? Stack(children: [
                                              Container(
                                                // width: Screens.width(context) *
                                                //     0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: PDFViewerFromUrl(
              url: widget.feedData.leadcheckdata2!.MediaURL3,
              appbarreq: false,
              title: 'PDF',
            ),
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //       image: DecorationImage(
                                                //           image: AssetImage(
                                                //               'Assets/pdfimg.png'),
                                                //           fit: BoxFit.cover)),
                                                // ),
                                              ),Positioned(child: InkWell(
        onTap: (){
  Get.to(()=>PDFViewerFromUrl(url: widget.feedData.leadcheckdata2!.MediaURL3, appbarreq: true,title: 'PDF',));
        },
        child: Container(
          width: Screens.width(context),
          height: Screens.padingHeight(context),
        ),
      ))
                                              // Container(
                                              //     width:
                                              //         Screens.width(context) *
                                              //             0.55,
                                              //     height: Screens.bodyheight(
                                              //             context) *
                                              //         0.15,
                                              //     padding: EdgeInsets.all(2),
                                              //     color: Colors.grey[200],
                                              //     child: Center(
                                              //         child: Text(
                                              //       widget.feedData.leadcheckdata2!.Title!,
                                              //       style: theme
                                              //           .textTheme.bodyText2,
                                              //       textAlign: TextAlign.center,
                                              //     ))),
                                            ]
                                            )
                                          : widget.feedData.leadcheckdata2!.MediaURL3!
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(".doc")
                                              ? Container(
                                                // width:
                                                //     Screens.width(context) *
                                                //         0.3,
                                                // height: Screens.bodyheight(
                                                //         context) *
                                                //     0.15,
                                                padding: EdgeInsets.all(5),
                                                color: Colors.grey[200],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'Assets/wordimg.jpg'),
                                                          fit: BoxFit
                                                              .cover)),
                                                ),
                                              )
                                              : widget.feedData.leadcheckdata2!.MediaURL3!
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(".xlsx")
                                                  ? Container(
                                                    // width: Screens.width(
                                                    //         context) *
                                                    //     0.3,
                                                    // height:
                                                    //     Screens.bodyheight(
                                                    //             context) *
                                                    //         0.15,
                                                    padding:
                                                        EdgeInsets.all(5),
                                                    color: Colors.grey[200],
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'Assets/xcelomg.png'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  )
                                                  : widget.feedData.leadcheckdata2!.MediaURL3!
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(".doc")
                                                      ? Container(
                                                        // width: Screens.width(
                                                        //         context) *
                                                        //     0.3,
                                                        // height: Screens
                                                        //         .bodyheight(
                                                        //             context) *
                                                        //     0.15,
                                                        padding:
                                                            EdgeInsets.all(
                                                                5),
                                                        color: Colors
                                                            .grey[200],
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'Assets/wordimg.png'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      )
                                                      : Container()),
                                ):

                               
                                                         





                                                          InkWell(
                                                              onTap: () {
                                                                final remoteImages =
                                                                    [
                                                                  // Image.network(widget
                                                                  //     .feedData
                                                                  //     .leadcheckdata2!
                                                                  //     .MediaURL1!),
                                                                  // Image.network(widget
                                                                  //     .feedData
                                                                  //     .leadcheckdata2!
                                                                  //     .MediaURL2!),
                                                                      Image.network(widget
                                                                      .feedData
                                                                      .leadcheckdata2!
                                                                      .MediaURL3!),
                                                                 
                                                                ];
                                                                SwipeImageGallery(
                                                                  context:
                                                                      context,
                                                                  children:
                                                                      remoteImages,
                                                                  onSwipe:
                                                                      (index) {
                                                                    print(
                                                                        "Swiped");
                                                                    // overlayController.add(OverlayExample(
                                                                    //   title: '${index + 1}/${remoteImages.length}',
                                                                    // ));
                                                                  },
                                                                  overlayController:
                                                                      overlayController,
                                                                  // initialOverlay: OverlayExample(
                                                                  //   title: '1/${remoteImages.length}',
                                                                  // ),
                                                                ).show();
                                                              },
                                                              child: Container(
                                                                width: Screens
                                                                        .width(
                                                                            context) *
                                                                    0.40,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.27,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(widget.feedData.leadcheckdata2!.MediaURL3!),
                                                                            fit: BoxFit.contain))),
                                                              ),
                                                            ),
                                                          )
                                                    ],
                                                  )
                                                   ,
                                                  // widget
                                                  //                 .feedData
                                                  //                 .leadcheckdata2!
                                                  //                 .MediaURL1 !=
                                                  //             "" &&
                                                  //         widget
                                                  //                 .feedData
                                                  //                 .leadcheckdata2!
                                                  //                 .MediaURL1 !=
                                                  //             "" &&
                                                  //         widget
                                                  //                 .feedData
                                                  //                 .leadcheckdata2!
                                                  //                 .MediaURL1 ==
                                                  //             ""
                                                  //     ? Row(children: [
                                                  //         InkWell(
                                                  //           onTap: () {
                                                  //             final remoteImages =
                                                  //                 [
                                                  //               Image.network(widget
                                                  //                   .feedData
                                                  //                   .leadcheckdata2!
                                                  //                   .MediaURL1!),
                                                  //               Image.network(widget
                                                  //                   .feedData
                                                  //                   .leadcheckdata2!
                                                  //                   .MediaURL2!),
                                                  //             ];
                                                  //             SwipeImageGallery(
                                                  //               context:
                                                  //                   context,
                                                  //               children:
                                                  //                   remoteImages,
                                                  //               onSwipe:
                                                  //                   (index) {
                                                  //                 print(
                                                  //                     "Swiped");
                                                  //               },
                                                  //               overlayController:
                                                  //                   overlayController,
                                                  //             ).show();
                                                  //           },
                                                  //           child: Container(
                                                  //             width: Screens.width(
                                                  //                     context) *
                                                  //                 0.44,
                                                  //             height: Screens
                                                  //                     .bodyheight(
                                                  //                         context) *
                                                  //                 0.27,
                                                  //             padding:
                                                  //                 EdgeInsets
                                                  //                     .all(2),
                                                  //             child: Container(
                                                  //                 decoration: BoxDecoration(
                                                  //                     image: DecorationImage(
                                                  //                         image: NetworkImage(widget
                                                  //                             .feedData
                                                  //                             .leadcheckdata2!
                                                  //                             .MediaURL1!),
                                                  //                         fit: BoxFit
                                                  //                             .cover))),
                                                  //           ),
                                                  //         ),
                                                  //         InkWell(
                                                  //           onTap: () {
                                                  //             //   List<String> netimg=[];
                                                  //             //   netimg.add( widget.feedData.MediaURL1!);
                                                  //             //   netimg.add( widget.feedData.MediaURL2!);

                                                  //             // Get.to(PhotoViewer( imagePathList: netimg, currentIndex: 1,));

                                                  //             final remoteImages =
                                                  //                 [
                                                  //               Image.network(widget
                                                  //                   .feedData
                                                  //                   .leadcheckdata2!
                                                  //                   .MediaURL1!),
                                                  //               Image.network(widget
                                                  //                   .feedData
                                                  //                   .leadcheckdata2!
                                                  //                   .MediaURL2!),
                                                  //             ];
                                                  //             SwipeImageGallery(
                                                  //               context:
                                                  //                   context,
                                                  //               initialIndex: 1,
                                                  //               children:
                                                  //                   remoteImages,
                                                  //               onSwipe:
                                                  //                   (index) {
                                                  //                 print(
                                                  //                     "Swiped");
                                                  //               },
                                                  //               overlayController:
                                                  //                   overlayController,
                                                  //             ).show();
                                                  //           },
                                                  //           child: Container(
                                                  //             width: Screens.width(
                                                  //                     context) *
                                                  //                 0.44,
                                                  //             height: Screens
                                                  //                     .bodyheight(
                                                  //                         context) *
                                                  //                 0.27,
                                                  //             padding:
                                                  //                 EdgeInsets
                                                  //                     .all(2),
                                                  //             child: Container(
                                                  //                 decoration: BoxDecoration(
                                                  //                     image: DecorationImage(
                                                  //                         image: NetworkImage(widget
                                                  //                             .feedData
                                                  //                             .leadcheckdata2!
                                                  //                             .MediaURL2!),
                                                  //                         fit: BoxFit
                                                  //                             .cover))),
                                                  //           ),
                                                  //         ),
                                                  //       ])
                                                  //     : InkWell(
                                                  //         onTap: () {
                                                  //           final remoteImages =
                                                  //               [
                                                  //             Image.network(widget
                                                  //                 .feedData
                                                  //                 .leadcheckdata2!
                                                  //                 .MediaURL1!),
                                                  //             //  Image.network( widget.feedData.MediaURL2!),
                                                  //           ];
                                                  //           SwipeImageGallery(
                                                  //             context: context,
                                                  //             children:
                                                  //                 remoteImages,
                                                  //             onSwipe: (index) {
                                                  //               print("Swiped");
                                                  //             },
                                                  //             overlayController:
                                                  //                 overlayController,
                                                  //           ).show();
                                                  //         },
                                                  //         child: Container(
                                                  //             width:
                                                  //                 Screens.width(
                                                  //                     context),
                                                  //             height: Screens
                                                  //                     .bodyheight(
                                                  //                         context) *
                                                  //                 0.27,
                                                  //             decoration: BoxDecoration(
                                                  //                 image: DecorationImage(
                                                  //                     image: NetworkImage(widget
                                                  //                         .feedData
                                                  //                         .leadcheckdata2!
                                                  //                         .MediaURL1!),
                                                  //                     fit: BoxFit
                                                  //                         .cover))),
                                                  //       ),
                                        ),

                      //actions like
                      Container(
                        width: Screens.width(context),
                        height: Screens.bodyheight(context) * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Screens.width(context) * 0.35,
                            ),
                            InkWell(
                              onTap: () {
                                widget.pvdDSBD
                                    .showBottomSheet(context, widget.feedData);
                                //context.read<FeedsControoler>().showBottomSheet(context);
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                  widget.feedData.Reaction == '' ||
                                          widget.feedData.Reaction == '??'
                                      ? '\u{1F44D}'
                                      : String.fromCharCode(int.parse(widget
                                          .feedData.Reaction!
                                          .toString())),
                                  // context.watch<FeedsControoler>().getSelectedEmoji,
                                  style: theme.textTheme.headline6,
                                ), //1f44c
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // Positioned(
          //   // top: 0//Screens.bodyheight(context)*0.1,
          //   // left: Screens.width(context)*0.2,
          //   child: Visibility(
          //     visible:true,

          //     //widget.pvdDSBD. getreactionvisible,
          //     child: Container(
          //       alignment: Alignment.center,
          //       width:  Screens.width(context),
          //       height: Screens.bodyheight(context),
          //       color: Colors.amber,
          //       //  height: widget.feedData.MediaType == "Link"?
          //       //   Screens.bodyheight(context)*0.2:
          //       //   widget.feedData.MediaType == "YoutubeURL"?
          //       //  Screens.bodyheight(context) * 0.38 :
          //       //  widget.feedData.MediaType == "Document"?
          //       //   Screens.bodyheight(context) * 0.15 :
          //       //   widget.feedData.MediaType == "Video"?
          //       //  Screens.bodyheight(context) * 0.38 :
          //       //   widget.feedData.MediaType == "OnlyText"?
          //       //   Screens.bodyheight(context) *0.12: Screens.bodyheight(context) *0.27,
          //    //   color: Colors.red,
          //       child: Lottie.asset("Assets/91069-like.json",
          //        animate: true,
          //     repeat: true,
          //   height: Screens.padingHeight(context) * 0.8,
          //     width: Screens.width(context) * 0.5),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      height: 40.0,
      child: Row(
        children: [
          Text(title),
        ],
      ),
    );
  }
}









// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
// // import 'package:any_link_preview/any_link_preview.dart';
// import 'dart:async';
// import 'dart:developer';
// import 'package:any_link_preview/any_link_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sellerkit/Pages/Dashboard/widgets/videoplayer2.dart';
// import 'package:swipe_image_gallery/swipe_image_gallery.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../../../Constant/Screen.dart';
// import '../../../Controller/DashBoardController/DashBoardController.dart';
// import '../../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';
// import '../widgets/webViewScree/webViewScreen.dart';
// //import 'package:simple_url_preview/simple_url_preview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class FeedContainerNew extends StatefulWidget {
//   FeedContainerNew({
//     Key? key,
//     required this.selected,
//     required this.feedData,
//     required this.pvdDSBD,
//   }) : super(key: key);

//   FeedsModalData feedData;
//   String selected;
//   DashBoardController pvdDSBD;
//   @override
//   State<FeedContainerNew> createState() => FeedContainerNewState();
// }

// class FeedContainerNewState extends State<FeedContainerNew> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   StreamController<Widget> overlayController =
//       StreamController<Widget>.broadcast();
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 2,
//       shadowColor: Colors.red,
//       child: Stack(
//         children: [
//           Container(
//             width: Screens.width(context),
//             // height: Screens.bodyheight(context) * 0.55,
//             decoration: BoxDecoration(
//                   // color: Colors.red.shade200
//                 ),
//             padding: EdgeInsets.only(
//               top: Screens.bodyheight(context) * 0.01,
//               bottom: Screens.bodyheight(context) * 0.01,
//               left: Screens.width(context) * 0.006,
//               right: Screens.width(context) * 0.01,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: Screens.width(context),
//                   //  color: Colors.yellow.shade200,
//                   height: Screens.bodyheight(context) * 0.08,
//                   padding: EdgeInsets.only(
//                       left: Screens.width(context) * 0.01,
//                       right: Screens.width(context) * 0.01),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           print("sdsdasd: ");
//                           // Navigator.push(context,
//                           //     MaterialPageRoute(builder: (_) => WEBV()));
//                         },
//                         child: Container(
//                           width: Screens.width(context) * 0.1,
//                           decoration: BoxDecoration(
//                               //    color: Colors.blueAccent,
//                               shape: BoxShape.circle,
//                              image:widget.feedData.ProfilePic!.isEmpty? DecorationImage(
//                                   image: //Image.network(widget.feedData.ProfilePic!),
//                                       AssetImage("Assets/img.jpg"),
//                                   fit: BoxFit.cover): DecorationImage(
//                                   image: //Image.network(widget.feedData.ProfilePic!),
//                                       NetworkImage(widget.feedData.ProfilePic!),
//                                   fit: BoxFit.cover)),

//                           // child:
//                           // Image.network(widget.feedData.ProfilePic!=null?widget.feedData.ProfilePic!:''),
//                         ),
//                       ),
//                       Container(
//                         width: Screens.width(context) * 0.78,
//                         //   color: Colors.blueAccent,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Container(
//                               alignment: Alignment.bottomLeft,
//                               height: Screens.bodyheight(context) * 0.03,
//                               width: Screens.width(context) * 0.8,
//                               child: Text(
//                                 "${widget.feedData.leadcheckdata2!.CreatedBy}",
//                                 style: theme.textTheme.bodyText2?.copyWith(),
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.topLeft,
//                               height: Screens.bodyheight(context) * 0.04,
//                               width: Screens.width(context) * 0.8,
//                               //     color: Colors.red,
//                               child: Text(
//                                 widget.pvdDSBD.config.subtractDateTime(widget
//                                     .feedData.leadcheckdata2!.CreatedDate!),
//                                 style: theme.textTheme.bodyText2
//                                     ?.copyWith(color: Colors.grey),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: Screens.width(context),
//                   padding: EdgeInsets.only(
//                       left: Screens.width(context) * 0.01,
//                       right: Screens.width(context) * 0.01),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           print("sdsdasd: ");
//                           // Navigator.push(context,
//                           //     MaterialPageRoute(builder: (_) => WEBV()));
//                         },
//                         child: Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "${widget.feedData.leadcheckdata2!.Title}",
//                             style: theme.textTheme.subtitle1,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: ExpandableText(
//                           '${widget.feedData.leadcheckdata2!.Description}',
//                           style: theme.textTheme.bodyText2
//                               ?.copyWith(color: Colors.grey),
//                           expandText: 'more',
//                           collapseText: 'less',
//                           maxLines: 2,
//                           linkColor: theme.primaryColor,
//                         ),
//                       ),

//                       //media type
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),

//                                  widget.feedData.leadcheckdata2!.MediaURL1!.isEmpty&&
//                                  widget.feedData.leadcheckdata2!.MediaURL2!.isEmpty&&
//                                  widget.feedData.leadcheckdata2!.MediaURL3!.isEmpty?
//                                  Container():
//                                       Container(
//                                         // alignment: Alignment.topLeft,
//                                           // color: Colors.red,
//                                           width: Screens.width(context),
//                                           // height: Screens.bodyheight(context)*0.5,
//                                           child: widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?
//                                                           InkWell(
//                                                             onTap: (){
                                                             
//                                                             },
//                                                             child: Stack(
//                                                               children: [
//                                                                 Container(
//                                                                   // color: Colors.amber,
//                                                                   width: Screens.width(context),
//                                                                                                                   height: Screens.padingHeight(context)*0.3,
//                                                                                                                    child: HtmlWidget(
//                                                                                                       '''<video width="300" height="700" controls preview>
//                                                                                                        <source src="${widget.feedData.leadcheckdata2!.MediaURL1}" type="video/mp4">
//                                                                                                        </video>''',
//                                                                                                     ),
                                                                                                  
//                                                                 ),
//                                                               Positioned(
//                                                                 top: 50,
//                                                                 bottom: 50,
//                                                                 left: Screens.width(context)*0.4,
//                                                                 child:InkWell(
//                                                                   onTap: (){
//  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer2(
//                                                                 data1: widget.feedData.leadcheckdata2!.MediaURL1!,
//                                                                 data2: widget.feedData.leadcheckdata2!.MediaURL2!,
//                                                                 data3:widget.feedData.leadcheckdata2!.MediaURL3! ,
//                                                               )));
//                                                                   },
//                                                                   child: Container(
//                                                                     child: CircleAvatar(
//                                                                       radius: Screens.bodyheight(context)*0.05,
//                                                                       backgroundColor: Colors.grey,
//                                                                     child: const Text('2+',),
//                                                                     ),
//                                                                   ),
//                                                                 ) 
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ):
                                                          
//                                               widget.feedData.leadcheckdata2!
//                                                               .MediaURL1 ==
//                                                           "" &&
//                                                       widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL2 ==
//                                                           "" &&
//                                                       widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3 ==
//                                                           ""
//                                                   ? Container()
//                                                  : Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                       widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL1! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?Container():widget.feedData.leadcheckdata2!.MediaURL1! ==''?Container():         
//                                                            Container(
//                                                              width: widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL2! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL2! ==''?Screens.width(context)*0.9:Screens.width(context)*0.46,
//                                                     height: Screens.padingHeight(context)*0.24,
                                                    
//                                                         // color: Colors.pink, 
//                                                         child:
                                    
//                                                        widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?
//                                                             widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".com")||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".net")
//                                                           ? Container(
//                                                             //  width: Screens.width(
//                                                             //           context) *
//                                                             //       0.52,
//                                                             //   height: Screens
//                                                             //           .bodyheight(
//                                                             //               context) *
//                                                             //       0.135,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                               child:
//                                                                   AnyLinkPreview(
//                                                                 link:
//                                                                     "${widget.feedData.leadcheckdata2!.MediaURL3}",
//                                                                 displayDirection:
//                                                                     UIDirection
//                                                                         .uiDirectionHorizontal,
//                                                                 cache: Duration(
//                                                                     seconds: 1),
//                                                                 showMultimedia:
//                                                                     false,
//                                                                 errorWidget:
//                                                                     Container(
//                                                                   color: Colors
//                                                                           .grey[
//                                                                       300],
//                                                                   child: Text(
//                                                                       'Oops!'),
//                                                                 ),
//                                                                 urlLaunchMode:
//                                                                     LaunchMode
//                                                                         .externalApplication,
//                                                                 onTap: () {
//                                                                   print(
//                                                                       "sASasAS");
//                                                                   widget.pvdDSBD.launchUrlInBrowser(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL3!); //"https://www.google.com"
//                                                                 },
//                                                                 // errorImage: _errorImage,
//                                                               ),
//                                                             )
//                                                           : 
//                                                           widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".doc") ||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".xlxs")?
//                                                               InkWell(
//                                   onTap: () {
//                                     print("object");
//                                     widget.pvdDSBD.launchUrlInBrowser(
//                                         widget.feedData.leadcheckdata2!.MediaURL3!);
//                                     //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
//                                   },
//                                   child: Container(
//                                       // width: Screens.width(
//                                       //                                 context) *
//                                       //                             0.52,
//                                       //                         height: Screens
//                                       //                                 .bodyheight(
//                                       //                                     context) *
//                                       //                             0.135,
//                                       child: widget.feedData.leadcheckdata2!.MediaURL3!
//                                               .toString()
//                                               .toLowerCase()
//                                               .contains("")
//                                           ? Row(children: [
//                                               Container(
//                                                 width: Screens.width(context) *
//                                                     0.3,
//                                                 height: Screens.bodyheight(
//                                                         context) *
//                                                     0.15,
//                                                 padding: EdgeInsets.all(5),
//                                                 color: Colors.grey[200],
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                           image: AssetImage(
//                                                               'Assets/pdfimg.png'),
//                                                           fit: BoxFit.cover)),
//                                                 ),
//                                               ),
//                                               Container(
//                                                   // width:
//                                                   //     Screens.width(context) *
//                                                   //         0.55,
//                                                   // height: Screens.bodyheight(
//                                                   //         context) *
//                                                   //     0.15,
//                                                   padding: EdgeInsets.all(2),
//                                                   color: Colors.grey[200],
//                                                   child: Center(
//                                                       child: Text(
//                                                     widget.feedData.leadcheckdata2!.Title!,
//                                                     style: theme
//                                                         .textTheme.bodyText2,
//                                                     textAlign: TextAlign.center,
//                                                   ))),
//                                             ])
//                                           : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                   .toString()
//                                                   .toLowerCase()
//                                                   .contains(".doc")
//                                               ? Row(children: [
//                                                   Container(
//                                                     width:
//                                                         Screens.width(context) *
//                                                             0.3,
//                                                     height: Screens.bodyheight(
//                                                             context) *
//                                                         0.15,
//                                                     padding: EdgeInsets.all(5),
//                                                     color: Colors.grey[200],
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: AssetImage(
//                                                                   'Assets/wordimg.jpg'),
//                                                               fit: BoxFit
//                                                                   .cover)),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                       // width: Screens.width(
//                                                       //         context) *
//                                                       //     0.55,
//                                                       // height:
//                                                       //     Screens.bodyheight(
//                                                       //             context) *
//                                                       //         0.15,
//                                                       padding:
//                                                           EdgeInsets.all(2),
//                                                       color: Colors.grey[200],
//                                                       child: Center(
//                                                           child: Text(
//                                                         widget.feedData.leadcheckdata2!.Title!,
//                                                         style: theme.textTheme
//                                                             .bodyText2,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ))),
//                                                 ])
//                                               : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(".xlxs")
//                                                   ? Row(children: [
//                                                       Container(
//                                                         width: Screens.width(
//                                                                 context) *
//                                                             0.3,
//                                                         height:
//                                                             Screens.bodyheight(
//                                                                     context) *
//                                                                 0.15,
//                                                         padding:
//                                                             EdgeInsets.all(5),
//                                                         color: Colors.grey[200],
//                                                         child: Container(
//                                                           decoration: BoxDecoration(
//                                                               image: DecorationImage(
//                                                                   image: AssetImage(
//                                                                       'Assets/pdfimg.png'),
//                                                                   fit: BoxFit
//                                                                       .cover)),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                           // width: Screens.width(
//                                                           //         context) *
//                                                           //     0.55,
//                                                           // height: Screens
//                                                           //         .bodyheight(
//                                                           //             context) *
//                                                           //     0.15,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           color:
//                                                               Colors.grey[200],
//                                                           child: Center(
//                                                               child: Text(
//                                                             widget.feedData.leadcheckdata2!
//                                                                 .Title!,
//                                                             style: theme
//                                                                 .textTheme
//                                                                 .bodyText2,
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ))),
//                                                     ])
//                                                   : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".doc")
//                                                       ? Row(children: [
//                                                           Container(
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.3,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.15,
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     5),
//                                                             color: Colors
//                                                                 .grey[200],
//                                                             child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: AssetImage(
//                                                                           'Assets/xcelomg.png'),
//                                                                       fit: BoxFit
//                                                                           .cover)),
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                               // width:
//                                                               //     Screens.width(
//                                                               //             context) *
//                                                               //         0.55,
//                                                               // height: Screens.bodyheight(
//                                                               //         context) *
//                                                               //     0.15,
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(2),
//                                                               color: Colors
//                                                                   .grey[200],
//                                                               child: Center(
//                                                                   child: Text(
//                                                                 widget.feedData
//                                                                    .leadcheckdata2! .Title!,
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyText2,
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                               ))),
//                                                         ])
//                                                       : Container()),
//                                 ):

//                                                           InkWell(
//                                                               onTap: () {
//                                                                 final remoteImages =
//                                                                     [
                                                                  
//                                                                   // Image.network(widget
//                                                                   //     .feedData
//                                                                   //     .leadcheckdata2!
//                                                                   //     .MediaURL2!),
//                                                                       Image.network(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL3!),
                                                                  
//                                                                 ];
//                                                                 SwipeImageGallery(
//                                                                   context:
//                                                                       context,
//                                                                   children:
//                                                                       remoteImages,
//                                                                   onSwipe:
//                                                                       (index) {
//                                                                     print(
//                                                                         "Swiped");
//                                                                     // overlayController.add(OverlayExample(
//                                                                     //   title: '${index + 1}/${remoteImages.length}',
//                                                                     // ));
//                                                                   },
//                                                                   overlayController:
//                                                                       overlayController,
//                                                                   // initialOverlay: OverlayExample(
//                                                                   //   title: '1/${remoteImages.length}',
//                                                                   // ),
//                                                                 ).show();
//                                                               },
//                                                               child: Container(
//                                                                 // width: Screens
//                                                                 //         .width(
//                                                                 //             context) *
//                                                                 //     0.40,
//                                                                 // height: Screens
//                                                                 //         .bodyheight(
//                                                                 //             context) *
//                                                                 //     0.27,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                                 child: Container(
//                                                                     decoration: BoxDecoration(
//                                                                         image: DecorationImage(
//                                                                             image:
//                                                                                 NetworkImage(widget.feedData.leadcheckdata2!.MediaURL3!),
//                                                                             fit: BoxFit.cover))),
//                                                               ),
//                                                             )
                                                          
                                                        
//                                                         // DATTATTATTA
                                                        
//                                                       :   widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL1
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".com")||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL1
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".com")
//                                                           ? Container(
                                                            
//                                                               // width: Screens
//                                                               //           .width(
//                                                               //               context) *
//                                                               //       0.44,
//                                                               //   height: Screens
//                                                               //           .bodyheight(
//                                                               //               context) *
//                                                               //       0.27,
//                                                                 // padding:
//                                                                 //     EdgeInsets
//                                                                 //         .all(2),
//                                                               child:
//                                                                   AnyLinkPreview(
//                                                                 link:
//                                                                     "${widget.feedData.leadcheckdata2!.MediaURL1}",
//                                                                 displayDirection:
//                                                                     UIDirection
//                                                                         .uiDirectionHorizontal,
//                                                                 cache: Duration(
//                                                                     seconds: 1),
//                                                                 showMultimedia:
//                                                                     false,
//                                                                 errorWidget:
//                                                                     Container(
//                                                                   color: Colors
//                                                                           .grey[
//                                                                       300],
//                                                                   child: Text(
//                                                                       'Oops!'),
//                                                                 ),
//                                                                 urlLaunchMode:
//                                                                     LaunchMode
//                                                                         .externalApplication,
//                                                                 onTap: () {
//                                                                   print(
//                                                                       "sASasAS");
//                                                                   widget.pvdDSBD.launchUrlInBrowser(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL1!); //"https://www.google.com"
//                                                                 },
//                                                                 // errorImage: _errorImage,
//                                                               ),
//                                                             )
//                                                           : widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL1
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".doc") ||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL1
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".xlxs")?
//                                                               InkWell(
//                                   onTap: () {
//                                     print("object");
//                                     widget.pvdDSBD.launchUrlInBrowser(
//                                         widget.feedData.leadcheckdata2!.MediaURL1!);
//                                     //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
//                                   },
//                                   child: Container(
//                                       // width: Screens
//                                       //                                   .width(
//                                       //                                       context) *
//                                       //                               0.40,
//                                       //                           height: Screens
//                                       //                                   .bodyheight(
//                                       //                                       context) *
//                                       //                               0.27,
//                                       child: widget.feedData.leadcheckdata2!.MediaURL1!
//                                               .toString()
//                                               .toLowerCase()
//                                               .contains("")
//                                           ? Row(children: [
//                                               Container(
//                                                 width: Screens.width(context) *
//                                                     0.3,
//                                                 height: Screens.bodyheight(
//                                                         context) *
//                                                     0.15,
//                                                 padding: EdgeInsets.all(5),
//                                                 color: Colors.grey[200],
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                           image: AssetImage(
//                                                               'Assets/pdfimg.png'),
//                                                           fit: BoxFit.cover)),
//                                                 ),
//                                               ),
//                                               Container(
//                                                   // width:
//                                                   //     Screens.width(context) *
//                                                   //         0.55,
//                                                   // height: Screens.bodyheight(
//                                                   //         context) *
//                                                   //     0.15,
//                                                   padding: EdgeInsets.all(2),
//                                                   color: Colors.grey[200],
//                                                   child: Center(
//                                                       child: Text(
//                                                     widget.feedData.leadcheckdata2!.Title!,
//                                                     style: theme
//                                                         .textTheme.bodyText2,
//                                                     textAlign: TextAlign.center,
//                                                   ))),
//                                             ])
//                                           : widget.feedData.leadcheckdata2!.MediaURL1!
//                                                   .toString()
//                                                   .toLowerCase()
//                                                   .contains(".doc")
//                                               ? Row(children: [
//                                                   Container(
//                                                     width:
//                                                         Screens.width(context) *
//                                                             0.3,
//                                                     height: Screens.bodyheight(
//                                                             context) *
//                                                         0.15,
//                                                     padding: EdgeInsets.all(5),
//                                                     color: Colors.grey[200],
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: AssetImage(
//                                                                   'Assets/wordimg.jpg'),
//                                                               fit: BoxFit
//                                                                   .cover)),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                       // width: Screens.width(
//                                                       //         context) *
//                                                       //     0.55,
//                                                       // height:
//                                                       //     Screens.bodyheight(
//                                                       //             context) *
//                                                       //         0.15,
//                                                       padding:
//                                                           EdgeInsets.all(2),
//                                                       color: Colors.grey[200],
//                                                       child: Center(
//                                                           child: Text(
//                                                         widget.feedData.leadcheckdata2!.Title!,
//                                                         style: theme.textTheme
//                                                             .bodyText2,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ))),
//                                                 ])
//                                               : widget.feedData.leadcheckdata2!.MediaURL1!
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(".xlxs")
//                                                   ? Row(children: [
//                                                       Container(
//                                                         width: Screens.width(
//                                                                 context) *
//                                                             0.3,
//                                                         height:
//                                                             Screens.bodyheight(
//                                                                     context) *
//                                                                 0.15,
//                                                         padding:
//                                                             EdgeInsets.all(5),
//                                                         color: Colors.grey[200],
//                                                         child: Container(
//                                                           decoration: BoxDecoration(
//                                                               image: DecorationImage(
//                                                                   image: AssetImage(
//                                                                       'Assets/pdfimg.png'),
//                                                                   fit: BoxFit
//                                                                       .cover)),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                           // width: Screens.width(
//                                                           //         context) *
//                                                           //     0.55,
//                                                           // height: Screens
//                                                           //         .bodyheight(
//                                                           //             context) *
//                                                           //     0.15,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           color:
//                                                               Colors.grey[200],
//                                                           child: Center(
//                                                               child: Text(
//                                                             widget.feedData.leadcheckdata2!
//                                                                 .Title!,
//                                                             style: theme
//                                                                 .textTheme
//                                                                 .bodyText2,
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ))),
//                                                     ])
//                                                   : widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".doc")
//                                                       ? Row(children: [
//                                                           Container(
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.3,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.15,
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     5),
//                                                             color: Colors
//                                                                 .grey[200],
//                                                             child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: AssetImage(
//                                                                           'Assets/xcelomg.png'),
//                                                                       fit: BoxFit
//                                                                           .cover)),
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                               // width:
//                                                               //     Screens.width(
//                                                               //             context) *
//                                                               //         0.55,
//                                                               // height: Screens.bodyheight(
//                                                               //         context) *
//                                                               //     0.15,
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(2),
//                                                               color: Colors
//                                                                   .grey[200],
//                                                               child: Center(
//                                                                   child: Text(
//                                                                 widget.feedData
//                                                                    .leadcheckdata2! .Title!,
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyText2,
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                               ))),
//                                                         ])
//                                                       : Container()),
//                                 ):InkWell(
//                                                               onTap: () {
//                                                                 final remoteImages =
//                                                                     [
//                                                                   Image.network(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL1!),
//                                                                   // Image.network(widget
//                                                                   //     .feedData
//                                                                   //     .leadcheckdata2!
//                                                                   //     .MediaURL2!),
                                                                    
                                                                  
//                                                                 ];
//                                                                 SwipeImageGallery(
//                                                                   context:
//                                                                       context,
//                                                                   children:
//                                                                       remoteImages,
//                                                                   onSwipe:
//                                                                       (index) {
//                                                                     print(
//                                                                         "Swiped");
//                                                                     // overlayController.add(OverlayExample(
//                                                                     //   title: '${index + 1}/${remoteImages.length}',
//                                                                     // ));
//                                                                   },
//                                                                   overlayController:
//                                                                       overlayController,
//                                                                   // initialOverlay: OverlayExample(
//                                                                   //   title: '1/${remoteImages.length}',
//                                                                   // ),
//                                                                 ).show();
//                                                               },
//                                                               child: Container(
//                                                                 // alignment: Alignment.centerLeft,
//                                                                 //  color: Colors.yellow,
//                                                                 // width: Screens
//                                                                 //         .width(
//                                                                 //             context) ,
//                                                                 // height: Screens
//                                                                 //         .bodyheight(
//                                                                 //             context) *
//                                                                 //     0.30,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                                 child: Container(
//                                                                     decoration: BoxDecoration(
                                                                     
//                                                                         image: DecorationImage(
//                                                                             image:
//                                                                                 NetworkImage(widget.feedData.leadcheckdata2!.MediaURL1!),
//                                                                             fit: BoxFit.fill))),
//                                                               ),
//                                                             ),

//                                                           ),
//                                                           SizedBox(
//                                                             width: Screens.width(context)*0.01,
//                                                           ),
//                                                    widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL2! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?Container():
//                                                           widget.feedData.leadcheckdata2!.MediaURL2! ==''?Container():     
//                                                             Container(
//                                                              width:widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL1! ==''&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL3! ==''&&widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")||widget.feedData.leadcheckdata2!.MediaURL1! =='' ?Screens.width(context)*0.9: Screens.width(context)*0.46,
//                                                     height: Screens.padingHeight(context)*0.24,
//                                                         // color: Colors.blue, 
//                                                     child:   widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?
//                                                             widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".com")||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".net")
//                                                           ? Container(
//                                                             //  width: Screens.width(
//                                                             //           context) *
//                                                             //       0.52,
//                                                             //   height: Screens
//                                                             //           .bodyheight(
//                                                             //               context) *
//                                                             //       0.135,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                               child:
//                                                                   AnyLinkPreview(
//                                                                 link:
//                                                                     "${widget.feedData.leadcheckdata2!.MediaURL3}",
//                                                                 displayDirection:
//                                                                     UIDirection
//                                                                         .uiDirectionHorizontal,
//                                                                 cache: Duration(
//                                                                     seconds: 1),
//                                                                 showMultimedia:
//                                                                     false,
//                                                                 errorWidget:
//                                                                     Container(
//                                                                   color: Colors
//                                                                           .grey[
//                                                                       300],
//                                                                   child: Text(
//                                                                       'Oops!'),
//                                                                 ),
//                                                                 urlLaunchMode:
//                                                                     LaunchMode
//                                                                         .externalApplication,
//                                                                 onTap: () {
//                                                                   print(
//                                                                       "sASasAS");
//                                                                   widget.pvdDSBD.launchUrlInBrowser(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL3!); //"https://www.google.com"
//                                                                 },
//                                                                 // errorImage: _errorImage,
//                                                               ),
//                                                             )
//                                                           : 
//                                                           widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".doc") ||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".xlxs")?
//                                                               InkWell(
//                                   onTap: () {
//                                     print("object");
//                                     widget.pvdDSBD.launchUrlInBrowser(
//                                         widget.feedData.leadcheckdata2!.MediaURL3!);
//                                     //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
//                                   },
//                                   child: Container(
//                                       // width: Screens.width(
//                                       //                                 context) *
//                                       //                             0.52,
//                                       //                         height: Screens
//                                       //                                 .bodyheight(
//                                       //                                     context) *
//                                       //                             0.135,
//                                       child: widget.feedData.leadcheckdata2!.MediaURL3!
//                                               .toString()
//                                               .toLowerCase()
//                                               .contains("")
//                                           ? Row(children: [
//                                               Container(
//                                                 width: Screens.width(context) *
//                                                     0.3,
//                                                 height: Screens.bodyheight(
//                                                         context) *
//                                                     0.15,
//                                                 padding: EdgeInsets.all(5),
//                                                 color: Colors.grey[200],
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                           image: AssetImage(
//                                                               'Assets/pdfimg.png'),
//                                                           fit: BoxFit.cover)),
//                                                 ),
//                                               ),
//                                               Container(
//                                                   // width:
//                                                   //     Screens.width(context) *
//                                                   //         0.55,
//                                                   // height: Screens.bodyheight(
//                                                   //         context) *
//                                                   //     0.15,
//                                                   padding: EdgeInsets.all(2),
//                                                   color: Colors.grey[200],
//                                                   child: Center(
//                                                       child: Text(
//                                                     widget.feedData.leadcheckdata2!.Title!,
//                                                     style: theme
//                                                         .textTheme.bodyText2,
//                                                     textAlign: TextAlign.center,
//                                                   ))),
//                                             ])
//                                           : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                   .toString()
//                                                   .toLowerCase()
//                                                   .contains(".doc")
//                                               ? Row(children: [
//                                                   Container(
//                                                     width:
//                                                         Screens.width(context) *
//                                                             0.3,
//                                                     height: Screens.bodyheight(
//                                                             context) *
//                                                         0.15,
//                                                     padding: EdgeInsets.all(5),
//                                                     color: Colors.grey[200],
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: AssetImage(
//                                                                   'Assets/wordimg.jpg'),
//                                                               fit: BoxFit
//                                                                   .cover)),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                       // width: Screens.width(
//                                                       //         context) *
//                                                       //     0.55,
//                                                       // height:
//                                                       //     Screens.bodyheight(
//                                                       //             context) *
//                                                       //         0.15,
//                                                       padding:
//                                                           EdgeInsets.all(2),
//                                                       color: Colors.grey[200],
//                                                       child: Center(
//                                                           child: Text(
//                                                         widget.feedData.leadcheckdata2!.Title!,
//                                                         style: theme.textTheme
//                                                             .bodyText2,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ))),
//                                                 ])
//                                               : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(".xlxs")
//                                                   ? Row(children: [
//                                                       Container(
//                                                         width: Screens.width(
//                                                                 context) *
//                                                             0.3,
//                                                         height:
//                                                             Screens.bodyheight(
//                                                                     context) *
//                                                                 0.15,
//                                                         padding:
//                                                             EdgeInsets.all(5),
//                                                         color: Colors.grey[200],
//                                                         child: Container(
//                                                           decoration: BoxDecoration(
//                                                               image: DecorationImage(
//                                                                   image: AssetImage(
//                                                                       'Assets/pdfimg.png'),
//                                                                   fit: BoxFit
//                                                                       .cover)),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                           // width: Screens.width(
//                                                           //         context) *
//                                                           //     0.55,
//                                                           // height: Screens
//                                                           //         .bodyheight(
//                                                           //             context) *
//                                                           //     0.15,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           color:
//                                                               Colors.grey[200],
//                                                           child: Center(
//                                                               child: Text(
//                                                             widget.feedData.leadcheckdata2!
//                                                                 .Title!,
//                                                             style: theme
//                                                                 .textTheme
//                                                                 .bodyText2,
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ))),
//                                                     ])
//                                                   : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".doc")
//                                                       ? Row(children: [
//                                                           Container(
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.3,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.15,
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     5),
//                                                             color: Colors
//                                                                 .grey[200],
//                                                             child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: AssetImage(
//                                                                           'Assets/xcelomg.png'),
//                                                                       fit: BoxFit
//                                                                           .cover)),
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                               // width:
//                                                               //     Screens.width(
//                                                               //             context) *
//                                                               //         0.55,
//                                                               // height: Screens.bodyheight(
//                                                               //         context) *
//                                                               //     0.15,
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(2),
//                                                               color: Colors
//                                                                   .grey[200],
//                                                               child: Center(
//                                                                   child: Text(
//                                                                 widget.feedData
//                                                                    .leadcheckdata2! .Title!,
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyText2,
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                               ))),
//                                                         ])
//                                                       : Container()),
//                                 ):

                               
                                                          





//                                                           InkWell(
//                                                               onTap: () {
//                                                                 final remoteImages =
//                                                                     [
//                                                                   // Image.network(widget
//                                                                   //     .feedData
//                                                                   //     .leadcheckdata2!
//                                                                   //     .MediaURL1!),
                                                                 
//                                                                       Image.network(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL3!),
                                                                  
//                                                                 ];
//                                                                 SwipeImageGallery(
//                                                                   context:
//                                                                       context,
//                                                                   children:
//                                                                       remoteImages,
//                                                                   onSwipe:
//                                                                       (index) {
//                                                                     print(
//                                                                         "Swiped");
//                                                                     // overlayController.add(OverlayExample(
//                                                                     //   title: '${index + 1}/${remoteImages.length}',
//                                                                     // ));
//                                                                   },
//                                                                   overlayController:
//                                                                       overlayController,
//                                                                   // initialOverlay: OverlayExample(
//                                                                   //   title: '1/${remoteImages.length}',
//                                                                   // ),
//                                                                 ).show();
//                                                               },
//                                                               child: Container(
//                                                                 // width: Screens
//                                                                 //         .width(
//                                                                 //             context) *
//                                                                 //     0.40,
//                                                                 // height: Screens
//                                                                 //         .bodyheight(
//                                                                 //             context) *
//                                                                 //     0.27,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                                 child: Container(
//                                                                     decoration: BoxDecoration(
//                                                                         image: DecorationImage(
//                                                                             image:
//                                                                                 NetworkImage(widget.feedData.leadcheckdata2!.MediaURL3!),
//                                                                             fit: BoxFit.cover))),
//                                                               ),
//                                                             )
                                                          
                                                        
//                                                         // DATTATTATTA
                                                        
//                                                       : widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL2
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".com")||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL2
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".net")
//                                                           ? Container(
//                                                               // width: Screens.width(
//                                                               //         context) *
//                                                               //     0.44,
//                                                               // height: Screens
//                                                               //         .bodyheight(
//                                                               //             context) *
//                                                               //     0.135,
//                                                                 // padding:
//                                                                 //     EdgeInsets
//                                                                 //         .all(2),
//                                                               child:
//                                                                   AnyLinkPreview(
//                                                                 link:
//                                                                     "${widget.feedData.leadcheckdata2!.MediaURL2}",
//                                                                 displayDirection:
//                                                                     UIDirection
//                                                                         .uiDirectionHorizontal,
//                                                                 cache: Duration(
//                                                                     seconds: 1),
//                                                                 showMultimedia:
//                                                                     false,
//                                                                 errorWidget:
//                                                                     Container(
//                                                                   color: Colors
//                                                                           .grey[
//                                                                       300],
//                                                                   child: Text(
//                                                                       'Oops!'),
//                                                                 ),
//                                                                 urlLaunchMode:
//                                                                     LaunchMode
//                                                                         .externalApplication,
//                                                                 onTap: () {
//                                                                   print(
//                                                                       "sASasAS");
//                                                                   widget.pvdDSBD.launchUrlInBrowser(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL2!); //"https://www.google.com"
//                                                                 },
//                                                                 // errorImage: _errorImage,
//                                                               ),
//                                                             )
//                                                           : 
//                                                           widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL2
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".doc") ||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL2
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".xlxs")?
//                                                               InkWell(
//                                   onTap: () {
//                                     print("object");
//                                     widget.pvdDSBD.launchUrlInBrowser(
//                                         widget.feedData.leadcheckdata2!.MediaURL2!);
//                                     //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
//                                   },
//                                   child: Container(
//                                       // width: Screens.width(
//                                       //                                 context) *
//                                       //                             0.52,
//                                       //                         height: Screens
//                                       //                                 .bodyheight(
//                                       //                                     context) *
//                                       //                             0.135,
//                                       child: widget.feedData.leadcheckdata2!.MediaURL2!
//                                               .toString()
//                                               .toLowerCase()
//                                               .contains("")
//                                           ? Row(children: [
//                                               Container(
//                                                 width: Screens.width(context) *
//                                                     0.3,
//                                                 height: Screens.bodyheight(
//                                                         context) *
//                                                     0.15,
//                                                 padding: EdgeInsets.all(5),
//                                                 color: Colors.grey[200],
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                           image: AssetImage(
//                                                               'Assets/pdfimg.png'),
//                                                           fit: BoxFit.cover)),
//                                                 ),
//                                               ),
//                                               Container(
//                                                   // width:
//                                                   //     Screens.width(context) *
//                                                   //         0.55,
//                                                   // height: Screens.bodyheight(
//                                                   //         context) *
//                                                   //     0.15,
//                                                   padding: EdgeInsets.all(2),
//                                                   color: Colors.grey[200],
//                                                   child: Center(
//                                                       child: Text(
//                                                     widget.feedData.leadcheckdata2!.Title!,
//                                                     style: theme
//                                                         .textTheme.bodyText2,
//                                                     textAlign: TextAlign.center,
//                                                   ))),
//                                             ])
//                                           : widget.feedData.leadcheckdata2!.MediaURL2!
//                                                   .toString()
//                                                   .toLowerCase()
//                                                   .contains(".doc")
//                                               ? Row(children: [
//                                                   Container(
//                                                     width:
//                                                         Screens.width(context) *
//                                                             0.3,
//                                                     height: Screens.bodyheight(
//                                                             context) *
//                                                         0.15,
//                                                     padding: EdgeInsets.all(5),
//                                                     color: Colors.grey[200],
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: AssetImage(
//                                                                   'Assets/wordimg.jpg'),
//                                                               fit: BoxFit
//                                                                   .cover)),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                       // width: Screens.width(
//                                                       //         context) *
//                                                       //     0.55,
//                                                       // height:
//                                                       //     Screens.bodyheight(
//                                                       //             context) *
//                                                       //         0.15,
//                                                       padding:
//                                                           EdgeInsets.all(2),
//                                                       color: Colors.grey[200],
//                                                       child: Center(
//                                                           child: Text(
//                                                         widget.feedData.leadcheckdata2!.Title!,
//                                                         style: theme.textTheme
//                                                             .bodyText2,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ))),
//                                                 ])
//                                               : widget.feedData.leadcheckdata2!.MediaURL2!
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(".xlxs")
//                                                   ? Row(children: [
//                                                       Container(
//                                                         width: Screens.width(
//                                                                 context) *
//                                                             0.3,
//                                                         height:
//                                                             Screens.bodyheight(
//                                                                     context) *
//                                                                 0.15,
//                                                         padding:
//                                                             EdgeInsets.all(5),
//                                                         color: Colors.grey[200],
//                                                         child: Container(
//                                                           decoration: BoxDecoration(
//                                                               image: DecorationImage(
//                                                                   image: AssetImage(
//                                                                       'Assets/pdfimg.png'),
//                                                                   fit: BoxFit
//                                                                       .cover)),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                           // width: Screens.width(
//                                                           //         context) *
//                                                           //     0.55,
//                                                           // height: Screens
//                                                           //         .bodyheight(
//                                                           //             context) *
//                                                           //     0.15,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           color:
//                                                               Colors.grey[200],
//                                                           child: Center(
//                                                               child: Text(
//                                                             widget.feedData.leadcheckdata2!
//                                                                 .Title!,
//                                                             style: theme
//                                                                 .textTheme
//                                                                 .bodyText2,
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ))),
//                                                     ])
//                                                   : widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".doc")
//                                                       ? Row(children: [
//                                                           Container(
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.3,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.15,
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     5),
//                                                             color: Colors
//                                                                 .grey[200],
//                                                             child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: AssetImage(
//                                                                           'Assets/xcelomg.png'),
//                                                                       fit: BoxFit
//                                                                           .cover)),
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                               // width:
//                                                               //     Screens.width(
//                                                               //             context) *
//                                                               //         0.55,
//                                                               // height: Screens.bodyheight(
//                                                               //         context) *
//                                                               //     0.15,
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(2),
//                                                               color: Colors
//                                                                   .grey[200],
//                                                               child: Center(
//                                                                   child: Text(
//                                                                 widget.feedData
//                                                                    .leadcheckdata2! .Title!,
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyText2,
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                               ))),
//                                                         ])
//                                                       : Container()),
//                                 ):

//                                                           InkWell(
//                                                               onTap: () {
//                                                                 final remoteImages =
//                                                                     [
//                                                                   // Image.network(widget
//                                                                   //     .feedData
//                                                                   //     .leadcheckdata2!
//                                                                   //     .MediaURL1!),
//                                                                   Image.network(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL2!),
                                                                      
                                                                  
//                                                                 ];
//                                                                 SwipeImageGallery(
//                                                                   context:
//                                                                       context,
//                                                                   children:
//                                                                       remoteImages,
//                                                                   onSwipe:
//                                                                       (index) {
//                                                                     print(
//                                                                         "Swiped");
//                                                                     // overlayController.add(OverlayExample(
//                                                                     //   title: '${index + 1}/${remoteImages.length}',
//                                                                     // ));
//                                                                   },
//                                                                   overlayController:
//                                                                       overlayController,
//                                                                   // initialOverlay: OverlayExample(
//                                                                   //   title: '1/${remoteImages.length}',
//                                                                   // ),
//                                                                 ).show();
//                                                               },
//                                                               child: Container(
//                                                                 // color: Colors.amber,
//                                                                 //  width: Screens
//                                                                 //         .width(
//                                                                 //             context) ,
//                                                                 // height: Screens
//                                                                 //         .bodyheight(
//                                                                 //             context) *
//                                                                 //     0.30,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                                 child: Container(
//                                                                     decoration: BoxDecoration(
//                                                                         image: DecorationImage(
//                                                                             image:
//                                                                                 NetworkImage(widget.feedData.leadcheckdata2!.MediaURL2!),
//                                                                             fit: BoxFit.cover))),
//                                                               ),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                        SizedBox(
//                                                             height: Screens.padingHeight(context)*0.01,
//                                                           ),
//                                                          widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?InkWell(
//                                                             onTap: (){
                                                             
//                                                             },
//                                                             child: Stack(
//                                                               children: [
//                                                                 Container(
//                                                                   // color: Colors.amber,
//                                                                   width: Screens.width(context),
//                                                                                                                   height: Screens.padingHeight(context)*0.3,
//                                                                                                                    child: HtmlWidget(
//                                                                                                       '''<video width="300" height="700" controls preview>
//                                                                                                        <source src="${widget.feedData.leadcheckdata2!.MediaURL1!.isEmpty?widget.feedData.leadcheckdata2!.MediaURL2:widget.feedData.leadcheckdata2!.MediaURL1}" type="video/mp4">
//                                                                                                        </video>''',
//                                                                                                     ),
                                                                                                  
//                                                                 ),
//                                                               Positioned(
//                                                                 top: 50,
//                                                                 bottom: 50,
//                                                                 left: Screens.width(context)*0.4,
//                                                                 child:InkWell(
//                                                                   onTap: (){
                                                                                  
//  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer2(
//                                                                 data1: widget.feedData.leadcheckdata2!.MediaURL1!,
//                                                                 data2: widget.feedData.leadcheckdata2!.MediaURL2!,
//                                                                 data3:widget.feedData.leadcheckdata2!.MediaURL3! ,
//                                                               )));
//                                                                   },
//                                                                   child: Container(
//                                                                     child: CircleAvatar(
//                                                                       radius: Screens.bodyheight(context)*0.05,
//                                                                       backgroundColor: Colors.grey,
//                                                                     child: const Text('1+',),
//                                                                     ),
//                                                                   ),
//                                                                 ) 
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ): widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")&&widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?InkWell(
//                                                             onTap: (){
                                                             
//                                                             },
//                                                             child: Stack(
//                                                               children: [
//                                                                 Container(
//                                                                   // color: Colors.amber,
//                                                                   width: Screens.width(context),
//                                                                                                                   height: Screens.padingHeight(context)*0.3,
//                                                                                                                    child: HtmlWidget(
//                                                                                                       '''<video width="300" height="700" controls preview>
//                                                                                                        <source src="${widget.feedData.leadcheckdata2!.MediaURL2!}" type="video/mp4">
//                                                                                                        </video>''',
//                                                                                                     ),
                                                                                                  
//                                                                 ),
//                                                               Positioned(
//                                                                 top: 50,
//                                                                 bottom: 50,
//                                                                 left: Screens.width(context)*0.4,
//                                                                 child:InkWell(
                                                                  
//                                                                   onTap: (){
//                                                                     log(" data1: widget.feedData.leadcheckdata2!.MediaURL1!::"+ widget.feedData.leadcheckdata2!.MediaURL1!.toString());
                                                  
//  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer2(
//                                                                 data1: widget.feedData.leadcheckdata2!.MediaURL1,
//                                                                 data2: widget.feedData.leadcheckdata2!.MediaURL2,
//                                                                 data3:widget.feedData.leadcheckdata2!.MediaURL3 ,
//                                                               )));
//                                                                   },
//                                                                   child: Container(
//                                                                     child: CircleAvatar(
//                                                                       radius: Screens.bodyheight(context)*0.05,
//                                                                       backgroundColor: Colors.grey,
//                                                                     child: const Text('1+',),
//                                                                     ),
//                                                                   ),
//                                                                 ) 
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ):

                                                          
//                                               widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")|| widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4") ||widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?  
//                                                            Container(
//                                                     width: Screens.width(context),
//                                                     height: Screens.padingHeight(context)*0.2,
//                                                         // color: Colors.amber,    
//                                                         child:  widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?
//                                                           Container(
//                                                              width: Screens
//                                                                         .width(
//                                                                             context) ,
//                                                                 height: Screens
//                                                                         .bodyheight(
//                                                                             context) *
//                                                                     0.20,
//                                       //  width: Screens.width(
//                                       //                                 context) *
//                                       //                             0.52,
//                                       //                         height: Screens
//                                       //                                 .bodyheight(
//                                       //                                     context) *
//                                       //                             0.135,
//                                      // color: Colors.red,
//                                       child: HtmlWidget(
//                                         '''<video width="300" height="700" controls preview>
//                                          <source src="${widget.feedData.leadcheckdata2!.MediaURL3}" type="video/mp4">
//                                          </video>''',
//                                       ),
//                                     ):widget.feedData.leadcheckdata2!.MediaURL2!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?
//                                                           Container(
//                                                              width: Screens
//                                                                         .width(
//                                                                             context) ,
//                                                                 height: Screens
//                                                                         .bodyheight(
//                                                                             context) *
//                                                                     0.20,
//                                       //  width: Screens.width(
//                                       //                                 context) *
//                                       //                             0.52,
//                                       //                         height: Screens
//                                       //                                 .bodyheight(
//                                       //                                     context) *
//                                       //                             0.135,
//                                      // color: Colors.red,
//                                       child: HtmlWidget(
//                                         '''<video width="300" height="700" controls preview>
//                                          <source src="${widget.feedData.leadcheckdata2!.MediaURL2}" type="video/mp4">
//                                          </video>''',
//                                       ),
//                                     ):widget.feedData.leadcheckdata2!.MediaURL1!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".mp4")?
//                                                           Container(
//                                                              width: Screens
//                                                                         .width(
//                                                                             context) ,
//                                                                 height: Screens
//                                                                         .bodyheight(
//                                                                             context) *
//                                                                     0.20,
                                     
//                                      // color: Colors.red,
//                                       child: HtmlWidget(
//                                         '''<video width="300" height="700" controls preview>
//                                          <source src="${widget.feedData.leadcheckdata2!.MediaURL1}" type="video/mp4">
//                                          </video>''',
//                                       ),
//                                     ):Container()
//                                                           ):widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3!.isEmpty?Container():
//                                                           Container(
//                                                             width: Screens.width(context),
//                                                             // color: Colors.amber,
//                                                             child: widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".com")||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".net")
//                                                           ? Container(
//                                                              width: Screens.width(
//                                                                       context) *
//                                                                   0.52,
//                                                               height: Screens
//                                                                       .bodyheight(
//                                                                           context) *
//                                                                   0.135,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                               child:
//                                                                   AnyLinkPreview(
//                                                                 link:
//                                                                     "${widget.feedData.leadcheckdata2!.MediaURL3}",
//                                                                 displayDirection:
//                                                                     UIDirection
//                                                                         .uiDirectionHorizontal,
//                                                                 cache: Duration(
//                                                                     seconds: 1),
//                                                                 showMultimedia:
//                                                                     false,
//                                                                 errorWidget:
//                                                                     Container(
//                                                                   color: Colors
//                                                                           .grey[
//                                                                       300],
//                                                                   child: Text(
//                                                                       'Oops!'),
//                                                                 ),
//                                                                 urlLaunchMode:
//                                                                     LaunchMode
//                                                                         .externalApplication,
//                                                                 onTap: () {
//                                                                   print(
//                                                                       "sASasAS");
//                                                                   widget.pvdDSBD.launchUrlInBrowser(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL3!); //"https://www.google.com"
//                                                                 },
//                                                                 // errorImage: _errorImage,
//                                                               ),
//                                                             )
//                                                           : 
//                                                           widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".doc") ||widget
//                                                               .feedData
//                                                               .leadcheckdata2!
//                                                               .MediaURL3
//                                                               .toString()
//                                                               .toLowerCase()
//                                                               .contains(".xlxs")?
//                                                               InkWell(
//                                   onTap: () {
//                                     print("object");
//                                     widget.pvdDSBD.launchUrlInBrowser(
//                                         widget.feedData.leadcheckdata2!.MediaURL3!);
//                                     //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
//                                   },
//                                   child: Container(
//                                       width: Screens.width(
//                                                                       context) *
//                                                                   0.52,
//                                                               height: Screens
//                                                                       .bodyheight(
//                                                                           context) *
//                                                                   0.135,
//                                       child: widget.feedData.leadcheckdata2!.MediaURL3!
//                                               .toString()
//                                               .toLowerCase()
//                                               .contains("")
//                                           ? Row(children: [
//                                               Container(
//                                                 width: Screens.width(context) *
//                                                     0.3,
//                                                 height: Screens.bodyheight(
//                                                         context) *
//                                                     0.15,
//                                                 padding: EdgeInsets.all(5),
//                                                 color: Colors.grey[200],
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                           image: AssetImage(
//                                                               'Assets/pdfimg.png'),
//                                                           fit: BoxFit.cover)),
//                                                 ),
//                                               ),
//                                               Container(
//                                                   width:
//                                                       Screens.width(context) *
//                                                           0.55,
//                                                   height: Screens.bodyheight(
//                                                           context) *
//                                                       0.15,
//                                                   padding: EdgeInsets.all(2),
//                                                   color: Colors.grey[200],
//                                                   child: Center(
//                                                       child: Text(
//                                                     widget.feedData.leadcheckdata2!.Title!,
//                                                     style: theme
//                                                         .textTheme.bodyText2,
//                                                     textAlign: TextAlign.center,
//                                                   ))),
//                                             ])
//                                           : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                   .toString()
//                                                   .toLowerCase()
//                                                   .contains(".doc")
//                                               ? Row(children: [
//                                                   Container(
//                                                     width:
//                                                         Screens.width(context) *
//                                                             0.3,
//                                                     height: Screens.bodyheight(
//                                                             context) *
//                                                         0.15,
//                                                     padding: EdgeInsets.all(5),
//                                                     color: Colors.grey[200],
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: AssetImage(
//                                                                   'Assets/wordimg.jpg'),
//                                                               fit: BoxFit
//                                                                   .cover)),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                       width: Screens.width(
//                                                               context) *
//                                                           0.55,
//                                                       height:
//                                                           Screens.bodyheight(
//                                                                   context) *
//                                                               0.15,
//                                                       padding:
//                                                           EdgeInsets.all(2),
//                                                       color: Colors.grey[200],
//                                                       child: Center(
//                                                           child: Text(
//                                                         widget.feedData.leadcheckdata2!.Title!,
//                                                         style: theme.textTheme
//                                                             .bodyText2,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ))),
//                                                 ])
//                                               : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(".xlxs")
//                                                   ? Row(children: [
//                                                       Container(
//                                                         width: Screens.width(
//                                                                 context) *
//                                                             0.3,
//                                                         height:
//                                                             Screens.bodyheight(
//                                                                     context) *
//                                                                 0.15,
//                                                         padding:
//                                                             EdgeInsets.all(5),
//                                                         color: Colors.grey[200],
//                                                         child: Container(
//                                                           decoration: BoxDecoration(
//                                                               image: DecorationImage(
//                                                                   image: AssetImage(
//                                                                       'Assets/pdfimg.png'),
//                                                                   fit: BoxFit
//                                                                       .cover)),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.55,
//                                                           height: Screens
//                                                                   .bodyheight(
//                                                                       context) *
//                                                               0.15,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           color:
//                                                               Colors.grey[200],
//                                                           child: Center(
//                                                               child: Text(
//                                                             widget.feedData.leadcheckdata2!
//                                                                 .Title!,
//                                                             style: theme
//                                                                 .textTheme
//                                                                 .bodyText2,
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ))),
//                                                     ])
//                                                   : widget.feedData.leadcheckdata2!.MediaURL3!
//                                                           .toString()
//                                                           .toLowerCase()
//                                                           .contains(".doc")
//                                                       ? Row(children: [
//                                                           Container(
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.3,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.15,
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     5),
//                                                             color: Colors
//                                                                 .grey[200],
//                                                             child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: AssetImage(
//                                                                           'Assets/xcelomg.png'),
//                                                                       fit: BoxFit
//                                                                           .cover)),
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                               width:
//                                                                   Screens.width(
//                                                                           context) *
//                                                                       0.55,
//                                                               height: Screens.bodyheight(
//                                                                       context) *
//                                                                   0.15,
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(2),
//                                                               color: Colors
//                                                                   .grey[200],
//                                                               child: Center(
//                                                                   child: Text(
//                                                                 widget.feedData
//                                                                    .leadcheckdata2! .Title!,
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyText2,
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                               ))),
//                                                         ])
//                                                       : Container()),
//                                 ):

                               
                                                          





//                                                           InkWell(
//                                                               onTap: () {
//                                                                 final remoteImages =
//                                                                     [
//                                                                   // Image.network(widget
//                                                                   //     .feedData
//                                                                   //     .leadcheckdata2!
//                                                                   //     .MediaURL1!),
//                                                                   // Image.network(widget
//                                                                   //     .feedData
//                                                                   //     .leadcheckdata2!
//                                                                   //     .MediaURL2!),
//                                                                       Image.network(widget
//                                                                       .feedData
//                                                                       .leadcheckdata2!
//                                                                       .MediaURL3!),
                                                                  
//                                                                 ];
//                                                                 SwipeImageGallery(
//                                                                   context:
//                                                                       context,
//                                                                   children:
//                                                                       remoteImages,
//                                                                   onSwipe:
//                                                                       (index) {
//                                                                     print(
//                                                                         "Swiped");
//                                                                     // overlayController.add(OverlayExample(
//                                                                     //   title: '${index + 1}/${remoteImages.length}',
//                                                                     // ));
//                                                                   },
//                                                                   overlayController:
//                                                                       overlayController,
//                                                                   // initialOverlay: OverlayExample(
//                                                                   //   title: '1/${remoteImages.length}',
//                                                                   // ),
//                                                                 ).show();
//                                                               },
//                                                               child: Container(
//                                                                 width: Screens
//                                                                         .width(
//                                                                             context) *
//                                                                     0.40,
//                                                                 height: Screens
//                                                                         .bodyheight(
//                                                                             context) *
//                                                                     0.27,
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(2),
//                                                                 child: Container(
//                                                                     decoration: BoxDecoration(
//                                                                         image: DecorationImage(
//                                                                             image:
//                                                                                 NetworkImage(widget.feedData.leadcheckdata2!.MediaURL3!),
//                                                                             fit: BoxFit.cover))),
//                                                               ),
//                                                             ),
//                                                           )
//                                                     ],
//                                                   )
//                                                    ,
//                                                   // widget
//                                                   //                 .feedData
//                                                   //                 .leadcheckdata2!
//                                                   //                 .MediaURL1 !=
//                                                   //             "" &&
//                                                   //         widget
//                                                   //                 .feedData
//                                                   //                 .leadcheckdata2!
//                                                   //                 .MediaURL1 !=
//                                                   //             "" &&
//                                                   //         widget
//                                                   //                 .feedData
//                                                   //                 .leadcheckdata2!
//                                                   //                 .MediaURL1 ==
//                                                   //             ""
//                                                   //     ? Row(children: [
//                                                   //         InkWell(
//                                                   //           onTap: () {
//                                                   //             final remoteImages =
//                                                   //                 [
//                                                   //               Image.network(widget
//                                                   //                   .feedData
//                                                   //                   .leadcheckdata2!
//                                                   //                   .MediaURL1!),
//                                                   //               Image.network(widget
//                                                   //                   .feedData
//                                                   //                   .leadcheckdata2!
//                                                   //                   .MediaURL2!),
//                                                   //             ];
//                                                   //             SwipeImageGallery(
//                                                   //               context:
//                                                   //                   context,
//                                                   //               children:
//                                                   //                   remoteImages,
//                                                   //               onSwipe:
//                                                   //                   (index) {
//                                                   //                 print(
//                                                   //                     "Swiped");
//                                                   //               },
//                                                   //               overlayController:
//                                                   //                   overlayController,
//                                                   //             ).show();
//                                                   //           },
//                                                   //           child: Container(
//                                                   //             width: Screens.width(
//                                                   //                     context) *
//                                                   //                 0.44,
//                                                   //             height: Screens
//                                                   //                     .bodyheight(
//                                                   //                         context) *
//                                                   //                 0.27,
//                                                   //             padding:
//                                                   //                 EdgeInsets
//                                                   //                     .all(2),
//                                                   //             child: Container(
//                                                   //                 decoration: BoxDecoration(
//                                                   //                     image: DecorationImage(
//                                                   //                         image: NetworkImage(widget
//                                                   //                             .feedData
//                                                   //                             .leadcheckdata2!
//                                                   //                             .MediaURL1!),
//                                                   //                         fit: BoxFit
//                                                   //                             .cover))),
//                                                   //           ),
//                                                   //         ),
//                                                   //         InkWell(
//                                                   //           onTap: () {
//                                                   //             //   List<String> netimg=[];
//                                                   //             //   netimg.add( widget.feedData.MediaURL1!);
//                                                   //             //   netimg.add( widget.feedData.MediaURL2!);

//                                                   //             // Get.to(PhotoViewer( imagePathList: netimg, currentIndex: 1,));

//                                                   //             final remoteImages =
//                                                   //                 [
//                                                   //               Image.network(widget
//                                                   //                   .feedData
//                                                   //                   .leadcheckdata2!
//                                                   //                   .MediaURL1!),
//                                                   //               Image.network(widget
//                                                   //                   .feedData
//                                                   //                   .leadcheckdata2!
//                                                   //                   .MediaURL2!),
//                                                   //             ];
//                                                   //             SwipeImageGallery(
//                                                   //               context:
//                                                   //                   context,
//                                                   //               initialIndex: 1,
//                                                   //               children:
//                                                   //                   remoteImages,
//                                                   //               onSwipe:
//                                                   //                   (index) {
//                                                   //                 print(
//                                                   //                     "Swiped");
//                                                   //               },
//                                                   //               overlayController:
//                                                   //                   overlayController,
//                                                   //             ).show();
//                                                   //           },
//                                                   //           child: Container(
//                                                   //             width: Screens.width(
//                                                   //                     context) *
//                                                   //                 0.44,
//                                                   //             height: Screens
//                                                   //                     .bodyheight(
//                                                   //                         context) *
//                                                   //                 0.27,
//                                                   //             padding:
//                                                   //                 EdgeInsets
//                                                   //                     .all(2),
//                                                   //             child: Container(
//                                                   //                 decoration: BoxDecoration(
//                                                   //                     image: DecorationImage(
//                                                   //                         image: NetworkImage(widget
//                                                   //                             .feedData
//                                                   //                             .leadcheckdata2!
//                                                   //                             .MediaURL2!),
//                                                   //                         fit: BoxFit
//                                                   //                             .cover))),
//                                                   //           ),
//                                                   //         ),
//                                                   //       ])
//                                                   //     : InkWell(
//                                                   //         onTap: () {
//                                                   //           final remoteImages =
//                                                   //               [
//                                                   //             Image.network(widget
//                                                   //                 .feedData
//                                                   //                 .leadcheckdata2!
//                                                   //                 .MediaURL1!),
//                                                   //             //  Image.network( widget.feedData.MediaURL2!),
//                                                   //           ];
//                                                   //           SwipeImageGallery(
//                                                   //             context: context,
//                                                   //             children:
//                                                   //                 remoteImages,
//                                                   //             onSwipe: (index) {
//                                                   //               print("Swiped");
//                                                   //             },
//                                                   //             overlayController:
//                                                   //                 overlayController,
//                                                   //           ).show();
//                                                   //         },
//                                                   //         child: Container(
//                                                   //             width:
//                                                   //                 Screens.width(
//                                                   //                     context),
//                                                   //             height: Screens
//                                                   //                     .bodyheight(
//                                                   //                         context) *
//                                                   //                 0.27,
//                                                   //             decoration: BoxDecoration(
//                                                   //                 image: DecorationImage(
//                                                   //                     image: NetworkImage(widget
//                                                   //                         .feedData
//                                                   //                         .leadcheckdata2!
//                                                   //                         .MediaURL1!),
//                                                   //                     fit: BoxFit
//                                                   //                         .cover))),
//                                                   //       ),
//                                         ),

//                       //actions like
//                       Container(
//                         width: Screens.width(context),
//                         height: Screens.bodyheight(context) * 0.05,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: Screens.width(context) * 0.35,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 widget.pvdDSBD
//                                     .showBottomSheet(context, widget.feedData);
//                                 //context.read<FeedsControoler>().showBottomSheet(context);
//                               },
//                               child: Container(
//                                 alignment: Alignment.centerRight,
//                                 width: Screens.width(context) * 0.4,
//                                 child: Text(
//                                   widget.feedData.Reaction == '' ||
//                                           widget.feedData.Reaction == '??'
//                                       ? '\u{1F44D}'
//                                       : String.fromCharCode(int.parse(widget
//                                           .feedData.Reaction!
//                                           .toString())),
//                                   // context.watch<FeedsControoler>().getSelectedEmoji,
//                                   style: theme.textTheme.headline6,
//                                 ), //1f44c
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),

//           // Positioned(
//           //   // top: 0//Screens.bodyheight(context)*0.1,
//           //   // left: Screens.width(context)*0.2,
//           //   child: Visibility(
//           //     visible:true,

//           //     //widget.pvdDSBD. getreactionvisible,
//           //     child: Container(
//           //       alignment: Alignment.center,
//           //       width:  Screens.width(context),
//           //       height: Screens.bodyheight(context),
//           //       color: Colors.amber,
//           //       //  height: widget.feedData.MediaType == "Link"?
//           //       //   Screens.bodyheight(context)*0.2:
//           //       //   widget.feedData.MediaType == "YoutubeURL"?
//           //       //  Screens.bodyheight(context) * 0.38 :
//           //       //  widget.feedData.MediaType == "Document"?
//           //       //   Screens.bodyheight(context) * 0.15 :
//           //       //   widget.feedData.MediaType == "Video"?
//           //       //  Screens.bodyheight(context) * 0.38 :
//           //       //   widget.feedData.MediaType == "OnlyText"?
//           //       //   Screens.bodyheight(context) *0.12: Screens.bodyheight(context) *0.27,
//           //    //   color: Colors.red,
//           //       child: Lottie.asset("Assets/91069-like.json",
//           //        animate: true,
//           //     repeat: true,
//           //   height: Screens.padingHeight(context) * 0.8,
//           //     width: Screens.width(context) * 0.5),
//           //     ),
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }

//   PopupMenuItem _buildPopupMenuItem(String title) {
//     return PopupMenuItem(
//       height: 40.0,
//       child: Row(
//         children: [
//           Text(title),
//         ],
//       ),
//     );
//   }
// }
class MediaFilesViewer {
  int? mediaType;
  String? mediaUrl;
  ChewieController? chewieController;
   VideoPlayerController? videoPlayerController; 

  MediaFilesViewer({
    required this.mediaType,
    required this.mediaUrl,
    required this.chewieController,
    required this.videoPlayerController
  });
}
