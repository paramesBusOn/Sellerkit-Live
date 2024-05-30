// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

import '../../Constant/ConstantSapValues.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';
import '../../Models/PostQueryModel/OrdersCheckListModel/GetOrderCheckListModel.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
import '../../Models/siteoutmodel/siteoutmodel.dart';
class siteOutApi {
  static Future<siteoutmodel> getData(siteout sitein,siteoutpatc siteoutp) async {
    int resCode = 500;
    try {
     log("URRRRL"+Url.queryApi + 'Sellerkit_Flexi/v2/SiteCheckOut');
      Config config = Config();
       final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/SiteCheckOut'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "checkoutadd":sitein.siteoutaddress,
            "visitid": siteoutp.visitid,
  "customername": "${siteoutp.customername!.replaceAll("'", "''")}",
   "visitoutcome": "${sitein.visitOutComes!.replaceAll("'", "''")}",
  "customermobile": "${siteoutp.customercode}",
  "customeremail":siteoutp.email==null||siteoutp.email=='null'||siteoutp.email!.isEmpty?null: "${siteoutp.email}",
  "customercode": "${siteoutp.customercode}",
  "contactperson":siteoutp.contactname==null||siteoutp.contactname=='null'||siteoutp.contactname!.isEmpty?null: "${siteoutp.contactname!.replaceAll("'", "")}",
  "address1":siteoutp.add1==null|| siteoutp.add1=='null'|| siteoutp.add1!.isEmpty?null:  "${siteoutp.add1!.replaceAll("'", "''")}",
  "address2":siteoutp.add2==null||siteoutp.add2=='null'||  siteoutp.add2!.isEmpty?null: "${siteoutp.add2!.replaceAll("'", "''")}",
  "address3": null,
  "area":siteoutp.area==null|| siteoutp.area=='null'|| siteoutp.area!.isEmpty?null: "${siteoutp.area!.replaceAll("'", "''")}",
  "city":siteoutp.city==null|| siteoutp.city=='null'|| siteoutp.city!.isEmpty?null: "${siteoutp.city!.replaceAll("'", "''")}",
  "district": null,
  "state": "${siteoutp.state}",
  "country": "${siteoutp.country}",
  "pincode":siteoutp.pincode,
  "storecode": ConstantValues.Storecode,
  "planneddate": "${siteoutp.meetingtime}",
  "checkoutdatetime": "${siteoutp.time}",
  "checkoutlat": ConstantValues.latitude,
  "checkoutlong": ConstantValues.langtitude,
  "purposeofvisit": "${siteoutp.purposeofvisit}",
  "lookingfor": siteoutp.lookingfor==null|| siteoutp.lookingfor=='null'||siteoutp.lookingfor!.isEmpty?null:"${siteoutp.lookingfor}",
  "assignedto":"${siteoutp.assignslpcode}",
  "potentialbusinessvalue": siteoutp.potential==null||siteoutp.potential=='null'?null: siteoutp.potential,
  "basetype":siteoutp.basetype,
  "baseid": siteoutp.baseid,
  "att1": sitein.attachmenturl1==null||sitein.attachmenturl1=='null'||sitein.attachmenturl1!.isEmpty?null: "${sitein.attachmenturl1}",
  "att2": sitein.attachmenturl2==null||sitein.attachmenturl2=='null'||sitein.attachmenturl2!.isEmpty?null: "${sitein.attachmenturl2}",
  "att3": sitein.attachmenturl3==null||sitein.attachmenturl3=='null'||sitein.attachmenturl3!.isEmpty?null: "${sitein.attachmenturl3}",
  "att4": sitein.attachmenturl4==null||sitein.attachmenturl4=='null'||sitein.attachmenturl4!.isEmpty?null: "${sitein.attachmenturl4}",
    "revisitreq": sitein.visitdate==null||sitein.visitdate=='null'||sitein.visitdate!.isEmpty?null: "${sitein.visitdate}",
  "revisitby":sitein.revisitby==null||sitein.revisitby=='null'||sitein.revisitby!.isEmpty?null: "${sitein.revisitby}"
          })
          );
          log("POSTSITeout"+jsonEncode({
            "checkoutadd":sitein.siteoutaddress,
            "visitid": siteoutp.visitid,
  "customername": "${siteoutp.customername!.replaceAll("'", "''")}",
   "visitoutcome": "${sitein.visitOutComes!.replaceAll("'", "''")}",
  "customermobile": "${siteoutp.customercode}",
  "customeremail":siteoutp.email==null||siteoutp.email=='null'||siteoutp.email!.isEmpty?null: "${siteoutp.email}",
  "customercode": "${siteoutp.customercode}",
  "contactperson":siteoutp.contactname==null||siteoutp.contactname=='null'||siteoutp.contactname!.isEmpty?null: "${siteoutp.contactname!.replaceAll("'", "")}",
  "address1":siteoutp.add1==null|| siteoutp.add1=='null'|| siteoutp.add1!.isEmpty?null:  "${siteoutp.add1!.replaceAll("'", "''")}",
  "address2":siteoutp.add2==null||siteoutp.add2=='null'||  siteoutp.add2!.isEmpty?null: "${siteoutp.add2!.replaceAll("'", "''")}",
  "address3": null,
  "area":siteoutp.area==null|| siteoutp.area=='null'|| siteoutp.area!.isEmpty?null: "${siteoutp.area!.replaceAll("'", "''")}",
  "city":siteoutp.city==null|| siteoutp.city=='null'|| siteoutp.city!.isEmpty?null: "${siteoutp.city!.replaceAll("'", "''")}",
  "district": null,
  "state": "${siteoutp.state}",
  "country": "${siteoutp.country}",
  "pincode":siteoutp.pincode,
  "storecode": ConstantValues.Storecode,
  "planneddate": "${siteoutp.meetingtime}",
  "checkoutdatetime": "${siteoutp.time}",
  "checkoutlat": ConstantValues.latitude,
  "checkoutlong": ConstantValues.langtitude,
  "purposeofvisit": "${siteoutp.purposeofvisit}",
  "lookingfor": siteoutp.lookingfor==null|| siteoutp.lookingfor=='null'||siteoutp.lookingfor!.isEmpty?null:"${siteoutp.lookingfor}",
  "assignedto":"${siteoutp.assignslpcode}",
  "potentialbusinessvalue": siteoutp.potential==null||siteoutp.potential=='null'?null: siteoutp.potential,
  "basetype":siteoutp.basetype,
  "baseid": siteoutp.baseid,
  "att1": sitein.attachmenturl1==null||sitein.attachmenturl1=='null'||sitein.attachmenturl1!.isEmpty?null: "${sitein.attachmenturl1}",
  "att2": sitein.attachmenturl2==null||sitein.attachmenturl2=='null'||sitein.attachmenturl2!.isEmpty?null: "${sitein.attachmenturl2}",
  "att3": sitein.attachmenturl3==null||sitein.attachmenturl3=='null'||sitein.attachmenturl3!.isEmpty?null: "${sitein.attachmenturl3}",
  "att4": sitein.attachmenturl4==null||sitein.attachmenturl4=='null'||sitein.attachmenturl4!.isEmpty?null: "${sitein.attachmenturl4}",
    "revisitreq": sitein.visitdate==null||sitein.visitdate=='null'||sitein.visitdate!.isEmpty?null: "${sitein.visitdate}",
  "revisitby":sitein.revisitby==null||sitein.revisitby=='null'||sitein.revisitby!.isEmpty?null: "${sitein.revisitby}"
      
  }).toString());

     
      resCode = response.statusCode;
      log(response.statusCode.toString());
      log("sk_get_check_customer111 "+response.body);
      if (response.statusCode == 200) {
         log("chequeenq:"+response.statusCode.toString());
        return siteoutmodel.fromJson(json.decode(response.body), response.statusCode);
        
      } else {
        print("chequeenqError: ${json.decode(response.body)}");
        return siteoutmodel.issues(json.decode(response.body),  response.statusCode);
      }
    } catch (e) {
      log("chequeenqException: " + e.toString());
      return siteoutmodel.error(e.toString(), resCode);
    }
  }
}
