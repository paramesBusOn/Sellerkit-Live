import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';import 'package:sellerkit/main.dart';

import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ItemMasterUpdateModel/ItemMasterUpdateModelNew.dart';
class ItemMasterApiUpdateNew {
  static Future<ItemMasterNewUpdateModal> getData(sapUserId,String itemCode,) async {
    int resCode = 500;
    try {
      log("message"+Url.queryApi+'SkClientPortal/GetItemDetails?slpCode=$sapUserId&ItemId=$itemCode');
      await config.getSetup(); final response = await http.get(
        Uri.parse(Url.queryApi+'SkClientPortal/GetItemDetails?slpCode=$sapUserId&ItemId=$itemCode'
        ),
         headers: {
        "content-type": "application/json",
        "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
        //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
        },
    //     body: jsonEncode({
    // "constr": "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
    // "query": "exec sk_sp_inventory_master_item '$sapUserId','$itemCode'"
    //     })
        );
        
      resCode = response.statusCode;
       print(response.statusCode.toString());
        log("updateitem"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return ItemMasterNewUpdateModal.fromJson(json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ItemMasterNewUpdateModal.error ('Error',response.statusCode);
      }
    } catch (e) {
      print("Exception: "+e.toString());
      return ItemMasterNewUpdateModal.error(e.toString(),resCode);
    }
  }


}
