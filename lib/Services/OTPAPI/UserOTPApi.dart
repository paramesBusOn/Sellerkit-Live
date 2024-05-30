import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Models/OTPMsg/OTPMsg.dart';
import 'package:sellerkit/main.dart';

class UserOTPApi1 {
  static Future<OTPMsg> getOTPApi1(String? otpNum) async {
    int resCode = 500;
    print(                "https://api.ultramsg.com/instance11070/messages/chat?token=f52pktts5h3t3c2e&to=+91${ConstantValues.phoneNum}&body=Your%20OTP%20for%20Forget%20Password%20is%20$otpNum%20-%20Seller%20Kit&priority=10");
    try {
      await config.getSetup(); final response = await http.post(
            Uri.parse(
                "https://api.ultramsg.com/instance11070/messages/chat?token=f52pktts5h3t3c2e&to=+91${ConstantValues.phoneNum}&body=Your%20OTP%20for%20Forget%20Password%20is%20$otpNum%20-%20Seller%20Kit&priority=10"),
         
         headers: {
            "content-type": "application/json",
          },
          ), 
          resCode = response.statusCode;
       print(response.statusCode.toString());
      String responseBody = utf8.decoder.convert(response.bodyBytes);
        print(responseBody);
      if (response.statusCode == 200) {
        return OTPMsg.fromJson(json.decode(responseBody), resCode);
      } else {
        print("Error: ${json.decode(responseBody)}");
        return OTPMsg.exception('Error', resCode);
      }
    } catch (e) {
      print("Exception: $e");
      return OTPMsg.exception(e.toString(), resCode);
    }
  }
}
