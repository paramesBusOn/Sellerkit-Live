// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Models/QuoteModel/quotemodel.dart';
import 'package:sellerkit/Constant/Configuration.dart';
class QuotesupdateApi {
  static Future<QuoteSavePostModal> getData(
      sapUserId, PostOrder postLead, PatchExCus patch) async {
    int resCode = 500;
    try {
      log("ConstantValues.token:::" + ConstantValues.token.toString());
      log("URLL::" + Url.queryApi + 'Sellerkit_Flexi/v2/QuoteUpdate');
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/QuoteUpdate'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
             "docentry":  patch.docent,
             "ordertype": patch.ordertype==null?null: "${patch.ordertype}",
  "ordernumber": patch.ordernum,
  "docdate":"${postLead.DocDateold}",
  // "purchasePlan": "${postLead.purchaseDate}",
  "deliveryduedate": "${postLead.deliveryDate}",
  "paymentduedate": "${postLead.paymentDate}",
  "customercode": "${patch.CardCode}",
  "customername":"${patch.CardName!.replaceAll("'", "''")}",
  "customermobile": "${patch.CardCode}",
  "alternatemobile": patch.altermobileNo == null ? null : "${patch.altermobileNo}",
  "contactname": patch.cantactName == null ? null : "${patch.cantactName!.replaceAll("'", "''")}",
  "customeremail": patch.U_EMail == null ? null : "${patch.U_EMail!.replaceAll("'", "''")}",
  "companyname":null,
  "pan": null,
  "gstno": null,
  "customerporef": postLead.poReference == null ? null : "${postLead.poReference}",
  "bil_address1":patch.U_Address1 == null ? null : "${patch.U_Address1!.replaceAll("'", "''")}",
  "bil_address2":patch.U_Address2 == null ? null : "${patch.U_Address2!.replaceAll("'", "''")}",
  "bil_address3":  null,
  "bil_area": patch.area == null ? null : "${patch.area!.replaceAll("'", "''")}",
  "bil_city": patch.U_City == null ? null : "${patch.U_City!.replaceAll("'", "''")}",
  "bil_district": null,
  "bil_state": patch.U_State == null ? null : "${patch.U_State}",
  "bil_country": patch.U_Country == null ? null : "${patch.U_Country}",
  "bil_pincode": patch.U_Pincode == null ? null : "${patch.U_Pincode}",
  "del_address1": "${patch.U_ShipAddress1!.replaceAll("'", "")}",
  "del_address2": "${patch.U_ShipAddress2!.replaceAll("'", "")}",
  "del_address3": null,
  "del_area": "${patch.U_Shiparea!.replaceAll("'", "''")}",
  "del_city": patch.U_ShipCity == null ? null : "${patch.U_ShipCity!.replaceAll("'", "''")}",
  "del_district": null,
  "del_state": patch.U_ShipState == null ? null : "${patch.U_ShipState}",
  "del_country":patch.U_ShipCountry == null ? null : "${patch.U_ShipCountry}",
  "del_pincode":  patch.U_ShipPincode == null ? null : "${patch.U_ShipPincode}",
  "customergroup": "${patch.U_Type}",
  "storecode": ConstantValues.Storecode,
  "deliveryfrom": postLead.docLine![0].deliveryfrom,
  "dealid": 0,
  "baseid": 0,
  "basetype": -1,
  "attachurl1": postLead.attachmenturl1 == null ||
                    postLead.attachmenturl1!.isEmpty
                ? null
                : "${postLead.attachmenturl1}",
  "attachurl2":  postLead.attachmenturl2 == null ||
                    postLead.attachmenturl2!.isEmpty
                ? null
                : "${postLead.attachmenturl2}",
  "attachurl3": postLead.attachmenturl3 == null ||
                    postLead.attachmenturl3!.isEmpty
                ? null
                : "${postLead.attachmenturl3}",
  "attachurl4":postLead.attachmenturl4 == null ||
                    postLead.attachmenturl4!.isEmpty
                ? null
                : "${postLead.attachmenturl4}",
  "attachurl5": postLead.attachmenturl5 == null ||
                    postLead.attachmenturl5!.isEmpty
                ? null
                : "${postLead.attachmenturl5}",
  "ordernote": "${postLead.notes}",
  "paymentterms": postLead.paymentTerms == null
                ? null
                : "${postLead.paymentTerms}",
  "isdelivered": null,
  "deliverydate": null,
  "deliveryno": null,
  "deliveryurl1": null,
  "deliveryurl2":null,
  "isinvoiced": null,
  "invoicedate": null,
  "invoiceno": null,
  "invoicetotal": null,
  "invoiceurl1": null,
  "invoiceurl2": null,
  "quotelines": postLead.docLine!.map((e) => e.tojason2()).toList()
          }));
      log("Update order Json ::" +
          jsonEncode({
             "docentry":  patch.docent,
             "ordertype": patch.ordertype==null?null: "${patch.ordertype}",
  "ordernumber": patch.ordernum,
  "docdate":"${config.currentDate()}",
  "deliveryduedate": "${postLead.deliveryDate}",
  "paymentduedate": "${postLead.paymentDate}",
  "customercode": "${patch.CardCode}",
  "customername":"${patch.CardName}",
  "customermobile": "${patch.CardCode}",
  "alternatemobile": patch.altermobileNo == null ? null : "${patch.altermobileNo}",
  "contactname": patch.cantactName == null ? null : "${patch.cantactName}",
  "customeremail": patch.U_EMail == null ? null : "${patch.U_EMail}",
  "companyname":null,
  "pan": null,
  "gstno": null,
  "customerporef": postLead.poReference == null ? null : "${postLead.poReference}",
  "bil_address1":patch.U_Address1 == null ? null : "${patch.U_Address1}",
  "bil_address2":patch.U_Address2 == null ? null : "${patch.U_Address2}",
  "bil_address3":  null,
  "bil_area": patch.area == null ? null : "${patch.area}",
  "bil_city": patch.U_City == null ? null : "${patch.U_City}",
  "bil_district": null,
  "bil_state": patch.U_State == null ? null : "${patch.U_State}",
  "bil_country": patch.U_Country == null ? null : "${patch.U_Country}",
  "bil_pincode": patch.U_Pincode == null ? null : "${patch.U_Pincode}",
  "del_address1": "${patch.U_ShipAddress1}",
  "del_address2": "${patch.U_ShipAddress2}",
  "del_address3": null,
  "del_area": "${patch.U_Shiparea}",
  "del_city": patch.U_ShipCity == null ? null : "${patch.U_ShipCity}",
  "del_district": null,
  "del_state": patch.U_ShipState == null ? null : "${patch.U_ShipState}",
  "del_country":patch.U_ShipCountry == null ? null : "${patch.U_ShipCountry}",
  "del_pincode":  patch.U_ShipPincode == null ? null : "${patch.U_ShipPincode}",
  "customergroup": "${patch.U_Type}",
  "storecode": ConstantValues.Storecode,
  "deliveryfrom": postLead.docLine![0].deliveryfrom,
  "dealid": 0,
  "baseid": 0,
  "basetype": -1,
  "attachurl1": postLead.attachmenturl1 == null ||
                    postLead.attachmenturl1!.isEmpty
                ? null
                : "${postLead.attachmenturl1}",
  "attachurl2":  postLead.attachmenturl2 == null ||
                    postLead.attachmenturl2!.isEmpty
                ? null
                : "${postLead.attachmenturl2}",
  "attachurl3": postLead.attachmenturl3 == null ||
                    postLead.attachmenturl3!.isEmpty
                ? null
                : "${postLead.attachmenturl3}",
  "attachurl4":postLead.attachmenturl4 == null ||
                    postLead.attachmenturl4!.isEmpty
                ? null
                : "${postLead.attachmenturl4}",
  "attachurl5": postLead.attachmenturl5 == null ||
                    postLead.attachmenturl5!.isEmpty
                ? null
                : "${postLead.attachmenturl5}",
  "ordernote": "${postLead.notes}",
  "paymentterms": "${patch.U_Type}",
  "isdelivered": null,
  "deliverydate": null,
  "deliveryno": null,
  "deliveryurl1": null,
  "deliveryurl2":null,
  "isinvoiced": null,
  "invoicedate": null,
  "invoiceno": null,
  "invoicetotal": null,
  "invoiceurl1": null,
  "invoiceurl2": null,
  "quotelines": postLead.docLine!.map((e) => e.tojason2()).toList()
          }).toString());
      log("json.decode(response.body)::" +
          json.decode(response.body).toString());
      resCode = response.statusCode;
      // print(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        // log("REsleadPost:" + json.decode(response.body).toString());

        return QuoteSavePostModal.fromJson(
            json.decode(response.body), response.statusCode);
        // return resCode;
      } else {
        //return resCode;
        // print("Error: ${json.decode(response.body).toString()}");
        return QuoteSavePostModal.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception111: " + e.toString());
      // return resCode;
      return QuoteSavePostModal.error(e.toString(), resCode);
    }
  }

  static printData(PostOrder postLead) {
    log(jsonEncode(postLead.tojson()));
  }
}




// class LeadSavePostApi {
//   static Future<LeadSavePostModal> getData(sapUserId, PostLead postLead) async {
//     int resCode = 500;
//     log(Url.SLUrl + 'Quotations' + " .. ${ConstantValues.sapSessions} save lead api");
//     try {
//       await config.getSetup(); final response = await http.post(Uri.parse(Url.SLUrl + 'Quotations'),
//           headers: {
//             "content-type": "application/json",
//             "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
//           },
//           body: jsonEncode(postLead.tojson()));
//         log(jsonEncode(postLead.tojson()));
//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       log(json.decode(response.body).toString());
//       if (response.statusCode >= 200 && response.statusCode <= 210) {
//         return LeadSavePostModal.fromJson(json.decode(response.body.toString()), resCode);
//         // return resCode;
//       } else {
//         //return resCode;
//         print("Error: ${json.decode(response.body)}");
//         return LeadSavePostModal.issue(json.decode(response.body), resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       // return resCode;
//       return LeadSavePostModal.error(e.toString(), resCode);
//     }
//   }

//   static printData(PostLead postLead) {
//     log(jsonEncode(postLead.tojson()));
//   }
// }
