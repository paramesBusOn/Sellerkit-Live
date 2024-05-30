// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Services/URL/LocalUrl.dart';

// import '../../../Constant/ConstantSapValues.dart';
// import '../../../Models/PostQueryModel/LeadsCheckListModel/ForwardLeadUserModel.dart';

// class CloseLeadApi {
//   static Future<ForwardLeadUser> getData(leadDocEntry) async {
//        log("url" + Url.SLUrl + 'Quotations($leadDocEntry)/Close');

//     int resCode = 500;
//     try {
//       await config.getSetup(); final response = await http.post(
//         Uri.parse(Url.SLUrl + 'Quotations($leadDocEntry)/Close'),
//         headers: {
//           "content-type": "application/json",
//           "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
//         },
//       );
//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       print(json.decode(response.body));
//       if (response.statusCode >= 200 && response.statusCode<=210) {
//         return ForwardLeadUser.fromjson(resCode);
//       } else {
//         return ForwardLeadUser.issue(json.decode(response.body), resCode);
//       }
//     } catch (e) {
//       return ForwardLeadUser.fromjson(resCode);
//     }
//   }
// }
