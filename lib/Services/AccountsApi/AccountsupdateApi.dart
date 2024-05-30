// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/AccountsModel/Accountspostmodel.dart';
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class AccountsUpdateApi {
  static Future<AccountsPostModal> getData(
      sapUserId, PostOrder postLead, PatchExCus patch) async {
    int resCode = 500;
    try {
      log("ConstantValues.token:::"+ConstantValues.token.toString());
      log("URLL::"+Url.queryApi + 'Sellerkit_Flexi/v2/UpdateCustomer');
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/UpdateCustomer'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
             "customercode": "${patch.CardCode}",
  "customername": "${patch.CardName}",
  "customermobile": "${patch.CardCode}",
  "alternatemobileno": patch.altermobileNo==null||patch.altermobileNo!.isEmpty?null: "${patch.altermobileNo}",
  "contactname":patch.cantactName==null||patch.cantactName!.isEmpty?null: "${patch.cantactName}",
  "customeremail":  patch.U_EMail==null||patch.U_EMail!.isEmpty?null:  "${patch.U_EMail}",
  "companyname": null,
  "gstno":  patch.gst==null||patch.gst!.isEmpty?null:"${patch.gst}",
  "codeid": null,
  "bil_address1": "${patch.U_Address1}",
  "bil_address2": "${patch.U_Address2}",
  "bil_address3": null,
  "bil_area": "${patch.area}",
  "bil_city": "${patch.U_City}",
  "bil_district": null,
  "bil_state": "${patch.U_State}",
  "bil_country": "${patch.U_Country}",
  "bil_pincode":  patch.U_Pincode==null?null:"${patch.U_Pincode}",
  "del_address1":  "${patch.U_ShipAddress1}",
  "del_address2":"${patch.U_ShipAddress2}",
  "del_address3": null,
  "del_area":"${patch.U_Shiparea}",
  "del_city": "${patch.U_ShipCity}",
  "del_district": null,
  "del_state": "${patch.U_ShipState}",
  "del_country": "${patch.U_ShipCountry}",
  "del_pincode": patch.U_ShipPincode==null?null: "${patch.U_ShipPincode}",
  "customergroup":  "${patch.U_Type}",
  "pan": null,
  "website": null,
  "facebook":null,
  "storecode": "${ConstantValues.Storecode}"
           
           
 
          }));
      log("save order Json ::" + jsonEncode({
             "customercode": "${patch.CardCode}",
  "customername": "${patch.CardName}",
  "customermobile": "${patch.CardCode}",
  "alternatemobileno": patch.altermobileNo==null||patch.altermobileNo!.isEmpty?null: "${patch.altermobileNo}",
  "contactname":patch.cantactName==null||patch.cantactName!.isEmpty?null: "${patch.cantactName}",
  "customeremail":  patch.U_EMail==null||patch.U_EMail!.isEmpty?null:  "${patch.U_EMail}",
  "companyname": null,
  "gstno":  patch.gst==null||patch.gst!.isEmpty?null:"${patch.gst}",
  "codeid": null,
  "bil_address1": "${patch.U_Address1}",
  "bil_address2": "${patch.U_Address2}",
  "bil_address3": null,
  "bil_area": "${patch.area}",
  "bil_city": "${patch.U_City}",
  "bil_district": null,
  "bil_state": "${patch.U_State}",
  "bil_country": "${patch.U_Country}",
  "bil_pincode":  patch.U_Pincode==null?null:"${patch.U_Pincode}",
  "del_address1":  "${patch.U_ShipAddress1}",
  "del_address2":"${patch.U_ShipAddress2}",
  "del_address3": null,
  "del_area":"${patch.U_Shiparea}",
  "del_city": "${patch.U_ShipCity}",
  "del_district": null,
  "del_state": "${patch.U_ShipState}",
  "del_country": "${patch.U_ShipCountry}",
  "del_pincode": patch.U_ShipPincode==null?null: "${patch.U_ShipPincode}",
  "customergroup":  "${patch.U_Type}",
  "pan": null,
  "website": null,
  "facebook":null,
  "storecode": "${ConstantValues.Storecode}"
        
          }).toString());
  log("json.decode(response.body)::"+json.decode(response.body).toString());
      resCode = response.statusCode;
      // print(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        // log("REsleadPost:" + json.decode(response.body).toString());

        return AccountsPostModal.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else {
        //return resCode;
        // print("Error: ${json.decode(response.body).toString()}");
        return AccountsPostModal.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception111: " + e.toString());
      // return resCode;
      return AccountsPostModal.error(e.toString(), resCode);
    }
  }

  static printData(PostOrder postLead) {
    log(jsonEncode(postLead.tojson()));
  }
}




// class LeadSavePostApi {
//   static Future<LeadSavePostModal> getData(sapUserId, PostLead postLead) async {
//     int resCode = 500;
//     log(Url.SLUrl + 'Quotations' + " .. ${ConstantValues.sapSessions} save lead api");
//     try {
//       await config.getSetup(); final response = await http.post(Uri.parse(Url.SLUrl + 'Quotations'),
//           headers: {
//             "content-type": "application/json",
//             "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
//           },
//           body: jsonEncode(postLead.tojson()));
//         log(jsonEncode(postLead.tojson()));
//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       log(json.decode(response.body).toString());
//       if (response.statusCode >= 200 && response.statusCode <= 210) {
//         return LeadSavePostModal.fromJson(json.decode(response.body.toString()), resCode);
//         // return resCode;
//       } else {
//         //return resCode;
//         print("Error: ${json.decode(response.body)}");
//         return LeadSavePostModal.issue(json.decode(response.body), resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       // return resCode;
//       return LeadSavePostModal.error(e.toString(), resCode);
//     }
//   }

//   static printData(PostLead postLead) {
//     log(jsonEncode(postLead.tojson()));
//   }
// }
