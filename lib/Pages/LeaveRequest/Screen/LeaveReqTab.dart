
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/LeaveReqController/LeaveReqController.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import 'package:sellerkit/Widgets/Navi3.dart';

class leaveReqtab extends StatefulWidget {
  const leaveReqtab({Key? key}) : super(key: key);

  @override
  State<leaveReqtab> createState() => _leaveReqtabState();
}

class _leaveReqtabState extends State<leaveReqtab> {
   final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();
  // Paddings paddings = Paddings();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<LeaveReqContoller>().init(context);
      });
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
         drawerEnableOpenDragGesture: false,
            resizeToAvoidBottomInset: false,
            // key: scaffoldKey2,
     drawer: drawer3(context),
     body: context
                              .watch<LeaveReqContoller>()
                              .isapiloading==true &&context
                              .watch<LeaveReqContoller>()
                              .Errormsg.isEmpty ?Center(child: CircularProgressIndicator(),):
    
                            
     context
                              .watch<LeaveReqContoller>()
                              .isapiloading==false &&context
                              .watch<LeaveReqContoller>()
                              .Errormsg.isNotEmpty  
                              ?Center(child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    context.watch<LeaveReqContoller>().lottie!.isEmpty?Container():
                                context.watch<LeaveReqContoller>().lottie!.isNotEmpty && context.watch<LeaveReqContoller>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<LeaveReqContoller>().lottie}',
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
                  ):              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('${context.watch<LeaveReqContoller>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                                  Text("${context
                                  .watch<LeaveReqContoller>()
                                  .Errormsg}",textAlign: TextAlign.center,),
                                ],
                              ),):
                                   Column(
                                     children: [
                                       Expanded(
                        child: ListView.builder(
                          itemCount: context
                              .watch<LeaveReqContoller>()
                              .getallleavereqdetails
                              .length,
                          //  prdACC
                          //     .getAccountsDataFilter
                          //     .length,
                          // prdACC.getAccountsData.length,
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                                // onTap: () {
                                //   context
                                //       .read<LeaveReqContoller>()
                                //       .setReqData(context
                                //           .read<LeaveReqContoller>()
                                //           .getallleavereqdetails[i]);
                                //   // AccountsDetailsState
                                //   //         .data =
                                //   //     "Balamurugan";
                                //   Get.toNamed(ConstantRoutes.leaveApprove);
                                // },
                                
                              child: Column(
                                children: [
                                  SizedBox(
                                height: Screens.padingHeight(context)*0.01,
                              ),
                                  Container(
                                        // color: Colors.amber,
                                        width: Screens.width(context),
                                                          padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical: Screens.bodyheight(context) * 0.001
                                  ),
                                  child: Container(
                                          
                                                            padding: EdgeInsets.symmetric(
                                        horizontal: Screens.width(context) * 0.02,
                                        vertical: Screens.bodyheight(context) * 0.01
                                        ),
                                        decoration: BoxDecoration(
    // color: Colors.red,
     color: Colors.grey[200],
     border: Border.all(color: Colors.black26),
     borderRadius: BorderRadius.circular(8)
                                        ),
                            
                                                            width: Screens.width(context),
                                                            child: Column(children: [
                                  Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           Container(
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Name",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "User Code",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color: Colors.grey),
                                              ),
                                            ),
                            
                                  ],),
                                                           //2nd
                                                           Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           Container(
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${ConstantValues.firstName}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color: theme.primaryColor),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.read<LeaveReqContoller>().getallleavereqdetails[i].slpcode}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color:theme.primaryColor),
                                              ),
                                            ),
                            
                                  ],),
                                  SizedBox(
                                        height: Screens.padingHeight(context)*0.01,
                                  ),
                                                            Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           Container(
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Leave Req Type",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Date",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color: Colors.grey),
                                              ),
                                            ),
                            
                                  ],),
                                                          
                                                          Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           Container(
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.read<LeaveReqContoller>().getallleavereqdetails[i].leaveRequestType}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color: theme.primaryColor),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: Screens.width(context) * 0.45,
                                              child: Text(
                                                "${context.read<LeaveReqContoller>().config.alignDate(context.read<LeaveReqContoller>().getallleavereqdetails[i].startDate.toString()) }",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(color:theme.primaryColor),
                                              ),
                                            ),
                            
                                  ],),
    SizedBox(
                                        height: Screens.padingHeight(context)*0.01,
                                  ),
                                         Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          //  Container(
                                          //     width: Screens.width(context) * 0.4,
                                          //     child: Text(
                                          //       "${context.read<LeaveReqContoller>().getallleavereqdetails[i].leaveRequestType}",
                                          //       style: theme.textTheme.bodyText2
                                          //           ?.copyWith(color: theme.primaryColor),
                                          //     ),
                                          //   ),
                                            Container(
                                            alignment: Alignment.centerRight,
                                            // color: Colors.green[200],
                                            width: Screens.width(context) * 0.3,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: Screens.width(context) * 0.02,
                                                right: Screens.width(context) * 0.02,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green[200],
                                                borderRadius: BorderRadius.circular(4)
                                              ),
                                           // width: Screens.width(context) * 0.1,
                                              child:context.watch<LeaveReqContoller>().getallleavereqdetails[i].status ==0?
                                              Text("Requested"):
                                              context.watch<LeaveReqContoller>().getallleavereqdetails[i].status ==1?
                                               Text(
                                                  "Approved",
                                                  style: theme.textTheme.bodyText2?.copyWith(
                                                      color: Colors.green[700],
                                                      fontSize: 12
                                                     // fontWeight: FontWeight.bold
                                                      )
                                                      ): context.watch<LeaveReqContoller>().getallleavereqdetails[i].status == -1?
                                                      Text(
                                                  "Rejected",
                                                  style: theme.textTheme.bodyText2?.copyWith(
                                                      color: Colors.green[700],
                                                      fontSize: 12
                                                     // fontWeight: FontWeight.bold
                                                      )
                                                      ):Text('')
                                            ),
                                          )
                            
                                  ],),
                                                            ],),
                            
                                  ),
                                  ),
                                ],
                              ),
                            );
                            
                           
                          },
                        ),
                      ),
                                     ],
                                   ),
            appBar: AppBar(
                backgroundColor: theme.primaryColor,
                title: Text('Leave Request'),
              ),
         floatingActionButton: FloatingActionButton(
            onPressed: () {
               context.read<LeaveReqContoller>().getuserdetails(context);
              Get.toNamed(ConstantRoutes.leaveReq)!.then((value) {});
            },
            child: Icon(Icons.add),
          ),
      ),
    );
  }
}