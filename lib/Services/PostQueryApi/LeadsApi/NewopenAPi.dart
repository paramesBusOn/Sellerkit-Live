// ignore_for_file: prefer_interpolation_to_compose_strings, unused_import

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/newleadopenmodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import 'package:sellerkit/main.dart';

class GetLeadopenApi {
 static  Future<GetLeadopenModal> getData(
  ) async {
    int resCode = 500;
    try {
// Config config = Config();
// print("Lead Status api::"+Url.queryApi +'SkClientPortal/GetallMaster?MasterTypeId=8');
      // await config.getSetup();
       final response = await http.get(Uri.parse(Url.queryApi +'SkClientPortal/GetallMaster?MasterTypeId=8'),
          headers: {
            "content-type": "application/json",
              "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":"Server=sathya.sellerkit.in;Database=SAPL;User Id=sa; Password=BusOn@123;",
          //   "query": "exec SK_GET_LEAD_STATUS_REASON '3443'"
          // })
          );

      resCode = response.statusCode;
      // print("LEAD_STATUS_REASONcode"+response.statusCode.toString());
      log("NEWWWWWWLEAD_STATUS_open"+response.body.toString());
      if (response.statusCode == 200) {
      //    ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // GetLeadStatusModal enquiryReferral =await port.first;
      //  islol.kill(priority: Isolate.immediate);
       return GetLeadopenModal.fromJson(json.decode(response.body), resCode);
      } else {
       print("Error: ${json.decode(response.body)}");
        return GetLeadopenModal.error('Error', resCode);
      }
    } catch (e) {
     print("Exception: " + e.toString());
      return GetLeadopenModal.error(e.toString(), resCode);
    }
  }
  //       deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = GetLeadStatusModal.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}
