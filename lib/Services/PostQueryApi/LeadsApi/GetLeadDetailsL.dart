// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/constant_sapvalues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsL.dart';

class GetLeadDetailsLApi {
  static Future<GetLeadDetailsL> getData(
    docentry,
  ) async {
    int resCode = 500;
    try {
Config config = Config();

      log("leaddetails"+Url.queryApi + 'SkClientPortal/Getleaddetailslead?leaddocentry=$docentry');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/Getleaddetailslead?leaddocentry=$docentry'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_LEAD_DETAILS_LEAD '${docentry}'"
          // })
          );

      resCode = response.statusCode;
      log(response.statusCode.toString());
      log("LEAD_DETAILS_LEAD: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return GetLeadDetailsL.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetLeadDetailsL.error('Error', resCode);
      }
    } catch (e) {
      print("Exception22: " + e.toString());
      return GetLeadDetailsL.error(e.toString(), resCode);
    }
  }
}
