

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/constant_sapvalues.dart';
import 'package:sellerkit/Models/ordergiftModel/valuebasedgiftModel.dart';

import 'package:sellerkit/Services/URL/LocalUrl.dart';

import '../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';

class valuebasedgiftApi{
  static Future<ValueBasedgiftDetails> getData(List<DocumentLines2> postLead)async{
     int resCode = 500;
     try{
        final response=await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetValueBasedGifts'),
      headers: {
        "content-type": "application/json",
        "Authorization": 'bearer '+ ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
      },
      body:jsonEncode( postLead.map((e) => e.tojasongift()).toList(),)
      );
      resCode = response.statusCode;
      log("response.body"+response.body.toString());
      log("response.encode"+jsonEncode(postLead.map((e) => e.tojasongift()).toList()));
      if(response.statusCode ==200){
        return ValueBasedgiftDetails.fromJson(json.decode(response.body.toString()),response.statusCode);
      }else{
        return ValueBasedgiftDetails.issues(json.decode(response.body),response.statusCode);
    
      }
     }catch (e){
      log("message"+e.toString());
       return ValueBasedgiftDetails.error(e.toString(), resCode);
     }

  }
}