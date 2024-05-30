import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/paymodemodel.dart';
import 'package:sellerkit/Models/leadexmodel/agemodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/DataBaseConfig.dart';

class DaystartApi {
  static Future<daycheckmodel> getData(
  
  ) async {
    int resCode = 500;
    try {
      
Config config = Config();
      log("URL:"+Url.queryApi+'Sellerkit_Flexi/v2/CheckDayStatus?UserCode=${ConstantValues.Usercode}');
      await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi+'Sellerkit_Flexi/v2/CheckDayStatus?UserCode=${ConstantValues.Usercode}'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer '+ ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //      "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_ENQUIRY_UPDATE_STATUS_LIST '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      print(response.statusCode.toString());
      // log("ResonAgeApi:"+response.body);
      
      if (response.statusCode == 200) {
        
        // Map data = json.decode(response.body);
        return daycheckmodel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        log("Errorreson: ${json.decode(response.body).toString()}");
        return daycheckmodel.issue(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception1: " + e.toString());
      return daycheckmodel.error("${e.toString()}", resCode);
    }
  }
}

class daycheckmodel{
  int? stcode;
  String? exception;
  String? rescode;
  String? restype;
  String? resdesc;
  int? data;
daycheckmodel({
  required this.stcode,
  required this.exception,
  required this.rescode,
  required this.restype,
  required this.resdesc,
  required this.data


});
factory daycheckmodel.fromJson(Map<String,dynamic> jsons,int stcode){
  return daycheckmodel(
    stcode: stcode, 
    exception: jsons[''], 
    rescode: jsons['respCode'],
    restype: jsons['respType'], 
    resdesc: jsons['respDesc'], 
    data: jsons['data']
    );

}
 factory daycheckmodel.error(String jsons,int stcode) {
    return daycheckmodel(
       stcode: stcode, 
    exception: null, 
    rescode: null,
    restype: null, 
    resdesc: null, 
    data: null
    );
  }
   factory daycheckmodel.issue(Map<String,dynamic> jsons,int stcode) {
    return daycheckmodel(
        stcode: stcode, 
    exception: jsons[''], 
    rescode: jsons['respCode'],
    restype: jsons['respType'], 
    resdesc: jsons['respDesc'], 
    data: null);
  }
}
