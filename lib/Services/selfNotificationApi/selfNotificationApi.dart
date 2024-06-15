import 'dart:convert';

import 'dart:developer';
import 'package:http/http.dart' as http;

class SelfNotificationSendApi {
  static Future<NotifiModel> getData(
      String screenName, String fcm, String titile, String body) async {
    int resCode = 500;
    try {
      final response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: {
                "content-type": "application/json",
                "Authorization":
                    'key=AAAARtTb1Zo:APA91bEJ9s5zg46zeTqgRKEIm_K7iRBdS8dDOE59DCf5zaY3WZNE8UymnJdLWi1C-herAGdg5ogGZDB7cyDSNpnh1SDcRyX0781BfysfT3UK78mKug016OntP4bMGsz9tdNMsdeHowlg',
              },
              body: jsonEncode({
                "to": fcm,
                "notification": {
                  "body": body,
                  "content_available": true,
                  "mutable_content": true,
                  "priority": "high",
                  "title": titile
                },
                "data": {
                  "DocEntry": "0",
                  "NaviScreen": screenName,
                  "JobId": "2"
                }
              }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("notifi res:${json.decode(response.body)}");
      if (response.statusCode >= 200 && response.statusCode <= 200) {
        return NotifiModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return NotifiModel.issues(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception: $e");
      return NotifiModel.error(500);
    }
  }
}

class NotifiModel {
  int? stcode;
  int? sucesscode;
  NotifiModel({
    this.stcode,
    required this.sucesscode,
  });

  factory NotifiModel.error(int resCode) {
    return NotifiModel(stcode: resCode, sucesscode: 0);
  }

  factory NotifiModel.issues(Map<String, dynamic> res, int statusCode) {
    return NotifiModel(stcode: statusCode, sucesscode: 0);
  }

  factory NotifiModel.fromJson(Map<String, dynamic> res, int statusCode) {
    return NotifiModel(stcode: statusCode, sucesscode: res['success']);
  }
}
