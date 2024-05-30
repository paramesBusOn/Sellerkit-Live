// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/challengeController/ChallengeController.dart';
import 'package:sellerkit/Pages/Challenges/Screens/Challengedesc.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../Constant/Configuration.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Models/ChallengeModel/challengemodel.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/SearchWidgets.dart';

class Challenges extends StatefulWidget {
  const Challenges({Key? key}) : super(key: key);

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    
     final theme = Theme.of(context);
 Config config2 =  Config();
    
    return ChangeNotifierProvider<challengeController>(
      create: (context) => challengeController(),
      builder: (context, child) {
        return Consumer<challengeController>(
            builder: (BuildContext context, challegeCon, Widget? child) {
          return Scaffold(        drawerEnableOpenDragGesture: false,

              key: scaffoldKey,
              drawer: drawer3(context),
              appBar: appbar("Challenges", scaffoldKey, theme, context),
              body: Container(
                padding: paddings.padding2(context),
                child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
                  child: Column(
                    children: [
                      SearchWidget(themes: theme),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: challegeCon.getchallengedatadetails.length,
                          itemBuilder: (BuildContext context, int i) {
                            final ChallengeData challengeData =
                            challegeCon.getchallengedatadetails[i];
                            return AnimationConfiguration.staggeredList(
                                position: i,
                                duration: const Duration(milliseconds: 400),
                                child: SlideAnimation(
                                    verticalOffset: 100.0,
                                    child: FlipAnimation(
                                      child: InkWell(
                                        onDoubleTap: (){
                                                  // log("ONTAPP"+challengeData.challengeproductlist![i].id.toString());
                                                   showDialog(
                                            context: context,
                                            builder: (_) =>
                                            challengedesc(
                                                    pardata: challegeCon.getchallengedatadetails[i],
                                                    // i: i,
                                                    )
                                            );
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                
                                                },
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // color: Colors.red,
                                            ),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      left: Screens.width(context) *
                                                          0.01,
                                                      right: Screens.width(context) *
                                                          0.01,
                                                      top: Screens.bodyheight(
                                                              context) *
                                                          0.001,
                                                      bottom: Screens.bodyheight(
                                                              context) *
                                                          0.001,
                                                    ),
                                                    width: Screens.width(context),
                                                    //color: Colors.red,
                                                    child: Text(
                                                      "${challegeCon.getchallengedatadetails[i].code}",
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      Screens.bodyheight(context) *
                                                          0.01,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: Screens.width(context) *
                                                        0.01,
                                                    right: Screens.width(context) *
                                                        0.01,
                                                    top: Screens.bodyheight(
                                                            context) *
                                                        0.001,
                                                    bottom: Screens.bodyheight(
                                                            context) *
                                                        0.001,
                                                  ),
                                                  width: Screens.width(context),
                                                  //  color: Colors.red,
                                                  child: Text(
                                                      "${challegeCon.getchallengedatadetails[i].description}"),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            Screens.width(context) *
                                                                0.1),
                                                    child: Divider(
                                                      color: Colors.grey[300],
                                                      thickness: 1,
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: Screens.width(
                                                                  context) *
                                                              0.02),
                                                      width:
                                                          Screens.width(context) *
                                                              0.4,
                                                      //  color: Colors.blue,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("From Date"),
                                                          Text("${config2.alignDate(challegeCon.getchallengedatadetails[i].fromdate.toString())}",style: theme.textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey),),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: Screens.width(
                                                                  context) *
                                                              0.02),
                                                      width:
                                                          Screens.width(context) *
                                                              0.4,
                                                      //color: Colors.green,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("To Date"),
                                                          Text("${config2.alignDate(challegeCon.getchallengedatadetails[i].todate.toString())}",style: theme.textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey),),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      Screens.bodyheight(context) *
                                                          0.01,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  // alignment: Alignment.center,
                                                  width: Screens.width(context),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10)),
                                                    color: theme.primaryColor,
                                                  ),
                                                  child: Text(
                                                    "Created on:${config2.alignDate(challegeCon.getchallengedatadetails[i].createdon.toString())}",
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        ?.copyWith(
                                                            color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
      },
    );
  }


}
