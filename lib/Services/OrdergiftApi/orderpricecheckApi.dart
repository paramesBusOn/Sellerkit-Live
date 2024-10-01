

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/OutStandingModel/outstandingmodel.dart';
import 'package:sellerkit/Models/ordergiftModel/ordergiftModel.dart';
import 'package:sellerkit/Models/ordergiftModel/orderpricecheckModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class OrderPricecheckApi{
  static Future<OrderpriceDetails> getData(String? itemcode,int? quantity,double? unitprice,String? couponcode)async{
     int resCode = 500;
     try{
      log("::aaa::"+Url.queryApi + 'SkClientPortal/CheckPriceValidity?ItemCode=${Uri.encodeComponent(itemcode!)}&StoreCode=${ConstantValues.Storecode}&Quantity=$quantity&Price=$unitprice&CouponCode=$couponcode');
      final response=await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/CheckPriceValidity?ItemCode=${Uri.encodeComponent(itemcode!)}&StoreCode=${ConstantValues.Storecode}&Quantity=$quantity&Price=$unitprice&CouponCode=$couponcode'),
      headers: {
        "content-type": "application/json",
        "Authorization": 'bearer '+ ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
      }
      );
      resCode = response.statusCode;
      log("response.body"+response.body.toString());
      log("response.body"+response.statusCode.toString());
      if(response.statusCode ==200){
        return OrderpriceDetails.fromJson(json.decode(response.body.toString()),response.statusCode);
      }else{
        return OrderpriceDetails.issues(json.decode(response.body),response.statusCode);
    
      }
     }catch (e){
      log("message"+e.toString());
       return OrderpriceDetails.error(e.toString(), resCode);
     }

  }
}