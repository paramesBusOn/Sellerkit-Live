// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'dart:io';
// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Pages/Dashboard/Screens/CurentFeedPage.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import 'NewFeedContainer.dart';

class FeedsPage extends StatefulWidget {
  FeedsPage({Key? key, required this.pvdDSBD}) : super(key: key);
  DashBoardController pvdDSBD;
  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
  Paddings paddings = Paddings();
  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
           insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(0),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Are you sure?"),
            // content: Text("Do you want to exit?"),
            content: Container(
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                     width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text(
                  "Alert",style: TextStyle(fontSize: 15)
                )),
                  ),
                   
                  SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
                 Container(
                      padding: EdgeInsets.only(left:40),
                  width: Screens.width(context)*0.85,
                  child: Divider(color: Colors.grey,)),
                  Container(
                     alignment: Alignment.center,
                    // width: Screens.width(context)*0.5,
                    // padding: EdgeInsets.only(left:20),
                    child: Text("Are you sure",style: TextStyle(fontSize: 15),)),
                   SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
                Container(
                  alignment: Alignment.center,
                    // padding: EdgeInsets.only(left:20),
                  child: Text("Do you want to exit?",style: TextStyle(fontSize: 15))),
              Container(
                  padding: EdgeInsets.only(left:40),
                  width: Screens.width(context)*0.85,
                  child: Divider(color: Colors.grey)),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                     Container(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                  )),
                            ),
                           onPressed: () {
                       exit(0);
                      },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Container(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                  )),
                            ),
                             onPressed: () {
                            setState(() {
                             
                         Navigator.of(context).pop(false);
                       
                            });
                        // context.read<EnquiryUserContoller>().checkDialogCon();
                        
                         
                      },
                          
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                  
                  ],
                ),
              
                ],
              ),
            ),
            // actions: [
            //   TextButton(
            //     onPressed: () => Navigator.of(context).pop(false),
            //     child: Text("No"),
            //   ),
            //   TextButton(
            //       onPressed: () {
            //         exit(0);
            //       },
            //       child: Text("yes"))
            // ],
          ),
        )) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return widget.pvdDSBD.searchfeedfilter.isEmpty?Center(
                                          child: Column(
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
                                              Text("No data..!!",),
                                            ],
                                          )
                                          // CircularProgressIndicator(),
                                        ): Stack(
      children: [
        Container(
          width: Screens.width(context),
          height: Screens.bodyheight(context),
          // padding: paddings.padding3(context),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: (){
                   return  widget.pvdDSBD.refreshFeeds();
                  },
                  child: GestureDetector( onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        onWillPop();
                      });
                    }
                  },
                    child: ListView.builder(
                      itemCount: widget.pvdDSBD.searchfeedfilter.length,
                      //widget.pvdDSBD.feedData.length,
                      itemBuilder: (BuildContext context, int i) {
                        return
                           
                  
                            // FeedContainerNew  CurrentFeedContainer
                            FeedContainerNew(
                              feedData: widget.pvdDSBD.searchfeedfilter[i],
                              // widget.pvdDSBD.feedData[i],
                              pvdDSBD: widget.pvdDSBD,
                              selected: '\u{1F44D}',
                              );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

            Visibility(
              visible: widget.pvdDSBD.getreactionvisible,
              child: Container(
                alignment: Alignment.center,
                width:  Screens.width(context),
                height: Screens.fullHeight(context),
                child: Lottie.asset("Assets/91069-like.json",
                 animate: true,
                 repeat: true,
                 height: Screens.fullHeight(context),
                 width: Screens.width(context) ),
              ),
            )
      ],
    );
  }
}
