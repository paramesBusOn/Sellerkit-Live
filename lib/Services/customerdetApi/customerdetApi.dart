

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class customerDetailApi{

  static Future<CutomerdetModal> getData()async{
int resCode =500;
try {
      
      log("URLLLLL"+Url.queryApi + 'SkClientPortal/GetstoresbyId?Id=${ConstantValues.storeid}');
      // await config.getSetup(); 
      final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetstoresbyId?Id=${ConstantValues.storeid}'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.slpcode}'"
          // })
          );

          // log(jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.sapUserID}'"
          // }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("CutomerdetModal11: "+response.body.toString());
      if (response.statusCode == 200) {
        return CutomerdetModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
      //  print("ErrorExceptionFEED: ${json.decode(response.body)}");
        return CutomerdetModal.error('Error', response.statusCode);
        //throw Exception();
      }
    } catch (e) {
     log("ExceptionFEED: " + e.toString());
      return CutomerdetModal.error(e.toString(), resCode);
     // throw Exception(e.toString());
    }
  }
}

class CutomerdetModal {
 customerdetData? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  CutomerdetModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory CutomerdetModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // List<FeedsModalData> dataList =
      //     list.map((data) => FeedsModalData.fromJson(data)).toList();
      return CutomerdetModal(
          leadcheckdata: customerdetData.fromJson(jsons),
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return CutomerdetModal(
          leadcheckdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory CutomerdetModal.error(String jsons, int stcode) {
    return CutomerdetModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}
class customerdetData{
  int? id;
  String? cardCode;
  String? cardName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? gstin;
  String? storeLogoUrl;
  customerdetData({
    required this.address1,
    required this.address2,
    required this.cardCode,
    required this.cardName,
    required this.city,
    required this.country,
    required this.gstin,
    required this.id,
    required this.pincode,
    required this.state,
    required this.storeLogoUrl

  });

  factory customerdetData.fromJson(Map<String,dynamic> jsons)=>
  customerdetData(
    storeLogoUrl:jsons['storeLogoUrl']??'',
    address1: jsons['address1']??'', 
    address2: jsons['address2']??'', 
    cardCode: jsons['cardCode']??'', 
    cardName: jsons['storeName']??'', 
    city: jsons['city'], 
    country: jsons['country']??'', 
    gstin: jsons['gstNo']??'', 
    id: jsons['id']??0, 
    pincode: jsons['pinCode']??'', 
    state: jsons['state']??''
    );
}