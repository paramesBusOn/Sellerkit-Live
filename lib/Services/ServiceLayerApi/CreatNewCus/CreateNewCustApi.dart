// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/AddEnqModel/AddEnqModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CustomerCreationModel.dart';

class NewCustCretApi {
  static Future<NewCustomerEnqValue> getData(
      sapUserId, PatchExCus patch, List<LeadCheckData> leadCheckData,
      [PostLead? postLead]) async {
    int resCode = 500;
    log(Url.queryApi + 'Sellerkit_Flexi/v2/AddLead');

    try {
      log("Token::" + ConstantValues.token.toString());
      log("Token::" + ConstantValues.EncryptedSetup.toString());
      Config config = Config();
      // await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/AddLead'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
           "interestLevel":patch.levelof==null?null:"${patch.levelof}",
           "orderType":patch.ordertype==null?null:"${patch.ordertype}",
            "leadDate": "${config.currentDate()}",
            "customerCode": "${patch.CardCode}",
            "customerName": "${patch.CardName!.replaceAll("'", "''")}",
            "customerMobile": "${patch.CardCode}",
            "customerEmail": patch.U_EMail==null?null:"${patch.U_EMail!.replaceAll("'", "''")}",
            "alternateMobileNo": patch.altermobileNo==null?null:"${patch.altermobileNo}",
            "contactName": patch.cantactName==null?null:"${patch.cantactName!.replaceAll("'", "''")}",
            "baseid":patch. enqid,
            "companyName": null,
            "customerGroup":patch.U_Type==null?null: "${patch.U_Type}",
            "storeCode": ConstantValues.Storecode,
            "address1": patch.U_Address1==null?null:"${patch.U_Address1!.replaceAll("'", "''")}",
            "address2":patch.U_Address2==null?null: "${patch.U_Address2!.replaceAll("'", "''")}",
            "area": patch.area==null?null:"${patch.area!.replaceAll("'", "''")}",
            "city": patch.U_City==null?null:"${patch.U_City!.replaceAll("'", "''")}",
            "district": null,
            "state": patch.U_State==null?null: "${patch.U_State}",
            "country": "${patch.U_Country}",
      "pincode":patch.U_Pincode==null?null :int.parse(patch.U_Pincode.toString()),
           
            "gender":postLead!.U_sk_gender==null?null: "${postLead!.U_sk_gender}",
            "headcount": int.parse(postLead.U_sk_headcount.toString()),
            "maxbudget": int.parse(postLead.U_sk_budget.toString()),
            "ageGroup":postLead.U_sk_Agegroup==null?null: "${postLead.U_sk_Agegroup}",
            "cameAs":postLead.U_sk_cameas==null?null: "${postLead.U_sk_cameas}",
            "assignedTo":null,
            "refferal": "${postLead.U_sk_Referals}",
            "purchasePlan": "${postLead.U_sk_planofpurchase}",
            "nextFollowupDate": "${postLead.U_sk_NextFollowDt}",
            "enquiryDescription": null,
            "leadLines": postLead.docLine!.map((e) => e.tojason2()).toList(),
            "checkList": leadCheckData.map((e) => e.tojson3()).toList()
          }));
      print("body Lead:" +
          jsonEncode({
           
        "interestLevel":patch.levelof==null?null:"${patch.levelof}",
           "orderType":patch.ordertype==null?null:"${patch.ordertype}",
            "leadDate": "${config.currentDate()}",
            "customerCode": "${patch.CardCode}",
            "customerName": "${patch.CardName}",
            "customerMobile": "${patch.CardCode}",
            "customerEmail": patch.U_EMail==null?null:"${patch.U_EMail}",
            "alternateMobileNo": patch.altermobileNo==null?null:"${patch.altermobileNo}",
            "contactName": patch.cantactName==null?null:"${patch.cantactName}",
            "baseid":patch. enqid,
            "companyName": null,
            "customerGroup":patch.U_Type==null?null: "${patch.U_Type}",
            "storeCode": ConstantValues.Storecode,
            "address1": patch.U_Address1==null?null:"${patch.U_Address1}",
            "address2":patch.U_Address2==null?null: "${patch.U_Address2}",
            "area": patch.area==null?null:"${patch.area}",
            "city": patch.U_City==null?null:"${patch.U_City}",
            "district": null,
            "state": patch.U_State==null?null: "${patch.U_State}",
            "country": "${patch.U_Country}",
      "pincode":patch.U_Pincode==null?null :int.parse(patch.U_Pincode.toString()),
           
            "gender":postLead!.U_sk_gender==null?null: "${postLead!.U_sk_gender}",
            "headcount": int.parse(postLead.U_sk_headcount.toString()),
            "maxbudget": int.parse(postLead.U_sk_budget.toString()),
            "ageGroup":postLead.U_sk_Agegroup==null?null: "${postLead.U_sk_Agegroup}",
            "cameAs":postLead.U_sk_cameas==null?null: "${postLead.U_sk_cameas}",
            "assignedTo":null,
            "refferal": "${postLead.U_sk_Referals}",
            "purchasePlan": "${postLead.U_sk_planofpurchase}",
            "nextFollowupDate": "${postLead.U_sk_NextFollowDt}",
            "enquiryDescription": null,
            "leadLines": postLead.docLine!.map((e) => e.tojason2()).toList(),
            "checkList": leadCheckData.map((e) => e.tojson3()).toList()
          }).toString());
      resCode = response.statusCode;
      print("New Customer ::" + response.statusCode.toString());
      // log("New Customer response::" + json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        log("datain");
        return NewCustomerEnqValue.fromJson(
            json.decode(response.body), response.statusCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        // log("Error: ${json.decode(response.body).toString()}");
        // throw Exception("Error");

        return NewCustomerEnqValue.issue(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception("Error");
        return NewCustomerEnqValue.issue(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //throw Exception(e.toString());
      return NewCustomerEnqValue.exception(e.toString(), resCode);
    }
  }
}
//  body: jsonEncode({
//                 "CardCode": "${patch.CardCode}", // "8610659136",
//                 "CardName": "${patch.CardName}",
//                 "CardType": "cCustomer",
//                 "SalesPersonCode" : "${ConstantValues.slpcode}",
//                 "LanguageCode": 8,
//                 "U_Address1": "${patch.U_Address1}",
//                 "U_Address2": "${patch.U_Address2}",
//                 "U_City": "${patch.U_City}",
//                 "U_Pincode": "${patch.U_Pincode}",
//                 "U_State": patch.U_State == null ? null : "${patch.U_State}",
//                 "U_Country":
//                     patch.U_Country == null ? null : "${patch.U_Country}",
//                 "U_Facebook":
//                     patch.U_Facebook == null ? null : "${patch.U_Facebook}",
//                 "U_EMail": "${patch.U_EMail}",
//                 "U_Type":"${patch.U_Type}"
//               })

//old Code
// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, avoid_print

// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Constant/Configuration.dart';
// import '../../../Constant/ConstantSapValues.dart';
// import '../../../Models/AddEnqModel/AddEnqModel.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/CustomerCreationModel.dart';

// class NewCustCretApi {
//   static Future<NewCustomerEnqValue> getData(sapUserId, PatchExCus patch,
//       [PostLead? postLead]) async {
//     int resCode = 500;
//     log(Url.queryApi + 'SkClientPortal/PostCustomer');
      
//     try {
//       log("Token::"+ConstantValues.token);
//         Config config= Config();
//         await config.getSetup();
//       final response =
//           await http.post(Uri.parse(Url.queryApi + 'SkClientPortal/PostCustomer'),
//               headers: {
//                 "content-type": "application/json",
//                 "Authorization": 'bearer ' + ConstantValues.token,
//                 "Location":'${ConstantValues.EncryptedSetup}'
//               },
//               body: jsonEncode({
//                 "id": 0,
//   "customerCode": "${patch.CardCode}",
//   "customerName": "${patch.CardName}",
//   "mobileNo": "${patch.CardCode}",
//   "alternateMobileNo": "${patch.altermobileNo}",
//   "contactName": "${patch.cantactName}",
//   "facebook": patch.U_Facebook == null ? null : "${patch.U_Facebook}",
//   "cardtype": "cCustomer",
//   "email": "${patch.U_EMail}",
//   "gstNo": "${patch.gst}",
//   "codeId": "",
//   "createdBy": ConstantValues.UserId,
//   "createdOn": "${config.currentDate()}",
//   "updatedBy": ConstantValues.UserId,
//   "updatedOn": "${config.currentDate()}",
//   "address1": "${patch.U_Address1}",
//   "address2": "${patch.U_Address2}",
//   "address3": "",
//   "city": "${patch.U_City}",
//   "state": patch.U_State == null ? null : "${patch.U_State}",
//   "country": patch.U_Country == null ? null : "${patch.U_Country}",
//   "pinCode": "${patch.U_Pincode}",
//   "shippingAddress1": "",
//   "shippingAddress2": "",
//   "shippingAddress3": "",
//   "shippingCity": "",
//   "shippingState": "",
//   "shippingCountry": "",
//   "shippingPinCode": "",
//   "tag": "${patch.U_Type}",
//   "status": true
//               }));
//     print("body Lead:"+jsonEncode({
//                 "id": 0,
//   "customerCode": "${patch.CardCode}",
//   "customerName": "${patch.CardName}",
//   "mobileNo": "${patch.CardCode}",
//   "alternateMobileNo": "${patch.altermobileNo}",
//   "contactName": "${patch.cantactName}",
//   "facebook": patch.U_Facebook == null ? null : "${patch.U_Facebook}",
//   "cardtype": "cCustomer",
//   "email": "${patch.U_EMail}",
//   "gstNo": "${patch.gst}",
//   "codeId": "",
//   "createdBy": ConstantValues.UserId,
//   "createdOn": "${config.currentDate()}",
//   "updatedBy": ConstantValues.UserId,
//   "updatedOn": "${config.currentDate()}",
//   "address1": "${patch.U_Address1}",
//   "address2": "${patch.U_Address2}",
//   "address3": "",
//   "city": "${patch.U_City}",
//   "state": patch.U_State == null ? null : "${patch.U_State}",
//   "country": patch.U_Country == null ? null : "${patch.U_Country}",
//   "pinCode": "${patch.U_Pincode}",
//   "shippingAddress1": "",
//   "shippingAddress2": "",
//   "shippingAddress3": "",
//   "shippingCity": "",
//   "shippingState": "",
//   "shippingCountry": "",
//   "shippingPinCode": "",
//   "tag": "${patch.U_Type}",
//   "status": true
//               }));
//       resCode = response.statusCode;
//       print("New Customer ::"+response.statusCode.toString());
//       log("New Customer response::"+json.decode(response.body).toString());
//       if (response.statusCode >= 200 && response.statusCode <= 210) {
//         log("datain");
//         return NewCustomerEnqValue.fromJson(
//             json.decode(response.body.toString()), response.statusCode);
//       } else if (response.statusCode >= 400 && response.statusCode <= 410) {
//         log("Error: ${json.decode(response.body).toString()}");
//         // throw Exception("Error");

//         return NewCustomerEnqValue.issue(json.decode(response.body), response.statusCode);
//       } else {
//         // throw Exception("Error");
//         return NewCustomerEnqValue.exception('', response.statusCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       //throw Exception(e.toString());
//       return NewCustomerEnqValue.exception(e.toString(), resCode);
//     }
//   }
// }
// //  body: jsonEncode({
// //                 "CardCode": "${patch.CardCode}", // "8610659136",
// //                 "CardName": "${patch.CardName}",
// //                 "CardType": "cCustomer",
// //                 "SalesPersonCode" : "${ConstantValues.slpcode}",
// //                 "LanguageCode": 8,
// //                 "U_Address1": "${patch.U_Address1}",
// //                 "U_Address2": "${patch.U_Address2}",
// //                 "U_City": "${patch.U_City}",
// //                 "U_Pincode": "${patch.U_Pincode}",
// //                 "U_State": patch.U_State == null ? null : "${patch.U_State}",
// //                 "U_Country":
// //                     patch.U_Country == null ? null : "${patch.U_Country}",
// //                 "U_Facebook":
// //                     patch.U_Facebook == null ? null : "${patch.U_Facebook}",
// //                 "U_EMail": "${patch.U_EMail}",
// //                 "U_Type":"${patch.U_Type}"
// //               })