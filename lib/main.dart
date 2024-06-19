// ignore_for_file: unused_element, unnecessary_new, avoid_print, unused_local_variable, prefer_if_null_operators, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Encripted.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Constant/LocationTrackIos.dart';
import 'package:sellerkit/Constant/flutter_background_service_utils.dart';
import 'package:sellerkit/Constant/methodchannel.dart';
// import 'package:sellerkit/Constant/LocationTrackIos.dart';
import 'package:sellerkit/Controller/AccountsController/AccountsController.dart';
import 'package:sellerkit/Controller/AccountsController/NewCustomerController.dart';
import 'package:sellerkit/Controller/CollectionController/CollectionController.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';
import 'package:sellerkit/Controller/ConfigurationController/ConfigurationController.dart';
import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
import 'package:sellerkit/Controller/DayStartEndController/DayStartEndController.dart';
import 'package:sellerkit/Controller/DownLoadController/DownloadController.dart';
import 'package:sellerkit/Controller/EarningController/EarningController.dart';
import 'package:sellerkit/Controller/EnquiryController/EnquiryMngController.dart';
import 'package:sellerkit/Controller/EnquiryController/EnquiryUserContoller.dart';
import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import 'package:sellerkit/Controller/LeaveApproveController/LeaveApproveController.dart';
import 'package:sellerkit/Controller/LeaveReqController/LeaveReqController.dart';
import 'package:sellerkit/Controller/NewProfileController/NewProfileController.dart';
import 'package:sellerkit/Controller/NotificationController/NotificationController.dart';
import 'package:sellerkit/Controller/OpenLeadController/OpenLeadController.dart';
import 'package:sellerkit/Controller/OutStandingController/OutStandingController.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';
import 'package:sellerkit/Controller/QuotationController/tabquotescontroller.dart';
import 'package:sellerkit/Controller/SettlementController/SettlementController.dart';
import 'package:sellerkit/Controller/SiteInController/SiteInController.dart';
import 'package:sellerkit/Controller/SiteOutController/SiteOutController.dart';
import 'package:sellerkit/Controller/StockAvailabilityController/StockListController.dart';
import 'package:sellerkit/Controller/VisitplanController/NewVisitController.dart';
import 'package:sellerkit/Controller/VisitplanController/VisitPlanController.dart';
import 'package:sellerkit/Controller/WalkinController/WalkinController.dart';
import 'package:sellerkit/Controller/specialpricecontroller/newpagecontroller.dart';
import 'package:sellerkit/Controller/specialpricecontroller/tabcontroller.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sellerkit/Models/LoginModel/LoginModel.dart';
import 'package:sellerkit/Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
import 'package:sellerkit/Services/CustomerMasterApi/CustomerMasterApi.dart';
import 'package:sellerkit/Services/LoginApi/LoginApi.dart';
import 'package:sellerkit/Services/PostQueryApi/ItemMasterApi/ItemMasterApiNew.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/Themes/themes_const.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Widgets/RestrictedPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'Constant/AllRoutes.dart';
import 'Controller/ChangePasswordContoller/ChangepwdCtrl.dart';
import 'Controller/LeadController/TabLeadController.dart';
import 'Controller/OrderController/OrderNewController.dart';
import 'Controller/OrderController/TabOrderController.dart';
import 'Controller/PriceListController/PriceListController.dart';
import 'Controller/SiteInController/newcreatesitein.dart';
import 'Controller/TargetController/TargetController.dart';
import 'DBHelper/DBOperation.dart';
import 'DBModel/NotificationModel.dart';
import 'Pages/Configuration/ConfigurationPage.dart';
import 'Services/LocalNotification/LocalNotification.dart';
import 'Themes/theme_manager.dart';

import 'package:timezone/data/latest.dart' as tzdata;

// Database? db;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {


//   Database db = (await DBHelper.getInstance())!;
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     List<NotificationModel> notify = [];

//     if (message.notification != null) {
//       // else {
//         await localNotificationService.Shownoti(
//           message: message,
//           title: message.notification!.title ?? "",
//           body: message.notification!.body ?? "",
//         );
// print("hhhhhh:::"+message.data['LogoutTypeId'].toString());
//       if (message.notification!.title!.contains('logout')) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.clear();
//         final Database db = (await DBHelper.getInstance())!;

//     await DBOperation.truncustomerMaster(db);
//     await DBOperation.truncareItemMaster(db);
//     await DBOperation.truncareoutstandingmaste(db);
//       await DBOperation.truncareoutstandingline(db);
//     await DBOperation.truncareEnqType(db);
//     await DBOperation.truncareCusTagType(db);
//     await DBOperation.trunstateMaster(db);
//     await DBOperation.truncareEnqReffers(db);
//     await DBOperation.truncateUserList(db);
//     await DBOperation.truncateLeadstatus(db);
//     await DBOperation.truncateOfferZone(db);
//     await DBOperation.truncateOfferZonechild1(db);
//     await DBOperation.truncateOfferZonechild2(db);
//     await DBOperation.truncatetableitemlist1(db);
//     await DBOperation.truncatetableitemlist2(db);
//         // HelperFunctions.saveOnBoardSharedPreference(true);
//     if( int.parse(message.data['LogoutTypeId'].toString()) ==2 || int.parse(message.data['LogoutTypeId'].toString()) ==4){
//  exit(0);
//     }   
       
//       } else{

   
//         if (message.notification!.android != null) {
//           if (message.notification!.android!.imageUrl != null) {
//             // log(message.data['DocEntry'].toString());
//             // log(message.data['NaviScreen'].toString());

//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: message.notification!.android!.imageUrl.toString(),
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           } else {
//             // log(message.data['DocEntry'].toString());
//             // log(message.data['NaviScreen'].toString());
//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: 'null',
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           }
//         } else {
//           if (message.notification!.apple!.imageUrl != null) {
//             // log(message.data['DocEntry'].toString());
//             // log("message.data['NaviScreen'].toString()::" +
//             //     message.notification!.apple!.imageUrl.toString());

//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: message.notification!.apple!.imageUrl.toString(),
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           } else {
//             // log(message.data['DocEntry'].toString());
//             // log(message.data['NaviScreen'].toString());
//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: 'null',
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           }
//         }
//            }
//       // }
//     }
//   });
//   print("message!.notification!.title!.toLowerCase()::"+message!.notification!.title!.toLowerCase());
//   if(message ==null){
//       await Firebase.initializeApp();
//   }
//  else if(message!.notification!.title!.toLowerCase() == 'logout'){

  
//   return;
//         }
        // else{
         await Firebase.initializeApp();
        // }
       List<NotificationModel> notify = [];
  await createDB();
  Config config2 = Config();
  // await NotificationUpdateApi.getData(
  //     docEntry: int.parse(message.data['DocEntry'].toString()),
  //     deliveryDT: config2.currentDate(),
  //     readDT: 'null',
  //     deviceCode: 'null');
  Database db = (await DBHelper.getInstance())!;
  if (message.notification != null) {
    if (message.notification!.title!.contains('logout') ) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
       final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncateQuotFilter(db);
    await DBOperation.truncustomerMaster(db);
    await DBOperation.truncareItemMaster(db);
     await DBOperation.truncareoutstandingmaste(db);
      await DBOperation.truncareoutstandingline(db);
    await DBOperation.truncareEnqType(db);
    await DBOperation.truncarelevelofType(db);
    await DBOperation.truncareorderType(db);
    
    await DBOperation.truncareCusTagType(db);
    await DBOperation.trunstateMaster(db);
    await DBOperation.truncareEnqReffers(db);
    await DBOperation.truncateUserList(db);
    await DBOperation.truncateLeadstatus(db);
    await DBOperation.truncateOfferZone(db);
    await DBOperation.truncateOfferZonechild1(db);
    await DBOperation.truncateOfferZonechild2(db);
    await DBOperation.truncatetableitemlist1(db);
    await DBOperation.truncatetableitemlist2(db);
      // HelperFunctions.saveOnBoardSharedPreference(true);
       if( int.parse(message.data['LogoutTypeId'].toString()) ==2 || int.parse(message.data['LogoutTypeId'].toString()) ==4){
 exit(0);
    }   
      // exit(0);
    } else {
      if (message.notification!.android != null  ) {
        if (message.notification!.android!.imageUrl != null) {
          notify.add(NotificationModel(
              jobid: int.parse(message.data['JobId'].toString()),
              docEntry: int.parse(message.data['DocEntry'].toString()),
              titile: message.notification!.title,
              description: message.notification!.body!,
              receiveTime: config2.currentDate(),
              seenTime: '0',
              imgUrl: message.notification!.android!.imageUrl.toString(),
              naviScn: message.data['NaviScreen'].toString()));
          await DBOperation.insertNotification(notify, db);
        } else {
          notify.add(NotificationModel(
              jobid: int.parse(message.data['JobId'].toString()),
              docEntry: int.parse(message.data['DocEntry'].toString()),
              titile: message.notification!.title,
              description: message.notification!.body!,
              receiveTime: config2.currentDate(),
              seenTime: '0',
              imgUrl: 'null',
              naviScn: message.data['NaviScreen'].toString()));
          await DBOperation.insertNotification(notify, db);
        }
      } else {
        if (message.notification!.apple!.imageUrl != null) {
          notify.add(NotificationModel(
              jobid: int.parse(message.data['JobId'].toString()),
              docEntry: int.parse(message.data['DocEntry'].toString()),
              titile: message.notification!.title,
              description: message.notification!.body!,
              receiveTime: config2.currentDate(),
              seenTime: '0',
              imgUrl: message.notification!.android!.imageUrl.toString(),
              naviScn: message.data['NaviScreen'].toString()));
          await DBOperation.insertNotification(notify, db);
        } else {
          notify.add(NotificationModel(
              jobid: int.parse(message.data['JobId'].toString()),
              docEntry: int.parse(message.data['DocEntry'].toString()),
              titile: message.notification!.title,
              description: message.notification!.body!,
              receiveTime: config2.currentDate(),
              seenTime: '0',
              imgUrl: 'null',
              naviScn: message.data['NaviScreen'].toString()));
          await DBOperation.insertNotification(notify, db);
        }
      }
    }
  // }    
        }
  // await Firebase.initializeApp();
 
}

Future createDB() async {
  await DBHelper.getInstance().then((value) {
    print("Created...");
  });
}
// await dbHelper2.insertNotify(notifiModel);
//  List<NotificationModel> notify = [];

//  notify.add(
//   NotificationModel(
//     docEntry: int.parse(message.data['DocEntry'].toString()),
//     titile: message.notification!.title,
//     description: message.notification!.body!,
//     receiveTime: config2.currentDate(),
//     seenTime: '0', ));

fetchData() async {
  String data = '';
  // Use the async/await pattern to get the string data
  String result = await config.getSetup();
  data = result;
  return data.toString();
}



LocalNotificationService localNotificationService =
    new LocalNotificationService();
Config config = Config();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// onReciveFCM22(RemoteMessage message) async {
//   Database db = (await DBHelper.getInstance())!;
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     List<NotificationModel> notify = [];

//     if (message.notification != null) {
//       // else {
//         await localNotificationService.Shownoti(
//           message: message,
//           title: message.notification!.title ?? "",
//           body: message.notification!.body ?? "",
//         );
// print("hhhhhh:::"+message.data['LogoutTypeId'].toString());
//       if (message.notification!.title!.contains('logout')) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.clear();
//         final Database db = (await DBHelper.getInstance())!;

//     await DBOperation.truncustomerMaster(db);
//     await DBOperation.truncareItemMaster(db);
//     await DBOperation.truncareoutstandingmaste(db);
//       await DBOperation.truncareoutstandingline(db);
//     await DBOperation.truncareEnqType(db);
//     await DBOperation.truncareCusTagType(db);
//     await DBOperation.trunstateMaster(db);
//     await DBOperation.truncareEnqReffers(db);
//     await DBOperation.truncateUserList(db);
//     await DBOperation.truncateLeadstatus(db);
//     await DBOperation.truncateOfferZone(db);
//     await DBOperation.truncateOfferZonechild1(db);
//     await DBOperation.truncateOfferZonechild2(db);
//     await DBOperation.truncatetableitemlist1(db);
//     await DBOperation.truncatetableitemlist2(db);
//         // HelperFunctions.saveOnBoardSharedPreference(true);
//     if( int.parse(message.data['LogoutTypeId'].toString()) ==2 || int.parse(message.data['LogoutTypeId'].toString()) ==4){
//  exit(0);
//     }   
       
//       } else{

   
//         if (message.notification!.android != null) {
//           if (message.notification!.android!.imageUrl != null) {
//             // log(message.data['DocEntry'].toString());
//             // log(message.data['NaviScreen'].toString());

//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: message.notification!.android!.imageUrl.toString(),
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           } else {
//             // log(message.data['DocEntry'].toString());
//             // log(message.data['NaviScreen'].toString());
//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: 'null',
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           }
//         } else {
//           if (message.notification!.apple!.imageUrl != null) {
//             // log(message.data['DocEntry'].toString());
//             // log("message.data['NaviScreen'].toString()::" +
//             //     message.notification!.apple!.imageUrl.toString());

//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: message.notification!.apple!.imageUrl.toString(),
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           } else {
//             // log(message.data['DocEntry'].toString());
//             // log(message.data['NaviScreen'].toString());
//             notify.add(NotificationModel(
//                 jobid: int.parse(message.data['JobId'].toString()),
//                 docEntry: int.parse(message.data['DocEntry'].toString()),
//                 titile: message.notification!.title,
//                 description: message.notification!.body!,
//                 receiveTime: config.currentDate(),
//                 seenTime: '0',
//                 imgUrl: 'null',
//                 naviScn: message.data['NaviScreen'].toString()));
//             DBOperation.insertNotification(notify, db);
//           }
//         }
//            }
//       // }
//     }
//   });
// }

onReciveFCM() async {
  Database db = (await DBHelper.getInstance())!;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    List<NotificationModel> notify = [];

    if (message.notification != null) {
      // else {
        await localNotificationService.Shownoti(
          message: message,
          title: message.notification!.title ?? "",
          body: message.notification!.body ?? "",
        );
print("hhhhhh:::"+message.data['LogoutTypeId'].toString());
      if (message.notification!.title!.contains('logout')) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        final Database db = (await DBHelper.getInstance())!;

    await DBOperation.truncustomerMaster(db);
    await DBOperation.truncareItemMaster(db);
    await DBOperation.truncareoutstandingmaste(db);
      await DBOperation.truncareoutstandingline(db);
    await DBOperation.truncareEnqType(db);
    await DBOperation.truncareCusTagType(db);
    await DBOperation.trunstateMaster(db);
    await DBOperation.truncareEnqReffers(db);
    await DBOperation.truncateUserList(db);
    await DBOperation.truncateLeadstatus(db);
    await DBOperation.truncateOfferZone(db);
    await DBOperation.truncateOfferZonechild1(db);
    await DBOperation.truncateOfferZonechild2(db);
    await DBOperation.truncatetableitemlist1(db);
    await DBOperation.truncatetableitemlist2(db);
        // HelperFunctions.saveOnBoardSharedPreference(true);
    if( int.parse(message.data['LogoutTypeId'].toString()) ==2 || int.parse(message.data['LogoutTypeId'].toString()) ==4){
 exit(0);
    }   
       
      } else{

   
        if (message.notification!.android != null) {
          if (message.notification!.android!.imageUrl != null) {
            // log(message.data['DocEntry'].toString());
            // log(message.data['NaviScreen'].toString());

            notify.add(NotificationModel(
                jobid: int.parse(message.data['JobId'].toString()),
                docEntry: int.parse(message.data['DocEntry'].toString()),
                titile: message.notification!.title,
                description: message.notification!.body!,
                receiveTime: config.currentDate(),
                seenTime: '0',
                imgUrl: message.notification!.android!.imageUrl.toString(),
                naviScn: message.data['NaviScreen'].toString()));
            DBOperation.insertNotification(notify, db);
          } else {
            // log(message.data['DocEntry'].toString());
            // log(message.data['NaviScreen'].toString());
            notify.add(NotificationModel(
                jobid: int.parse(message.data['JobId'].toString()),
                docEntry: int.parse(message.data['DocEntry'].toString()),
                titile: message.notification!.title,
                description: message.notification!.body!,
                receiveTime: config.currentDate(),
                seenTime: '0',
                imgUrl: 'null',
                naviScn: message.data['NaviScreen'].toString()));
            DBOperation.insertNotification(notify, db);
          }
        } else {
          if (message.notification!.apple!.imageUrl != null) {
            // log(message.data['DocEntry'].toString());
            // log("message.data['NaviScreen'].toString()::" +
            //     message.notification!.apple!.imageUrl.toString());

            notify.add(NotificationModel(
                jobid: int.parse(message.data['JobId'].toString()),
                docEntry: int.parse(message.data['DocEntry'].toString()),
                titile: message.notification!.title,
                description: message.notification!.body!,
                receiveTime: config.currentDate(),
                seenTime: '0',
                imgUrl: message.notification!.apple!.imageUrl.toString(),
                naviScn: message.data['NaviScreen'].toString()));
            DBOperation.insertNotification(notify, db);
          } else {
            // log(message.data['DocEntry'].toString());
            // log(message.data['NaviScreen'].toString());
            notify.add(NotificationModel(
                jobid: int.parse(message.data['JobId'].toString()),
                docEntry: int.parse(message.data['DocEntry'].toString()),
                titile: message.notification!.title,
                description: message.notification!.body!,
                receiveTime: config.currentDate(),
                seenTime: '0',
                imgUrl: 'null',
                naviScn: message.data['NaviScreen'].toString()));
            DBOperation.insertNotification(notify, db);
          }
        }
           }
      // }
    }
  });
}

//Background Services
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
// Map<String, String> allValues = await _storage.readAll();

  // /// OPTIONAL, using custom notification channel id
  // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   'my_foreground', // id
  //   'MY FOREGROUND SERVICE', // title
  //   description:
  //       'This channel is used for important notifications.', // description
  //   importance: Importance.low, // importance must be at low or higher level
  // );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart(),

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart(),

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}
// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

void dismissKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

int temp = 0;
@pragma('vm:entry-point')

onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  // await startMonitoringService();
}
// void onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();

//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually

//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.setString("hello", "world");

//   /// OPTIONAL when use custom notification
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   // bring to foreground
//   Timer.periodic(const Duration(hours: 1), (timer) async {
//     await checkLocation();
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {}
//     }

//     /// you can see this log in logcat
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }

//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }

//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//     temp = temp + 1;

//     String? getUrl = '';
//     getUrl = await HelperFunctions.getHostDSP();
//     print("URL1:" + getUrl.toString());
//     if (getUrl != null && getUrl != 'null' && getUrl != '') {
//       await refreshData();
//     }
//   });
// }

String? token = '';

refreshData() async {
  String? getUrl2 = '';
  temp = temp + 1;

  getUrl2 = await HelperFunctions.getHostDSP();
  print("getUrl2:" + getUrl2.toString());
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // print("URL1:" + ConstantValues.urlvalue.toString());

 
  PostLoginData postLoginData = new PostLoginData();
  Url.queryApi = 'http://${getUrl2.toString()}/api/';

  print('ItemMaster-CustomerMasterInsert');
  ItemMasterApiNew itemMasterApiNew = ItemMasterApiNew();
  CustomerMasterApiNew customerMaster1 = CustomerMasterApiNew();
  String? deviceID;
  final Database db = (await DBHelper.getInstance())!;
  String? licenseKey = await HelperFunctions.getLicenseKeySharedPreference();
  String? userCode = await HelperFunctions.getLogginUserCodeSharedPreference();
  String? passsword = await HelperFunctions.getPasswordSharedPreference();
  ConstantValues.tenetID =
      (await HelperFunctions.getTenetIDSharedPreference()).toString();

  bool? isLoggedIn = await HelperFunctions.getUserLoggedInSharedPreference();
  token = await HelperFunctions.getFCMTokenSharedPreference();
  // log("FCM Token: $token");
  deviceID = await HelperFunctions.getDeviceIDSharedPreference();

  // await HelperFunctions.saveFCMTokenSharedPreference(token);
  // log("licenseKey:::" + deviceID.toString());
  // //  String? fcmToken = await HelperFunctions.getFCMTokenSharedPreference();
  // log("PASWORD:::" + passsword.toString());
  postLoginData.deviceCode = deviceID;
  postLoginData.licenseKey = licenseKey;
  postLoginData.username = userCode;
  postLoginData.fcmToken = token;
  postLoginData.password = passsword;
  String? model=await  Config.getdeviceModel() ;
    String? brand=await  Config.getdeviceBrand() ;
postLoginData. devicename='${brand} ${model}';

  await LoginAPi.getData(postLoginData).then((value) async {
    // log("login resocde:: ${value.resCode}");

    if (value.resCode! >= 200 && value.resCode! <= 210) {
      if (value.loginstatus!.toLowerCase().contains('success') &&
          value.data != null) {
        ConstantValues.UserId = value.data!.UserID;
        ConstantValues.Usercode = value.data!.userCode;
       
        ConstantValues.storeid = int.parse(value.data!.storeid.toString());
        ConstantValues.Storecode = value.data!.storecode.toString();

        // log("token ${value.data!.UserID}");
      }
    }
  });

  await DBOperation.truncareItemMaster(db);
  List<ItemMasterDBModel> valuesInserMaster = [];

  ItemMasterNewModal itemMasterData = await itemMasterApiNew.getData();
  if (itemMasterData.stcode! >= 200 && itemMasterData.stcode! <= 210) {
    if (itemMasterData.itemdata != null) {
      String date = config.currentDate();
      // log("Api itemMasterData.itemdata!.length ${itemMasterData.itemdata!.length}");
      for (int ij = 0; ij < itemMasterData.itemdata!.length; ij++) {
        valuesInserMaster.add(ItemMasterDBModel(
            id: int.parse(itemMasterData.itemdata![ij].id!.toString()),
            itemCode: itemMasterData.itemdata![ij].itemcode,
            brand: itemMasterData.itemdata![ij].Brand!,
            division: itemMasterData.itemdata![ij].Division!,
            category: itemMasterData.itemdata![ij].Category!,
            itemName: itemMasterData.itemdata![ij].itemName!,
            segment: itemMasterData.itemdata![ij].Segment!,
            isselected: 0,
            favorite: itemMasterData.itemdata![ij].Favorite!,
            mgrPrice:
                double.parse(itemMasterData.itemdata![ij].MgrPrice.toString()),
            slpPrice:
                double.parse(itemMasterData.itemdata![ij].SlpPrice.toString()),
            storeStock: double.parse(
                itemMasterData.itemdata![ij].StoreStock.toString()),
            whsStock:
                double.parse(itemMasterData.itemdata![ij].WhsStock.toString()),
            refreshedRecordDate: date,
            itemDescription:
                itemMasterData.itemdata![ij].itemDescription.toString(),
            modelNo: itemMasterData.itemdata![ij].modelNo.toString(),
            partCode: itemMasterData.itemdata![ij].partCode.toString(),
            skucode: itemMasterData.itemdata![ij].skucode.toString(),
            brandCode: itemMasterData.itemdata![ij].brandCode.toString(),
            itemGroup: itemMasterData.itemdata![ij].itemGroup.toString(),
            specification:
                itemMasterData.itemdata![ij].specification.toString(),
            sizeCapacity: itemMasterData.itemdata![ij].sizeCapacity.toString(),
            clasification:
                itemMasterData.itemdata![ij].clasification.toString(),
            uoM: itemMasterData.itemdata![ij].uoM.toString(),
            taxRate: itemMasterData.itemdata![ij].taxRate,
            catalogueUrl1:
                itemMasterData.itemdata![ij].catalogueUrl1.toString(),
            catalogueUrl2:
                itemMasterData.itemdata![ij].catalogueUrl2.toString(),
            imageUrl1: itemMasterData.itemdata![ij].imageUrl1.toString(),
            imageUrl2: itemMasterData.itemdata![ij].imageUrl2.toString(),
            textNote: itemMasterData.itemdata![ij].textNote.toString(),
            status: itemMasterData.itemdata![ij].status.toString(),
            movingType: itemMasterData.itemdata![ij].movingType.toString(),
            eol: itemMasterData.itemdata![ij].eol,
            veryFast: itemMasterData.itemdata![ij].veryFast,
            fast: itemMasterData.itemdata![ij].fast,
            slow: itemMasterData.itemdata![ij].slow,
            verySlow: itemMasterData.itemdata![ij].verySlow,
            serialNumber: itemMasterData.itemdata![ij].serialNumber,
            priceStockId: itemMasterData.itemdata![ij].priceStockId,
            storeCode: itemMasterData.itemdata![ij].storeCode.toString(),
            whseCode: itemMasterData.itemdata![ij].whseCode.toString(),
            sp: itemMasterData.itemdata![ij].sp,
            ssp1: itemMasterData.itemdata![ij].ssp1,
            ssp2: itemMasterData.itemdata![ij].ssp2,
            ssp3: itemMasterData.itemdata![ij].ssp3,
            ssp4: itemMasterData.itemdata![ij].ssp4,
            ssp5: itemMasterData.itemdata![ij].ssp5,
            ssp1Inc: itemMasterData.itemdata![ij].ssp1Inc,
            ssp2Inc: itemMasterData.itemdata![ij].ssp2Inc,
            ssp3Inc: itemMasterData.itemdata![ij].ssp3Inc,
            ssp4Inc: itemMasterData.itemdata![ij].ssp4Inc,
            ssp5Inc: itemMasterData.itemdata![ij].ssp5Inc,
            allowNegativeStock: itemMasterData.itemdata![ij].allowNegativeStock,
            allowOrderBelowCost:
                itemMasterData.itemdata![ij].allowOrderBelowCost,
            isFixedPrice: itemMasterData.itemdata![ij].isFixedPrice,
            validTill: itemMasterData.itemdata![ij].validTill.toString(),
            color: itemMasterData.itemdata![ij].color,
            calcType:itemMasterData.itemdata![ij].calcType.toString(),
        payOn:itemMasterData.itemdata![ij].payOn.toString() ,
            ));
        // log("valuesInserMaster" + valuesInserMaster[0].id.toString());
        // dbHelper.insertdocuments(valuesInserMaster[ij]);
      }
    }
    // notifyListeners();
  }

  await DBOperation.insertItemMaster(valuesInserMaster, db);
   await flutterLocalNotificationsPlugin.show(
    888,
    'Seller Kit Refresh Master Api..\nItemMaster:${valuesInserMaster.length}',
    'Awesome ${DateTime.now()}',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'my_foreground',
        'MY FOREGROUND SERVICE',
        icon: 'ic_bg_service_small',
        ongoing: true,
      ),
    ),
  );
}
// getOverlayPermission() async {
//     bool status = await FlutterOverlayWindow.isPermissionGranted();
//     if (!status) {
//       // Navigator.pop(context);
//        openAppSettings();
//       // status = await FlutterOverlayWindow.isPermissionGranted();
//       if (!status){
//         print("hi this is Anbu");
//       }
//     }
//   }
Future getPermissionUser() async {
  //  bool status = await FlutterOverlayWindow.isPermissionGranted();
  //   if (!status) {
  //     await FlutterOverlayWindow.requestPermission();
  //   }
  if (await Permission.phone.request().isGranted) {
  } else {
    await Permission.phone.request();
  }
  if (await Permission.contacts.request().isGranted) {
  } else {
    await Permission.contacts.request();
  }
}
void main() async {
  tzdata.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  await getPermissionUser();
// await getOverlayPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//  
 var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOs = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {});
  var initSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse,) async {
// this should print now
// print("message:::"+message.notification!.title!.toString());
    print("payload: " + notificationResponse.payload.toString());
   
// let's add some switch statements here
final RemoteMessage? remoteMessage=await FirebaseMessaging.instance.getInitialMessage();
if(remoteMessage !=null){
   print('gggfgfhf::'+remoteMessage!.notification!.    title!.toString());
if(remoteMessage!.notification!.    title!.toString().toLowerCase() != 'logout'){
  return;
}

}else{
switch (notificationResponse.notificationResponseType) {
// triggers when the notification is tapped
      case NotificationResponseType.selectedNotification:
        if (notificationResponse.payload != null) {
          
          try {
            var pdfText = await json.decode(notificationResponse.payload!);
            // if (pdfText["NaviScreen"] == "enquiry") {
            Get.toNamed(ConstantRoutes.testing);
            // }
          } catch (error) {
            // log('Notification payload error $error');
          }
        }
        break;
      default:
    }
}
    
  }

// final RemoteMessage? remoteMessage=await FirebaseMessaging.instance.getInitialMessage();

//  if(remoteMessage !=null){
//    print('gggfgfhf::'+remoteMessage!.notification!.    title!.toString());
// if(remoteMessage!.notification!.    title!.toString().toLowerCase() != 'logout') {
 
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );
//  }
//  }
 
  

  onReciveFCM();
  // if (Platform.isAndroid) {
  //   await LocationTrack.determinePosition();
  // } else {
  //   await LocationTrack2.determinePosition();
  // }
// await firebasemethod();

  await checkLocation();
  // await getOverlayPermission();
  // await initializeService();
   await checkLoginVerification();

  runApp(const MyApp2());
}
firebasemethod()async{
  
 FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      
    }
  });
 FirebaseMessaging.instance.setAutoInitEnabled(false);
 FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
  if(remoteMessage !=null){
    if(remoteMessage.notification != null && remoteMessage.notification!.title?.toLowerCase() == 'logout'){

  
  return;
        }else{
        }
  }
  });
  

  //  final RemoteMessage? remoteMessage=await FirebaseMessaging.instance.getInitialMessage();
   

  //  }
  
  
  // await localNotificationService.init();
  // .resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()
  // ?.createNotificationChannel(localNotificationService.channel);

  // !
 
  
}



//overlay Method
@pragma("vm:entry-point")
// void overlayMain() async {
//   // debugPrint("Starting Alerting Window Isolate!");
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   onStart();
//   // await createDB();
//   runApp(const Overlay());
// }

// class Overlay extends StatefulWidget {
//   const Overlay({
//     Key? key,
//   }): super(key: key);

//   @override
//   State<Overlay> createState() => _OverlayState();
// }

// class _OverlayState extends State<Overlay> {
//   // final _messagingService = MessagingService();
//   @override
//   void initState() {
//     // _messagingService.init(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         key: navigatorKey,
//         providers: [
//           ChangeNotifierProvider(create: (_) => ThemeManager()),
//           // ChangeNotifierProvider(create: (_) => LocaleProvider()),
//           // ChangeNotifierProvider(
//           //     create: (_) => LoginwithSellerkitContoller(context)),
//           // ChangeNotifierProvider(create: (_) => DashboardController()),
//           // ChangeNotifierProvider(create: (_) => SplashController()),
//           ChangeNotifierProvider(create: (_) => DownLoadController()),
//           // ChangeNotifierProvider(
//           //     create: (_) => ConfigurationController(context)),
//           ChangeNotifierProvider(create: (_) => CallNotificationController()),
//         ],
//         child: Consumer<ThemeManager>(
//             builder: (context,  themes, Widget? child) {
//           return GetMaterialApp(
//               theme: themes.selectedTheme == 'merron'
//                   ? merronTheme(context)
//                   : themes.selectedTheme == 'blue'
//                       ? blueTheme(context)
//                       : orangeTheme(context),
//               debugShowCheckedModeBanner: false,
//               home: const CustomOverlayNew(),
//               builder: (context, child) {
//           return KeyboardContainer(child: child);
//         },
//               );
//         }));
//   }
// }
Future<List<String>> getLocation(String restricdata) async {
  String split1 = restricdata;
  List<String>? clist = split1.split(",");

  return clist;
}
  checkLoginVerification() async {
    final Database db = (await DBHelper.getInstance())!;
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      bool verifibool = false;

      String? getUrl = await HelperFunctions.getHostDSP();
      print("URL1:" + getUrl.toString());
      if (getUrl != null && getUrl != 'null' && getUrl != '') {
        List<Map<String, Object?>> VerificationDataDBData =
            await DBOperation.getLoginVerifiDBData(db);
        print("VerificationDataDBData bool:" +
            VerificationDataDBData.length.toString());

   if (VerificationDataDBData.isNotEmpty) {
  bool anyConditionSatisfied = false; 

  for (int i = 0; i < VerificationDataDBData.length; i++) {
    print("VerificationDataDBData[i]['RestrictionType'].toString()::"+VerificationDataDBData[i]['RestrictionType'].toString());

    if (VerificationDataDBData[i]['RestrictionType'].toString() == '1') {
      if (VerificationDataDBData[i]['RestrictionData'].toString() == ConstantValues.ipaddress) {
        verifibool = true;
        anyConditionSatisfied = true; 
        break;
      }
    } else if (VerificationDataDBData[i]['RestrictionType'].toString() == '2') {
           if (Platform.isAndroid) {
                await LocationTrack.determinePosition();
              } else {
                await LocationTrack2.determinePosition();
              }
              List<String>? locatoindetals = await getLocation(
                  VerificationDataDBData[i]['RestrictionData'].toString());
              String? lat = locatoindetals[0];
              String? long = locatoindetals[1];
              String? dis = locatoindetals[2];
              double totaldis = calculateDistance2(
                  double.parse(locatoindetals[0]),
                  double.parse(locatoindetals[1]),
                  double.parse(ConstantValues.latitude.toString()),
                  double.parse(ConstantValues.langtitude.toString()));
              print("Total Dis:" + totaldis.toString());
              int apiDis = int.parse(locatoindetals[2].toString());
              if (totaldis < apiDis.toDouble()) {
              verifibool = true;
      anyConditionSatisfied = true;
      break;
              }

     
    } else if (VerificationDataDBData[i]['RestrictionType'].toString() == '3') {
       String ipname = ConstantValues.ipname.replaceAll('"', '');
           if (VerificationDataDBData[i]['RestrictionData'].toString() ==
              ipname.toString()) {
                verifibool = true;
      anyConditionSatisfied = true; 
      break;
              }

    
    }
  }

  if (!anyConditionSatisfied) { 
    Get.offAllNamed(ConstantRoutes.restrictionValue);
  } else {
    if (RestrictionPageState.loginbool == true) {
      Get.offAllNamed(ConstantRoutes.download);
      RestrictionPageState.loginbool=false;
    }
    // else{
    //    Get.offAllNamed(ConstantRoutes.login);
    // }
  }
}

        // if (VerificationDataDBData.isNotEmpty) {
        //   for (int i = 0; i < VerificationDataDBData.length; i++) {
        //     if (VerificationDataDBData[i]['RestrictionType'].toString() ==
        //         '1') {
        //       if (VerificationDataDBData[i]['RestrictionData'].toString() ==
        //           ConstantValues.ipaddress) {
        //         verifibool = true;
        //          break;
        //       }
        //     }
        //      else if (VerificationDataDBData[i]['RestrictionType'].toString() ==
        //         '2') {
        //       if (Platform.isAndroid) {
        //         await LocationTrack.determinePosition();
        //       } else {
        //         await LocationTrack2.determinePosition();
        //       }
        //       List<String>? locatoindetals = await getLocation(
        //           VerificationDataDBData[i]['RestrictionData'].toString());
        //       String? lat = locatoindetals[0];
        //       String? long = locatoindetals[1];
        //       String? dis = locatoindetals[2];
        //       double totaldis = calculateDistance2(
        //           double.parse(locatoindetals[0]),
        //           double.parse(locatoindetals[1]),
        //           double.parse(ConstantValues.latitude.toString()),
        //           double.parse(ConstantValues.langtitude.toString()));
        //       print("Total Dis:" + totaldis.toString());
        //       int apiDis = int.parse(locatoindetals[2].toString());
        //       if (totaldis < apiDis.toDouble()) {
        //         verifibool = true;
        //          break;
        //       }
        //       //
        //     }
        //     else {
        //       String ipname = ConstantValues.ipname.replaceAll('"', '');
        //       if (VerificationDataDBData[i]['RestrictionData'].toString() ==
        //           ipname) {
        //         verifibool = true;
        //          break;
        //       }
        //     }
        //   }

        //   if (verifibool == false) {
        //     // await HelperFunctions.clearHost();
        //     // await DBOperation.truncateLoginVerficationDB(db);

        //     Get.offAllNamed(ConstantRoutes.restrictionValue);
        //   } else {
        //     if (RestrictionPageState.loginbool == true) {
        //     Get.offAllNamed(ConstantRoutes.dashboard);
        //     }
        //   }
        // }
      }
      print("verifi bool:" + verifibool.toString());
    });
  }
  double calculateDistance2(lat1, lon1, lat2, lon2) {
  print('process lat' + lat1.toString());
  print('process long' + lon1.toString());

  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742000 * asin(sqrt(a));
}
checkLocation() async {
  print("Before await LocationTrack.determinePosition()");
  if (Platform.isAndroid) {
    await LocationTrack.determinePosition();
  } else {
    await LocationTrack2.determinePosition();
  }
  // await LocationTrack.determinePosition();
  // await LocationTrack. checkcamlocation();
  print("After await LocationTrack.determinePosition()");
  await Future.delayed(Duration(seconds: 3));
  Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    // log("result:::" + result.name.toString());
    // Got a new connectivity status!
    if (result.name == 'none') {
      ConstantValues.ipaddress = '';
      ConstantValues.ipname = '';
    } else if (result.name == 'mobile') {
      if (Platform.isAndroid) {
        final MobileNetworkInfo mobileNetworkInfo = MobileNetworkInfo();
        final String name = await Config.getipaddress();

        // List<String>? wifiiInfo = await config.setNetwork();
        //
        // var ipAddress = IpAddress(type: RequestType.text);
         final String? data = await mobileNetworkInfo.getMobileNetworkName();
        // String data = await ipAddress.getIpAddress();
      //   final String? datastrength = await mobileNetworkInfo.getMobileNetworkStrength();
      // print  ("datastrength:::"+datastrength.toString());
           print("ssssss::"+data.toString());
        ConstantValues.ipaddress = name == null ? 'null' : name;
     
        ConstantValues.ipname = data == null ? 'null' : data;
      } else if (Platform.isIOS) {
        List<String>? wifiiInfo = await config.getIosNetworkInfo();
        ConstantValues.ipaddress = wifiiInfo[1];
        ConstantValues.ipname = wifiiInfo[0];
      }
    }
    // else if (result.name == 'mobile') {
    //   List<String>? wifiiInfo = await config.setNetwork();
    //   ConstantValues.ipaddress = wifiiInfo[1] == null ? 'null' : wifiiInfo[1];
    //   ConstantValues.ipname = wifiiInfo[0] == null ? 'null' : wifiiInfo[0];
    // }
    else if (result.name == 'wifi') {
       String? name= await Config.getipaddress();
      List<String>? wifiiInfo = await config.setNetwork();
      ConstantValues.ipaddress = name == null ? 'null' : name;
      ConstantValues.ipname = wifiiInfo[0];
    }
    // print("LocationTrack.Lat::" + LocationTrack.Lat.toString());
    // print("LocationTrack.Long::" + LocationTrack.Long.toString());
    // print("ConstantValues.lat::" + ConstantValues.latitude.toString());
    // print("ConstantValues.lang::" + ConstantValues.langtitude.toString());
    ConstantValues.latitude = LocationTrack.Lat.isEmpty
        ? "${ConstantValues.latitude}"
        : '${LocationTrack.Lat}';
    ConstantValues.langtitude = LocationTrack.Long.isEmpty
        ? "${ConstantValues.langtitude}"
        : '${LocationTrack.Long}';
    //
    if (ConstantValues.langtitude!.isEmpty || ConstantValues.langtitude == '') {
      ConstantValues.langtitude = '0.000';
    }
    if (ConstantValues.latitude!.isEmpty || ConstantValues.latitude == '') {
      ConstantValues.latitude = '0.000';
    }
    ConstantValues.headerSetup =
        "${ConstantValues.latitude};${ConstantValues.langtitude};${ConstantValues.ipname};${ConstantValues.ipaddress}";
    //
    print("Location Header::" + ConstantValues.headerSetup.toString());
    EncryptData enc = new EncryptData();
    String? encryValue = enc.encryptAES("${ConstantValues.headerSetup}");
    // log("Encryped Location Header:::" + encryValue.toString());
    ConstantValues.EncryptedSetup = encryValue;
    // log("ConstantValues.EncryptedSetup::" +
    //     ConstantValues.EncryptedSetup.toString());
    //  await config.getSetup();
  });
  // await LocationTrack.checkcamlocation();
}
// checkloc()async{

// }
class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State <MyApp2> createState() =>  MyApp2State();
}

class  MyApp2State extends State <MyApp2> with WidgetsBindingObserver{
   Timer? _timer;
  @override
  void initState(){
     super.initState();
  WidgetsBinding.instance.addObserver(this);  
  }
  @override
void dispose(){
  super.dispose();
  WidgetsBinding.instance.removeObserver(this);
}
void restartApp() async{
    _timer?.cancel(); 

    if(Platform.isAndroid){
await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    print("Appp restarted::Android");
    }else{

Restart.restartApp();
    print("Appp restarted::ios");
    }
   // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => SplashPage()),
    // );
    // exit(0);
    
    // Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      // Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
// Get.offAllNamed(ConstantRoutes.splash);
      

  }
//  void restartApp() {
//     _timer?.cancel(); 
//     SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//       print("Appp restarted");
//   }
@override
void didChangeAppLifecycleState(AppLifecycleState state){
  super.didChangeAppLifecycleState(state);
  print("lifecycle::"+state.toString());
   if (state == AppLifecycleState.resumed) {
        if (_timer != null) {
          _timer!.cancel();
        }
      } else if (state == AppLifecycleState.paused) {
        _timer = Timer(Duration(hours: 4),
        
         restartApp);
   
      }
  

}
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: navigatorKey,
      providers: [
        ChangeNotifierProvider(create: (_) => DashBoardController()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => ConfigurationContoller()),
        ChangeNotifierProvider(create: (_) => DownLoadController()),
        ChangeNotifierProvider(create: (_) => PriceListController()),
        ChangeNotifierProvider(create: (_) => StockListController()),
        ChangeNotifierProvider(create: (_) => EnquiryMangerContoller()),
        ChangeNotifierProvider(create: (_) => EnquiryUserContoller()),
        ChangeNotifierProvider(create: (_) => NewEnqController()),
        ChangeNotifierProvider(create: (_) => WalkinController()),
        ChangeNotifierProvider(create: (_) => LeadTabController()),
        ChangeNotifierProvider(create: (_) => LeadNewController()),
        ChangeNotifierProvider(create: (_) => NewProfileController()),
        ChangeNotifierProvider(create: (_) => NotificationContoller()),
        ChangeNotifierProvider(create: (_) => AccountsContoller()),
        ChangeNotifierProvider(create: (_) => OpenLeadController()),
        ChangeNotifierProvider(create: (_) => OrderNewController()),
        ChangeNotifierProvider(create: (_) => OrderTabController()),
        //New
      //  ChangeNotifierProvider(create: (_) => DashBoardController()), 
        ChangeNotifierProvider(create: (_) => NewCustomerContoller()),
        ChangeNotifierProvider(create: (_) => NewVisitplanController()),
        ChangeNotifierProvider(create: (_) => VisitplanController()),
        ChangeNotifierProvider(create: (_) => DayStartEndController()),
        ChangeNotifierProvider(
            create: (_) => SettlementController()), //SiteInController
        ChangeNotifierProvider(
            create: (_) => SiteInController()), //SiteOutController
        ChangeNotifierProvider(create: (_) => SiteOutController()),
        // ChangeNotifierProvider(
        //     create: (_) => SiteInController()), //SiteOutController
        // ChangeNotifierProvider(create: (_) => SiteOutController()),
        ChangeNotifierProvider(create: (_) => QuotestabController()),
        ChangeNotifierProvider(create: (_) => createSiteInController()),
        ChangeNotifierProvider(create: (_) => LeaveReqContoller()),
        ChangeNotifierProvider(create: (_) => LeaveApproveContoller()),
        ChangeNotifierProvider(create: (_) => ColletionContoller()),
        ChangeNotifierProvider(create: (_) => NewCollectionContoller()),
        ChangeNotifierProvider(create: (_) => NewquoteController()),
        ChangeNotifierProvider(create: (_) => Outstandingcontroller()),
        ChangeNotifierProvider(create: (_) => ChangePasswordController()),
        ChangeNotifierProvider(create: (_) => TargetTabController()),
        ChangeNotifierProvider(create: (_) => NewpriceController()),
        ChangeNotifierProvider(create: (_) => tabpriceController()),
        ChangeNotifierProvider(create: (_) => EarningController ()),
  ],
      child: Consumer<ThemeManager>(builder: (context, themes, Widget? child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Seller kit',
            theme: themes.selectedTheme == 'merron'
                ? merronTheme(context)
                : themes.selectedTheme == 'blue'
                    ? blueTheme(context)
                    : orangeTheme(context),
            home: ConfigurationPage(),
            getPages: Routes.allRoutes,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0, alwaysUse24HourFormat: false),
                  child: child!);
            });
      }),
    );
  }
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: navigatorKey,
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => ConfigurationContoller()),
        ChangeNotifierProvider(create: (_) => DownLoadController()),
        ChangeNotifierProvider(create: (_) => PriceListController()),
        ChangeNotifierProvider(create: (_) => StockListController()),
        ChangeNotifierProvider(create: (_) => EnquiryMangerContoller()),
        ChangeNotifierProvider(create: (_) => EnquiryUserContoller()),
        ChangeNotifierProvider(create: (_) => NewEnqController()),
        ChangeNotifierProvider(create: (_) => WalkinController()),
        ChangeNotifierProvider(create: (_) => LeadTabController()),
        ChangeNotifierProvider(create: (_) => LeadNewController()),
        ChangeNotifierProvider(create: (_) => NewProfileController()),
        ChangeNotifierProvider(create: (_) => NotificationContoller()),
        ChangeNotifierProvider(create: (_) => AccountsContoller()),
        ChangeNotifierProvider(create: (_) => OpenLeadController()),
        ChangeNotifierProvider(create: (_) => OrderNewController()),
        ChangeNotifierProvider(create: (_) => OrderTabController()),
        //New
      //  ChangeNotifierProvider(create: (_) => DashBoardController()), 
        ChangeNotifierProvider(create: (_) => NewCustomerContoller()),
        ChangeNotifierProvider(create: (_) => NewVisitplanController()),
        ChangeNotifierProvider(create: (_) => VisitplanController()),
        ChangeNotifierProvider(create: (_) => DayStartEndController()),
        ChangeNotifierProvider(
            create: (_) => SettlementController()), //SiteInController
        ChangeNotifierProvider(
            create: (_) => SiteInController()), //SiteOutController
        ChangeNotifierProvider(create: (_) => SiteOutController()),
        // ChangeNotifierProvider(
        //     create: (_) => SiteInController()), //SiteOutController
        // ChangeNotifierProvider(create: (_) => SiteOutController()),
        ChangeNotifierProvider(create: (_) => QuotestabController()),
        ChangeNotifierProvider(create: (_) => createSiteInController()),
        ChangeNotifierProvider(create: (_) => LeaveReqContoller()),
        ChangeNotifierProvider(create: (_) => LeaveApproveContoller()),
        ChangeNotifierProvider(create: (_) => ColletionContoller()),
        ChangeNotifierProvider(create: (_) => NewCollectionContoller()),
        ChangeNotifierProvider(create: (_) => NewquoteController()),
        ChangeNotifierProvider(create: (_) => Outstandingcontroller()),
        ChangeNotifierProvider(create: (_) => ChangePasswordController()),
        ChangeNotifierProvider(create: (_) => TargetTabController()),



      ],
      child: Consumer<ThemeManager>(builder: (context, themes, Widget? child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Seller kit',
            theme: themes.selectedTheme == 'merron'
                ? merronTheme(context)
                : themes.selectedTheme == 'blue'
                    ? blueTheme(context)
                    : orangeTheme(context),
            home: ConfigurationPage(),
            getPages: Routes.allRoutes,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0, alwaysUse24HourFormat: false),
                  child: child!);
            });
      }),
    );
  }
}