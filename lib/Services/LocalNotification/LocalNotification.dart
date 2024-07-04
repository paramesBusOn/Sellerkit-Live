// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class LocalNotificationService {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      "hig_importance_channel", "High Importance Notification",
      importance: Importance.high, playSound: true, showBadge: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

        Future init()async{
  AndroidInitializationSettings android = const AndroidInitializationSettings('ic_launcher');

  var ios = DarwinInitializationSettings(
  requestAlertPermission :true,
   requestSoundPermission : true,
   requestBadgePermission : true,
   onDidReceiveLocalNotification: ( id,  title, body, payload) async{

    log("message: datratata");
    });


   var initSettings = InitializationSettings(
    android: android,
   iOS: ios );
  //  await _requestPermissions();

    void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
// this should print now
    log("notifications: "+notificationResponse.payload.toString());
// let's add some switch statements here
switch (notificationResponse.notificationResponseType) {
// triggers when the notification is tapped
        case NotificationResponseType.selectedNotification:
          if (notificationResponse.payload != null) {
            try {
             
              var notificationPayload =
                  (jsonDecode(notificationResponse.payload.toString()));
              log("decoded: "+notificationPayload.toString()); // prints the decoded JSON

                      log("DocEntry: "+notificationPayload ["DocEntry"].toString()); 
            } catch (error) {
              log('Notification payload error $error');
            }
          }
          break;
        default:
      }
}


 await  flutterLocalNotificationsPlugin.initialize(initSettings,
   onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
  //  (NotificationResponse details) {
  //    log("payload: "+details.payload.toString());
  //    log("payload22: "+ details.actionId.toString());
  //    details.toString();
  //  },
    // onDidReceiveBackgroundNotificationResponse: (v){
    //   log("payload: "+v.payload.toString());
    // },
   );

     await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
}

Future<void> _requestPermissions() async {
if (Platform.isIOS || Platform.isMacOS) {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
} else if (Platform.isAndroid) {
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  //final bool? granted = await androidImplementation?.requestPermission();

}
}

  void showNitification(
      {String? titile, String? msg, RemoteMessage? message}) async {
          if(titile.toString().toLowerCase() != 'logout') { 
    if (message!.notification!.android!.imageUrl != null) {
      String? url = _getImageUrl(message.notification!);
       List<String> data = url!.split("/");
      String? filePath = await _downloadAndSavePicture(url, data.last);

      NotificationDetails notificationDetails =
          _buildDetails(titile!, msg!, filePath, true);
        
           await flutterLocalNotificationsPlugin.show(
        1,
        titile,
        msg,
        notificationDetails
        );
    }else{
  await flutterLocalNotificationsPlugin.show(
        1,
        titile ?? 'Testing !!!',
        msg ?? 'Testing how are you',
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id, channel.name,
          importance: Importance.high,
          color: Colors.red,
          playSound: true,
          enableVibration: true,
          enableLights: true,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          fullScreenIntent: false,
          // styleInformation: StyleInformation()
        ))
        );
    } 
    } 
  }

  String? _getImageUrl(RemoteNotification notification) {
    if (Platform.isIOS && notification.apple != null ||Platform.isIOS && notification.apple != "") {
      return notification.apple?.imageUrl;
    }
    if (Platform.isAndroid && notification.android != null||Platform.isIOS && notification.apple != "") {
      return notification.android?.imageUrl;
    }
    return null;
  }

  Future<String?> _downloadAndSavePicture(String? url, String fileName) async {
    if (url == null || url.isEmpty || url == "null") return null;
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  NotificationDetails _buildDetails(
      String title, String body, String? picturePath, bool showBigPicture) {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      styleInformation: buildBigPictureStyleInformation(
          title, body, picturePath, showBigPicture),
      importance: Importance.high,
      color: Colors.red,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      fullScreenIntent: false,
    );
  final DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert:true,
          presentBadge:true,
          presentBanner: true,
          presentSound: true,
          attachments:picturePath==null || picturePath==''&&picturePath.isEmpty?null: <DarwinNotificationAttachment>[
      DarwinNotificationAttachment(picturePath.toString())
    ]);
    final NotificationDetails details = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );
    return details;
  }

  BigPictureStyleInformation? buildBigPictureStyleInformation(
    String title,
    String body,
    String? picturePath,
    bool showBigPicture,
  ) {
    if (picturePath == null) return null;
    final FilePathAndroidBitmap filePath = FilePathAndroidBitmap(picturePath);
    return BigPictureStyleInformation(
      showBigPicture ? filePath : const FilePathAndroidBitmap("empty"),
      largeIcon: filePath,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
  }



  //

  Future Shownoti({int id=0,String? title,String? body, 
   required RemoteMessage message  })async{
    log("loogg"+title.toString()+body.toString());
    String? filePath;
    String? url = _getImageUrl(message.notification!);
    log("url::"+url.toString());
    if(url !=null &&url !="") {
 List<String> data = url!.split("/");
      filePath = await _downloadAndSavePicture(url, data.last);
  
    }
  
   DataNoti datano = DataNoti(docentry: int.parse(message.data['DocEntry']??''), image: message.data['image']??'',
   naviscreen: message.data['NaviScreen']??'',JobId: message.data['JobId']??''
   
   );
var datass =jsonEncode(datano.tojson());

NotificationDetails notificationDetails =
          _buildDetails(title!, body!, filePath, true);
  if(title.toString().toLowerCase() != 'logout') { 
flutterLocalNotificationsPlugin.show(id, title, body,notificationDetails,

  payload: datass
   );
 }
 //await notificationss()
}
  notificationss(){
      return NotificationDetails(
         android: AndroidNotificationDetails(
          channel.id, channel.name,
          importance: Importance.high,
          color: Colors.red,
          playSound: true,
          enableVibration: true,
          enableLights: true,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          fullScreenIntent: false,
          // styleInformation: StyleInformation()
        ),
        // AndroidNotificationDetails("channelId", "channelName",importance: Importance.high),
        // iOS: DarwinNotificationDetails(
        //   attachments: [DarwinNotificationAttachment(filePath)]
        // )
      );
  }
}


class DataNoti {

  int docentry;
  String naviscreen;
  String image;
  String? JobId;

  DataNoti({
    required this.docentry,
    required this.image,
    required this.naviscreen,
    required this.JobId
  });

   Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "DocEntry": docentry,
        "NaviScreen":naviscreen,
        "image": image,
        "JobId":JobId
    };
    return map;
  }
   
}