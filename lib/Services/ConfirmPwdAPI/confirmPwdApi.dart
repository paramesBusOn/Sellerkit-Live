// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/ConfirmPwdModel.dart/ConfirmModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:http/http.dart' as http;

import '../../Constant/ConstantSapValues.dart';
// import 'package:sellerkit/main.dart';

class ConfirmPwdAPi {
  static String token = '';
  static Config config = Config();

  static Future<ConfirmPwdModel> getConfirmPwdData(
      String userCode, String oldPwd, String newPwd) async {
    int resCode = 500;
    try {
      log("UpdatePassword::${Url.queryApi}SellerKit/ChangePassword");
      log('ConstantValues.token::${ConstantValues.token}');
      log('userCode::${userCode}');
      log('newPwd::${newPwd}');
      log('oldPwd::${oldPwd}');

      // await config.getSetup();
      final response = await http.post(
          Uri.parse(
             Url.queryApi + "Sellerkit_Flexi/v2/ChangePassword"),
          headers: {
            "accept": "/",
            "content-type": "application/json",
            "Authorization": "bearer " + ConstantValues.token
            //eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbmNyeXB0ZWQiOiJVcmcvK1hpa3dvSGV1TUUySnZLZVRXV0tBNVpCNGJtVG5PN1NqbFgrVWRXbGZDY1lxWVNCT2hCYlZkSFR1ZVVsbXN3WVBjZ29UVGlnSXdSSHJMYzZvaGdTWWw2RTNYZGYxZUluTEFheENxdXcyOGNmQk5IUmhwZHFvVVJsRGZoR3E1b25Ob0hOb2YvQkhyVWd3dTZsSXU2bWpRRktreVZFc2poOHdNMndxd1dHTTNMbHVBb0VTSC9YV1JZUFdXLzdESU5kTlVCUU5wL2YramdMendzbkFlSW5GMzdkQXUxRm8wNVlQUUtzenArVTlITTRvb1A3SUgzL3JCNU1BM003VVRJekJwRTJWbnVtUUN2OTh0ZWdYQUVvNXVmekRmR3J3cW8zNnZnRVNqUWxIZTBUNXpMR1JjVFEyS2E5QVl6Zm9xb0JRMC9jSHNoczdEVnQ3VzJBSk9jZzE1ekUrb1htdndTaExlZjNKWllPeVlscEhMaUhCZ0I0MDdzV1lxTmZnTXNvNHVYNkZ0VkRHSmdlVjduSWNnUEowelhQZ2M3WTcvcnIzQWFzR0lhbVRxK0c4WHFBbzU4Y1hyUlA2RFZWd2JsL2tpODgzUVZKelYvcGhqS0N3SDBGNGlWL2h2VUlzK0RmZ2YvUHFSZz0iLCJuYmYiOjE3MDg1OTUxNDMsImV4cCI6MTcwODYyMzk0MywiaWF0IjoxNzA4NTk1MTQzfQ.cLrayCIouSNvuDn7qfodjYHOBd1hZ-QsOurpRVyl4qBZha5iqmrGdh13K4CDUBsPYsrHkMk8rPU3m-3PNpEVow'
          },
          body: jsonEncode({
            "userCode": "$userCode",
            "oldPassword": "$oldPwd",
            "newPassword": "$newPwd"
          }));
      print("confimn body" +
          jsonEncode({
            "userCode": userCode,
            "oldPassword": oldPwd,
            "newPassword": newPwd
          }));
      resCode = response.statusCode;
      print("confirmpassword statusCode:" + response.statusCode.toString());
      print("confirmpassword new: " + json.decode(response.body).toString());

      if (response.statusCode == 200) {
        return ConfirmPwdModel.fromJson(
            json.decode(response.body.toString()), resCode);
      } else {
        print("Error: error");
        return ConfirmPwdModel.error("Something went wrong..!!", resCode);
      }
    } catch (e) {
      print(e.toString());
      return ConfirmPwdModel.error("$e", resCode);
    }
  }
}