import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OutStandingController/OutStandingController.dart';
import 'package:sellerkit/Pages/Outstanding/Screens/filterScreen.dart';
import 'package:sellerkit/Pages/Outstanding/Screens/filterScreen2.dart';
import 'package:sellerkit/Pages/Outstanding/widgets/Followdialog.dart';
import 'package:sellerkit/Pages/Outstanding/widgets/navDrawer.dart';
import 'package:sellerkit/Widgets/Navi3.dart';

class OutStandingPage extends StatefulWidget {
  const OutStandingPage({Key? key}) : super(key: key);

  @override
  State<OutStandingPage> createState() => OutStandingPageState();
}

class OutStandingPageState extends State<OutStandingPage> {
  DateTime? currentBackPressTime;
    static bool iscomfromLead = false;
   final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
    @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
 setState(() {
  context.read<Outstandingcontroller>().clearalldata();
  if (iscomfromLead == false){
    setState(() {
      context.read<Outstandingcontroller>().clearalldata();
   context.read<Outstandingcontroller>(). GetAllOutstandingscall();
    });
  
  }
     
  else if (iscomfromLead == true) {
          log("ANBU::");
           setState(() {
  context.read<Outstandingcontroller>().clearalldata();
          context.read<Outstandingcontroller>().comefromAcc();

          iscomfromLead = false;
    });
          
        }
    });
    
    });
   
   
    super.initState();
  }
  bool isdrawer=false;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
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
      onWillPop:onbackpress,
      child: Scaffold(
        key: scaffoldKey1,
        // backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Text('Outstanding'),
          actions: [
            IconButton(
              color:Colors.transparent,
              onPressed: (){}, icon: Icon(Icons.filter_alt))
          ],
          // automaticallyImplyLeading:false,

        ),
        drawer:drawer3(context)
        ,
        endDrawer: navDrawer(),
        body:
        GestureDetector(
          onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
          child: context.watch<Outstandingcontroller>().errormsg==''&&context.watch<Outstandingcontroller>().valueDBmodel.isEmpty&& context.watch<Outstandingcontroller>().apiloading==true
        
          
          ?Center(child: CircularProgressIndicator(),):
          context.watch<Outstandingcontroller>().errormsg !='' &&
          context.watch<Outstandingcontroller>().apiloading==false&&
          
          context.watch<Outstandingcontroller>().valueDBmodel.isEmpty
          ? Center(child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
               context.watch<Outstandingcontroller>().lottie!.isEmpty?Container():
                                context.watch<Outstandingcontroller>().lottie!.isNotEmpty && context.watch<Outstandingcontroller>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<Outstandingcontroller>().lottie}',
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
                    child: Lottie.asset('${context.watch<Outstandingcontroller>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
              Text("${context.read<Outstandingcontroller>().errormsg}",textAlign: TextAlign.center,),
            ],
          ),):
          
           Column(
            //  physics: new NeverScrollableScrollPhysics(),
            //   controller: context.read<Outstandingcontroller>().pageController,
            //   onPageChanged: (index){
            //      setState(() {
            //     context.read<Outstandingcontroller>().pageChanged = index;
            //   });
            //   print(context.read<Outstandingcontroller>().pageChanged);
            //   },
            children: [
           Container(
            width: Screens.width(context),
            height: Screens.padingHeight(context)*0.9,
            // color: Colors.amber,
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
                vertical: Screens.bodyheight(context) * 0.02),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.01,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.02),
                  decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black26)),
                  width: Screens.width(context),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text(
                            "Total Outstanding",
                            style: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor,fontSize: 15),
                          ),
                        ),
                        Container(
                          child: Text(
                            "₹ ${Config.k_m_b_generator22(context.read<Outstandingcontroller>().totaloutstanding!.toString())}",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText1?.copyWith(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Overdue",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color:theme.primaryColor,fontSize: 15),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Upcoming",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: theme.primaryColor,fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "₹ ${Config.k_m_b_generator22(context.read<Outstandingcontroller>().overdue!.toString())}",
                                style: theme.textTheme.bodyText1?.copyWith(),
                              ),
                            ),
                            Container(
                              child: Text(
                                "₹ ${Config.k_m_b_generator22(context.read<Outstandingcontroller>().upcoming!.toString())}",
                                style: theme.textTheme.bodyText1?.copyWith(),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.008,
                ),
             context.read<Outstandingcontroller>().valueDBmodel!.isEmpty?
             Center(
              
              child:Column(
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
                 Text("No Outstanding..!!",textAlign: TextAlign.center,),
               ],
             )):
                Expanded(
                  child: ListView.builder(
                      itemCount:context.read<Outstandingcontroller>().valueDBmodel.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onDoubleTap: (){
                            setState(() {
                             context.read<Outstandingcontroller>().        clearontap();
                             context.read<Outstandingcontroller>().     ontapkpicall(context.read<Outstandingcontroller>().valueDBmodel[i].customerCode!);
                        
                            context.read<Outstandingcontroller>().   onDoubletap(context.read<Outstandingcontroller>().valueDBmodel[i].customerCode);
                            
                            });
                        //  context.read<Outstandingcontroller>().     ontapkpicall(context.read<Outstandingcontroller>().valueDBmodel[i].customerCode!);
                        //  context.read<Outstandingcontroller>().   onDoubletap(context.read<Outstandingcontroller>().valueDBmodel[i].customerCode);
                            showDialog<dynamic>(context: context, builder: (_){
                              return Followdialog(outstandingModel:context.read<Outstandingcontroller>().valueDBmodel[i]);
        
                            }).then((value){
                              //  context.read<Outstandingcontroller>().getdbmodel();
        
                            });
        
                          },
                          onLongPress: (){
                            setState(() {
                             context.read<Outstandingcontroller>().        clearontap();
                             context.read<Outstandingcontroller>().     ontapkpicall(context.read<Outstandingcontroller>().valueDBmodel[i].customerCode!);
                        
                            context.read<Outstandingcontroller>().   onDoubletap(context.read<Outstandingcontroller>().valueDBmodel[i].customerCode);
                            
                            });
                      
                            showDialog<dynamic>(context: context, builder: (_){
                              return Followdialog(outstandingModel:context.read<Outstandingcontroller>().valueDBmodel[i]);
        
                            }).then((value){
                              //  context.read<Outstandingcontroller>().getdbmodel();
        
                            });
        
                          },
                          child: Container(
                            // color: Colors.amber,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.01,
                                vertical: Screens.padingHeight(context) * 0.004),
                            child: Container(
                              width: Screens.width(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.03,
                                  vertical: Screens.bodyheight(context) * 0.008),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black26)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Customer Code",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Total Outstanding",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "${context.read<Outstandingcontroller>().valueDBmodel[i].customerCode}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: theme.primaryColor),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${context
                                                            .read<
                                                                Outstandingcontroller>()
                                                            .config.slpitCurrency22(context.read<Outstandingcontroller>().valueDBmodel[i].balanceToPay!.toString()) }",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: theme.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Customer Name",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Amount Paid",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "${context.read<Outstandingcontroller>().valueDBmodel[i].customerName}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: theme.primaryColor),
                                        ),
                                      ),
                                       Container(
                                        child: Text(
                                          "${context
                                                            .read<
                                                                Outstandingcontroller>()
                                                            .config.slpitCurrency22(context.read<Outstandingcontroller>().valueDBmodel[i].amountPaid!.toString())}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: theme.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Trans Amount",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "${context
                                                            .read<
                                                                Outstandingcontroller>()
                                                            .config.slpitCurrency22(context.read<Outstandingcontroller>().valueDBmodel[i].transAmount!.toString())}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: theme.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
              //  FilterScreen(), 
            ],
          ),
        )
        ,
       

        floatingActionButton: FloatingActionButton(
          onPressed: (){
          // setState(() {
          //  widget. isdrawer=true;
          // widget.  scaffoldKey.currentState?.openEndDrawer();
          //  log("ANBU");

          // });
          setState(() {
             context.read<Outstandingcontroller>().  clearfilterval();
             context.read<Outstandingcontroller>(). getdbmodel();
            scaffoldKey1.currentState?.openEndDrawer();
           
          //  context.read<Outstandingcontroller>().firstPageNextBtn();
          });
        
        },
          child: Icon(Icons.filter_alt),
        ),
      ),
    );
  }

  
}

// class FirstPage extends StatefulWidget {
//    FirstPage({
//     Key? key,required this.isdrawer,
//     required this.theme,required this.scaffoldKey
//   }) : super(key: key);

//   final ThemeData theme;
//   bool isdrawer;
//    final GlobalKey<ScaffoldState> scaffoldKey;

//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//     // Stack(
//     //   children: [
        
      
    
//   }
// }
