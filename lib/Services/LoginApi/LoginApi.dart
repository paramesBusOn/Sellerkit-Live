// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, non_constant_identifier_names, unnecessary_string_interpolations, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/Encripted.dart';
import 'package:html_unescape/html_unescape.dart';
import '../../Models/LoginModel/LoginModel.dart';
import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/Encripted.dart';

import '../URL/LocalUrl.dart';

class LoginAPi {
  static Future<LoginModel> getData(PostLoginData postLoginData) async {
    int resCode = 500;

    try {
     log("aaa::"+"${Url.queryApi}PortalAuthenticate/MOBILELOGIN");
     log("ConstantValues.token:::"+ConstantValues.token.toString());
      final response = await http.post(
          Uri.parse("${Url.queryApi}PortalAuthenticate/MOBILELOGIN"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "tenantId": "${ConstantValues.tenetID.toString().trim()}",
            "userCode": "${postLoginData.username.toString().trim()}",
            "password": "${postLoginData.password.toString().trim()}",
            "deviceCode": "${postLoginData.deviceCode}",
            "fcmToken": "${postLoginData.fcmToken}",
            "ip": ConstantValues.ipaddress,
            "ssid": ConstantValues.ipname,
            "lattitude": ConstantValues.latitude == 'null' ||
                    ConstantValues.latitude == ''
                ? 0.0
                : double.parse(ConstantValues.latitude.toString()),
            "longitude": ConstantValues.langtitude == 'null' ||
                    ConstantValues.langtitude == ''
                ? 0.0
                : double.parse(ConstantValues.langtitude.toString()),
                "devicename":"${postLoginData.devicename}",
          }));
      print("Login Req Body::" +
          jsonEncode({
           "tenantId": "${ConstantValues.tenetID.toString().trim()}",
            "userCode": "${postLoginData.username.toString().trim()}",
            "password": "${postLoginData.password.toString().trim()}",
            "deviceCode": "${postLoginData.deviceCode}",
            "fcmToken": "${postLoginData.fcmToken}",
            "ip": ConstantValues.ipaddress,
            "ssid": ConstantValues.ipname,
            "lattitude": ConstantValues.latitude == 'null' ||
                    ConstantValues.latitude == ''
                ? 0.0
                : double.parse(ConstantValues.latitude.toString()),
            "longitude": ConstantValues.langtitude == 'null' ||
                    ConstantValues.langtitude == ''
                ? 0.0
                : double.parse(ConstantValues.langtitude.toString()),
                "devicename":"${postLoginData.devicename}",
          }).toString());
     
      // log("ADADADDAD" + "${response.statusCode.toString()}");
      log("bodylogin::" + "${response.body}");

      resCode = response.statusCode;
      if (response.statusCode == 200) {
        //
        
        Config config = new Config();
         Map<String, dynamic> tokenNew3=json.decode(response.body);
        Map<String, dynamic> jres = config.parseJwt("${tokenNew3['token'].toString()}");
        log("ABCD7333:::" + jres.toString());
        EncryptData Encrupt = new EncryptData();
        String? testData2 = Encrupt.decrypt(jres['encrypted']);

        Map<String, dynamic> jres2 = jsonDecode("${testData2}");
        log("jres2:::"+jres2.toString());
        Map<String, dynamic> tokenNew=json.decode(response.body);
                log("token::::"+tokenNew['token'].toString());
       ConstantValues.token = tokenNew['token'];
        return LoginModel.fromJson(jres2,json.decode(response.body) ,response.statusCode);
      } else if(response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: error");
        return LoginModel.issue(response.statusCode, json.decode(response.body));
      }else{
        log("APIERRor::"+json.decode(response.body).toString());
        return LoginModel.issue(response.statusCode, json.decode(response.body));
      }
    } catch (e) {
      print("Catch:" + e.toString());
      return LoginModel.error(resCode, "${e}");
    }
  }
}

// body: jsonEncode({
//             "deviceCode": "${postLoginData.deviceCode}",
//             "userName":"${postLoginData.username}",
//             "password": postLoginData.password.toString().isEmpty || postLoginData.password == null?"null":"${postLoginData.password}",
//             "licenseKey":postLoginData.licenseKey.toString().isEmpty  || postLoginData.licenseKey == null?"null": "${postLoginData.licenseKey}",
//            "fcmToken":"${postLoginData.fcmToken}"
//           }));
