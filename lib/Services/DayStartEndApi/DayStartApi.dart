// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/EarningModel/EraningModel1.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
// import 'package:sellerkit/main.dart';

class DayStartApi {
  static Future<EarningModel1> getDayStartApiData(
      DayStartList? postData) async {
    int resCode = 500;
    try {
      log("DAYSART"+"${Url.queryApi}SkClientPortal/PostDayStart");
            Config config = Config();
      // await config.getSetup(); 
      final response = await http.post(
          Uri.parse('${Url.queryApi}Sellerkit_Flexi/v2/dayStart'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "userid": postData!.userId,
  "lat": double.parse(postData.latititudeST) ,
  "lon":double.parse(postData.longitudeST) ,
  "locaddress1": "${postData.startAddress}",
  "locaddress2": "${postData.address2}",
  "locaddress3": "${postData.address3}",
  "imageurl": postData.startPointImgurl==null?null:"${postData.startPointImgurl}"
    }));
print("DayStart Post::"+jsonEncode({
             "userid": postData!.userId,
  "lat": double.parse(postData.latititudeST) ,
  "lon":double.parse(postData.longitudeST) ,
  "locaddress1": "${postData.startAddress}",
  "locaddress2": "${postData.address2}",
  "locaddress3": "${postData.address3}",
  "imageurl": postData.startPointImgurl==null?null:"${postData.startPointImgurl}"
          }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("Earnings1Api" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return EarningModel1.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EarningModel1.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: $e");
      return EarningModel1.error(e.toString(), resCode);
    }
  }
}

class DayStartList {
  int userId; //1
  String slpCode; // SLP001
  String startAddress; // 4/44
  String startDate; //2023-09-28T09;38;51.401Z
  String latititudeST; //32540.325
  String longitudeST; //24.3564
  String startPointImgurl; //strin
  String? address2;
  String? address3;

  DayStartList({
    this.address2,
    this.address3,
    required this.userId, //1
    required this.slpCode, // SLP001
    required this.startAddress, // 4/44
    required this.startDate, //2023-09-28T09;38;51.401Z
    required this.latititudeST, //32540.325
    required this.longitudeST, //24.3564
    required this.startPointImgurl, //strin
  });
}
