// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/EarningModel/EraningModel1.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
// import 'package:sellerkit/main.dart';

class DayEndApi {
  static Future<EarningModel1> getDayEndApiData(DayEndList? postdata) async {
    int resCode = 500;
    try {
            Config config = Config();

      await config.getSetup(); 
      final response = await http.post(
          Uri.parse('${Url.queryApi}Sellerkit_Flexi/v2/dayEnd'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "userid": postdata!.userId,
  "lat": double.parse(postdata!.latititudeET.toString()),
  "lon":double.parse (postdata.longitudeET.toString()),
  "locaddress1": "${postdata!.endAddress}",
  "locaddress2": "${postdata!.address2}",
  "locaddress3": "${postdata!.address3}",
  "imageurl":postdata.startPointImgurl==null?null:"${postdata.startPointImgurl}"
            // "endAddress": "${postdata!.endAddress}",
            // "endDate": "${postdata.endDate}",
            // "latititudeET": postdata.latititudeET,
            // "longitudeET": postdata.longitudeET
          }));
print("Day End::"+jsonEncode({
             "userid": postdata!.userId,
  "lat": double.parse(postdata!.latititudeET.toString()),
  "lon":double.parse (postdata.longitudeET.toString()),
  "locaddress1": "${postdata!.endAddress}",
  "locaddress2": "${postdata!.address2}",
  "locaddress3": "${postdata!.address3}",
  "imageurl":postdata.startPointImgurl==null?null:"${postdata.startPointImgurl}"
          }));
      resCode = response.statusCode;
       log("DAYENDAPI" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return EarningModel1.fromJson(json.decode(response.body), resCode);
      } else {
       return EarningModel1.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      log("DAYENDAPIEXP" + e.toString());
      return EarningModel1.error(e.toString(), resCode);
    }
  }
}

class DayEndList {
  String? endAddress; // 4/44
  String? endDate; //2023-09-28T09;38;51.401Z
  String? latititudeET; //32540.325
  String? longitudeET; 
  String? address2;
  String? address3;
  String? startPointImgurl;
  int? userId;//24.3564

  DayEndList({
    required this.userId,
    required this.address2,
    required this.address3,
    required this.startPointImgurl,
    required this.endAddress, // 4/44
    required this.endDate, //2023-09-28T09;38;51.401Z
    required this.latititudeET, //32540.325
    required this.longitudeET, //24.3564
  });
}
