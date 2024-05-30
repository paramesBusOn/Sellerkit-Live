// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CheckEnqPrevModel.dart';

class EnqPrevDetailsApi {
  static Future<CheckEnqPrevDetailsModel> getData(
    int enqDocEntry
  ) async {
    int resCode = 500;
    try {
        
Config config = Config();
      log("PREVIOUS:"+Url.queryApi + 'SkClientPortal/GetPreviousenquiryDetails?EnqId=$enqDocEntry&slpCode=${ConstantValues.slpcode}');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetPreviousenquiryDetails?EnqId=$enqDocEntry&slpCode=${ConstantValues.slpcode}'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //      "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec sk_get_Enquiries_Details '$enqDocEntry','${ConstantValues.slpcode}'"
          // })
          );

// log("spLll: "+ jsonEncode({
//             "constr":
//                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec sk_get_Enquiries_Details '$enqDocEntry','${ConstantValues.slpcode}'"
//           }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("prevenq::"+response.body.toString());
      if (response.statusCode == 200) {
        return CheckEnqPrevDetailsModel.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return CheckEnqPrevDetailsModel.error('Error', resCode);
      }
    } catch (e) {
      log("Exception: " + e.toString());
      return CheckEnqPrevDetailsModel.error(e.toString(), resCode);
    }
  }
}
