import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Models/OTPMsg/OTPMsg.dart';
import 'package:sellerkit/main.dart';

class ManagerOTPApi1 {
  static Future<OTPMsg> getManagerOTPApi1(String? otpNum) async {
    int resCode = 500;
    try {
      await config.getSetup(); final response = await http.post(
            Uri.parse(
                "https://api.ultramsg.com/instance11070/messages/chat?token=f52pktts5h3t3c2e&to=+91${ConstantValues.managerPhonenum}&body=Your%20OTP%20for%20Forget%20Password%20is%20$otpNum%20-%20Seller%20Kit&priority=10"),
          ), //${ConstantValues.phoneNum}
          resCode = response.statusCode;
      print(
          "https://api.ultramsg.com/instance11070/messages/chat?token=f52pktts5h3t3c2e&to=+91${ConstantValues.managerPhonenum}&body=Your%20OTP%20for%20Forget%20Password%20is%20$otpNum%20-%20Seller%20Kit&priority=10");

      print(response.statusCode.toString());
      print("offerZone:${response.body}");
      if (response.statusCode == 200) {
        return OTPMsg.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return OTPMsg.exception('Error', resCode);
      }
    } catch (e) {
      print("Exception: $e");
      return OTPMsg.exception(e.toString(), resCode);
    }
  }
}
