// import 'dart:developer';
// import 'dart:io';

// import 'package:call_log/call_log.dart';
// import 'package:flutter/material.dart';
// import 'package:sellerkit/Constant/Helper.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// import 'package:sellerkit/Constant/Utils.dart';
// import 'package:sellerkit/Constant/getCallLog_NativeCode.dart';
// import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
// import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
// import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
// import 'package:system_alert_window/system_alert_window.dart';

// class CustomOverlay extends StatefulWidget {
//   @override
//   State<CustomOverlay> createState() => CustomOverlayState();
// }

// class CustomOverlayState extends State<CustomOverlay> {
//   // static const String _mainAppPort = 'MainApp';
//   // SendPort? mainAppPort;
//   bool update = false;
//     List<Callloginfo> callsInfo = [];
// static bool callented=false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SystemAlertWindow.overlayListener.listen((event) {
//       log("$event in overlay");
//       if (event is bool) {
//         setState(() {
//           update = event;
//         });
//       }
//     });
    
//   }
  

//   // List<Callloginfo> callsInfo = [];
 
//   // void callBackFunction(String tag) {
//   //   print("Got tag " + tag);
//   //   mainAppPort ??= IsolateNameServer.lookupPortByName(
//   //     _mainAppPort,
//   //   );
//   //   mainAppPort?.send('Date: ${DateTime.now()}');
//   //   mainAppPort?.send(tag);
//   // }
// calllog()async{
  
//   if(callented==false)return;
//   String mobileno = '';
//       String callername = 'Unknown Number';
//       String? getToken = await HelperFunctions.getTokenSharedPreference();
//       // Utils.token = getToken;
//       // getPermissionUser();
//       if (Utils.token != null) {
//         if (Platform.isAndroid) {
//           Iterable<CallLogEntry> entries = await CallLog.get();
//           for (var item in entries) {
//             if (item.callType.toString().contains('incoming')) {
//               callsInfo.add(Callloginfo(
//                   name: item.callType.toString(),
//                   number: item.number,
//                   duration: item.name.toString()));
//               // break;
//             }
//           }
//           mobileno = callsInfo[0].number!;
//           String? getUrl = await HelperFunctions.getHostDSP();
//           log("getUrl $getUrl");
//           Utils.queryApi = 'http://${getUrl.toString()}/api/';
//           // String meth = '${ConstantApiUrl.getCustomerApi}';
//           // GetCutomerpost reqpost =
//           //     GetCutomerpost(customermobile: mobileno.replaceAll('+91', ''));
//           GetCutomerDetailsApi.getData(mobileno, '').then((value) {
//             if (value.stcode! <= 210 && value.stcode! >= 200) {
//               GetCustomerDataHeadertwo? itemdata;
//               itemdata = value.itemdata;
//               callername = itemdata!.customerdetails![0].customerName!;
//               mobileno = itemdata!.customerdetails![0].mobileNo!;
//               callsInfo
//                   .add(Callloginfo(number: callername, duration: mobileno));
//             }
//           });
//         } else {
//           List<Object?> result = await CallLogService.getCallLog();
//           List<dynamic> listWithoutNulls =
//               result.where((element) => element != null).toList();
//           List<Contact> contacts = listWithoutNulls
//               .map((item) => Contact(
//                     firstName: item['firstName'],
//                     lastName: item['lastName'],
//                     phoneNumbers: List<String>.from(item['phoneNumbers']),
//                   ))
//               .toList();
//           for (int i = 0; i < contacts.length; i++) {
//             callsInfo.add(Callloginfo(
//                 name: contacts[i].firstName.toString(),
//                 number: contacts[i].phoneNumbers.toString(),
//                 duration: ''));
//           }
//         }
//       }
// }
//   Widget overlay() {
//     final theme = Theme.of(context);
//     calllog();
//     print('test::'+callented.toString());
//     return Stack(
//       children: [
//         Container(
//           color: theme.primaryColor,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: callsInfo.isEmpty
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // calllog();

//                         // SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
//                       },
//                       child: Icon(Icons.open_in_browser),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         // calllog();

//                         SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
//                       },
//                       child: const Center(child: Icon(Icons.close)),
//                     ),
//                   ],
//                 )
//               : SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         height: Screens.bodyheight(context) * 0.26,
//                         decoration: BoxDecoration(
//                             // borderRadius: BorderRadius.circular(100),
//                             color: theme.primaryColor),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text("${callsInfo[0].name} ",
//                                           style: const TextStyle(
//                                               fontSize: 20,
//                                               color: Colors.white)),
//                                       Container(
//                                         alignment: Alignment.topCenter,
//                                         height:
//                                             Screens.bodyheight(context) * 0.07,
//                                         width: Screens.width(context) * 0.2,
//                                         decoration: BoxDecoration(
//                                             color: Colors.yellow[100],
//                                             borderRadius:
//                                                 BorderRadius.circular(4)),
//                                         child: const Text("Corporate"),
//                                       )
//                                     ],
//                                   ),
//                                   Text(
//                                     "+91 ${callsInfo[0].number}",
//                                     style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   // callBackFunction("Close");
//                                   SystemAlertWindow.closeSystemWindow(
//                                       prefMode: prefMode);
//                                 },
//                                 icon: Icon(
//                                   Icons.close,
//                                   size: Screens.bodyheight(context) * 0.06,
//                                 ))
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: Screens.bodyheight(context) * 0.9,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20)),
//                             color: Colors.grey[300]!),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               height: Screens.bodyheight(context) * 0.7,
//                               width: Screens.width(context) * 0.85,
//                               // color: Colors.grey[300]!,
//                               child: ListView.builder(
//                                   itemCount: 3,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Container(
//                                       padding: EdgeInsets.all(
//                                           Screens.bodyheight(context) * 0.01),
//                                       margin: EdgeInsets.all(
//                                           Screens.bodyheight(context) * 0.01),
//                                       // height: Screens.bodyheight(context)*0.08,
//                                       decoration: BoxDecoration(
//                                           border:
//                                               Border.all(color: Colors.grey),
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: Colors.white),
//                                       child: const Column(
//                                         children: [
//                                           Text("Last Order on 02-04-2023"),
//                                           Text("Sales Order #23345123"),
//                                           Text("LG Refridgerator DLX - R511L5"),
//                                           Text(
//                                               "Handled by Mr.Vinoth -CUD1 Branch"),
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.1,
//                                   width: Screens.width(context) * 0.4,
//                                   child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor: theme.primaryColor,
//                                           // side: BorderSide(color: Colors.yellow, width: 5),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10))),
//                                       onPressed: () {},
//                                       child: Text(
//                                         'Add Enquiry',
//                                         style: theme.textTheme.bodySmall!
//                                             .copyWith(color: Colors.white),
//                                       )),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.1,
//                                   width: Screens.width(context) * 0.4,
//                                   child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor: theme.primaryColor,
//                                           // side: BorderSide(color: Colors.yellow, width: 5),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10))),
//                                       onPressed: () {},
//                                       child: Text(
//                                         'Analyse',
//                                         style: theme.textTheme.bodySmall!
//                                             .copyWith(color: Colors.white),
//                                       )),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }

//   SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: overlay(),
//     );
//   }
// }
