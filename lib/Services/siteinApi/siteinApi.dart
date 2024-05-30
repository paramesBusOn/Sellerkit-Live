// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
import '../../Models/siteinModel/siteinmodel.dart';

class siteinDetailsApi {
  static Future<siteInModel> getData(siteinpatch sitein) async {
    int resCode = 500;
    try {
     log("URRRRL"+Url.queryApi + 'Sellerkit_Flexi/v2/SiteCheckIn');
      Config config = Config();
      await config.getSetup(); final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/SiteCheckIn'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "checkinadd":"${sitein.checkinaddress}",
      "visitid":sitein.visitid,
  "customername": "${sitein.customername!.replaceAll("'", "''")}",
  "customermobile": "${sitein.customercode}",
  "customercode": "${sitein.customercode}",
  "customeremail":sitein.email==null|| sitein.email=='null'||sitein.email!.isEmpty?null: "${sitein.email!.replaceAll("'", "''")}",
  "contactperson":sitein.contactname==null|| sitein.contactname=='null'||sitein.contactname!.isEmpty?null: "${sitein.contactname!.replaceAll("'", "''")}",
  "address1":sitein.add1==null|| sitein.add1=='null'||sitein.add1!.isEmpty?null: "${sitein.add1!.replaceAll("'", "''")}",
  "address2":sitein.add2==null|| sitein.add2=='null'||sitein.add2!.isEmpty?null: "${sitein.add2!.replaceAll("'", "''")}",
  "address3": null,
  "area":sitein.area==null|| sitein.area=='null'||sitein.area!.isEmpty?null: "${sitein.area!.replaceAll("'", "''")}",
  "city":sitein.city==null|| sitein.city=='null'||sitein.city!.isEmpty?null: "${sitein.city!.replaceAll("'", "''")}",
  "district": null,
  "state": "${sitein.state}",
  "country": "${sitein.country}",
  "pincode": sitein.pincode,
  "storecode": ConstantValues.Storecode,
 "planneddate":sitein.meetingtime==null?null: "${sitein.meetingtime}",
  "checkindatetime": "${sitein.time}",
  "checkinlat":ConstantValues.latitude,
  "checkinlong":ConstantValues.langtitude,
  "purposeofvisit": "${sitein.purposeofvisit}",
  "lookingfor":sitein.lookingfor==null|| sitein.lookingfor=='null'||sitein.lookingfor!.isEmpty?null:"${sitein.lookingfor}",
  "assignedto": "${sitein.assignslpcode}",
  "potentialbusinessvalue":sitein.potential==null||sitein.potential=='null'?null: sitein.potential,
  "basetype": sitein.basetype,
  "baseid": sitein.baseid,
  "att1": null,
  "att2": null,
  "att3": null,
  "att4": null

          })
          );

          log("tein"+jsonEncode({
     "checkinadd":"${sitein.checkinaddress}",
      "visitid":sitein.visitid,
  "customername": "${sitein.customername!.replaceAll("'", "''")}",
  "customermobile": "${sitein.customercode}",
  "customercode": "${sitein.customercode}",
  "customeremail":sitein.email==null|| sitein.email=='null'||sitein.email!.isEmpty?null: "${sitein.email!.replaceAll("'", "''")}",
  "contactperson":sitein.contactname==null|| sitein.contactname=='null'||sitein.contactname!.isEmpty?null: "${sitein.contactname!.replaceAll("'", "''")}",
  "address1":sitein.add1==null|| sitein.add1=='null'||sitein.add1!.isEmpty?null: "${sitein.add1!.replaceAll("'", "''")}",
  "address2":sitein.add2==null|| sitein.add2=='null'||sitein.add2!.isEmpty?null: "${sitein.add2!.replaceAll("'", "''")}",
  "address3": null,
  "area":sitein.area==null|| sitein.area=='null'||sitein.area!.isEmpty?null: "${sitein.area!.replaceAll("'", "''")}",
  "city":sitein.city==null|| sitein.city=='null'||sitein.city!.isEmpty?null: "${sitein.city!.replaceAll("'", "''")}",
  "district": null,
  "state": "${sitein.state}",
  "country": "${sitein.country}",
  "pincode": sitein.pincode,
  "storecode": ConstantValues.Storecode,
 "planneddate":sitein.meetingtime==null?null: "${sitein.meetingtime}",
  "checkindatetime": "${sitein.time}",
  "checkinlat":ConstantValues.latitude,
  "checkinlong":ConstantValues.langtitude,
  "purposeofvisit": "${sitein.purposeofvisit}",
  "lookingfor":sitein.lookingfor==null|| sitein.lookingfor=='null'||sitein.lookingfor!.isEmpty?null:"${sitein.lookingfor}",
  "assignedto": "${sitein.assignslpcode}",
  "potentialbusinessvalue":sitein.potential==null||sitein.potential=='null'?null: sitein.potential,
  "basetype": sitein.basetype,
  "baseid": sitein.baseid,
  "att1": null,
  "att2": null,
  "att3": null,
  "att4": null

}));
      resCode = response.statusCode;
      log(response.statusCode.toString());
      log("sk_get_check_customer111 "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
         log("chequeenq:"+response.statusCode.toString());
        return siteInModel.fromJson(json.decode(response.body), response.statusCode);
        
      } else {
        print("chequeenqError: ${json.decode(response.body)}");
        return siteInModel.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("chequeenqException: " + e.toString());
      return siteInModel.error(e.toString(), resCode);
    }
  }
}
//  body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec sk_get_check_customer '${phoneNO}','${ConstantValues.slpcode}'"
//           }));
