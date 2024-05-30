// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/SiteInController/newcreatesitein.dart';

import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/SiteInController/SiteInController.dart';
import '../../../Controller/SiteInController/SiteInController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/NewSiteIn.dart';

class SiteInPage extends StatefulWidget {
  const SiteInPage({Key? key}) : super(key: key);

  @override
  State<SiteInPage> createState() => _SiteInPageState();
}

class _SiteInPageState extends State<SiteInPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<SiteInController>().gesiteindata(context);
      // context.read<SiteInController>().clearAll();
      
      context.read<SiteInController>().init(context);
    });
  }
 void _handleTabChange() {
  setState(() {
    context.read<SiteInController>().mycontroller[12].text='';  
   context.read<SiteInController>().setListData();
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

  @override
  Widget build(BuildContext context) {
    Config config=Config();
    final theme = Theme.of(context);
    return WillPopScope(
        onWillPop: onbackpress,
        child: Scaffold(       drawerEnableOpenDragGesture: false,

          key: scaffoldKey,
          drawer: drawer3(context),
          appBar: appbar("Site Check-In", scaffoldKey,theme, context),
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
            child: Container(
              //color: Colors.red,
              width: Screens.width(context),
              height: Screens.bodyheight(context),
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.03,
                  vertical: Screens.bodyheight(context) * 0.02),
              child: Column(
                children: [
                 
                  InkWell(
                    onTap: () async {
                      // context.read<SiteInController>().source1 =
                      //     // await widget.prdsrch.
                      //     await context.read<SiteInController>().getPathOFDB();
                      // context.read<SiteInController>().copyTo = await
                      //     //  widget.prdsrch.
                      //     context.read<SiteInController>().getDirectory();
              
                      // bool permission = await context
                      //     .read<SiteInController>()
                      //     .getPermissionStorage();
                      // if (permission == true) {
                      //   if ((await context
                      //       .read<SiteInController>()
                      //       .copyTo!
                      //       .exists())) {
                      //     print("EXISTS");
                      //     // widget.prdsrch
                      //     context.read<SiteInController>().createDBFile(
                      //         context.read<SiteInController>().copyTo!.path);
                      //   } else {
                      //     print("Not EXISTS");
                      //     // widget.prdsrch.
                      //     context.read<SiteInController>().createDirectory();
                      //   }
                      // } else if (permission == false) {
                      //   context.read<SiteInController>().showSnackBars(
                      //       'Please give stoage permission to continue!!..',
                      //       Colors.red);
                      // }
                    },
                    child: Container(
                      height: Screens.bodyheight(context) * 0.05,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Upcoming Visit Plans",
                        style: theme.textTheme.headline6
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ),
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal: Screens.width(context)*0.02),
                     child: Container(
                               height: Screens.bodyheight(context) * 0.06,
                               
                               decoration: BoxDecoration(
                                 color: theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
                                 borderRadius:
                                     BorderRadius.circular(Screens.width(context) * 0.02),
                               ),
                               child: TextField(
                                 autocorrect: false,
                                 onChanged: (val) {
                                   context.read<SiteInController>().searchfilter(val);
                                 },
                                 controller: context.read<SiteInController>().mycontroller[12],
                                 decoration: InputDecoration(
                                   filled: false,
                                   hintText: 'Search Here!!..',
                                   enabledBorder: InputBorder.none,
                                   focusedBorder: InputBorder.none,
                                   suffixIcon: IconButton(
                                     icon: const Icon(Icons.search),
                                     onPressed: () {
                      // FocusScopeNode focus = FocusScope.of(context);
                      // if (!focus.hasPrimaryFocus) {
                      //   focus.unfocus();
                      // }
                      // context.read<LeadNewController>().changeVisible();
                                     }, //
                                     color: theme.primaryColor,
                                   ),
                                   contentPadding: const EdgeInsets.symmetric(
                                     vertical: 11,
                                     horizontal: 10,
                                   ),
                                 ),
                               ),
                             ),
                   ),
                  Expanded(
          
                    child:
                    context.watch<SiteInController>().isloading ==true &&
                    context.watch<SiteInController>().errortabMsg.isEmpty &&
                    context.watch<SiteInController>().filteropenVisitData.isEmpty
                    ?Center(child: CircularProgressIndicator(),) :
                context.watch<SiteInController>().isloading ==false&&  
                 context.watch<SiteInController>().errortabMsg.isEmpty&&
                  context.watch<SiteInController>().filteropenVisitData.isEmpty?
          
               Center(
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
                          Text(
                              "No Data..!!",textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ):
                    
                    
                    context.watch<SiteInController>().isloading ==false &&
                    context.watch<SiteInController>().errortabMsg.isNotEmpty &&
                    context.watch<SiteInController>().filteropenVisitData.isEmpty
                    ?Center(child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                                        
                      children: [
                          context.watch<SiteInController>().lottie!.isEmpty?Container():
                                context.watch<SiteInController>().lottie!.isNotEmpty && context.watch<SiteInController>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<SiteInController>().lottie}',
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
                    child: Lottie.asset('${context.watch<SiteInController>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                        Text("${context.watch<SiteInController>().errortabMsg}",textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),
                      ],
                    ),)
                   : ListView.builder(
                      itemCount:
                          context.watch<SiteInController>().filteropenVisitData.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () {
                            context.read<SiteInController>().selectedOpenVisits(
                                context
                                    .read<SiteInController>()
                                    .filteropenVisitData[i]);
                            Get.toNamed(ConstantRoutes.newsitein);
                          },
                          onLongPress: () {},
                          child: Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.bodyheight(context) * 0.01),
                            child: Container(
                             
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical: Screens.bodyheight(context) * 0.01),
                                   decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black26)
                          ),
                              width: Screens.width(context),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                          "Customer",
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                          "Date & Time",
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                            "${context.watch<SiteInController>().filteropenVisitData[i].customername}",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(
                                              color: theme.primaryColor,
                                              // fontWeight: FontWeight.bold
                                            )),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                            "${config.alignmeetingdate(context.watch<SiteInController>().filteropenVisitData[i].meetingtime.toString())}",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(
                                              color: theme.primaryColor,
                                              //fontWeight: FontWeight.bold
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                          "Purpose",
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                          "Area",
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          // color:Colors.red,
              
                                          alignment: Alignment.topLeft,
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                              "${context.watch<SiteInController>().filteropenVisitData[i].purposeofvisit!}",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: theme.primaryColor,
                                                //fontWeight: FontWeight.bold
                                              )),
                                        ),
                                        Container(
                                          // color:Colors.red,
                                          alignment: Alignment.topRight,
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                              "${context.watch<SiteInController>().filteropenVisitData[i].city!} ",
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: theme.primaryColor,
                                                //fontWeight: FontWeight.bold
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            //color: Colors.red,
                                            width: Screens.width(context) * 0.54,
                                            child: Text("Product",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                  color: Colors.grey,
                                                  // fontWeight: FontWeight.bold
                                                )),
                                          ),
                                     context.watch<SiteInController>().filteropenVisitData[i].LookingFor ==null||context.watch<SiteInController>().filteropenVisitData[i].LookingFor=='null'||context.watch<SiteInController>().filteropenVisitData[i].LookingFor!.isEmpty?Container():     Container(
                                            // color: Colors.red,
                                            alignment: Alignment.centerLeft,
                                            width: Screens.width(context) * 0.54,
                                            child: Text(
                                                "${context.watch<SiteInController>().filteropenVisitData[i].LookingFor!}",
                                                //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                  color: theme.primaryColor,
                                                  //fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        // color: Colors.green[200],
                                        width: Screens.width(context) * 0.3,
                                        child: Container(
                                          // padding: EdgeInsets.only(
                                          //   left: Screens.width(context) * 0.02,
                                          //   right: Screens.width(context) * 0.02,
                                          // ),
                                          decoration: BoxDecoration(
                                              color: Colors.green[200],
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          // width: Screens.width(context) * 0.1,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                Screens.width(context) * 0.01),
                                            child: Text(
                                                "${context.watch<SiteInController>().filteropenVisitData[i].visitstatus}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.green[700],
                                                        fontSize: 12
                                                        // fontWeight: FontWeight.bold
                                                        )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  // Container(
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: Screens.width(context) * 0.1),
                                  //     child: Divider(
                                  //       thickness: 1,
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
              context.read<SiteInController>().clearText();
               context.read<createSiteInController>().clearAll();
           
              });
              Get.toNamed(ConstantRoutes.newsitein);
            },
            child: IconButton(
                onPressed: () {
                  setState(() {
                   context.read<SiteInController>().clearText();
                  context.read<createSiteInController>().clearAll();
                  
                  });
                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewSiteIn(),
                                      ));
                                  
                  // Get.toNamed(ConstantRoutes.newsitein);
                },
                icon: Icon(Icons.add)),
          ),
        ));
  }
}
