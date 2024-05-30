// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/GetLDB.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sqflite/sqflite.dart';
import '../../DBModel/NotificationModel.dart';
import '../../Services/LocalNotification/LocalNotification.dart';
import '../../Services/PostQueryApi/NotificationApi/NotificationApi.dart';

class NotificationContoller extends ChangeNotifier {
  LocalNotificationService localNotificationService =  LocalNotificationService();
  GETDB getdb = GETDB();
  Config config = new Config();

 // NotificationContoller() {
    // getNotification();
    // onReciveFCM();
 // }
  List<NotificationModel> notify = [];
  List<NotificationModel> notifyreverse = [];
  List<NotificationModel> get getnotify => notify;

  int? unSeenNotify;
  int get getunSeenNotify => unSeenNotify != null ? unSeenNotify! : 0;

  getUnSeenNotify() async {
       final Database db = (await DBHelper.getInstance())!;
    unSeenNotify = await DBOperation.getUnSeenNotificationCount(db);
    notifyListeners();
  }

  getNotification() async {
       final Database db = (await DBHelper.getInstance())!;
    notifyreverse = await DBOperation.getNotification(db);
    print('Notify Count::'+notifyreverse.length.toString());
    notify =  notifyreverse.reversed.toList();
    notifyListeners();
  }

  // Future<int?> getNotificationCount() async {
  //   int? ii = await dbHelper.getUnSeenNotificationCount();
  //   notifyListeners();
  //   return ii;
  // }

  updateSeenTime(int id, String time) async {
       final Database db = (await DBHelper.getInstance())!;

    await DBOperation.updateNotify(id, time,db);
    notifyListeners();
    notifyreverse = await DBOperation.getNotification(db);
    notify =  notifyreverse.reversed.toList();
    notifyListeners();
  }

  swipeRefreshIndiactor() async {
   await getUnSeenNotify();
       final Database db = (await DBHelper.getInstance())!;
    notifyreverse = await DBOperation.getNotification(db);
    notify =  notifyreverse.reversed.toList();
    notifyListeners();
  }

  updateApi({int? docEntry, String? seenTime,String? deliveryTime}) async {
    log("seenTime: " + seenTime!);
    if (seenTime == '0') {
      String deviceID = (await HelperFunctions.getDeviceIDSharedPreference())!;
      await NotificationUpdateApi.getData(
          docEntry: docEntry,
          deliveryDT: deliveryTime,
          readDT: config.currentDate(),
          deviceCode: deviceID);
    }
  }

  onReciveFCM()async{
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      List<NotificationModel> notify = [];
  if (message.notification != null) {
       getUnSeenNotify();
  //  Provider.of<NotificationContoller>(context,listen: false).getUnSeenNotify();
 // navigatorKey.currentContext!.read<NotificationContoller>().getUnSeenNotify();
  }
});
}

clearData(){
  notify.clear();
  notifyreverse.clear();
  notifyListeners();
}

deleteNotify(int docid)async{
       final Database db = (await DBHelper.getInstance())!;
  await DBOperation.deleteNotify(docid,db);
  notifyListeners();
    notifyreverse = await DBOperation.getNotification(db);
    notify =  notifyreverse.reversed.toList();
    notifyListeners();
}
deleteNotifyAll()async{
       final Database db = (await DBHelper.getInstance())!;
  await DBOperation.deleteNotifyAll(db);
  notifyListeners();
    notifyreverse = await DBOperation.getNotification(db);
    notify =  notifyreverse.reversed.toList();
    notifyListeners();
}

gotoPages(String page,BuildContext context){
  if(page.toLowerCase().contains('accounts'))
  {
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.accounts);
  }
  else if(page.toLowerCase().contains('follow'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.followupTab);
  }
  else if(page.toLowerCase().contains('order'))
  {
     Navigator.pop(context);
    // Get.toNamed(ConstantRoutes.followupTab);
  }
  else if(page.toLowerCase().contains('walkin'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.walkins);
  }
  else if(page.toLowerCase().contains('oferr zone'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.offerZone);
  }
  else if(page.toLowerCase().contains('price'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.priceList);
  }
  else if(page.toLowerCase().contains('stock'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.stock);
  }
  else if(page.toLowerCase().contains('challenge'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.challenges);
  }
  else if(page.toLowerCase().contains('targets'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.targets);
  }
  else if(page.toLowerCase().contains('earnings'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.earnings);
  }
  else if(page.toLowerCase().contains('score card'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.scoreCardScreenOne);
  }
  else if(page.toLowerCase().contains('enquiry'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.enquiriesUser);
  }
  else if(page.toLowerCase().contains('Lead'))
  {
     Navigator.pop(context);
     Get.toNamed(ConstantRoutes.leadstab);
  }
}
}
