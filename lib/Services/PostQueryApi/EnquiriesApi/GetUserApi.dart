// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';

class GetUserApi {
   Future<UserListModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      
// Config config = Config();
      print("Anbuuuu"+Url.queryApi + 'Sellerkit_Flexi/v2/GetAllUsers?userId=$sapUserId');
      print("token:"+ConstantValues.token);
      // await config.getSetup();
       final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllUsers?userId=$sapUserId'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
      );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // print("sk_get_userlist_for_assign"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
      //     ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // UserListModal enquiryReferral =await port.first;
      //  islol.kill(priority: Isolate.immediate);
      //  return enquiryReferral;
      // log("JJHHS:"+response.body.toString() );
return UserListModal.fromJson(jsonDecode(response.body), response.statusCode);
      } else {
      //  print("Error: ${json.decode(response.body)}");
        return UserListModal.issues(jsonDecode(response.body), response.statusCode);
      }
    } catch (e) {
     // print("Exception: " + e.toString());
      return UserListModal.error(e.toString(), resCode);
    }
  }

  //   deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = UserListModal.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}
