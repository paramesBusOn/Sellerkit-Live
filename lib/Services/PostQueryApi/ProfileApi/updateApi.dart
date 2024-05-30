// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/ProfileModel.dart/profileupdate.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import 'package:sellerkit/main.dart';

class ProfileUpdateApi {
static   Future<ProfileupdateModel> getData(String? urlimage) async {
    int resCode = 500;
    try {
      print("Profile api::"+Url.queryApi + 'Sellerkit_Flexi/v2/UpdateProfilePic?UserId=${ConstantValues.UserId}&ProfilePicurl=$urlimage');
      // await config.getSetup();
       final response = await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/UpdateProfilePic?UserId=${ConstantValues.UserId}&ProfilePicurl=$urlimage'),
          headers: {
            "content-type": "application/json",
             "Authorization": 'bearer ' + ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_USER_PROFILE '$sapUserId'"
          // })
          );
      resCode = response.statusCode;
      // print(response.statusCode.toString());
     log("ProfileAPI4444444: " + response.body.toString());
      if (response.statusCode == 200) {
      //      ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // ProfileModel enquiryReferral =await port.first;
      //  islol.kill(priority: Isolate.immediate);
       return ProfileupdateModel.fromJson(json.decode(response.body),response.statusCode);
      } else {
     //   print("Error: ${json.decode(response.body)}");
        return ProfileupdateModel.issues(json.decode(response.body),response.statusCode);
      }
    } catch (e) {
     print("Exception: " + e.toString());
      return ProfileupdateModel.error(e.toString(),resCode);
    }
  }

  //      deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = ProfileModel.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}
