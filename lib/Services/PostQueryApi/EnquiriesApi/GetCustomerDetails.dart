import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/constant_sapvalues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';

class GetCutomerDetailsApi {
  static Future<GetCustomerDataHeader> getData(
    mobileNo,
    sapUserId,
  ) async {

    int resCode = 500;
    
    try {
      log("loogg::${ConstantValues.token}");
      log("loogg::${ConstantValues.EncryptedSetup}");
      log('${Url.queryApi}Sellerkit_Flexi/v2/Customers');
      // await config.getSetup(); 
      final response = await http.post(Uri.parse('${Url.queryApi}Sellerkit_Flexi/v2/Customers'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ${ConstantValues.token}',
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "listtype": "withrecenttrans",
  "valuetype": "name",
  "customermobile": "$mobileNo"
             })
          );

       
log("CUSTOMERJSON::${jsonEncode({
            "listtype": "withrecenttrans",
  "valuetype": "name",
  "customermobile": "$mobileNo"
             })}");
      resCode = response.statusCode;
      //  print("COmgetcus"+response.body.toString());
       log("COmgetcus:${response.body}");
     log("COm:${json.decode(response.body)}");
      if (response.statusCode == 200) {
        print("COmgetcus");
          
        return GetCustomerDataHeader.fromJson(
            json.decode(response.body)as Map<String,dynamic>, response.statusCode);
      } else {
        print("Errorgetcus::${response.body}");
        return GetCustomerDataHeader.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exceptiongetcus::$e");
      return GetCustomerDataHeader.error(e.toString(), resCode);
    }
  }
}



//old code
// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// 
// import 'package:sellerkit/Constant/constant_sapvalues.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';

// class GetCutomerDetailsApi {
//   static Future<GetCustomerDetailsModal> getData(
//     mobileNo,
//     sapUserId,
//   ) async {

//     int resCode = 500;
    
//     try {
//       Config config = Config();
      
//       print(Url.queryApi + 'SkClientPortal/GetCustomerBymoblie?mobile=$mobileNo');
//       // await config.getSetup(); 
//       final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetCustomerBymoblie?mobile=$mobileNo'),
//           headers: {
//             "content-type": "application/json",
//             "Authorization": 'bearer '+ ConstantValues.token,
//             "Location":'${ConstantValues.EncryptedSetup}'
//           },
//           // body: jsonEncode({
//           //   "constr":
//           //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//           //   "query":  "exec sk_get_customer '$mobileNo','${ConstantValues.slpcode}'"
//           // })
//           );

       

//       resCode = response.statusCode;
//        print("COmgetcus"+response.body.toString());
//        log("COmgetcus:"+response.body.toString());
//      log("COm:"+json.decode(response.body).toString());
//       if (response.statusCode == 200) {
//         print("COmgetcus");
          
//         return GetCustomerDetailsModal.fromJson(
//             json.decode(response.body), response.statusCode);
//       } else {
//         print("Errorgetcus::"+response.body);
//         return GetCustomerDetailsModal.error(response.body, response.statusCode);
//       }
//     } catch (e) {
//       print("Exceptiongetcus::"+e.toString());
//       return GetCustomerDetailsModal.error(e.toString(), resCode);
//     }
//   }
// }

