// // ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Constant/ConstantSapValues.dart';
// import '../../../Models/AddEnqModel/AddEnqModel.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/UpdateEnqModel.dart';

// class EnqPatchExistCustApi {
//   static Future<UpdateEnqModal> getData(sapUserId, PatchExCus patch) async {
//     int resCode = 500;        Config config=new Config();

//     // ignore: unnecessary_null_comparison
//     try {
//       log("existApi::"+Url.queryApi + 'SkClientPortal/PutCustomerById?Id=${patch.id}/${patch.custcode}');
//       await config.getSetup(); final response = await http.put(
//           Uri.parse(Url.queryApi + 'SkClientPortal/PutCustomerById?Id=${patch.id}'),
//           headers: {
//             "content-type": "application/json",
//             "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
//             //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
//           },
//           body: 
//           jsonEncode({
//            "id":patch.id ,
//   "customerCode": "${patch.custcode}",
//   // "C002",
//   "customerName": "${patch.CardName}",
//   "mobileNo": "${patch.CardCode}",
//   "alternateMobileNo": "${patch.altermobileNo}",
//   "contactName": "${patch.cantactName}",
//   "facebook": patch.U_Facebook==null?null:"${patch.U_Facebook}",
//   "cardtype": "",
//   "email": "${patch.U_EMail}",
//   "gstNo": "${patch.gst}",
//   "codeId": "",
//   "createdBy": ConstantValues.UserId,
//   "createdOn": "${config.currentDate()}",
//   "updatedBy": ConstantValues.UserId,
//   "updatedOn": "${config.currentDate()}",
//   "address1": "${patch.U_Address1}",
//   "address2": "${patch.U_Address2}",
//   "address3": "",
//   "city": "${patch.U_City}",
//   "state": patch.U_State==null?null:"${patch.U_State}",
//   "country":patch.U_Country==null?null:"${patch.U_Country}",
//   "pinCode": "${patch.U_Pincode}",
//   "shippingAddress1": "",
//   "shippingAddress2": "",
//   "shippingAddress3": "",
//   "shippingCity": "",
//   "shippingState": "",
//   "shippingCountry": "",
//   "shippingPinCode": "",
//   "tag": "${patch.U_Type}",
//   "status": true  }));

        
//       resCode = response.statusCode;
//       // ignore: unnecessary_null_comparison
//       print(response.statusCode.toString());
    
//       if (response.statusCode == 200) {
//           log("exist"+json.decode(response.body).toString());
//         return UpdateEnqModal.fromJson(json.decode(response.body), resCode);
//         //return resCode;
//       } else {
//         //return resCode;
//         print("Error: ${json.decode(response.body).toString()}");
//         return UpdateEnqModal.error("Error", resCode);
//       }
//     } catch (e) {
//       log("Exception: " + e.toString());
//       //  return  resCode;
//       return UpdateEnqModal.error(e.toString(), resCode);
//     }
//   }

//   static printJson(sapUserId, PatchExCus patch){
//      log(jsonEncode({
//             "constr":"Server=164.52.214.147;Database=JRF1;User Id=Sa; Password=BusOn@123;",
//             "query": "exec SK_UPDATE_CUSTOMER '${ConstantValues.slpcode}','${patch.CardCode}','${patch.CardName}','${patch.U_Address1}','${patch.U_Address2}','${patch.U_City}','${patch.U_Pincode}',"+ (patch.U_State ==null?null: '${patch.U_State}').toString() +  ","+
//     (patch.U_Country ==null?null : '${patch.U_Country}' ).toString()+ ","+(patch.U_Facebook ==null?null: '${patch.U_Facebook},' ).toString()+","+ (patch.U_EMail ==null?null: "'${patch.U_EMail}'").toString(),
//           }));
//   }
// }
// // jsonEncode({
// //             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
// //             "query": "exec SK_UPDATE_CUSTOMER '${ConstantValues.slpcode}','${patch.CardCode}','${patch.CardName}','${patch.U_Address1}','${patch.U_Address2}','${patch.U_City}','${patch.U_Pincode}',"+ (patch.U_State ==null?null: '${patch.U_State}').toString() +  ","+
// //              (patch.U_Country ==null?null : '${patch.U_Country}' ).toString()+ ","+(patch.U_Facebook ==null?null: '${patch.U_Facebook},' ).toString()+","+ (patch.U_EMail==null?null: "'${patch.U_EMail}'").toString() +","+  (patch.U_Type==''?null: "'${patch.U_Type}'").toString(),
// //           })

// //   try {
// //       await config.getSetup(); final response = await http.patch(Uri.parse(Url.SLUrl + "BusinessPartners('${patch.CardCode}')"),
// //           headers: {
// //             "content-type": "application/json",
// //             "cookie": 'B1SESSION='+ ConstantValues.sapSessions,
// //           },
// //           body: jsonEncode(
// //           {
// //     "CardCode":"${patch.CardCode}",// "8610659136",
// //     "CardName": "${patch.CardName}",
// //     "CardType": "cCustomer" ,
// //      "U_Address1":"${patch.U_Address1}",
// //     "U_Address2": "${patch.U_Address2}",
// //     "U_City": "${patch.U_City}",
// //     "U_Pincode":"${patch.U_Pincode}",
// //     "U_State":patch.U_State==null?null:"${patch.U_State}",
// //     "U_Country":patch.U_Country==null?null:"${patch.U_Country}",
// //     "U_Facebook":patch.U_Facebook==null?null:"${patch.U_Facebook}",
// //     "U_EMail" : "${patch.U_EMail}",
// // }
// //           ));
// // log(
// //   jsonEncode(
// //           {
// //     "CardCode":"${patch.CardCode}",// "8610659136",
// //     "CardName": "${patch.CardName}",
// //     "CardType": "cCustomer" ,
// //      "U_Address1":"${patch.U_Address1}",
// //     "U_Address2": "${patch.U_Address2}",
// //     "U_City": "${patch.U_City}",
// //     "U_Pincode":"${patch.U_Pincode}",
// //     "U_State":patch.U_State==null?null:"${patch.U_State}",
// //     "U_Country":patch.U_Country==null?null:"${patch.U_Country}",
// //     "U_Facebook":patch.U_Facebook==null?null:"${patch.U_Facebook}",
// //     "U_EMail" : "${patch.U_EMail}",
// // }
// //           ));
// //       resCode = response.statusCode;
// //       print(response.statusCode.toString());
// //       print(json.decode(response.body));
// //       if (response.statusCode == 200) {
// //         return EnqPatchModal.fromJson(
// //             json.decode(response.body), resCode);
// //         //return resCode;
// //       } else {
// //          //return resCode;
// //        print("Error: ${json.decode(response.body)}");
// //        return EnqPatchModal.issue(json.decode(response.body), resCode);
// //       }
// //     }