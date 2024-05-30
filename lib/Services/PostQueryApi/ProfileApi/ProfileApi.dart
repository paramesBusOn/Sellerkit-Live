// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ProfileModel.dart/ProfileModel.dart';
import 'package:sellerkit/main.dart';

class ProfileApi {
   Future<ProfileModel> getData(sapUserId) async {
    int resCode = 500;
    try {
      print("Profile api::"+Url.queryApi + 'SkClientPortal/getusersById?Id=${ConstantValues.UserId}');
      // await config.getSetup();
       final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/getusersById?Id=${ConstantValues.UserId}'),
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
    //  log("ProfileAPI4: " + response.body.toString());
      if (response.statusCode == 200) {
      //      ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // ProfileModel enquiryReferral =await port.first;
      //  islol.kill(priority: Isolate.immediate);
       return ProfileModel.fromJson(json.decode(response.body),response.statusCode);
      } else {
     //   print("Error: ${json.decode(response.body)}");
        return ProfileModel.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
     print("Exception: " + e.toString());
      return ProfileModel.error(e.toString(), resCode);
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
