// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Controller/callNotificationController/callNotificationController.dart';
import 'package:sellerkit/Models/QuickEnqModel/quickenqmodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnqPostModel.dart';

// old  Url.queryApi + 'SkClientPortal/PostEnquiry'
class quickEnqPostApi {
  static Future<QuickEnqPostModal> getData(qenqcolumns enqcolumn ) async {
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
             "enquiredOn": "${config.currentDate()}",
  "customerCode": "${enqcolumn.mobile}",
  "customerName": "${enqcolumn.name}",
  "contactName": null,
  "customerMobile": "${enqcolumn.mobile}",
  "alternateMobileNo": null,
  "companyName": null,
  "customerEmail": null,
  "customerGroup": null,
  "storeCode": null,
  "address1": null,
  "address2": null,
  "pinCode": null,
  "bilArea": null,
  "city": null,
  "district": null,
  "state": null,
  "country": null,
  "potentialvalue": 0,
  "itemCode": null,
  "itemName": null,
  "assignedTo": "${enqcolumn.assignto}",
  "refferal": null,
  "enquiryType":null,
  "lookingfor": "${enqcolumn.lookingfor}",
  "enquirydscription": "${enqcolumn.Description}",
  "interestLevel": null,
  "orderType": null,
  "quantity": 0,
  "followupOn": "${config.currentDate()}",
  "isVisitRequired": "N",
  "visitTime": null,
  "remindOn": null
          }));
      log("postbody::" +
          jsonEncode({
             "enquiredOn": "${config.currentDate()}",
  "customerCode": "${enqcolumn.mobile}",
  "customerName": "${enqcolumn.name}",
  "contactName": null,
  "customerMobile": "${enqcolumn.mobile}",
  "alternateMobileNo": null,
  "companyName": null,
  "customerEmail": null,
  "customerGroup": null,
  "storeCode": null,
  "address1": null,
  "address2": null,
  "pinCode": null,
  "bilArea": null,
  "city": null,
  "district": null,
  "state": null,
  "country": null,
  "potentialvalue": 0,
  "itemCode": null,
  "itemName": null,
  "assignedTo": "${enqcolumn.assignto}",
  "refferal": null,
  "enquiryType":null,
  "lookingfor": "${enqcolumn.lookingfor}",
  "enquirydscription": "${enqcolumn.Description}",
  "interestLevel": null,
  "orderType": null,
  "quantity": 0,
  "followupOn": null,
  "isVisitRequired": "N",
  "visitTime": null,
  "remindOn": null
          }));
       resCode = response.statusCode;
      // print(response.statusCode.toString());
      print("Post Enq Responce::" + response.body.toString());
      // print("Post Enq Stcode::" + response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return QuickEnqPostModal.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return QuickEnqPostModal.issue(json.decode(response.body), resCode);
      } else {
        return QuickEnqPostModal.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception3333: " + e.toString());
      // return resCode;
      return QuickEnqPostModal.error(e.toString(), resCode);
    }
  }
}
