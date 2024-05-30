// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/AddEnqModel/AddEnqModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CustomerCreationModel.dart';

class OrderNewCustCretApi {
  static Future<NewCustomerEnqValue> getData(sapUserId, PatchExCus patch,
      [PostOrder? postLead]) async {
    int resCode = 500;
    log(Url.queryApi + 'SkClientPortal/PostCustomer');

    try {
      log("Token::" + ConstantValues.token);
      Config config = new Config();
      await config.getSetup(); 
      final response = await http.post(
          Uri.parse(Url.queryApi + 'SkClientPortal/PostCustomer'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "id": 0,
            "customerCode": "${patch.CardCode}",
            "customerName": "${patch.CardName}",
            "mobileNo": "${patch.CardCode}",
            "alternateMobileNo": "${patch.altermobileNo}",
            "contactName": "${patch.cantactName}",
            "facebook": patch.U_Facebook == null ? null : "${patch.U_Facebook}",
            "cardtype": "cCustomer",
            "email": "${patch.U_EMail}",
            "gstNo": "${patch.gst}",
            "codeId": "string",
            "createdBy": ConstantValues.UserId,
            "createdOn": "${config.currentDate()}",
            "updatedBy": ConstantValues.UserId,
            "updatedOn": "${config.currentDate()}",
            "address1": "${patch.U_Address1}",
            "address2": "${patch.U_Address2}",
            "address3": "${patch.U_Address3}",
            "city": "${patch.U_City}",
            "state": patch.U_State == null ? null : "${patch.U_State}",
            "country": patch.U_Country == null ? null : "${patch.U_Country}",
            "pinCode": "${patch.U_Pincode}",
            "shippingAddress1": "${patch.U_ShipAddress1}",
            "shippingAddress2": "${patch.U_ShipAddress2}",
            "shippingAddress3": "${patch.U_ShipAddress3}",
            "shippingCity": "${patch.U_ShipCity}",
            "shippingState": "${patch.U_ShipState}",
            "shippingCountry": "",
            "shippingPinCode": "${patch.U_ShipPincode}",
            "tag": "${patch.U_Type}",
            "status": true
          }));
      log("New Customer Create" +
          jsonEncode({
            "id": 0,
            "customerCode": "${patch.CardCode}",
            "customerName": "${patch.CardName}",
            "mobileNo": "${patch.CardCode}",
            "alternateMobileNo": "${patch.altermobileNo}",
            "contactName": "${patch.cantactName}",
            "facebook": patch.U_Facebook == null ? null : "${patch.U_Facebook}",
            "cardtype": "cCustomer",
            "email": "${patch.U_EMail}",
            "gstNo": "${patch.gst}",
            "codeId": "string",
            "createdBy": ConstantValues.UserId,
            "createdOn": "${config.currentDate()}",
            "updatedBy": ConstantValues.UserId,
            "updatedOn": "${config.currentDate()}",
            "address1": "${patch.U_Address1}",
            "address2": "${patch.U_Address2}",
            "address3": "${patch.U_Address3}",
            "city": "${patch.U_City}",
            "state": patch.U_State == null ? null : "${patch.U_State}",
            "country": patch.U_Country == null ? null : "${patch.U_Country}",
            "pinCode": "${patch.U_Pincode}",
            "shippingAddress1": "${patch.U_ShipAddress1}",
            "shippingAddress2": "${patch.U_ShipAddress2}",
            "shippingAddress3": "${patch.U_ShipAddress3}",
            "shippingCity": "${patch.U_ShipCity}",
            "shippingState": "${patch.U_ShipState}",
            "shippingCountry": "",
            "shippingPinCode": "${patch.U_ShipPincode}",
            "tag": "${patch.U_Type}",
            "status": true
          }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("response::" + json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        log("datain");
        return NewCustomerEnqValue.fromJson(
            json.decode(response.body.toString()), response.statusCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        log("Error: ${json.decode(response.body).toString()}");
        // throw Exception("Error");

        return NewCustomerEnqValue.issue(json.decode(response.body), resCode);
      } else {
        // throw Exception("Error");
        return NewCustomerEnqValue.exception('', resCode);
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