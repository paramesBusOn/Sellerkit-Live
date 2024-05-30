// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../Models/OpenLeadModel.dart/OpenLeadModel.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
// import 'package:sellerkit/main.dart';

class newscheduleApi {
  static Future<NewCustomerschedule> postvisit(
      postscheduledata postvistdata) async {
    int resCode = 500;
    try {
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/AddVisitPlan'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "visitid": null,
            "customername": "${postvistdata.customername!.replaceAll("'", "''")}",
            "customermobile": "${postvistdata.customercode}",
            "customercode":"${postvistdata.customercode}",
            "customeremail":postvistdata.email==null?null: "${postvistdata.email!.replaceAll("'", "''")}",
            "contactperson":postvistdata.contactname==null?null: "${postvistdata.contactname!.replaceAll("'", "''")}",
            "address1": postvistdata.add1==null?null:"${postvistdata.add1!.replaceAll("'", "''")}",
            "address2":postvistdata.add2==null?null: "${postvistdata.add2!.replaceAll("'", "''")}",
            "address3": null,
            "area": postvistdata.area==null?null:"${postvistdata.area!.replaceAll("'", "''")}",
            "city": postvistdata.city==null?null:"${postvistdata.city!.replaceAll("'", "''")}",
            "district": null,
            "state":postvistdata.state==null?null: "${postvistdata.state}",
            "country": postvistdata.country==null?null:"${postvistdata.country}",
            "pincode": postvistdata.pincode,
            "storecode":  ConstantValues.Storecode,
            "planneddate": "${postvistdata.meetingtime}",
            "purposeofvisit": "${postvistdata.purposeofvisit}",
            "lookingfor": "${postvistdata.lookingfor}",
            "assignedto": "${postvistdata.assignslpcode}",
            "potentialbusinessvalue":postvistdata.potential,
            "basetype": postvistdata.basetype,
            "baseid": postvistdata.baseid,
            "att1": null,
            "att2": null,
            "att3": null,
            "att4": null
          }));

      log("visitbody" +
          jsonEncode({
            "visitid": null,
            "customername": "${postvistdata.customername}",
            "customermobile": "${postvistdata.customercode}",
            "customercode":"${postvistdata.customercode}",
            "customeremail":postvistdata.email==null?null: "${postvistdata.email}",
            "contactperson":postvistdata.contactname==null?null: "${postvistdata.contactname}",
            "address1": postvistdata.add1==null?null:"${postvistdata.add1}",
            "address2":postvistdata.add2==null?null: "${postvistdata.add2}",
            "address3": null,
            "area": postvistdata.area==null?null:"${postvistdata.area}",
            "city": postvistdata.city==null?null:"${postvistdata.city}",
            "district": null,
            "state":postvistdata.state==null?null: "${postvistdata.state}",
            "country": postvistdata.country==null?null:"${postvistdata.country}",
            "pincode": postvistdata.pincode,
            "storecode":  ConstantValues.Storecode,
            "planneddate": "${postvistdata.meetingtime}",
            "purposeofvisit": "${postvistdata.purposeofvisit}",
            "lookingfor": "${postvistdata.lookingfor}",
            "assignedto": "${postvistdata.assignslpcode}",
            "potentialbusinessvalue":postvistdata.potential,
            "basetype": postvistdata.basetype,
            "baseid": postvistdata.baseid,
            "att1": null,
            "att2": null,
            "att3": null,
            "att4": null
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("postvisit:" + json.decode(response.body).toString());

      if (response.statusCode == 200) {
        return NewCustomerschedule.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        //  print("Error: ${json.decode(response.body)}");
        return NewCustomerschedule.issue(json.decode(response.body),  response.statusCode);
      }
    } catch (e) {
      print("Exception: $e");
      return NewCustomerschedule.exception(e.toString(), resCode);
    }
  }
}
