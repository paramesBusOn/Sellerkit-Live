// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:readmore/readmore.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/DownLoadController/DownloadController.dart';
import 'package:sellerkit/Pages/Challenges/Widgets/SearchWidgets.dart';
import 'package:sellerkit/Pages/Dashboard/widgets/chewievideoplayer.dart';
import 'package:sellerkit/Pages/OfferZone/OfferPopup.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:video_player/video_player.dart';
import '../../../Constant/Configuration.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/OfferZoneController/OfferZoneController.dart';
import '../../../Widgets/Navi3.dart';

class OfferZone extends StatefulWidget {
  const OfferZone({Key? key}) : super(key: key);

  @override
  State<OfferZone> createState() => OfferZoneState();
}

class OfferZoneState extends State<OfferZone> {
  var keys;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
  @override
  bool isReadMore = false;
  Widget build(BuildContext context) {
    final themes = Theme.of(context);
    Config config2 = Config();
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Offer Zone", scaffoldKey, themes, context),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Check if the user is swiping from left to right
            print(details.primaryDelta);
            if (details.primaryDelta! > ConstantValues.slidevalue!) {
              setState(() {
                Get.offAllNamed(ConstantRoutes.dashboard);
              });
            }
          },
          child: ChangeNotifierProvider<OfferZoneController>(
              create: (context) => OfferZoneController(),
              builder: (context, child) {
                return Consumer<OfferZoneController>(
                    builder: (BuildContext context, prdOffZ, Widget? child) {
                  return SafeArea(
                    child: prdOffZ.getofferzone.isEmpty
                        ? Center(child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('Assets/no-data.png',
        //               opacity: AnimationController(
        //     vsync: this,
        //     value: 1
        // ),
        // color:Colors.transparent,
                        // animate: true,
                        // repeat: true,
                        
                        height: Screens.padingHeight(context) * 0.2,
                        width: Screens.width(context)*0.5
                        ),
                  ),
                            Text("No data..!!",textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
                          ],
                        )
                            //   CircularProgressIndicator(
                            //   color: themes.primaryColor,
                            // )
                            )
                        : Column(
                            children: [
                              Container(
                                height: Screens.bodyheight(context) * 0.06,
                                decoration: BoxDecoration(
                                  color: themes.primaryColor
                                      .withOpacity(0.1), //Colors.grey[200],
                                  borderRadius: BorderRadius.circular(
                                      Screens.width(context) * 0.02),
                                ),
                                child: TextField(
                                  autocorrect: false,
                                  onChanged: (v) {
                                    prdOffZ.offerfilterList(v);
                                  },
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: 'Search Here!!..',
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    prefixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        FocusScopeNode focus =
                                            FocusScope.of(context);
                                        if (!focus.hasPrimaryFocus) {
                                          focus.unfocus();
                                        }
                                      }, //
                                      color: themes.primaryColor,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 5,
                                    ),
                                  ),
                                ),
                              ),
                              // SearchWidget(
                              //   themes: themes,
                              // ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    return prdOffZ.refreshData();
                                  },
                                  child: ListView.builder(
                                    itemCount: prdOffZ.getofferviewAll.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      keys = prdOffZ.getofferviewAll.toList();

                                      return InkWell(
                                          onDoubleTap: () {
                                            for(int i=0;i<prdOffZ
                                                .getofferviewAll
                                                .length;i++){

                                                }
                                            prdOffZ.searchmethod(
                                                prdOffZ.getofferviewAll[i],
                                                context,
                                                themes);
                                            // if (prdOffZ
                                            //     .getofferviewAll[i]
                                            //     .offerproductlistdetails!
                                            //     .isNotEmpty &&prdOffZ
                                            //     .getofferviewAll[i]
                                            //     . offerproductlistdetails! [i].offerid ==prdOffZ
                                            //     .getofferviewAll[i].offerId) {
                                            //   showDialog(
                                            //       context: context,
                                            //       builder: (_) {
                                            //         // if( prdOffZ
                                            //         //             .getofferviewAll[i].offerproductlistdetails!.isNotEmpty){
                                            //         return DiviceDialogBox(
                                            //           pardata: prdOffZ
                                            //               .getofferviewAll[i],
                                            //           theme: themes,
                                            //           // popvalues: prdOffZ.getofferviewAll[i].offerproductlistdetails!,
                                            //           // i: i,
                                            //           // popvalues2:prdOffZ.getofferviewAll,
                                            //         );
                                            //         // }
                                            //       });
                                            // }
                                          },
                                          child:
                                              AnimationConfiguration
                                                  .staggeredList(
                                                      position: i,
                                                      duration: const Duration(
                                                          milliseconds: 400),
                                                      child: SlideAnimation(
                                                          verticalOffset: 100.0,
                                                          child: FlipAnimation(
                                                            child: Card(
                                                              elevation: 2,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: Screens.width(context) *
                                                                            0.01,
                                                                        right: Screens.width(context) *
                                                                            0.01,
                                                                        top: Screens.bodyheight(context) *
                                                                            0.01,
                                                                        bottom: Screens.bodyheight(context) *
                                                                            0.001,
                                                                      ),
                                                                      width: Screens
                                                                          .width(
                                                                              context),
                                                                      child:
                                                                          Text(
                                                                        prdOffZ
                                                                            .getofferviewAll[i]
                                                                            .offerName
                                                                            .toString(),
                                                                        style: themes
                                                                            .textTheme
                                                                            .bodyText1
                                                                            ?.copyWith(),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: Screens.bodyheight(
                                                                              context) *
                                                                          0.01,
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: Screens.width(context) *
                                                                            0.01,
                                                                        right: Screens.width(context) *
                                                                            0.01,
                                                                        top: Screens.bodyheight(context) *
                                                                            0.001,
                                                                        bottom: Screens.bodyheight(context) *
                                                                            0.001,
                                                                      ),
                                                                      width: Screens
                                                                          .width(
                                                                              context),
                                                                      child:ReadMoreText(
                                                                         prdOffZ.getofferviewAll[i].offerDetails.toString(),
                                                                        trimLines: 1,
                                                                         trimMode: TrimMode.Line,
                                                                         moreStyle: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),
                                                                         lessStyle: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),
                                                                        colorClickableText: Colors.blue,
                                                                         trimCollapsedText: '...Read more',
                  trimExpandedText: ' ...Read less',

                                                                      ),
                                                                      //     Text(
                                                                        
                                                                      //       prdOffZ.getofferviewAll[i].offerDetails.toString(),
                                                                      //   style: themes
                                                                      //       .textTheme
                                                                      //       .bodyText1
                                                                      //       ?.copyWith(),
                                                                      //   maxLines: isReadMore
                                                                      //       ? 50
                                                                      //       : 1,
                                                                      // ),
                                                                    ),
                                                                    // (prdOffZ
                                                                    //           .getofferviewAll[i]
                                                                    //           .offerDetails!.length)< 40?Container():
                                                                    // GestureDetector(
                                                                    //   onTap:
                                                                    //       () {
                                                                    //     setState(
                                                                    //         () {
                                                                    //       isReadMore =
                                                                    //           !isReadMore;
                                                                    //     });
                                                                    //   },
                                                                    //   child:
                                                                    //       Container(
                                                                    //         alignment: Alignment.centerLeft,
                                                                    //     child: isReadMore ==
                                                                    //             false
                                                                    //         ? Text(
                                                                    //             "Read More",
                                                                    //             style: themes.textTheme.bodyText1?.copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                                                                    //           )
                                                                    //         : Text(
                                                                    //             "Read Less",
                                                                    //             style: themes.textTheme.bodyText1?.copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                                                                    //           ),
                                                                    //   ),
                                                                    // ),
                                                                    SizedBox(
                                                                      height: Screens.bodyheight(
                                                                              context) *
                                                                          0.01,
                                                                    ),
                                                                    prdOffZ.getofferviewAll[i].mediaurl1!.toString().toLowerCase().contains(".mp4") &&
                                                                            prdOffZ.getofferviewAll[i].mediaurl2!.toString().toLowerCase().contains(
                                                                                ".mp4")
                                                                        ? Column(
                                                                            children: [
                                                                              Container(
                                                                                  // color: Colors.amber,
                                                                                  width: Screens.width(context),
                                                                                  height: Screens.padingHeight(context) * 0.2,
                                                                                  child: VideoPlayerWidget(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(prdOffZ.getofferviewAll[i].mediaurl1!)))
                                                                                  // HtmlWidget(
                                                                                  //   '''<video width="300" height="700" controls preview>
                                                                                  //                          <source src="${prdOffZ.getofferviewAll[i].mediaurl1!}" type="video/mp4">
                                                                                  //                          </video>''',
                                                                                  // ),
                                                                                  ),
                                                                              Container(
                                                                                  // color: Colors.amber,
                                                                                  width: Screens.width(context),
                                                                                  height: Screens.padingHeight(context) * 0.2,
                                                                                  child: VideoPlayerWidget(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(prdOffZ.getofferviewAll[i].mediaurl2!)))
                                                                                  // HtmlWidget(
                                                                                  //   '''<video width="300" height="700" controls preview>
                                                                                  //                          <source src="${prdOffZ.getofferviewAll[i].mediaurl2!}" type="video/mp4">
                                                                                  //                          </video>''',
                                                                                  // ),
                                                                                  )
                                                                            ],
                                                                          )
                                                                        : prdOffZ.getofferviewAll[i].mediaurl1!.toString().toLowerCase().contains(".mp4") ||
                                                                                prdOffZ.getofferviewAll[i].mediaurl2!.toString().toLowerCase().contains(".mp4")
                                                                            ? Column(
                                                                                children: [
                                                                                  prdOffZ.getofferviewAll[i].mediaurl2!.toString().toLowerCase().contains(".mp4")
                                                                                      ? Column(
                                                                                          children: [
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                final remoteImages = [
                                                                                                  Image.network(prdOffZ.getofferviewAll[i].mediaurl1.toString()),
                                                                                                ];
                                                                                                SwipeImageGallery(
                                                                                                  context: context,
                                                                                                  children: remoteImages,
                                                                                                  onSwipe: (index) {
                                                                                                    print("Swiped");
                                                                                                    // overlayController.add(OverlayExample(
                                                                                                    //   title: '${index + 1}/${remoteImages.length}',
                                                                                                    // ));
                                                                                                  },
                                                                                                  overlayController: overlayController,
                                                                                                  // initialOverlay: OverlayExample(
                                                                                                  //   title: '1/${remoteImages.length}',
                                                                                                  // ),
                                                                                                ).show();
                                                                                              },
                                                                                              child: Container(
                                                                                                // color: Colors.amber,

                                                                                                padding: EdgeInsets.all(2),
                                                                                                child: Container(
                                                                                                    // color: Colors.amber,
                                                                                                    alignment: Alignment.center,
                                                                                                    height: Screens.bodyheight(context) * 0.2,
                                                                                                    width: Screens.width(context),
                                                                                                    decoration: BoxDecoration(image: DecorationImage(alignment: Alignment.center, image: NetworkImage(prdOffZ.getofferviewAll[i].mediaurl1.toString()), fit: BoxFit.contain))),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                                // color: Colors.amber,
                                                                                                width: Screens.width(context),
                                                                                                height: Screens.padingHeight(context) * 0.2,
                                                                                                child: VideoPlayerWidget(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(prdOffZ.getofferviewAll[i].mediaurl2!)))
                                                                                                // HtmlWidget(
                                                                                                //   '''<video width="300" height="700" controls preview>
                                                                                                //                          <source src="${prdOffZ.getofferviewAll[i].mediaurl2!}" type="video/mp4">
                                                                                                //                          </video>''',
                                                                                                // ),
                                                                                                ),
                                                                                          ],
                                                                                        )
                                                                                      : Column(
                                                                                          children: [
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                final remoteImages = [
                                                                                                  Image.network(prdOffZ.getofferviewAll[i].mediaurl2.toString()),
                                                                                                ];
                                                                                                SwipeImageGallery(
                                                                                                  context: context,
                                                                                                  children: remoteImages,
                                                                                                  onSwipe: (index) {
                                                                                                    print("Swiped");
                                                                                                    // overlayController.add(OverlayExample(
                                                                                                    //   title: '${index + 1}/${remoteImages.length}',
                                                                                                    // ));
                                                                                                  },
                                                                                                  overlayController: overlayController,
                                                                                                  // initialOverlay: OverlayExample(
                                                                                                  //   title: '1/${remoteImages.length}',
                                                                                                  // ),
                                                                                                ).show();
                                                                                              },
                                                                                              child: Container(
                                                                                                // color: Colors.amber,

                                                                                                padding: EdgeInsets.all(2),
                                                                                                child: Container(height: Screens.bodyheight(context) * 0.2, width: Screens.width(context), decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(prdOffZ.getofferviewAll[i].mediaurl2.toString()), fit: BoxFit.cover))),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                                // color: Colors.amber,
                                                                                                width: Screens.width(context),
                                                                                                height: Screens.padingHeight(context) * 0.2,
                                                                                                child: VideoPlayerWidget(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(prdOffZ.getofferviewAll[i].mediaurl1!)))
                                                                                                // HtmlWidget(
                                                                                                //   '''<video width="300" height="700" controls preview>
                                                                                                //                          <source src="${prdOffZ.getofferviewAll[i].mediaurl1!}" type="video/mp4">
                                                                                                //                          </video>''',
                                                                                                // ),
                                                                                                ),
                                                                                          ],
                                                                                        )
                                                                                ],
                                                                              )
                                                                            : Row(
                                                                                children: [
                                                                                  prdOffZ.getofferviewAll[i].mediaurl1!.isNotEmpty
                                                                                      ? InkWell(
                                                                                          onTap: () {
                                                                                            final remoteImages = [
                                                                                              Image.network(prdOffZ.getofferviewAll[i].mediaurl1.toString()),
                                                                                              Image.network(prdOffZ.getofferviewAll[i].mediaurl2.toString()),
                                                                                            ];
                                                                                            SwipeImageGallery(
                                                                                              context: context,
                                                                                              children: remoteImages,
                                                                                              onSwipe: (index) {
                                                                                                print("Swiped");
                                                                                                // overlayController.add(OverlayExample(
                                                                                                //   title: '${index + 1}/${remoteImages.length}',
                                                                                                // ));
                                                                                              },
                                                                                              overlayController: overlayController,
                                                                                              // initialOverlay: OverlayExample(
                                                                                              //   title: '1/${remoteImages.length}',
                                                                                              // ),
                                                                                            ).show();
                                                                                          },
                                                                                          child: Container(
                                                                                            padding: EdgeInsets.all(2),
                                                                                            child: Container(
                                                                                                height: Screens.bodyheight(context) * 0.2,
                                                                                                width: prdOffZ.getofferviewAll[i].mediaurl2!.isEmpty ? Screens.width(context) * 0.9 : Screens.width(context) * 0.40,
                                                                                                decoration: BoxDecoration(
                                                                                                    // color: Colors.pink,
                                                                                                    image: DecorationImage(image: NetworkImage(prdOffZ.getofferviewAll[i].mediaurl1.toString()), fit: BoxFit.fitHeight))),
                                                                                          ),
                                                                                        )
                                                                                      : Container(),
                                                                                  prdOffZ.getofferviewAll[i].mediaurl2!.isNotEmpty
                                                                                      ? InkWell(
                                                                                          onTap: () {
                                                                                            final remoteImages = [
                                                                                              Image.network(prdOffZ.getofferviewAll[i].mediaurl2.toString()),
                                                                                              Image.network(prdOffZ.getofferviewAll[i].mediaurl1.toString()),
                                                                                            ];
                                                                                            SwipeImageGallery(
                                                                                              context: context,
                                                                                              children: remoteImages,
                                                                                              onSwipe: (index) {
                                                                                                print("Swiped");
                                                                                                // overlayController.add(OverlayExample(
                                                                                                //   title: '${index + 1}/${remoteImages.length}',
                                                                                                // ));
                                                                                              },
                                                                                              overlayController: overlayController,
                                                                                              // initialOverlay: OverlayExample(
                                                                                              //   title: '1/${remoteImages.length}',
                                                                                              // ),
                                                                                            ).show();
                                                                                          },
                                                                                          child: Container(
                                                                                            // color: Colors.amber,

                                                                                            padding: EdgeInsets.all(2),
                                                                                            child: Container(height: Screens.bodyheight(context) * 0.2, width: prdOffZ.getofferviewAll[i].mediaurl1!.isEmpty ? Screens.width(context) * 0.9 : Screens.width(context) * 0.40, decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(prdOffZ.getofferviewAll[i].mediaurl2.toString()), fit: BoxFit.fitHeight))),
                                                                                          ),
                                                                                        )
                                                                                      : Container(),
                                                                                ],
                                                                              ),
                                                                    Container(
                                                                      height: Screens.bodyheight(
                                                                              context) *
                                                                          0.05,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              2),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width: Screens
                                                                          .width(
                                                                              context),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        color: themes
                                                                            .primaryColor,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.01),
                                                                            width:
                                                                                Screens.width(context) * 0.55,
                                                                            //s color: Colors.blue,
                                                                            child:
                                                                                Text(
                                                                              "Offer valid till ${config2.alignDate("${prdOffZ.getofferviewAll[i].validTill}")}",
                                                                              style: themes.textTheme.bodyText1?.copyWith(color: Colors.white),
                                                                            ),
                                                                          ),
//                                                                           Container(
//                                                                             alignment:
//                                                                                 Alignment.centerRight,
//                                                                             padding:
//                                                                                 EdgeInsets.symmetric(horizontal: Screens.padingHeight(context) * 0.02),
//                                                                             width:
//                                                                                 Screens.width(context) * 0.4,
//                                                                             //color: Colors.green,
//                                                                             child:
//                                                                             //     IconButton(
//                                                                             // onPressed: (){

//                                                                             // },
//                                                                           InkWell(
//                                                                             onTap: (){
//                                                                               setState((){
//  prdOffZ . sharefiles(prdOffZ.getofferviewAll[i].mediaurl1.toString(),prdOffZ.getofferviewAll[i].mediaurl2.toString(),prdOffZ.getofferviewAll[i].offerDetails) ;
//                                                                               });
//                                                                            },
//                                                                             child: Icon(Icons.share)),
//                                                                             //  ),
//                                                                           ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ))));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                  );
                });
              }),
        ));
  }
}
