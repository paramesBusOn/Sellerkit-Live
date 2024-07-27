import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/LeadAnalysisModel/LeadAnalysisModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../../DBHelper/DBHelper.dart';
import '../../Models/LeadAnalysisModel/TestReportModel.dart';

class NewLeadAnalysisApi {
  static String? fromDate;
  static String? endDate;

  static List<SplitLeadData> splitdataaa = [];
  static List<SplitLeadData> splitdataaa22 = [];
  static List<SplitLeadData> splitdataaa55 = [];
  static List<TestReportMod> leadReportTestt = [];

  static Future<LeadAnalysisModel> getdata() async {
    int resCode = 500;
    splitdataaa = [];
    splitdataaa55 = [];

    try {
      Config config = Config();
      await config.getSetup();
      // log(ConstantValues.token);
      log('message::${Url.queryApi}Sellerkit_Flexi/v2/GetLeadReport?UserId=${ConstantValues.UserId}&FromDate=$fromDate&Todate=$endDate');
      final response = await http.get(
        Uri.parse(
            '${Url.queryApi}Sellerkit_Flexi/v2/GetLeadReport?UserId=${ConstantValues.UserId}&FromDate=$fromDate&Todate=$endDate'
            // '${Url.queryApi}Sellerkit_Flexi/v2/GetLeadReport?UserId=${ConstantValues.UserId}&FromDate=${fromDate}T12%3A58%3A17.753Z&Todate=${endDate}T12%3A58%3A17.753Z'
            //     "${Url.queryApi}Sellerkit_Flexi/v2/GetLeadReport?UserId=${ConstantValues.UserId}"
            ),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ${ConstantValues.token}',
        },
      );
      log('Report response.::${json.decode(response.body.toString())}');
      if (response.statusCode == 200) {
        var responseBody = response.body;
        Map<String, dynamic> parsedResponse = json.decode(responseBody);
        String leadList = parsedResponse['data'].toString();
        List<String> keys = parsedResponse.keys.toList();
        splitdataaa22 = [];
        leadReportTestt = [];

        String xxx = '';
        List<TestReportMod> testInserList = [];

        Map<String, dynamic> parsedResponse2 = json.decode(leadList.toString());
        var leadListReport = parsedResponse2['ReportList'];
        // log('leadListReportleadListReport::${leadListReport.toString()}');
        // Keys
        for (var i = 0; i < leadListReport.length; i++) {
          // log('yyyy:::${leadListReport[i].keys.toList().toString()}');
          splitdataaa.add(SplitLeadData(
              leadReportData: leadListReport[i]
                  .keys
                  .toList()
                  .toString()
                  .replaceAll('[', '')));
        }
        List<String> propertiesaa = [];

        for (var i = 0; i < splitdataaa.length; i++) {
          xxx = splitdataaa[i].leadReportData!.toString().replaceAll(']', '');
        }
        String zzz = xxx.toString().replaceAll(',', '').toString();
        List<String> properties = zzz.split(' ').map((e) => e.trim()).toList();

        for (var i = 0; i < properties.length; i++) {
          splitdataaa55
              .add(SplitLeadData(leadReportData: properties[i].toString()));
        }
        // log('splitdataaa55splitdataaa55 length::${splitdataaa55.length}');

//values
        for (var i = 0; i < leadListReport.length; i++) {
          splitdataaa22.add(SplitLeadData(
              leadReportData: leadListReport[i]
                  .values
                  .toList()
                  .toString()
                  .replaceAll('[', '')));
        }
        propertiesaa = [];
        for (var i = 0; i < splitdataaa22.length; i++) {
          xxx = splitdataaa22[i].leadReportData!.toString().replaceAll(']', '');

          String aaaa = xxx.toString();
          propertiesaa.addAll(aaaa.split(',').map((e) => e.trim()).toList());
        }
        // log('propertiesaapropertiesaa::${propertiesaa.toList()}');
        // if (propertiesaa.isNotEmpty && splitdataaa55.isNotEmpty) {
        //   log('propertiesaapropertiesaa::${propertiesaa.toList()}');
        //   for (var ij = 0; ij < propertiesaa.length; ij++) {
        //     testValues.add(
        //         TestReportValues(reportValues: propertiesaa[ij].toString()));
        //   }
        // }

        return LeadAnalysisModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return LeadAnalysisModel.issues(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("collection exception:$e");

      return LeadAnalysisModel.error("$e", resCode);
    }
  }
}

class SplitLeadData {
  String? leadReportData;
  SplitLeadData({required this.leadReportData});
}
