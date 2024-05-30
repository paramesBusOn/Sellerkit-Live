
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/specialpriceModel/GetAllSPModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/GetAllOrderModel.dart';
import 'package:sellerkit/main.dart';

class GetAllSPApi {
  static Future<GetAllSPModal> getData(
    
  ) async {
    int resCode = 500;
    try {
      
Config config = Config();
      log("URLL:"+Url.queryApi + 'Sellerkit_Flexi/v2/SplPriceGet');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/SplPriceGet'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
         
         
          );
          
       
      resCode = response.statusCode;
      // print(response.statusCode.toString());
      log("Get All Orders"+response.body);
      if (response.statusCode == 200) {
        return 
        GetAllSPModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return 
        GetAllSPModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return 
      GetAllSPModal.error(e.toString(), resCode);
    }
  }
}