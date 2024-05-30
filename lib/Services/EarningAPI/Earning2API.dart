import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/EarningModel/Earning2Model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
// import 'package:sellerkit/main.dart';

class EarningtableApi {
  static Future<EarningModel2> getEarningtableData(
      String userid, String frmdate, todate) async {
    int resCode = 500;
    try {
    

      // log("message"+"${Url.queryApi}SkClientPortal/getearnings2/$frmdate/$todate/${ConstantValues.slpcode}");
      Config config = Config();

      await config.getSetup();
      final response = await http.get(
        Uri.parse(
            '${Url.queryApi}Sellerkit_Flexi/v2/GetReportIncentiveTrans?UserId=$userid&FromDate=$frmdate&Todate=$todate'),
        //  final response = await http.get(Uri.parse('${Url.queryApi}SkClientPortal/getearnings2/$frmdate/$todate/${ConstantValues.slpcode}'),

        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ${ConstantValues.token}',
          "Location": '${ConstantValues.EncryptedSetup}'
        },
      );
      log("Earnings2Api::${response.body}");

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        resCode = response.statusCode;
        return EarningModel2.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EarningModel2.error(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: $e");
      // throw Exception(e);
      return EarningModel2.error(e.toString(), resCode);
    }
  }
}

//         Map<String, dynamic> resposnsemsg = json.decode(response.body);
//         var xxxx = resposnsemsg['data'];
//         log('message::$xxxx');
//         var yyyyy = xxxx['IncentiveDetails'].toString();
//         log('message222:$yyyyy');
//         resCode = response.statusCode;
//         return EarningModel2.fromJson(json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return EarningModel2.error('Error', resCode);
//       }
//     } catch (e) {
//       log("Exception: $e");
//       throw Exception(e);
//       // return EarningModel2.error(e.toString(), resCode);
//     }
//   }
// }
