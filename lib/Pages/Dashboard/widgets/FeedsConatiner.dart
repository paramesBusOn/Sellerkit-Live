// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
// // import 'package:any_link_preview/any_link_preview.dart';
// import 'dart:async';
// import 'dart:developer';
// import 'package:any_link_preview/any_link_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:sellerkit/Pages/Dashboard/widgets/LoadUrlPage.dart';
// import 'package:swipe_image_gallery/swipe_image_gallery.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../../../Constant/Screen.dart';
// import '../../../Controller/DashBoardController/DashBoardController.dart';
// import '../../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';
// //import 'package:simple_url_preview/simple_url_preview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class FeedContainer extends StatefulWidget {
//   FeedContainer({
//     Key? key,
//     required this.selected,
//     required this.feedData,
//     required this.pvdDSBD,
//   }) : super(key: key);

//   FeedsModalData feedData;
//   String selected;
//   DashBoardController pvdDSBD;
//   @override
//   State<FeedContainer> createState() => _FeedContainerState();
// }

// class _FeedContainerState extends State<FeedContainer> {
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
//       child: Container(
//         width: Screens.width(context),
//         // height: Screens.bodyheight(context) * 0.55,
//         decoration: BoxDecoration(
//            //   color: Colors.red.shade200
//             ),
//         padding: EdgeInsets.only(
//           top: Screens.bodyheight(context) * 0.01,
//           bottom: Screens.bodyheight(context) * 0.01,
//           left: Screens.width(context) * 0.006,
//           right: Screens.width(context) * 0.006,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: Screens.width(context),
//               //  color: Colors.yellow.shade200,
//               height: Screens.bodyheight(context) * 0.08,
//               padding: EdgeInsets.only(
//                   left: Screens.width(context) * 0.01,
//                   right: Screens.width(context) * 0.01),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: Screens.width(context) * 0.1,
//                     decoration: BoxDecoration(
//                         //    color: Colors.blueAccent,
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                            image: //Image.network(widget.feedData.ProfilePic!),
//                            NetworkImage(widget.feedData.ProfilePic!),
//                            fit: BoxFit.cover)
//                             ),

//                             // child: 
//                             // Image.network(widget.feedData.ProfilePic!=null?widget.feedData.ProfilePic!:''),
//                   ),
//                   Container(
//                     width: Screens.width(context) * 0.78,
//                     //   color: Colors.blueAccent,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Container(
//                           alignment: Alignment.bottomLeft,
//                           height: Screens.bodyheight(context) * 0.03,
//                           width: Screens.width(context) * 0.8,
//                           child: Text(
//                             "${widget.feedData.leadcheckdata2!.CreatedBy}",
//                             style: theme.textTheme.bodyText2?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.topLeft,
//                           height: Screens.bodyheight(context) * 0.04,
//                           width: Screens.width(context) * 0.8,
//                           //     color: Colors.red,
//                           child: Text(
//                             widget.pvdDSBD.config
//                                 .subtractDateTime(widget.feedData.leadcheckdata2!.CreatedDate!),
//                             style: theme.textTheme.bodyText2
//                                 ?.copyWith(color: Colors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               width: Screens.width(context),
//               padding: EdgeInsets.only(
//                   left: Screens.width(context) * 0.01,
//                   right: Screens.width(context) * 0.01),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "${widget.feedData.leadcheckdata2!.Title}",
//                       style: theme.textTheme.subtitle1,
//                     ),
//                   ),
//                   ExpandableText(
//                     '${widget.feedData.leadcheckdata2!.Description}',
//                     style:
//                         theme.textTheme.bodyText2?.copyWith(color: Colors.grey),
//                     expandText: 'more',
//                     collapseText: 'less',
//                     maxLines: 2,
//                     linkColor: theme.primaryColor,
//                   ),

//                   //media type
//                   SizedBox(
//                     height: Screens.bodyheight(context) * 0.01,
//                   ),
//                   widget.feedData.leadcheckdata2!.MediaType == "Link"
//                       ? Container(
//                           width: Screens.width(context),
//                           height: Screens.bodyheight(context) * 0.2,
//                           child: AnyLinkPreview(
//                             link: "${widget.feedData.leadcheckdata2!.MediaURL1}",
//                             displayDirection: UIDirection.uiDirectionHorizontal,
//                             cache: Duration(seconds: 1),
//                             showMultimedia: false,
//                             errorWidget: Container(
//                               color: Colors.grey[300],
//                               child: Text('Oops!'),
//                             ),
//                             urlLaunchMode: LaunchMode.externalApplication,
//                             onTap: () {
//                               print("sASasAS");
//                               widget.pvdDSBD.launchUrlInBrowser(widget.feedData.leadcheckdata2!
//                                   .MediaURL1!); //"https://www.google.com"
//                             },
//                             // errorImage: _errorImage,
//                           ),
//                         )
//                       : widget.feedData.leadcheckdata2!.MediaType == "YoutubeURL"
//                           ? Container(
//                               width: Screens.width(context),
//                               height: Screens.bodyheight(context) * 0.38,
//                               child: WebView(
//                                 initialUrl: "${widget.feedData.leadcheckdata2!.MediaURL1}",
//                                 javascriptMode: JavascriptMode.unrestricted,
//                                 initialMediaPlaybackPolicy:
//                                     AutoMediaPlaybackPolicy
//                                         .require_user_action_for_all_media_types,
//                                 onWebViewCreated: (controllerGloba) {
//                                   widget.pvdDSBD.controllerGlobal =
//                                       controllerGloba;
//                                 },
//                               ),
//                             )
//                           : widget.feedData.leadcheckdata2!.MediaType == "Document"
//                               ? InkWell(
//                                   onTap: () {
//                                     print("object");
//                                     widget.pvdDSBD.launchUrlInBrowser(
//                                         widget.feedData.leadcheckdata2!.MediaURL1!);
//                                     //  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoadURLPage(urlls:"${widget.feedData.MediaURL1}")));
//                                   },
//                                   child: Container(
//                                       width: Screens.width(context),
//                                       height:
//                                           Screens.bodyheight(context) * 0.15,
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
//                                 )
//                               : widget.feedData.leadcheckdata2!.MediaType == "Video"
//                                   ? Container(
//                                       width: Screens.width(context),
//                                       height: Screens.bodyheight(context) * 0.38,
//                                      // color: Colors.red,
//                                       child: HtmlWidget(
//                                         '''<video width="300" height="700" controls preview>
//                                          <source src="${widget.feedData.leadcheckdata2!.MediaURL1}" type="video/mp4">
//                                          </video>''',
//                                       ),
//                                     )
//                                   : widget.feedData.leadcheckdata2!.MediaType == "OnlyText"
//                                       ? Container()
//                                       :

//                                       ///image
//                                       Container(
//                                           width: Screens.width(context),
//                                           height: Screens.bodyheight(context) *
//                                               0.27,
//                                           child: widget.feedData.leadcheckdata2!.MediaURL1 !=
//                                                       "" &&
//                                                   widget.feedData.leadcheckdata2!.MediaURL1 !=
//                                                       "" &&
//                                                   widget.feedData.leadcheckdata2!.MediaURL1 !=
//                                                       ""
//                                               ? Row(children: [
//                                                   InkWell(
//                                                     onTap: () {
//                                                       print("11111");
//                                                       // List<String> netimg=[];
//                                                       // netimg.add( widget.feedData.MediaURL1!);
//                                                       // netimg.add( widget.feedData.MediaURL2!);
//                                                       // netimg.add( widget.feedData.MediaURL3!);
//                                                       // Get.to(PhotoViewer( imagePathList: netimg, currentIndex: 0,));
//                                                       final remoteImages = [
//                                                         Image.network(widget
//                                                             .feedData
//                                                             .leadcheckdata2!.MediaURL1!),
//                                                         Image.network(widget
//                                                             .feedData
//                                                             .leadcheckdata2!.MediaURL2!),
//                                                         Image.network(widget
//                                                             .feedData
//                                                            .leadcheckdata2! .MediaURL3!),
//                                                       ];
//                                                       SwipeImageGallery(
//                                                         context: context,
//                                                       children: remoteImages,
//                                                         onSwipe: (index) {
//                                                           print("Swiped");
//                                                           // overlayController.add(OverlayExample(
//                                                           //   title: '${index + 1}/${remoteImages.length}',
//                                                           // ));
//                                                         },
//                                                         overlayController:
//                                                             overlayController,
//                                                         // initialOverlay: OverlayExample(
//                                                         //   title: '1/${remoteImages.length}',
//                                                         // ),
//                                                       ).show();
//                                                     },
//                                                     child: Container(
//                                                       width: Screens.width(
//                                                               context) *
//                                                           0.44,
//                                                       height:
//                                                           Screens.bodyheight(
//                                                                   context) *
//                                                               0.27,
//                                                       padding:
//                                                           EdgeInsets.all(2),
//                                                       child: Container(
//                                                           decoration: BoxDecoration(
//                                                               image: DecorationImage(
//                                                                   image: NetworkImage(widget
//                                                                       .feedData
//                                                                      .leadcheckdata2! .MediaURL1!),
//                                                                   fit: BoxFit
//                                                                       .cover))),
//                                                     ),
//                                                   ),
//                                                   Column(
//                                                     children: [
//                                                       InkWell(
//                                                         onTap: () {
//                                                           final remoteImages = [
//                                                             Image.network(widget
//                                                                 .feedData
//                                                                 .leadcheckdata2!.MediaURL1!),
//                                                             Image.network(widget
//                                                                 .feedData
//                                                                 .leadcheckdata2!.MediaURL2!),
//                                                             Image.network(widget
//                                                                 .feedData
//                                                               .leadcheckdata2!  .MediaURL3!),
//                                                           ];
//                                                           SwipeImageGallery(
//                                                             context: context,
//                                                             initialIndex: 1,
//                                                             children:
//                                                                 remoteImages,
//                                                             onSwipe: (index) {
//                                                               print("Swiped");
//                                                             },
//                                                             overlayController:
//                                                                 overlayController,
//                                                           ).show();
//                                                         },
//                                                         child: Container(
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.44,
//                                                           height: Screens
//                                                                   .bodyheight(
//                                                                       context) *
//                                                               0.135,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: NetworkImage(widget
//                                                                           .feedData
//                                                                         .leadcheckdata2!  .MediaURL2!),
//                                                                       fit: BoxFit
//                                                                           .cover))),
//                                                         ),
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () {
//                                                           final remoteImages = [
//                                                             Image.network(widget
//                                                                 .feedData
//                                                                .leadcheckdata2! .MediaURL1!),
//                                                             Image.network(widget
//                                                                 .feedData
//                                                             .leadcheckdata2!    .MediaURL2!),
//                                                             Image.network(widget
//                                                                 .feedData
//                                                               .leadcheckdata2!  .MediaURL3!),
//                                                           ];
//                                                           SwipeImageGallery(
//                                                             context: context,
//                                                           initialIndex: 2,
//                                                             children:
//                                                                 remoteImages,
//                                                             onSwipe: (index) {
//                                                               print("Swiped");
//                                                             },
//                                                             overlayController:
//                                                                 overlayController,
//                                                           ).show();
//                                                         },
//                                                         child: Container(
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.44,
//                                                           height: Screens
//                                                                   .bodyheight(
//                                                                       context) *
//                                                               0.135,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: NetworkImage(widget
//                                                                           .feedData
//                                                                       .leadcheckdata2!    .MediaURL3!),
//                                                                       fit: BoxFit
//                                                                           .cover))),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ])
//                                               : widget.feedData.leadcheckdata2!.MediaURL1 !=
//                                                           "" &&
//                                                       widget.feedData
//                                                               .leadcheckdata2!.MediaURL1 !=
//                                                           "" &&
//                                                       widget.feedData
//                                                               .leadcheckdata2!.MediaURL1 ==
//                                                           ""
//                                                   ? Row(children: [
//                                                       InkWell(
//                                                         onTap: () {
//                                                           final remoteImages = [
//                                                             Image.network(widget
//                                                                 .feedData
//                                                               .leadcheckdata2!  .MediaURL1!),
//                                                             Image.network(widget
//                                                                 .feedData
//                                                               .leadcheckdata2!  .MediaURL2!),
//                                                           ];
//                                                           SwipeImageGallery(
//                                                             context: context,
//                                                            children:
//                                                                  remoteImages,
//                                                             onSwipe: (index) {
//                                                               print("Swiped");
//                                                             },
//                                                             overlayController:
//                                                                 overlayController,
//                                                           ).show();
//                                                         },
//                                                         child: Container(
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.44,
//                                                           height: Screens
//                                                                   .bodyheight(
//                                                                       context) *
//                                                               0.27,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: NetworkImage(widget
//                                                                           .feedData
//                                                                         .leadcheckdata2!  .MediaURL1!),
//                                                                       fit: BoxFit
//                                                                           .cover))),
//                                                         ),
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () {
//                                                           //   List<String> netimg=[];
//                                                           //   netimg.add( widget.feedData.MediaURL1!);
//                                                           //   netimg.add( widget.feedData.MediaURL2!);

//                                                           // Get.to(PhotoViewer( imagePathList: netimg, currentIndex: 1,));

//                                                           final remoteImages = [
//                                                             Image.network(widget
//                                                                 .feedData
//                                                               .leadcheckdata2!  .MediaURL1!),
//                                                             Image.network(widget
//                                                                 .feedData
//                                                                 .leadcheckdata2!.MediaURL2!),
//                                                           ];
//                                                           SwipeImageGallery(
//                                                             context: context,
//                                                             initialIndex: 1,
//                                                             children: remoteImages,
//                                                             onSwipe: (index) {
//                                                               print("Swiped");
//                                                             },
//                                                             overlayController:
//                                                                 overlayController,
//                                                           ).show();
//                                                         },
//                                                         child: Container(
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.44,
//                                                           height: Screens
//                                                                   .bodyheight(
//                                                                       context) *
//                                                               0.27,
//                                                           padding:
//                                                               EdgeInsets.all(2),
//                                                           child: Container(
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: NetworkImage(widget
//                                                                           .feedData
//                                                                          .leadcheckdata2! .MediaURL2!),
//                                                                       fit: BoxFit
//                                                                           .cover))),
//                                                         ),
//                                                       ),
//                                                     ])
//                                                   : InkWell(
//                                                       onTap: () {
//                                                         final remoteImages = [
//                                                           Image.network(widget
//                                                               .feedData
//                                                               .leadcheckdata2!.MediaURL1!),
//                                                           //  Image.network( widget.feedData.MediaURL2!),
//                                                         ];
//                                                         SwipeImageGallery(
//                                                           context: context,
//                                                         children: remoteImages,
//                                                           onSwipe: (index) {
//                                                             print("Swiped");
//                                                           },
//                                                           overlayController:
//                                                               overlayController,
//                                                         ).show();
//                                                       },
//                                                       child: Container(
//                                                           width: Screens.width(
//                                                               context),
//                                                           height:
//                                                               Screens.bodyheight(
//                                                                       context) *
//                                                                   0.27,
//                                                           decoration: BoxDecoration(
//                                                               image: DecorationImage(
//                                                                   image: NetworkImage(widget
//                                                                       .feedData
//                                                                     .leadcheckdata2!  .MediaURL1!),
//                                                                   fit: BoxFit
//                                                                       .cover))),
//                                                     ),
//                                         ),

//                   //actions like
//                   Container(
//                     width: Screens.width(context),
//                     height: Screens.bodyheight(context) * 0.05,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: Screens.width(context) * 0.35,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             widget.pvdDSBD
//                                 .showBottomSheet(context, widget.feedData);
//                             //context.read<FeedsControoler>().showBottomSheet(context);
//                           },
//                           child: Container(
//                             alignment: Alignment.centerRight,
//                             width: Screens.width(context) * 0.4,
//                             child: Text(
//                               widget.feedData.Reaction == '' ||     widget.feedData.Reaction == '??' 
//                                   ? '\u{1F44D}'
//                                   :  String.fromCharCode(int.parse(widget.feedData.Reaction!.toString())),
//                              // context.watch<FeedsControoler>().getSelectedEmoji,
//                               style: theme.textTheme.headline6,
//                             ), //1f44c
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
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
