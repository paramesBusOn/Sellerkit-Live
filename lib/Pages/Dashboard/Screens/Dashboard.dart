// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_field, prefer_final_fields, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Constant/LocationTrackIos.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/NotificationController/NotificationController.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import 'package:sellerkit/main.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import '../../../Widgets/Navi3.dart';
import 'Analytics.dart';
import 'FeedsPage.dart';
import 'KPIScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  Timer? timer;
  TabController? controller;

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 300)).then((_) async {
      await Provider.of<NotificationContoller>(context, listen: false);
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
     controller = new TabController(vsync: this, length: 3, initialIndex: 0);
     controller!.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
      context.read<DashBoardController>().mycontroller[0].clear();
      locationCheck();
    });
      checkLocation();
        context.read<DashBoardController>().init(context);
      // context.read<NotificationContoller>().getUnSeenNotify();
      // context.read<NotificationContoller>().onReciveFCM();
      // context.read<DashBoardController>().getDefaultValues();
      // context.read<DashBoardController>().callKpiApi();
      // context.read<DashBoardController>().callFeedsApi();
      //context.read<DashBoardController>().checkAuth();
      log(ConstantValues.sapUserType);
    });

    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => periodicTask());
   
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) => notify());
  }
void _handleTabChange() {
    setState(() {
     context.read<DashBoardController>().mycontroller[0].text ='';
    });
  }
  // periodicTask() {
  //   print("Bala do it");
  //   // controller!.animateTo((controller!.index + 1));
  //   //changepageauto();
  // }

  int color = 0;
  // notify() {
  //   if (color == 0) {
  //     setState(() {
  //       color = 1;
  //     });
  //   } else {
  //     setState(() {
  //       color = 0;
  //     });
  //   }
  // }

 @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  Future locationCheck() async {
    await Timer.periodic(Duration(minutes: 1), (timer) async {
      setState(() {

 if (Platform.isAndroid) {
     LocationTrack.determinePosition();
  } else {
     LocationTrack2.determinePosition();
  }      });
      
      // LocationPermission permission;
      // permission = await Geolocator.checkPermission();
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.best);
      // ConstantValues.latitude = position.latitude.toString();
      //       ConstantValues.langtitude = position.longitude.toString();
      //               print('lati' + ConstantValues.langtitude.toString());

      //   StreamSubscription<Position> positionStream =
      //       Geolocator.getPositionStream(locationSettings: locationSettings)
      //           .listen((Position? position) async {
      //     setState(() {
      //       ConstantValues.latitude = position!.latitude.toString();
      //       ConstantValues.langtitude = position.longitude.toString();
      //       print('lati1' + ConstantValues.langtitude.toString());
      //       print('long' + ConstantValues.latitude.toString());
      //     });
      //   });
      
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  var tabIndex = 0;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Feeds'),
    Tab(text: 'KPI'),
    Tab(text: 'Analytics'),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    // timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
        //  DefaultTabController(
        //   length: 3,
        //   initialIndex: tabIndex,
        //   child:
        WillPopScope(
      onWillPop: onWillPop, // context.read<DashBoardController>().onbackpress ,
      child: 
      // Consumer<DashBoardController>(
      //     builder: (BuildContext context, pvdDSBD, Widget? child) {
      //   return 
        Scaffold(
          drawerEnableOpenDragGesture: false,
      
          key: scaffoldKey,
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                       context 
                                          .read<DashBoardController>()
                                          .popupmenu(context);
                    });
                  },
                  icon: Icon(Icons.list))
              // PopupMenuButton<String>(
              //   onSelected: (value) {
              //     // Handle the selected option here
              //     print('Selected: $value');
              //   },
              //   itemBuilder: (BuildContext context) {
              //     return <PopupMenuEntry<String>>[
              //       PopupMenuItem<String>(
              //         value: 'option1',
              //         child: Text('${ConstantValues.latitude}'),
              //       ),
              //       PopupMenuItem<String>(
              //         value: 'option2',
              //         child: Text('${ConstantValues.langtitude}'),
              //       ),
              //       PopupMenuItem<String>(
              //         value: 'option3',
              //         child: Text('${ConstantValues.ipaddress}'),
              //       ),
              //       PopupMenuItem<String>(
              //         value: 'option3',
              //         child: Text('${ConstantValues.ipname}'),
              //       ),
              //     ];
              //   },
              // ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
               padding:
              //  controller!.index.toString()=="0"
              //  ?
                EdgeInsets.symmetric(
                    horizontal: Screens.bodyheight(context) * 0.02),
                    // :EdgeInsets.symmetric(
                    // horizontal: Screens.bodyheight(context) * 0.00),
                child: Column(
                  children: [
                  // controller!.index.toString()=="0"?
                    Container(
                      height: Screens.bodyheight(context) * 0.06,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              Screens.width(context) * 0.01),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: TextField(
                        controller: context.read<DashBoardController>().mycontroller[0],
                        onTap: () {
                          // Get.toNamed(ConstantRoutes.screenshot);
                        },
                        autocorrect: false,
                        onChanged: (v) {
                          if (v.length == 10) {
                              // context.read<DashBoardController>().     showdialog(context,context.read<DashBoardController>().customerdetails!,context.read<DashBoardController>().customerDatalist);
               
        context.read<DashBoardController>().getAllOutstandingscall();
                       context.read<DashBoardController>().callApi(context, context.read<DashBoardController>().mycontroller[0].text);
                          }
                          // context
                                                // .watch<DashBoardController>().SearchFilter(v);
      
                        
                        },
                        inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly,
                                      new LengthLimitingTextInputFormatter(
                                          10),
                                    ],
                                    keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Search',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: InkWell(
                            onTap: (){
                        //         context.read<DashBoardController>().showdialog(
                        // context,
                        // );
                                
                  
                            },
                            child: Icon(
                              Icons.search,
                              color: theme.primaryColor,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 5,
                          ),
                        ),
                      ),
                    ),
                  //   :Container( 
                  //     // child:  Text("ItemMaster length:${context
                                                // .watch<DashBoardController>().allProductDetails.length}"
                  // // ,style:TextStyle(color: Colors.white,)
                  // // )
                  // ),
                  //   SizedBox(
                  //     height:Screens.padingHeight(context)*0.01
                  //   ),
                  //  Container(
                  //   alignment:Alignment.centerLeft,
                  // child:  Text("ItemMaster length:${context
                                                // .watch<DashBoardController>().allProductDetails.length}"
                  // ,style:TextStyle(color: Colors.white,)
                  // )
                  //  ),
                   
                    TabBar(
                      controller: controller,
                      tabs: myTabs,
                    ),
                  ],
                ),
              ),
            ),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    // color: Colors.amber,
                        width: Screens.width(context) * 0.5,
                        // height: Screens.bodyheight(context) * 0.1,
                    child: Text(
                      'Hi, ${ConstantValues.firstName}',
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      style: theme.textTheme.subtitle1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed(ConstantRoutes.testing);
                      },
                      child: Container(
                        // color: Colors.amber,
                        width: Screens.width(context) * 0.12,
                        height: Screens.bodyheight(context) * 0.055,
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.white54,
                              size: Screens.bodyheight(context) * 0.05,
                            ),
                            Positioned(
                              // top: Screens.bodyheight(context)*0.005,
                              left: Screens.width(context) * 0.05,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: EdgeInsets.all(2),
                                child: Text(
                                  context
                                      .watch<NotificationContoller>()
                                      .getunSeenNotify
                                      .toString(),
                                  //"${context
                                                // .watch<DashBoardController>().getunSeenNotify}",
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(
                                          color: theme.primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          // orderAppBar(context,scaffoldKey,"Dashboard"),
          drawer: drawer3(context),
          body: GestureDetector(
            onTap: () {
              setState(() {
                FocusScope.of(context).unfocus();
              });
            },
            onHorizontalDragUpdate: (details) {
              // Check if the user is swiping from left to right
              print(details.primaryDelta);
              if (details.primaryDelta! > ConstantValues.slidevalue!) {
                setState(() {
                  onWillPop();
                });
              }
            },
            child: DashBoardController.isLogout == true
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: controller,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                        (context .watch<DashBoardController>().feedData.isNotEmpty &&
                                context .watch<DashBoardController>().feedsApiExcp == '' &&
                                context .watch<DashBoardController>().isloading == false)
                            ? FeedsPage(pvdDSBD: context .watch<DashBoardController>())
                            : (context .watch<DashBoardController>().feedData.isEmpty &&
                                    context.watch<DashBoardController>().feedsApiExcp != '' &&
                                    context.watch<DashBoardController>().isloading == false)
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
     context  .watch<DashBoardController>().lottiurl.isEmpty?Container():
                          context
                                                .watch<DashBoardController>().lottiurl.isNotEmpty && context
                                                .watch<DashBoardController>().lottiurl.contains(".png")?     InkWell(
              onTap: () {
                // HelperFunctions.clearCheckedOnBoardSharedPref();
                // HelperFunctions.clearUserLoggedInSharedPref();
              },
              child: Image.asset('${context
                                                .watch<DashBoardController>().lottiurl}',
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
              child: Lottie.asset('${context
                                                .watch<DashBoardController>().lottiurl}',
                  animate: true,
                  repeat: true,
                  // height: Screens.padingHeight(context) * 0.3,
                  width: Screens.width(context) * 0.4),
            ),
                                        Text(context
                                                .watch<DashBoardController>().feedsApiExcp,textAlign: TextAlign.center,),
                                      ],
                                    ))
  : Center(
                                        child: CircularProgressIndicator(),
                                      ),

                                (context
                                                .watch<DashBoardController>()
                                                .getNewKpiData2!
                                                .length <
                                            1 ||
                                        context
                                                .watch<DashBoardController>()
                                                .getNewKpiData2 ==
                                            null) &&
                                    context
                                            .watch<DashBoardController>()
                                            .KpiApiExcp ==
                                        "" &&
                                    context
                                        .watch<DashBoardController>()
                                        .kpilottie
                                        .isEmpty
                                ? Center(
                                    child: CircularProgressIndicator()
                                  )
                              
                                : context
                                                .watch<DashBoardController>()
                                                .getNewKpiData2!
                                                .length >
                                            0 ||
                                        context
                                            .watch<DashBoardController>()
                                            .getNewKpiData2!
                                            .isNotEmpty
                                    ? KPIScreen(
                                        color: color, kpiData:  context
                                            .watch<DashBoardController>()
                                            .getNewKpiData2!,
                                      )
                                    : ((context
                                                        .watch<
                                                            DashBoardController>()
                                                        .getNewKpiData2!
                                                        .length <
                                                    1 ||
                                                context
                                                    .watch<
                                                        DashBoardController>()
                                                    .getNewKpiData2!
                                                    .isEmpty) &&
                                            context
                                                .watch<DashBoardController>()
                                                .KpiApiExcp
                                                .isNotEmpty)? Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                     
                                  children: [
      
                                     context
                                                .watch<DashBoardController>().kpilottie.isNotEmpty?               InkWell(
              onTap: () {
                // HelperFunctions.clearCheckedOnBoardSharedPref();
                // HelperFunctions.clearUserLoggedInSharedPref();
              },
              child: Lottie.asset('${context
                                                .watch<DashBoardController>().kpilottie}',
                  animate: true,
                  repeat: true,
                  // height: Screens.padingHeight(context) * 0.3,
                  width: Screens.width(context) * 0.4),
            ):Container(),
                                    Text(context
                                                .watch<DashBoardController>().KpiApiExcp,textAlign: TextAlign.center,),
                                  ],
                                ))
                                : Center(
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
                                  ),
                        AnalyticsPage(
                          data21:
                              context.read<DashBoardController>().data21,
                          dataMap:
                              context.read<DashBoardController>().dataMap,
                        )
                      ]),
          ),
          //   });
          // }),
      
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.add,
          //   ),
          //   onPressed: (){
          //       Get.toNamed(ConstantRoutes.feedsCreation);
          // }),
        )
     
     
      // }),
    );
  }

  changepageauto() {
    if (controller!.index == 0) {
      controller!.animateTo((controller!.index + 1));
    } else if (controller!.index == 1) {
      controller!.animateTo((controller!.index + 1));
    } else if (controller!.index == 2) {
      controller!.animateTo((controller!.index - 2));
    }
  }

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
}
class NewWidget extends StatefulWidget {
   NewWidget({Key? key,required this.customerdata,required this.customerDatalist}): super(key: key);


  @override
  List<GetCustomerData>? customerdata;
  List<GetenquiryData>? customerDatalist;
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return 
    
                 context.watch<DashBoardController>(). customerapicLoading==true
                 
                 ?
                 LoadingPage(context)
                :  
              //   context.watch<DashBoardController>(). customerapicLoading==false &&
              //  widget.customerdata!.isEmpty 
              //   ?
                
              //   NodataPage(context):
                viewDefault(context, theme,widget.customerdata!,widget.customerDatalist);
  }

Container LoadingPage(BuildContext context) {
    return Container(
        width: Screens.width(context) * 0.9,
        height: Screens.bodyheight(context) * 0.3,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ));
  }
  
Container NodataPage(BuildContext context) {
    return Container(
        width: Screens.width(context) * 0.9,
        height: Screens.bodyheight(context) * 0.3,
        child: Center(
          child: Text("No data..!!")
        ));
  }

  SizedBox viewDefault(BuildContext context, ThemeData theme,List<GetCustomerData> customerdata,List<GetenquiryData>? customerDatalist) {
    Config config = Config();
    // context.read<DashBoardController>().refershAfterClosedialog();
    return SizedBox(
      width: Screens.width(context),
      // height: Screens.bodyheight(context),

      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: Screens.width(context),
                height: Screens.padingHeight(context) * 0.06,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      alignment: Alignment.center,
                      child: Text("View Details",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white)),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 18,
                    )
                  ],
                )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 customerdata!.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : 
                      Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.01,
                              vertical: Screens.bodyheight(context) * 0.008),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: IntrinsicHeight(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.45,
                                  // height:Screens.padingHeight(context)*0.2 ,
                                  // color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.03,
                                        child: const Text("Customer Info"),
                                      ),
                                      const Divider(
                                        color: Colors.black26,
                                      ),
                                      Text(
                                        "Name ",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        '${customerdata![0].customerName}',
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.primaryColor),
                                      ),
                                      Text(
                                        "Phone ",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        "${customerdata[0].customerCode}",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.primaryColor),
                                      ),
                                      Text(
                                        "City/State ",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        "${customerdata[0].City},${customerdata[0].State == null || customerdata[0].State == "null" ? "" : customerdata[0].State}",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                // VerticalDivider(
                                //     width: Screens.width(context) * 0.001,
                                //     color: Colors.red,
                                //     thickness: 10.0),
                                SizedBox(
                                  width: Screens.width(context) * 0.40,
                                  // height:Screens.padingHeight(context)*0.2 ,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.03,
                                        child: const Text(""),
                                      ),
                                      const Divider(
                                        color: Colors.black26,
                                      ),
                                      Text(
                                        "Status",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        "${customerdata![0].status}",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.primaryColor),
                                      ),
                                      Text(
                                        "Potential Value",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        "${customerdata[0].PotentialValue}",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.primaryColor),
                                      ),
                                      Text(
                                        "Email",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        "${customerdata[0].email}",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.002,
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.002,
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.45,
                    child: customerDatalist!
                            .isEmpty
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: customerDatalist!
                                .length,
                            itemBuilder: (BuildContext context, int i) {
                              // final customerDatalist = customerDatalist![i];
                              return InkWell(
                                onDoubleTap: () async {
                                  // await context
                                  //     .read<DashBoardController>()
                                  //     .viewDetailsMethod(
                                  //         context
                                  //             .read<DashBoardController>()
                                  //             .customerdetails![0]
                                  //             .customerCode
                                  //             .toString(),
                                  //         customerDatalist.DocNum.toString(),
                                  //         customerDatalist.DocType!,
                                  //         context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Screens.width(context) * 0.01,
                                      vertical: Screens.padingHeight(context) *
                                          0.002),
                                  child: Container(
                                    width: Screens.width(context),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.padingHeight(context) *
                                                0.01),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.black26)),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Doc Number",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.grey),
                                          ),
                                          Text(
                                            "Doc Date",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${customerDatalist[i].DocNum}",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                          Text(
                                            customerDatalist[i].DocDate!.isEmpty
                                                ? '-'
                                                : config.alignDate(
                                                    customerDatalist[i].DocDate
                                                        .toString()),
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.002,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Doc Type",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.grey),
                                          ),
                                          Text(
                                            "Status",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${customerDatalist[i].DocType}",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                          Text(
                                            "${customerDatalist[i].Status}",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.002,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Assigned To",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.grey),
                                          ),
                                          Text(
                                            "Business Value",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            customerDatalist[i].AssignedTo
                                                .toString(),
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                          Text(
                                            config.slpitCurrency22(
                                                customerDatalist[i].BusinessValue
                                                    .toString()),
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget createOrderTable(ThemeData theme, BuildContext context) {
  SizedBox viewOutstandingdetails(BuildContext context, ThemeData theme) {
    return SizedBox(
      width: Screens.width(context),
      // height: Screens.bodyheight(context),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                  ),
                  child: const Text("View Details"))),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                context.watch<DashBoardController>().outstandingkpi.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        width: Screens.width(context),
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.01,
                            vertical: Screens.bodyheight(context) * 0.008),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black26)),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.45,
                              // height:Screens.padingHeight(context)*0.2 ,
                              // color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                    child: const Text("Customer Info"),
                                  ),
                                  const Divider(
                                    color: Colors.black26,
                                  ),
                                  Text(
                                    "Name ",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    "${context.watch<DashBoardController>().ontapKpi2[0].CustomerName}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    "Phone ",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    "${context.watch<DashBoardController>().ontapKpi2[0].CustomerCode}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    "City/State ",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    "${context.watch<DashBoardController>().ontapKpi2[0].Bil_City},${context.read<DashBoardController>().ontapKpi2[0].Bil_State == null || context.read<DashBoardController>().ontapKpi2[0].Bil_State == "null" ? "" : context.read<DashBoardController>().ontapKpi2[0].Bil_State}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                                width: Screens.width(context) * 0.001,
                                color: Colors.red,
                                thickness: 10.0),
                            SizedBox(
                              width: Screens.width(context) * 0.40,
                              // height:Screens.padingHeight(context)*0.2 ,
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                    child: const Text("Outstanding"),
                                  ),
                                  const Divider(
                                    color: Colors.black26,
                                  ),
                                  Text(
                                    "TotalOutStanding",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    context
                                        .read<DashBoardController>()
                                        .config
                                        .slpitCurrency22(context
                                            .watch<DashBoardController>()
                                            .totaloutstanding
                                            .toString()),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    "Overdue",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    context
                                        .read<DashBoardController>()
                                        .config
                                        .slpitCurrency22(context
                                            .watch<DashBoardController>()
                                            .overdue
                                            .toString()),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    "Upcoming",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    context
                                        .read<DashBoardController>()
                                        .config
                                        .slpitCurrency22(context
                                            .watch<DashBoardController>()
                                            .upcoming
                                            .toString()),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.002,
                ),
                const Divider(
                  color: Colors.black26,
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.002,
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.45,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: context
                          .read<DashBoardController>()
                          .outstandingkpi
                          .length,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.01,
                              vertical: Screens.padingHeight(context) * 0.002),
                          child: Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.padingHeight(context) * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black26)),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Trans Number",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    "Date",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${context.read<DashBoardController>().outstandingkpi[i].TransNum}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    context
                                        .read<DashBoardController>()
                                        .config
                                        .alignDate(context
                                            .read<DashBoardController>()
                                            .outstandingkpi[i]
                                            .TransDate
                                            .toString()),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.002,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Trans Ref Number",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    "Age",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${context.read<DashBoardController>().outstandingkpi[i].TransRef1}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    "${context.read<DashBoardController>().outstandingkpi[i].age!.toInt()}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.002,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Trans Total",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    "Balance to Pay",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context
                                        .read<DashBoardController>()
                                        .config
                                        .slpitCurrency22(context
                                            .read<DashBoardController>()
                                            .outstandingkpi[i]
                                            .TransAmount!
                                            .toString()),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  Text(
                                    context
                                        .read<DashBoardController>()
                                        .config
                                        .slpitCurrency22(context
                                            .read<DashBoardController>()
                                            .outstandingkpi[i]
                                            .BalanceToPay!
                                            .toString()),
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}

