// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:sellerkit/Constant/Configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/GetOrderCheckListModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/couponModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class CouponApi {
  static Future<AllCouponModal> getData(couponmodel coupondata)async {
    int resCode = 500;
    log('LEADCHK' + Url.queryApi + 'Sellerkit_Flexi/v2/GetCoupon');
    log('LEADCHK' + ConstantValues.token);
    try {
       
Config config = Config();
      final response = await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetCoupon'),
          headers: {
            "content-type": "application/json",
             "Authorization": 'bearer ' + ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
           "customerCode": "${coupondata.customerCode}",
  "itemCode": "${coupondata.itemCode}",
  "storeCode": "${coupondata.storeCode}",
  "qty": coupondata.qty,
  "totalBillValue": coupondata.totalBillValue,
  "requestedBy_UserCode": "${coupondata.requestedBy_UserCode}"
        }));

            log("CHECKLISTBODY:"+ jsonEncode({
            "customerCode": "${coupondata.customerCode}",
  "itemCode": "${coupondata.itemCode}",
  "storeCode": "${coupondata.storeCode}",
  "qty": coupondata.qty,
  "totalBillValue": coupondata.totalBillValue,
  "requestedBy_UserCode": "${coupondata.requestedBy_UserCode}"
        }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("CHeckListRES::"+response.body);
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return AllCouponModal.fromJson(json.decode(response.body), response.statusCode);
        
        // return resCode;
      } else {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return   AllCouponModal.issues(json.decode(response.body), response.statusCode);
        //LeadSavePostModal.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exceptionchecklist: " + e.toString());
      // return resCode;
      return AllCouponModal.error(e.toString(), resCode);
       //LeadSavePostModal.error(e.toString(), resCode);
    }
  }

  static printData(List<OrderCheckData> leadCheckData,int docEntry) {
    print(leadCheckData.length);
       log(jsonEncode({
        "U_LeadDocEntry":docEntry,
        "LEAD_CHK_LINECollection":leadCheckData.map((e) => e.tojson()).toList()
        }));
  }
}
