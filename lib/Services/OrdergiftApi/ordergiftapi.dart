

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Models/OutStandingModel/outstandingmodel.dart';
import 'package:sellerkit/Models/ordergiftModel/ordergiftModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class OrdergiftDetailsApi{
  static Future<OrdergiftDetails> getData(String? itemcode,int? quantity,double? unitprice)async{
     int resCode = 500;
     try{
      log("SkClientPortal/getOfferWithParameter?ItemCode=${Uri.encodeComponent(itemcode!)}&StoreCode=${ConstantValues.Storecode}&Quantity=$quantity&Price=$unitprice::aaa::"+Url.queryApi + 'SkClientPortal/getOfferWithParameter/$itemcode/${ConstantValues.Storecode}/$quantity/$unitprice');
      final response=await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/getOfferWithParameter?ItemCode=${Uri.encodeComponent(itemcode!)}&StoreCode=${ConstantValues.Storecode}&Quantity=$quantity&Price=$unitprice'),
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
        return OrdergiftDetails.fromJson(json.decode(response.body.toString()),response.statusCode);
      }else{
        return OrdergiftDetails.issues(json.decode(response.body),response.statusCode);
    
      }
     }catch (e){
      log("message"+e.toString());
       return OrdergiftDetails.error(e.toString(), resCode);
     }

  }
}