// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/AddEnqModel/AddEnqModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnqPostModel.dart';

// old  Url.queryApi + 'SkClientPortal/PostEnquiry'
class EnqPostApi {
  static Future<EnqPostModal> getData(
      sapUserId, PostEnq patch, PatchExCus patchdet) async {
    int resCode = 500;
    log("postURL" + Url.queryApi + 'Sellerkit_Flexi/v2/Enquiry');
    log("jj::" + ConstantValues.token.toString());
    log("KK::" + ConstantValues.EncryptedSetup.toString());
    try {
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/Enquiry'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "interestLevel":patchdet.levelof==null?null:"${patchdet.levelof}",
            "OrderType":patchdet.ordertype==null?null:"${patchdet.ordertype}",
            "enquiredOn": "${config.currentDate()}",
            "customerCode": "${patch.CardCode}",
            "customerName": "${patchdet.CardName!.replaceAll("'", "''")}",
            "contactName":patchdet.cantactName ==null?null: "${patchdet.cantactName!.replaceAll("'", "''")}",
            "alternateMobileNo":patchdet.altermobileNo ==null?null: "${patchdet.altermobileNo}",
            "bilArea":patchdet.area ==null?null: "${patchdet.area!.replaceAll("'", "''")}",
            "customerMobile": "${patchdet.CardCode}",
            "companyName": null,
            "customerEmail":patchdet.U_EMail==null?null: "${patchdet.U_EMail!.replaceAll("'", "''")}",
            "customerGroup": "${patchdet.U_Type}",
            "storeCode": ConstantValues.Storecode,
            "address1": patchdet.U_Address1 ==null?null:"${patchdet.U_Address1!.replaceAll("'", "''")}",
            "address2":patchdet.U_Address2 ==null?null: "${patchdet.U_Address2!.replaceAll("'", "''")}",
            "pinCode":patchdet.U_Pincode==null?null: patchdet.U_Pincode,
            "city": patchdet.U_City ==null?null:"${patchdet.U_City!.replaceAll("'", "''")}",
            "district": null,
            "state": patchdet.U_State == null ||patchdet.U_State!.isEmpty? null : "${patchdet.U_State}",
            "country":
                patchdet.U_Country == null || patchdet.U_Country!.isEmpty? null : "${patchdet.U_Country}",
            "potentialvalue": patch.U_PotentialValue,
            //  0,
            "itemCode": null,
            "itemName": null,
            "assignedTo": "${patch.assignedtoslpCode}",
            "refferal": "${patch.U_EnqRefer}",
            "enquiryType": patch.ActivityType,
            "lookingfor": "${patch.U_Lookingfor}",
            "enquirydscription": "${patchdet.remarks!.replaceAll("'", "''")}",
            "quantity": 0,
            "followupOn":  patch.remainderdate == null ? null : "${patch.remainderdate}",
            "isVisitRequired": "${patch.isvist}",
            "visitTime": patch.sitedate == null ? null : "${patch.sitedate}",
            "remindOn":
                patch.remainderdate == null ? null : "${patch.remainderdate}"
          }));
      log("postbody::" +
          jsonEncode({
             "interestLevel":patchdet.levelof==null?null:"${patchdet.levelof}",
            "OrderType":patchdet.ordertype==null?null:"${patchdet.ordertype}",
            "enquiredOn": "${config.currentDate()}",
            "customerCode": "${patch.CardCode}",
            "customerName": "${patchdet.CardName}",
            "contactName":patchdet.cantactName ==null?null: "${patchdet.cantactName}",
            "alternateMobileNo":patchdet.altermobileNo ==null?null: "${patchdet.altermobileNo}",
            "bilArea":patchdet.area ==null?null: "${patchdet.area}",
            "customerMobile": "${patchdet.CardCode}",
            "companyName": null,
            "customerEmail":patchdet.U_EMail==null?null: "${patchdet.U_EMail}",
            "customerGroup": "${patchdet.U_Type}",
            "storeCode": ConstantValues.Storecode,
            "address1": patchdet.U_Address1 ==null?null:"${patchdet.U_Address1}",
            "address2":patchdet.U_Address2 ==null?null: "${patchdet.U_Address2}",
            "pinCode": patchdet.U_Pincode,
            "city": patchdet.U_City ==null?null:"${patchdet.U_City}",
            "district": null,
            "state": patchdet.U_State == null ||patchdet.U_State!.isEmpty? null : "${patchdet.U_State}",
            "country":
                patchdet.U_Country == null || patchdet.U_Country!.isEmpty? null : "${patchdet.U_Country}",
            "potentialvalue": patch.U_PotentialValue,
            //  0,
            "itemCode": null,
            "itemName": null,
            "assignedTo": "${patch.assignedtoslpCode}",
            "refferal": "${patch.U_EnqRefer}",
            "enquiryType": patch.ActivityType,
            "lookingfor": "${patch.U_Lookingfor}",
            "enquirydscription": "${patchdet.remarks}",
            "quantity": 0,
            "followupOn":  patch.remainderdate == null ? null : "${patch.remainderdate}",
            "isVisitRequired": "${patch.isvist}",
            "visitTime": patch.sitedate == null ? null : "${patch.sitedate}",
            "remindOn":
                patch.remainderdate == null ? null : "${patch.remainderdate}"
          }));
      // jsonEncode({
      //   "id": 0,
      //   "customerCode": "${patch.CardCode}",
      //   "activity": "CCustomer",
      //   "activityType": patch.ActivityType,
      //   "potentialvalue": patch.U_PotentialValue,
      //   "u_Lookingfor": "${patch.U_Lookingfor}",
      //   "u_AssignedTo": "${patch.assignedtoslpCode}",
      //   // ${patch.assignedtoslpCode}
      //   "u_ManagerSlp": "${patch.assignedtoManagerSlpCode}",
      //   "u_EnqStatus": "NEW ENQUIRY",
      //   "u_EnqRefer": "${patch.U_EnqRefer}",
      //   "createdby": ConstantValues.UserId,
      //   "createdDate": "${config.currentDate()}",
      //   "updatedby": ConstantValues.UserId,
      //   //  ConstantValues.UserId
      //   "updateddate": "${config.currentDate()}",
      //    "closed": "N"
      // }));

//       log("Post enq " +
//           jsonEncode({
//  "id": 0,
//   "customerCode": "${patch.CardCode}",
//   "customerName": "${patchExc.CardName}",
//   "mobileNo": "${patch.CardCode}",
//   "alternateMobileNo": patchExc.altermobileNo,
//   "contactName": patchExc.cantactName,
//   "email": patchExc.U_EMail,
//   "gstNo": patchExc.gst,
//   "codeId": null,
//   "address1": patchExc.U_Address1,
//   "address2": patchExc.U_Address2,
//   "city": patchExc.U_City,
//   "state": patchExc.U_State == null ? null : "${patchExc.U_State}",
//   "country": "${ConstantValues.Country}",
//   "tag": patchExc.U_Type,
//   "status": true,
//   "pinCode": patchExc.U_Pincode,
//   "activity": "CcCustomer",
//   "activityType": patch.ActivityType,
//   "potentialvalue":  patch.U_PotentialValue,
//   "u_Lookingfor": "${patch.U_Lookingfor}",
//   "u_AssignedTo": "${patch.assignedtoslpCode}",
//   "u_ManagerSlp": "${patch.assignedtoManagerSlpCode}",
//   "u_EnqStatus": "NEW ENQUIRY",
//   "u_EnqRefer": "${patch.U_EnqRefer}",
//   "createdby": int.parse(ConstantValues.UserId.toString()),
//   "createdDate": "${config.currentDate()}",
//   "updatedby": int.parse(ConstantValues.UserId.toString()),
//   "updateddate": "${config.currentDate()}",
//   "u_Followupdate": null,
//   "closed": "N",
//   "leadConversion": 0,
//   "enquirydscription": null,
//   "itemCode": null,
//   "itemName": null,
//   "quantity": 0
// }).toString()
// );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      print("Post Enq Responce::" + response.body.toString());
      // print("Post Enq Stcode::" + response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return EnqPostModal.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return EnqPostModal.issue(json.decode(response.body), resCode);
      } else {
        return EnqPostModal.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception3333: " + e.toString());
      // return resCode;
      return EnqPostModal.error(e.toString(), resCode);
    }
  }
}

//OLd Body
// body: jsonEncode({
//             "CardCode": "${patch.CardCode}",
//             "Activity": "cn_Task",
//             "ActivityType": patch.ActivityType,//enqtype
//             "U_Lookingfor": "${patch.U_Lookingfor}",
//             "U_PotentialValue": null,
//             "U_AssignedTo": patch.assignedtoslpCode,
//             "U_ManagerSlp" : "${ConstantValues.slpcode}",
//             "U_EnqStatus": "NEW ENQUIRY",
//             "U_EnqRefer":"${patch.U_EnqRefer}",
//           }));

//flexi befor Json below

// jsonEncode({
//           "id": 0,
//           "customerCode": "${patch.CardCode}",
//           "activity": "CCustomer",
//           "activityType": patch.ActivityType,
//           "potentialvalue": patch.U_PotentialValue,
//           "u_Lookingfor": "${patch.U_Lookingfor}",
//           "u_AssignedTo": "${patch.assignedtoslpCode}",
//           // ${patch.assignedtoslpCode}
//           "u_ManagerSlp": "${patch.assignedtoManagerSlpCode}",
//           "u_EnqStatus": "NEW ENQUIRY",
//           "u_EnqRefer": "${patch.U_EnqRefer}",
//           "createdby": int.parse(ConstantValues.UserId.toString()),
//           "createdDate": "${config.currentDate()}",
//           "updatedby":int.parse(ConstantValues.UserId.toString()),
//           //  ConstantValues.UserId
//           "updateddate": "${config.currentDate()}",
//            "closed": "N",
//            "leadConversion": 0,
// "enquirydscription": null,
// "itemCode": null,
// "itemName": null,
// "quantity": 0
//         }).toString());
