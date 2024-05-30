// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
// // import 'package:any_link_preview/any_link_preview.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:get/get.dart';
// import 'package:sellerkit/Widgets/NetworkPDFViewer.dart';
// import 'package:swipe_image_gallery/swipe_image_gallery.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../../../Constant/Screen.dart';
// import '../../../Controller/DashBoardController/DashBoardController.dart';
// import '../../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';
// import '../widgets/videoplayer.dart';

// class CurrentFeedContainer extends StatefulWidget {
//   CurrentFeedContainer({
//     Key? key,
//     required this.selected,
//     required this.feedData,
//     required this.pvdDSBD,
//   }) : super(key: key);

//   FeedsModalData feedData;
//   String selected;
//   DashBoardController pvdDSBD;
//   @override
//   State<CurrentFeedContainer> createState() => CurrentFeedContainerState();
// }

// class CurrentFeedContainerState extends State<CurrentFeedContainer> {
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
//                 // color: Colors.red.shade200
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
//                   height: Screens.bodyheight(context) * 0.08,
//                   padding: EdgeInsets.only(
//                       left: Screens.width(context) * 0.01,
//                       right: Screens.width(context) * 0.01),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // Navigator.push(context,
//                           //     MaterialPageRoute(builder: (_) => WEBV()));
//                         },
//                         child: Container(
//                           width: Screens.width(context) * 0.1,
//                           decoration: BoxDecoration(
//                               //    color: Colors.blueAccent,
//                               shape: BoxShape.circle,
//                               image: widget.feedData.ProfilePic!.isEmpty
//                                   ? DecorationImage(
//                                       image: //Image.network(widget.feedData.ProfilePic!),
//                                           AssetImage("Assets/img.jpg"),
//                                       fit: BoxFit.cover)
//                                   : DecorationImage(
//                                       image: //Image.network(widget.feedData.ProfilePic!),
//                                           NetworkImage(
//                                               widget.feedData.ProfilePic!),
//                                       fit: BoxFit.cover)),

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
//                       widget.pvdDSBD.checkContent(
//                                   widget.feedData.leadcheckdata2!) ==
//                               1
//                           ? Container(
//                               width: Screens.width(context),
//                               height: Screens.padingHeight(context) * 0.3,
//                               // color: Colors.red,
//                               child: 
//                               oneMedia(
//                                   widget.feedData.leadcheckdata2!.MediaURL1,
//                                   Screens.width(context),
//                                             Screens.padingHeight(context) * 0.3,
//                                   ),
//                             )
//                           : widget.pvdDSBD.checkContent(
//                                       widget.feedData.leadcheckdata2!) ==
//                                   2
//                               ? Container(
//                                   width: Screens.width(context),
//                                   // height: Screens.padingHeight(context) * 0.3,
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                           width: Screens.width(context),
//                                            height: Screens.padingHeight(context) * 0.3,
//                                          // color: Colors.green,
//                                         child: oneMedia(widget.feedData
//                                             .leadcheckdata2!.MediaURL1,
//                                              Screens.width(context),
//                                             Screens.padingHeight(context) * 0.3,
//                                             ),
//                                       ),
//                                       Container(
//                                          width: Screens.width(context),
//                                           height: Screens.padingHeight(context) * 0.3,
//                                        //  color: Colors.blue,
//                                         child: oneMedia(widget.feedData
//                                             .leadcheckdata2!.MediaURL2,
                                            
//                                             Screens.width(context),
//                                             Screens.padingHeight(context) * 0.3,),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               : Container(
//                                   width: Screens.width(context),
//                                 //  height: Screens.bodyheight(context) * 0.3,
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         width: Screens.width(context),
//                                         height: Screens.bodyheight(context) * 0.3,
//                                         child: oneMedia(widget.feedData
//                                             .leadcheckdata2!.MediaURL1,
                                            
//                                             Screens.width(context),
//                                             Screens.padingHeight(context) * 0.3,),
//                                       ),
//                                       Container(
//                                         width: Screens.width(context),
//                                         height: Screens.bodyheight(context) * 0.3,
//                                         child: Stack(
//                                           alignment: Alignment.center,
//                                           children: [
//                                             multiMedia(widget.feedData
//                                                 .leadcheckdata2!.MediaURL2,
                                                
//                                             Screens.width(context),
//                                             Screens.padingHeight(context) * 0.3,),
//                                             StackPostion(widget: widget, theme: theme)
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),

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
//         ],
//       ),
//     );
//   }

//   Widget oneMedia(String url, double width, double height) {
//     if (url.contains('.mp4')) {
//       return Stack(
//         children: [
//           Container(
//              width: width,
//           height: height,
//             child: HtmlWidget(
          
//                 '''<video width="300" height="700" controls preview>
//              <source src="${url}" type="video/mp4">
//               </video>''',
//                ),
//           ),
//       Positioned(child: InkWell(
//         onTap: (){
//           print("object");
//  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(
//                                                                 data1: widget.feedData.leadcheckdata2!.MediaURL1!,
//                                                               )));
//                                                                   },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//         ],
//       );
//     } else if (url.contains('.png') || url.contains('.jp')) {
//       return Stack(
//         children: [
//           Container(
//              width: width,
//           height: height,
//             child: Image.network(
//               url,
//               fit: BoxFit.cover,
//             ),
//           ),
//            Positioned(
//         child: InkWell(
//         onTap: (){
//         final  remoteImages = [Image.network(url)];
//            SwipeImageGallery(
//                                                                   context:
//                                                                       context,
//                                                                   children:
//                                                                       remoteImages,
//                                                                   onSwipe:
//                                                                       (index) {
//                                                                   },
//                                                                   overlayController:
//                                                                       overlayController,
//                                                                 ).show();
//         },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//         ],
//       );
//     } else if (url.contains('.pdf')) {
//       return Stack(
//         children: [
//           Container(
//             child: PDFViewerFromUrl(
//               url: url,
//               appbarreq: false,
//               title: 'PDF',
//             ),
//           ),
//       Positioned(child: InkWell(
//         onTap: (){
//   Get.to(()=>PDFViewerFromUrl(url: url, appbarreq: true,title: 'Projects',));
//         },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//         ],
//       );
//     }

//     return Stack(
//       alignment: Alignment.center,
//       children:[ 
//         WebView(
//         zoomEnabled: false,
//         initialUrl: url,
//       ),
//       Positioned(child: InkWell(
//         onTap: (){
//             launchInWebViewadrees(Uri.parse(url));
//         },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//     ]);
//   }

//   Widget multiMedia(String url, double width, double height) {
//     if (url.contains('.mp4')) {
//       return Stack(
//         children: [
//           Container(
//              width: width,
//           height: height,
//             child: HtmlWidget(
          
//                 '''<video width="300" height="700" controls preview>
//              <source src="${url}" type="video/mp4">
//               </video>''',
//                ),
//           ),
//       Positioned(child: InkWell(
//         onTap: (){
//           print("object");
//  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(
//                                                                 data1: widget.feedData.leadcheckdata2!.MediaURL1!,
//                                                               )));
//                                                                   },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//         ],
//       );
//     } else if (url.contains('.png') || url.contains('.jp')) {
//       return Stack(
//         children: [
//           Container(
//              width: width,
//           height: height,
//             child: Image.network(
//               url,
//               fit: BoxFit.cover,
//             ),
//           ),
//            Positioned(
//         child: InkWell(
//         onTap: (){
//         final  remoteImages = [Image.network(url)];
//            SwipeImageGallery(
//                                                                   context:
//                                                                       context,
//                                                                   children:
//                                                                       remoteImages,
//                                                                   onSwipe:
//                                                                       (index) {
//                                                                   },
//                                                                   overlayController:
//                                                                       overlayController,
//                                                                 ).show();
//         },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//         ],
//       );
//     } else if (url.contains('.pdf')) {
//       return Stack(
//         children: [
//           Container(
//             child: PDFViewerFromUrl(
//               url: url,
//               appbarreq: false,
//               title: 'PDF',
//             ),
//           ),
//       Positioned(child: InkWell(
//         onTap: (){
//   Get.to(()=>PDFViewerFromUrl(url: url, appbarreq: true,title: 'Projects',));
//         },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//         ],
//       );
//     }

//     return Stack(
//       alignment: Alignment.center,
//       children:[ 
//         WebView(
//         zoomEnabled: false,
//         initialUrl: url,
//       ),
//       Positioned(child: InkWell(
//         onTap: (){
//             launchInWebViewadrees(Uri.parse(url));
//         },
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ))
//     ]);
//   }


//     Future<void> launchInWebViewadrees(Uri url) async {
//     if (!await launchUrl(
//       url, //
//       mode: LaunchMode.inAppWebView,
//       webViewConfiguration: const WebViewConfiguration(
//           headers: <String, String>{'my_header_key': 'my_header_value'}),
//     )) {
//       throw Exception('Could not launch $url');
//     }
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

// class StackPostion extends StatelessWidget {
//   const StackPostion({
//     Key? key,
//     required this.widget,
//     required this.theme,
//   }) : super(key: key);

//   final CurrentFeedContainer widget;
//   final ThemeData theme;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         child: InkWell(
//       onTap: () {
       
//       },
//       child: Container(
//         child: CircleAvatar(
//           radius: Screens.bodyheight(
//                   context) *
//               0.05,
//           backgroundColor: theme
//               .primaryColor
//               .withOpacity(0.6),
//           child: const Text(
//             '1+',
//             style: TextStyle(
//                 color: Colors.white),
//           ),
//         ),
//       ),
//     ));
//   }


//   viewFile(BuildContext context,String Url){
//     if(Url.contains('.mp4')){
//        Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     VideoPlayer(
//                       data1: widget
//                           .feedData
//                           .leadcheckdata2!
//                           .MediaURL1!,
//                     )));
//     }
//   }
// }
