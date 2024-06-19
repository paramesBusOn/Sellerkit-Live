// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sellerkit/Services/getuserbyId/getuserbyid.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/newleadopenmodel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/newphonemodel.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetAllLeads.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/NewopenAPi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/Newphoneapi.dart';
import 'package:sellerkit/Services/userDialApi/userdialapi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBHelper.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/FollowUPModel.dart/FollowUPKPIModel.dart';
import '../../Models/PostQueryModel/FollowUPModel.dart/FollowUPModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTL.dart';
import '../../Services/PostQueryApi/FollowUPApi.dart/FollowUPKpiapi.dart';
import '../../Services/PostQueryApi/FollowUPApi.dart/FollowUPListApi.dart';
import '../../Services/PostQueryApi/LeadsApi/CancelLeadWonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/CloseLeadwonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/ForwardLeadUserApi.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTL.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDetailsL.dart';
import '../../Services/PostQueryApi/LeadsApi/LostSaveLeadApi.dart';
import '../../Services/PostQueryApi/LeadsApi/OpenSaveApi.dart';
import '../../Services/PostQueryApi/LeadsApi/WonSaveApi.dart';

class FollowupController extends ChangeNotifier {
  FollowupController() {
    clearAllData();
    // clearData();
    callGetAllApi();

    getDataOnLoad();
  }
  callusermobileApi() async {
    await userbyidApi.getData(ConstantValues.UserId).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        ConstantValues.userbyidmobile = value.ageLtData!.mobile!;
        log("ConstantValues. userbyidmobile:::" +
            ConstantValues.userbyidmobile.toString());
        getfirebase();
      }
    });
  }

  String? apidate;
  bool iscalltrue = false;
  bool get getiscalltrue => iscalltrue;
  String userid = '';
  String get getuserid => userid;
  String? usernumber = '';
  calldialApi(String? number) async {
    usernumber = '';
    iscalltrue = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 40), () {
      log("secondsoverrr:::");
      iscalltrue = false;
      notifyListeners();
    });

    // final FirebaseProduct = FirebaseFirestore.instance.collection("myoperator");

//     FirebaseProduct.get().then((value) {
// value.docs.forEach((element) {
//   usernumber=element!['mobile'].toString();
//   userid=element!['id'].toString();
// log("fsdfdf::"+userid.toString());
    // if(ConstantValues.userbyidmobile==usernumber){
    log("fsdfdf::user number match");
    UserdialApi.getdata(userid!, number!).then((value) {});
    // }
//   else{
// log("fsdfdf::no user number not match");
//   }

// });
    // });
  }

  getfirebase() async {
    userid = '';
    notifyListeners();
    final FirebaseProduct = FirebaseFirestore.instance.collection("myoperator");

    await FirebaseProduct.get().then((value) {
      value.docs.forEach((element) {
        usernumber = element!['mobile'].toString();

        log("fsdfdf::" + usernumber.toString());
        if (ConstantValues.userbyidmobile == usernumber) {
          log("fsdfdf::user number match");
          userid = element!['id'].toString();
          notifyListeners();
//  UserdialApi.getdata(userid!, number!).then((value) {

//     });
        }
//   else{
// log("fsdfdf::no user number not match");
//   }
      });
    });
  }

  clearAllData() {
    iscalltrue = false;
    userid = '';
    usernumber = '';
  }

  void showtoastforall() {
    Fluttertoast.showToast(
        msg: "Select User..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  Config config = new Config();
  bool isLoading = true;
  bool get getisLoading => isLoading;

  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());

  String excepMsg = '';
  String get getexcepMsg => excepMsg;

  List<FollowUPListData> fupODueListData = [];
  List<FollowUPListData> get getfupListData => fupODueListData;

  List<FollowUPListData> fupUpcmListData = [];
  List<FollowUPListData> get getfupUpcmListData => fupUpcmListData;

  List<FollowUPKPIData> followUPKPIOverDue = [];
  List<FollowUPKPIData> get getfollowUPKPIOverDue => followUPKPIOverDue;
  List<FollowUPKPIData> followUPKPIupcoming = [];
  List<FollowUPKPIData> get getfollowUPKPIupcoming => followUPKPIupcoming;
  List<GetLeadPhoneData> leadphonedata = [];
  List<GetLeadPhoneData> get getleadphonedata => leadphonedata;
  List<GetLeadopenData> leadopendata = [];
  List<GetLeadopenData> get getleadopendata => leadopendata;
  List<String> openleadFU = [];
  List<String> get getopenleadFU => openleadFU;
  List<String> wonleadFU = [];
  List<String> get getwonleadFU => wonleadFU;
  List<String> lostleadFU = [];
  List<String> get getlostleadFU => lostleadFU;

// bool? requireVisitBool=false;
//   bool? get getrequireVisitBool => requireVisitBool;
  callinitApi() async {
    await GetLeadopenApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadopendata = value.leadopendata!;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        excepMsg = "Something went wrong";
        notifyListeners();
      } else {
        excepMsg = "${value.stcode!}..!!Network Issue..\nTry again Later..!!";

        notifyListeners();
      }
    });
    await GetLeadphoneApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadphonedata = value.leadphonedata!;

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        excepMsg = "Something went wrong";
        notifyListeners();
      } else {
        excepMsg = "${value.stcode!}..!!Network Issue..\nTry again Later..!!";
        notifyListeners();
      }
    });
  }

  callFollowUPApi() async {
    lottie = '';
    followUPKPIOverDue.clear();
    followUPKPIupcoming.clear();

    await FollowUPKPIApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.followUPKPIheadr!.followUPKPIData != null &&
            value.followUPKPIheadr!.followUPKPIData!.isNotEmpty) {
          mapvaluessummary(value.followUPKPIheadr!.followUPKPIData!);
          isLoading = false;
          notifyListeners();
        } else if (value.followUPKPIheadr!.followUPKPIData == null ||
            value.followUPKPIheadr!.followUPKPIData!.isEmpty) {
          isLoading = false;
          lottie = 'Assets/no-data.png';
          excepMsg = 'No data...!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        lottie = '';
        excepMsg = '${value.message}..!!${value.exception}...!!';
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          isLoading = false;
          excepMsg = 'Check your Internet Connection...!!';
          notifyListeners();
        } else {
          isLoading = false;
          lottie = 'Assets/NetworkAnimation.json';
          excepMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  mapvaluessummary(List<FollowUPKPIData> followUPKPI) {
    for (int i = 0; i < followUPKPI.length; i++) {
      if (followUPKPI[i].OverdueKPI_Head_1 == "Overdue") {
        followUPKPIOverDue.add(FollowUPKPIData(
          OverdueKPI_Head_1: followUPKPI[i].OverdueKPI_Head_1,
          OverdueKPI_Line_1: followUPKPI[i].OverdueKPI_Line_1,
          OverdueKPI_Line_2: followUPKPI[i].OverdueKPI_Line_2,
        ));
        log("followUPKPIOverDue::" + followUPKPIOverDue.length.toString());
        notifyListeners();
      } else {
        followUPKPIupcoming.add(FollowUPKPIData(
          OverdueKPI_Head_1: followUPKPI[i].OverdueKPI_Head_1,
          OverdueKPI_Line_1: followUPKPI[i].OverdueKPI_Line_1,
          OverdueKPI_Line_2: followUPKPI[i].OverdueKPI_Line_2,
        ));
      }
      notifyListeners();
    }
    notifyListeners();
  }

  clearData() {
    errorVisitTime = "";
    errorTime = "";
    forwarderrorVisitTime = "";
    isLoading = true;
    excepMsg = '';
    isSelectedFollowUpcode = '';
    caseStatusSelectedcode = "";
    iscorectime2 = false;
    leadOpenAllData.clear();
    followUPKPIOverDue.clear();
    followUPKPIupcoming.clear();
    fupUpcmListData.clear();
    fupODueListData.clear();
    clearbool();
    notifyListeners();
  }

  List<GetAllLeadData> leadOpenAllData = [];

  String lottie = '';
  String get getlottie => lottie;
  callGetAllApi() async {
    leadOpenAllData.clear();

    lottie = ''; //  final Database db = (await DBHelper.getInstance())!;
    // leadStatusLost = await DBOperation.getLeadStatusLost(db);
    await GetAllLeadApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckheader!.leadcheckdata != null &&
            value.leadcheckheader!.leadcheckdata!.isNotEmpty) {
          // isLoading = false;
          // log("not null"+value.leadcheckheader!.length.toString());
          mapValues(value.leadcheckheader!.leadcheckdata!);
        } else if (value.leadcheckheader!.leadcheckdata == null ||
            value.leadcheckheader!.leadcheckdata!.isEmpty) {
          isLoading = false;
          lottie = 'Assets/no-data.png';
          excepMsg = 'No Data...!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isLoading = false;
        lottie = '';
        excepMsg = '${value.message}..!! ${value.exception}..!!';

        notifyListeners();
      } else if (value.stcode == 500) {
        isLoading = false;
        lottie = 'Assets/NetworkAnimation.json';
        excepMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
      notifyListeners();
    });
    await callusermobileApi();
  }

  mapValues(List<GetAllLeadData> leadcheckdata) async {
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status == "Open") {
        print("Open Lead follDate" + leadcheckdata[i].NextFollowup.toString());
        leadOpenAllData.add(GetAllLeadData(
          InterestLevel: leadcheckdata[i].InterestLevel,
          OrderType: leadcheckdata[i].OrderType,
          LeadDocEntry: leadcheckdata[i].LeadDocEntry,
          LeadNum: leadcheckdata[i].LeadNum,
          Mobile: leadcheckdata[i].Mobile,
          CustomerName: leadcheckdata[i].CustomerName,
          DocDate: leadcheckdata[i].DocDate,
          City: leadcheckdata[i].City,
          NextFollowup: leadcheckdata[i].NextFollowup,
          Product: leadcheckdata[i].Product,
          Value: leadcheckdata[i].Value,
          Status: leadcheckdata[i].Status,
          LastUpdateMessage: leadcheckdata[i].LastUpdateMessage,
          LastUpdateTime: leadcheckdata[i].LastUpdateTime,
          FollowupEntry: leadcheckdata[i].FollowupEntry,
          customermob: leadcheckdata[i].customermob,
          cusEmail: leadcheckdata[i].cusEmail,
          companyname: leadcheckdata[i].companyname,
          cusgroup: leadcheckdata[i].cusgroup,
          storecode: leadcheckdata[i].storecode,
          add1: leadcheckdata[i].add1,
          add2: leadcheckdata[i].add2,
          area: leadcheckdata[i].area,
          district: leadcheckdata[i].district,
          state: leadcheckdata[i].state,
          country: leadcheckdata[i].country,
          pincode: leadcheckdata[i].pincode,
          gender: leadcheckdata[i].gender,
          agegroup: leadcheckdata[i].agegroup,
          cameAs: leadcheckdata[i].cameAs,
          headcount: leadcheckdata[i].headcount,
          maxbudget: leadcheckdata[i].maxbudget,
          assignedTo: leadcheckdata[i].assignedTo,
          refferal: leadcheckdata[i].refferal,
          purchasePlan: leadcheckdata[i].purchasePlan,
          dealDescription: leadcheckdata[i].dealDescription,
          lastFollowupDate: leadcheckdata[i].lastFollowupDate,
          createdBy: leadcheckdata[i].createdBy,
          createdDate: leadcheckdata[i].createdDate,
          updatedBy: leadcheckdata[i].updatedBy,
          updatedDate: leadcheckdata[i].updatedDate,
          traceId: leadcheckdata[i].traceId,
        ));

        // log("currentdate::" + leadOpenAllData.length.toString());
      }
    }
    await mapvaluestoDB(leadOpenAllData);

    notifyListeners();
  }

  mapvaluestoDB(List<GetAllLeadData> leadOpenAllData) async {
    fupUpcmListData.clear();
    fupODueListData.clear();
    String currentdate;
    String? nextfollowdate;
    DateTime curentdate2;
    DateTime nextfollowdate2;
    currentdate = config.currentDateOnly();
    curentdate2 = DateTime.parse(currentdate);
    // log("currentdate::" + currentdate.toString());

    // log("currentdate22::" + curentdate2.toString());
    for (int i = 0; i < leadOpenAllData.length; i++) {
      // log("leadOpenAllData::" + leadOpenAllData.length.toString());
      nextfollowdate = config.aligndatefollow(leadOpenAllData[i].NextFollowup!);
      nextfollowdate2 = DateTime.parse(nextfollowdate);
      // log("nextfollowdate2::" + nextfollowdate2.toString());

      if (nextfollowdate2.isAfter(curentdate2)) {
        fupUpcmListData.add(FollowUPListData(
            FollowupDate: leadOpenAllData[i].NextFollowup,
            LeadDocEntry: leadOpenAllData[i].LeadDocEntry,
            LeadDocNum: leadOpenAllData[i].LeadNum,
            FollowupEntry: leadOpenAllData[i].FollowupEntry,
            Phone: leadOpenAllData[i].Mobile,
            Customer: leadOpenAllData[i].CustomerName,
            CretedDate: leadOpenAllData[i].createdDate,
            LastFollowupDate: leadOpenAllData[i].createdDate,
            DocTotal: leadOpenAllData[i].Value,
            Product: leadOpenAllData[i].Product,
            LastFollowupStatus: leadOpenAllData[i].LastUpdateMessage,
            add1: leadOpenAllData[i].add1,
            add2: leadOpenAllData[i].add2,
            area: leadOpenAllData[i].area,
            city: leadOpenAllData[i].City,
            cusEmail: leadOpenAllData[i].cusEmail,
            cusgroup: leadOpenAllData[i].cusgroup,
            pincode: leadOpenAllData[i].pincode,
            state: leadOpenAllData[i].state));
        // log("fupUpcmListData::" + fupUpcmListData.length.toString());
      } else {
        fupODueListData.add(FollowUPListData(
            FollowupDate: leadOpenAllData[i].NextFollowup,
            LeadDocEntry: leadOpenAllData[i].LeadDocEntry,
            LeadDocNum: leadOpenAllData[i].LeadNum,
            FollowupEntry: leadOpenAllData[i].FollowupEntry,
            Phone: leadOpenAllData[i].Mobile,
            Customer: leadOpenAllData[i].CustomerName,
            CretedDate: leadOpenAllData[i].createdDate,
            LastFollowupDate: leadOpenAllData[i].lastFollowupDate,
            DocTotal: leadOpenAllData[i].Value,
            Product: leadOpenAllData[i].Product,
            LastFollowupStatus: leadOpenAllData[i].LastUpdateMessage,
            add1: leadOpenAllData[i].add1,
            add2: leadOpenAllData[i].add2,
            area: leadOpenAllData[i].area,
            city: leadOpenAllData[i].City,
            cusEmail: leadOpenAllData[i].cusEmail,
            cusgroup: leadOpenAllData[i].cusgroup,
            pincode: leadOpenAllData[i].pincode,
            state: leadOpenAllData[i].state));

        // log("fupODueListData::" + fupODueListData.length.toString());
        notifyListeners();
      }
    }
    await callFollowUPApi();
    await callinitApi();
    notifyListeners();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  mapValuestoorder2(FollowUPListData leadOpenAllData) {
    OrderNewController.datafromfollow.clear();
    OrderNewController.datafromfollow.add(leadOpenAllData.Phone!);
    OrderNewController.datafromfollow.add(leadOpenAllData.Customer!);
    OrderNewController.datafromfollow.add(leadOpenAllData.add1!);
    OrderNewController.datafromfollow.add(leadOpenAllData.add2!);
    OrderNewController.datafromfollow.add(leadOpenAllData.pincode!);
    OrderNewController.datafromfollow
        .add(leadOpenAllData.city!); //isSelectedCsTag
    OrderNewController.datafromfollow
        .add(leadOpenAllData.LeadDocNum.toString());
    OrderNewController.datafromfollow.add(leadOpenAllData.cusEmail.toString());
    OrderNewController.datafromfollow.add(leadOpenAllData.state.toString());
    OrderNewController.datafromfollow.add(leadOpenAllData.cusgroup.toString());

    OrderNewController.datafromfollow.add(leadOpenAllData.area.toString());

    OrderBookNewState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.ordernew);
    notifyListeners();
    // GetCutomerDetailsApi.getData(mobile, "${ConstantValues.slpcode}")
    //     .then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if (value.itemdata != null) {
    //       //  itemdata = value.itemdata!;

    //       // OrderNewController.datafromfollow
    //       //     .add(value.itemdata!.mobileNo==null?'':value.itemdata!.mobileNo.toString());
    //       // OrderNewController.datafromfollow
    //       //     .add(value.itemdata!.customerName==null?'':value.itemdata!.customerName.toString());
    //       // OrderNewController.datafromfollow
    //       //     .add(value.itemdata!.alternateMobileNo=="null"||value.itemdata!.alternateMobileNo ==null?"": value.itemdata!.alternateMobileNo.toString());
    //       // OrderNewController.datafromfollow.add(value.itemdata!.email==null?"":value.itemdata!.email.toString());
    //       // OrderNewController.datafromfollow
    //       //     .add(value.itemdata!.address1==null?"":value.itemdata!.address1.toString());
    //       // OrderNewController.datafromfollow
    //       //     .add(value.itemdata!.address2==null?'':value.itemdata!.address2.toString());
    //       // OrderNewController.datafromfollow.add(value.itemdata!.city==null?'':value.itemdata!.city.toString());
    //       // OrderNewController.datafromfollow.add(value.itemdata!.state==null?'':value.itemdata!.state.toString());
    //       // OrderNewController.datafromfollow
    //       //     .add(value.itemdata!.pinCode==null?'':value.itemdata!.pinCode.toString());
    //       // OrderNewController.datafromfollow.add(value.itemdata!.customerGroup.toString());
    //       // OrderNewController.datafromfollow
    //       //     .add(docen.toString());
    //       //     OrderNewController.datafromfollow
    //       //     .add(value.itemdata!.area==null?'':value.itemdata!.area.toString());
    //       //  Get.toNamed(ConstantRoutes.ordernew);

    //       log("datataa" + docen.toString());
    //       notifyListeners();
    //       OrderBookNewState.iscomfromLead = true;
    //       Get.toNamed(ConstantRoutes.ordernew);
    //     } else if (value.itemdata == null) {
    //       //  leadLoadingdialog = false;
    //       excepMsg = 'No Data found...!!';
    //       //   forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

    //       notifyListeners();
    //     }
    //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
    //     // leadLoadingdialog = false;
    //     excepMsg =
    //         'Something went wrong try again\n${value.stcode} ${value.exception}...!!';
    //     // forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

    //     notifyListeners();
    //   } else if (value.stcode == 500) {
    //     //  leadLoadingdialog = false;
    //     excepMsg =
    //         'Something went wrong try again\n${value.stcode} ${value.exception}...!!';
    //     //    forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

    //     notifyListeners();
    //   }
    // });
  }

  // mapValuesFUP(List<FollowUPListData> followUPListData) {
  //   for (int i = 0; i < followUPListData.length; i++) {
  //     if (followUPListData[i].Followup_Due_Type == 'Overdue') {
  //       fupODueListData.add(FollowUPListData(
  //           FollowupDate: followUPListData[i].FollowupDate,
  //           LeadDocEntry: followUPListData[i].LeadDocEntry,
  //           LeadDocNum: followUPListData[i].LeadDocNum,
  //           FollowupEntry: followUPListData[i].FollowupEntry,
  //           Phone: followUPListData[i].Phone,
  //           Customer: followUPListData[i].Customer,
  //           CretedDate: followUPListData[i].CretedDate,
  //           LastFollowupDate: followUPListData[i].LastFollowupDate,
  //           DocTotal: followUPListData[i].DocTotal,
  //           Quantity: followUPListData[i].Quantity,
  //           Product: followUPListData[i].Product,
  //           LastFollowupStatus: followUPListData[i].LastFollowupStatus,
  //           LastFollowup_Feedback: followUPListData[i].LastFollowup_Feedback,
  //           CustomerInitialIcon: followUPListData[i].CustomerInitialIcon,
  //           Followup_Due_Type: followUPListData[i].Followup_Due_Type));
  //       log("fupODueListData:" + fupODueListData.length.toString());
  //     } else if (followUPListData[i].Followup_Due_Type == 'Upcoming') {
  //       fupUpcmListData.add(FollowUPListData(
  //           FollowupDate: followUPListData[i].FollowupDate,
  //           LeadDocEntry: followUPListData[i].LeadDocEntry,
  //           LeadDocNum: followUPListData[i].LeadDocNum,
  //           FollowupEntry: followUPListData[i].FollowupEntry,
  //           Phone: followUPListData[i].Phone,
  //           Customer: followUPListData[i].Customer,
  //           CretedDate: followUPListData[i].CretedDate,
  //           LastFollowupDate: followUPListData[i].LastFollowupDate,
  //           DocTotal: followUPListData[i].DocTotal,
  //           Quantity: followUPListData[i].Quantity,
  //           Product: followUPListData[i].Product,
  //           LastFollowupStatus: followUPListData[i].LastFollowupStatus,
  //           LastFollowup_Feedback: followUPListData[i].LastFollowup_Feedback,
  //           CustomerInitialIcon: followUPListData[i].CustomerInitialIcon,
  //           Followup_Due_Type: followUPListData[i].Followup_Due_Type));
  //     }
  //   }
  // }

  /// follow up dialog controlls

  bool isLodingDialog = false;
  bool get getisLodingDialog => isLodingDialog;
  String forwardDialogSuccessMsg = '';
  String get getforwardSuccessMsg => forwardDialogSuccessMsg;
  bool viewDetailsClicked = false;
  bool get getviewDetailsClicked => viewDetailsClicked;
  bool forwardDialogClicked = false;
  bool get getforwardDialogClicked => forwardDialogClicked;
  bool updateFrowardDialog = false;
  bool get getupdateFrowardDialog => updateFrowardDialog;

  void followUPClicked() {
    viewDetailsClicked = !viewDetailsClicked;
    notifyListeners();
  }

//view details api called

  List<GetLeadDeatilsQTHData> leadDeatilsQTHData = [];
  List<GetLeadDeatilsQTHData> get getleadDeatilsQTHData => leadDeatilsQTHData;

  List<GetLeadQTLData> leadDeatilsQTLData = [];
  List<GetLeadQTLData> get getleadDeatilsQTLData => leadDeatilsQTLData;

  List<GetLeadDeatilsLData> leadDeatilsLData = [];
  List<GetLeadDeatilsLData> get getleadDeatilsLeadData => leadDeatilsLData;

  callGetLeadDeatilsApi(String leadDocEnt) async {
    leadDeatilsQTHData.clear();
    leadDeatilsQTLData.clear();
    leadDeatilsLData.clear();
    forwardDialogSuccessMsg = '';
    isLodingDialog = true;
    notifyListeners();
    await GetLeadQTHApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadDeatilheadsData != null) {
          leadDeatilsQTHData = value.leadDeatilheadsData!.leadcheckQTHdata!;
          leadDeatilsQTLData = value.leadDeatilheadsData!.leadDeatilsQTLData!;

          if (value.leadDeatilheadsData!.leadDeatilsLeadData != null) {
            leadDeatilsLData = value.leadDeatilheadsData!.leadDeatilsLeadData!;
          }

          isLodingDialog = false;
          viewDetailsClicked = true;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardDialogSuccessMsg = '${value.message}..!!${value.exception}..!!';
        isLodingDialog = false;
        notifyListeners();
      } else {
        forwardDialogSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });

    // await GetLeadQTLApi.getData(leadDocEnt).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     leadDeatilsQTLData = value.leadDeatilsQTLData!;
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     forwardDialogSuccessMsg = 'Something wemt wrong..!!';
    //     isLodingDialog = false;
    //     notifyListeners();
    //   } else {
    //     forwardDialogSuccessMsg = 'Something wemt wrong..!!';
    //     isLodingDialog = false;
    //     notifyListeners();
    //   }
    // });

    // await GetLeadDetailsLApi.getData(leadDocEnt).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if(value.leadDeatilsLeadData!=null){
    //     leadDeatilsLData = value.leadDeatilsLeadData!;
    //     isLodingDialog = false;
    //     viewDetailsClicked = true;
    //     notifyListeners();
    //     }else{
    //        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
    //     isLodingDialog = false;
    //     notifyListeners();
    //     }
    //     // forwardSuccessMsg = 'Successfully Saved..!!';

    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     forwardDialogSuccessMsg = 'Something wemt wrong..!!';
    //     isLodingDialog = false;
    //     notifyListeners();
    //   } else {
    //     forwardDialogSuccessMsg = 'Something wemt wrong..!!';
    //     isLodingDialog = false;
    //     notifyListeners();
    //   }
    // });
  }

  /// forward dialog

  String? forwardNextFollowDate = 'Next Followup:*'; //cl
  String? get getforwardNextFollowDate => forwardNextFollowDate;
  String forwardnextWonFD = '';
  String get getforwardnextWonFD => forwardnextWonFD;
  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
  List<UserListData> filteruserLtData = [];
  List<UserListData> get getfiltergetuserLtData => filteruserLtData;
  String apiforwardNextFollowUPDate = '';
  String selectedUserList = '';
  String get getselectedUserList => selectedUserList;

  Future<void> swipeRefreshIndiactor() async {
    // return Future.delayed(Duration.zero,(){
    clearData();
    refershAfterClosedialog();
    callGetAllApi();

    // callSummaryApi();

    //});
  }

  getSelectedUserSalesEmpId(int i) {
    selectedUserList = filteruserLtData[i].userCode.toString();

    selectUser(i);
  }

  refershAfterClosedialog() {
    clearbool();
    forwaVisitTime = '';
    forwardnextWonFD = '';
    mycontroller[5].clear();
    iscorectime2 = false;

    leadOpenAllData.clear();

    mycontroller[3].text = "";
    mycontroller[4].text = "";

    caseStatusSelectedcode = "";
    caseStatusSelected = "";
    isSelectedFollowUp = '';
    isSelectedFollowUpcode = '';
    assignVisitTime = "Followup Time:*";
    forwardNextFollowDate = 'Next Followup:*';
    leadDeatilsQTHData.clear();
    leadDeatilsQTLData.clear();
    leadDeatilsLData.clear();
    selectedUserList = '';

    notifyListeners();
  }

  setForwardDataList() {
    List<UserListData> filteruserLtData2 = [];
// print("List Length"+filteruserLtData.length.toString());
    for (int i = 0; i < filteruserLtData.length; i++) {
      // print("User slp::${ConstantValues.slpcode}--${filteruserLtData[i].slpcode}");
      if (filteruserLtData[i].slpcode != ConstantValues.slpcode) {
        filteruserLtData2.add(UserListData(
            userCode: filteruserLtData[i].userCode,
            storeid: filteruserLtData[i].storeid,
            mngSlpcode: filteruserLtData[i].mngSlpcode,
            UserName: filteruserLtData[i].UserName,
            color: filteruserLtData[i].color,
            slpcode: filteruserLtData[i].slpcode,
            SalesEmpID: filteruserLtData[i].SalesEmpID));
      }
    }

    if (filteruserLtData2.isNotEmpty) {
      filteruserLtData = [];
      filteruserLtData = filteruserLtData2;
    }
    notifyListeners();
  }

  filterListAssignData(String v) {
    for (int i = 0; i < filteruserLtData.length; i++) {
      filteruserLtData[i].color = 0;
    }
    if (v.isNotEmpty) {
      filteruserLtData = userLtData
          .where((e) => e.UserName!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.s!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteruserLtData = userLtData;
      notifyListeners();
    }
  }

  String? salesEmpIdForward;
  selectUser(int ij) {
    for (int i = 0; i < filteruserLtData.length; i++) {
      if (filteruserLtData[i].slpcode == filteruserLtData[ij].slpcode) {
        filteruserLtData[i].color = 1;
        salesEmpIdForward = filteruserLtData[ij].slpcode;
      } else {
        filteruserLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  forwardClicked() {
    forwardDialogClicked = !forwardDialogClicked;
    notifyListeners();
  }

  getDataOnLoad() async {
    leadStatusOpen.clear();
    leadStatusWon.clear();
    leadStatusLost.clear();
    final Database db = (await DBHelper.getInstance())!;

    leadStatusOpen = await DBOperation.getLeadStatusOpen(db);
    leadStatusLost = await DBOperation.getLeadStatusLost(db);
    leadStatusWon = await DBOperation.getLeadStatusWon(db);
    userLtData = await DBOperation.getUserList(db);
    filteruserLtData = userLtData;
    setForwardDataList();
    //  openlea();
    // wonlea();
    // lostlea();
    notifyListeners();
  }

  openlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusOpen.length; i++) {
      var openleadcode = leadStatusOpen[i].code!;
      openleadFU = leadStatusOpen[i].name!.split(',');
      //  return openlead[i];
      log("openlea" + openleadFU[i].toString());
    }
    notifyListeners();
  }

  wonlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusWon.length; i++) {
      var wonleadcode = leadStatusWon[i].code!;
      wonleadFU = leadStatusWon[i].name!.split(',');

      log("wonleadFU" + wonleadFU[i].toString());
    }

    notifyListeners();
  }

  lostlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusLost.length; i++) {
      var lostleadcode = leadStatusLost[i].code!;
      lostleadFU = leadStatusLost[i].name!.split(',');
      // return openlead[i];
      log("lostleadFU" + lostleadFU[i].toString());
      notifyListeners();
    }
    notifyListeners();
  }

  // forwardApi(String followDocEntry, int salesPersonEmpId) async {
  //   notifyListeners();
  //   if (forwardnextWonFD.isEmpty) {
  //     forwardNextFollowDate = 'Next FollowUp*';
  //     notifyListeners();
  //   } else {
  //     forwardDialogSuccessMsg = '';
  //     isLodingDialog = true;
  //     viewDetailsClicked = false;
  //     updateFrowardDialog = false;
  //     forwardDialogClicked = false;
  //     notifyListeners();
  //     ForwardLeadUserData forwardLeadUserData = new ForwardLeadUserData();
  //     forwardLeadUserData.curentDate = config.currentDateOnly();
  //     forwardLeadUserData.nextFD = apiforwardNextFollowUPDate;
  //     forwardLeadUserData.nextUser = salesPersonEmpId;

  //     //   ForwardLeadUserApi.printn(followDocEntry, forwardLeadUserData);
  //     // Future.delayed(Duration(seconds: 3),(){
  //     // forwardDialogSuccessMsg = 'Done..!!';
  //     // isLodingDialog = false;
  //     // });
  //     await ForwardLeadUserApi.getData(followDocEntry, forwardLeadUserData)
  //         .then((value) {
  //       if (value.stCode >= 200 && value.stCode <= 210) {
  //         forwardDialogSuccessMsg = 'Successfully Forwarded..!!';
  //         isLodingDialog = false;
  //         notifyListeners();
  //       } else if (value.stCode >= 400 && value.stCode <= 410) {
  //         forwardDialogSuccessMsg = value.error!;
  //         isLodingDialog = false;
  //         notifyListeners();
  //       } else if (value.stCode == 500) {
  //         forwardDialogSuccessMsg = 'Some thing went wrong try agin..!!';
  //         isLodingDialog = false;
  //         notifyListeners();
  //       }
  //     });
  //     // checkValues();
  //   }
  // }

  void showForwardNextDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      forwaVisitTime = '';
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiforwardNextFollowUPDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiforwardNextFollowUPDate);

      forwardnextWonFD = chooseddate;
      notifyListeners();
    });
  }

  String errorVisitTime = "";
  selectVisitTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay startTime = TimeOfDay(hour: 7, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);
    if (visitDt.isNotEmpty) {
      errorVisitTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );

      if (newTime != null) {
        timee = newTime;
        // if (timee.hour < startTime.hour ||
        //       timee.hour > endTime.hour || (timee.hour == endTime.hour && timee.minute > endTime.minute)) {
        //         VisitTime = "";

        //     nextVisitTime = 'Visit Time:*';
        //     notifyListeners();
        //       }else{
        if (visitDt == DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              (timee.hour == TimeOfDay.now().hour &&
                  timee.minute < TimeOfDay.now().minute)) {
            errorVisitTime = "Please Choose Correct Time";
            VisitTime = "";
            notifyListeners();
            print("error");
          } else {
            errorVisitTime = "";
            print("correct11");
            VisitTime = timee.format(context).toString();
          }
        } else {
          errorVisitTime = "";
          print("correct22");
          timee = newTime;
          VisitTime = timee.format(context).toString();
        }
        nextVisitTime = 'Visit Time:';
        notifyListeners();
        // }
      }
      notifyListeners();
    } else {
      VisitTime = "";
      errorVisitTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }

  String errorTime = "";
  selectTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay startTime = TimeOfDay(hour: 7, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);
    if (nextFD.isNotEmpty) {
      errorTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );

      if (newTime != null) {
        timee = newTime;
        log("timee:::" + timee.toString());
        // if (timee.hour < startTime.hour ||
        //       timee.hour > endTime.hour|| (timee.hour == endTime.hour && timee.minute > endTime.minute)) {
        //         nextFDTime = "";

        //     nextFollowupTime = 'Follow up Time: *';
        //     errorTime=' Choose 7AM to 10PM';
        //     notifyListeners();
        //       }else{
        if (nextFD == DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              (timee.hour == TimeOfDay.now().hour &&
                  timee.minute < TimeOfDay.now().minute)) {
            errorTime = "Please Choose Correct Time";
            nextFDTime = "";
            notifyListeners();
            print("error");
          } else {
            errorTime = "";
            timee = newTime;
            print("correct11" + timee.format(context).toString());
            nextFDTime = timee.format(context).toString();
          }
        } else {
          errorTime = "";
          print("correct22");
          timee = newTime;
          nextFDTime = timee.format(context).toString();
        }
        nextFollowupTime = 'Follow up Time:*';
        notifyListeners();
        //  }
      }
      notifyListeners();
    } else {
      nextFDTime = "";
      errorTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }

  /// update dialog won lost open

  String? followup =
      'How you made the follow up?'; //cl How the follow up has been made
  String? get getfollowup => followup;
  String caseStatusSelected = ''; //cl
  String? get getcaseStatusSelected => caseStatusSelected;

  String isSelectedFollowUp = '';
  String get getisSelectedFollowUp => isSelectedFollowUp;

  bool leadOpenSaveClicked = false;
  bool leadWonSaveClicked = false;
  bool leadLostSaveClicked = false;

  String? hinttextforOpenLead = 'Select Status:* '; //cl
  String? get gethinttextforOpenLead => hinttextforOpenLead;
  String? hinttextforWonLead = 'Select Status:* '; //cl
  String? get gethinttextforWonLead => hinttextforWonLead;
  String? hinttextforLostLead = 'Select Reason*'; //cl
  String? get gethinttextforLostLead => hinttextforLostLead;
  String? feedbackLead = 'Give your feedback*'; //cl Give your feedback
  String? get getfeedbackLead => feedbackLead;
  String? nextFollowupDate = 'Next Follow up:*'; //cl
  String? get getnextFollowupDate => nextFollowupDate;
  String? nextFollowupTime = 'Follow up Time:*';
  String? get getnextFollowupTime => nextFollowupTime;
//
  String? nextVisitDate = 'Visit Date:*'; //cl
  String? get getnextVisitDate => nextVisitDate;
  String? nextVisitTime = 'Visit Time:*';
  String? get getnextVisitTime => nextVisitTime;
//

  String? orderBillRefer = 'Order/Bill Reference*'; //cl
  String? get getorderBillRefer => orderBillRefer;
  String? orderBillDate = 'Order/Bill Date:*'; //cl
  String? get getorderBillDate => orderBillDate;
  String apiFDate = '';
  String nextFD = '';
  //Vsiplan
  String apivisitate = '';
  String visitDt = '';
  String VisitTime = '';
  String get getVsitTime => VisitTime;
  //
  String nextWonFD = '';
  String get getnextFD => nextFD;
  String nextFDTime = '';
  String get getnextFDTime => nextFDTime;

  String? valueChosedReason; //cl
  String? get getvalueChosedReason => valueChosedReason;
  String? valueChosedStatus; //cl
  String? get getvalueChosedStatus => valueChosedStatus;
  String? valueChosedStatusWon; //cl
  String? get getvalueChosedStatusWon => valueChosedStatusWon;

  List<GetLeadStatusData> leadStatusOpen = [];
  List<GetLeadStatusData> leadStatusLost = [];
  List<GetLeadStatusData> leadStatusWon = [];
  List<GetLeadStatusData> get getleadStatusOpen => leadStatusOpen;
  List<GetLeadStatusData> get getleadStatusLost => leadStatusLost;
  List<GetLeadStatusData> get getleadStatusWon => leadStatusWon;

  changetoFolloweUp() {
    updateFrowardDialog = true;
    notifyListeners();
  }

  String isSelectedFollowUpcode = '';
  String get getisSelectedFollowUpcode => isSelectedFollowUpcode;
  selectFollowUp(String selected, String selectcode) {
    isSelectedFollowUp = selected;
    isSelectedFollowUpcode = selectcode;
    notifyListeners();
  }

  String caseStatusSelectedcode = ''; //cl
  String? get getcaseStatusSelectedcode => caseStatusSelectedcode;
  caseStatusSelectBtn(String val, String code) {
    caseStatusSelected = val;
    caseStatusSelectedcode = code;
    log("caseStatusSelected::" + caseStatusSelected.toString());
    log("caseStatusSelectedcode::" + caseStatusSelectedcode.toString());
    notifyListeners();
  }

  bool? sitevisitreq = false;
  bool? get getsitevisitreq => sitevisitreq;
  clearbool() {
    visitDt = '';
    VisitTime = '';
    errorVisitTime = '';
    forwaVisitTime = '';
    forwardnextWonFD = '';
    iscorectime2 = false;
    notifyListeners();
  }

  checksitevisit(bool val) {
    if (val == true) {
      log("DONE");
      clearbool();
      notifyListeners();
    }
    sitevisitreq = val;
    log("message::" + sitevisitreq.toString());
    notifyListeners();
  }

  validatebtnChanged() {
    if (caseStatusSelected == "Open") {
      sitevisitreq = false;
      if (leadOpenSaveClicked == true) {
        hinttextforOpenLead = "Select Status: *";
        feedbackLead = 'Give your feedback *';
        nextFollowupDate = 'Next Follow up: *';
        followup = 'How you made the follow up? *';
        nextFollowupTime = 'Follow up Time: *';
        nextVisitDate = 'Visit Date: *';
        nextVisitTime = 'Visit Time: *';
      } else {
        hinttextforOpenLead = "Select Status:*";
        feedbackLead = 'Give your feedback*';
        nextFollowupDate = 'Next Follow up:*';
        followup = 'How you made the follow up?*';
        nextFollowupTime = 'Follow up Time:*';
        nextVisitDate = 'Visit Date:*';
        nextVisitTime = 'Visit Time:*';
      }
      notifyListeners();
    } else {}

    if (caseStatusSelected == "Won") {
      if (leadWonSaveClicked == true) {
        hinttextforWonLead = "Select Status: *";
        orderBillRefer = 'Order/Bill Reference *';
        followup = 'How you made the follow up? *';
      } else {
        hinttextforWonLead = "Select Status:*";
        orderBillRefer = 'Order/Bill Reference*';
        feedbackLead = 'Give your feedback*';
        nextFollowupDate = 'Next Follow up:*';
        followup = 'How you made the follow up?*';
      }
      nextFD = '';
      nextFDTime = '';
      nextWonFD = '';
    } else {}

    if (caseStatusSelected == "Lost") {
      if (leadLostSaveClicked == true) {
        feedbackLead = 'Give your feedback *';
        hinttextforLostLead = 'Select Reason: *';
        followup = 'How you made the follow up? *';
      } else {
        feedbackLead = 'Give your feedback*';
        hinttextforLostLead = 'Select Reason:*';
        followup = 'How you made the follow up?*';
      }
      nextFD = '';
      nextFDTime = '';
      nextWonFD = '';
    } else {}
    notifyListeners();
  }

  String apiWonFDate = '';
  String get getnextWonFD => nextWonFD;
  void showFollowupWonDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiWonFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiWonFDate);

      nextWonFD = chooseddate;
      notifyListeners();
    });
  }

  choosedReason(String val) {
    valueChosedReason = val;
    notifyListeners();
  }

  choosedStatus(String val) {
    valueChosedStatus = val;
    notifyListeners();
  }

  choosedStatusWon(String val) {
    valueChosedStatusWon = val;
    notifyListeners();
  }

  void showFollowupDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      nextFD = chooseddate;
      notifyListeners();
    });
  }

  void showVisitDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      VisitTime = '';
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apivisitate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      visitDt = chooseddate;
      notifyListeners();
    });
  }

  clickLeadSaveBtn(String followDocEntry, String leadDocEntry) {
    if (caseStatusSelected == 'Open') {
      leadOpenSaveClicked = true;
      leadWonSaveClicked = false;
      leadLostSaveClicked = false;

      callRequiredOpen(followDocEntry, leadDocEntry);
    } else if (caseStatusSelected == 'Won') {
      leadWonSaveClicked = true;
      leadOpenSaveClicked = false;
      leadLostSaveClicked = false;
      callRequiredWon(followDocEntry, leadDocEntry);
    } else if (caseStatusSelected == 'Lost') {
      leadLostSaveClicked = true;
      leadOpenSaveClicked = false;
      leadWonSaveClicked = false;
      callRequiredLost(followDocEntry, leadDocEntry);
    }
  }

  callRequiredOpen(String followDocEntry, String leadDocEntry) {
    int i = 0;
    if (valueChosedStatus == null) {
      i = i + 1;
      hinttextforOpenLead = "Select Status: *";
    } else {
      hinttextforOpenLead = "Select Status:*";
    }
    if (mycontroller[1].text.isEmpty) {
      i = i + 1;
      feedbackLead = 'Give your feedback *';
    } else {
      feedbackLead = 'Give your feedback*';
    }
    if (nextFD == '') {
      i = i + 1;
      nextFollowupDate = 'Next Follow up: *';
    } else {
      nextFollowupDate = 'Next Follow up:*';
    }
    if (nextFDTime == '') {
      nextFollowupTime = 'Follow up Time: *';
    } else {
      nextFollowupTime = 'Follow up Time:*';
    }

    if (sitevisitreq == true) {
      if (visitDt == '') {
        nextVisitDate = 'Visit Date: *';
      } else {
        nextVisitDate = 'Visit Date:*';
      }

      if (VisitTime == '') {
        i = i + 1;
        nextVisitTime = 'Visit Time: *';
      } else {
        nextVisitTime = 'Visit Time:*';
      }
    }

    if (isSelectedFollowUp == '') {
      print("4");

      i = i + 1;
      followup = 'How you made the follow up? *';
    } else {
      followup = 'How you made the follow up?*';
    }
    hinttextforWonLead = "Select Status:*";
    orderBillRefer = 'Order/Bill Reference*';
    orderBillDate = 'Order/Bill Date*';
    hinttextforLostLead = 'Select Reason:*';
    if (i < 1) {
      print("ssssss");
      Allfollowupupdate(followDocEntry, leadDocEntry, mycontroller[1].text,
          apiFDate, "", "", "", "");

      // openSave(
      //     followDocEntry, valueChosedStatus, mycontroller[1].text, apiFDate);
    }
    notifyListeners();
  }

  callRequiredWon(String followDocEntry, String leadDocEntry) {
    int i = 0;
    if (valueChosedStatusWon == null) {
      print("1a");
      i = i + 1;
      hinttextforWonLead = "Select Status: *";
    } else {
      hinttextforWonLead = "Select Status:*";
    }
    if (mycontroller[0].text.isEmpty) {
      i = i + 1;
      print("2");

      orderBillRefer = 'Order/Bill Reference *';
    } else {
      orderBillRefer = 'Order/Bill Reference*';
    }
    if (nextWonFD == '') {
      print("3");

      i = i + 1;
      orderBillDate = 'Order/Bill Date *';
    } else {
      orderBillDate = 'Order/Bill Date*';
    }
    if (isSelectedFollowUp == '') {
      print("4");

      i = i + 1;
      followup = 'ow you made the follow up? *';
    } else {
      followup = 'ow you made the follow up?*';
    }
    feedbackLead = 'Give your feedback *';
    nextFollowupDate = 'Next Follow up:*';
    hinttextforLostLead = 'Select Reason:*';
    hinttextforOpenLead = "Select Status:*";
    print(i);
    if (i < 1) {
      print("ssssss");
      Allfollowupupdate(followDocEntry, leadDocEntry, mycontroller[1].text, "",
          apiWonFDate, mycontroller[0].text, '', "");

      // WonSave(
      //     followDocEntry,
      //     leadDocEntry,
      //     valueChosedStatusWon,
      //     mycontroller[1].text,
      //     isSelectedFollowUp,
      //     apiWonFDate,
      //     mycontroller[0].text);
    }
    notifyListeners();
  }

  callRequiredLost(String followDocEntry, String leadDocEntry) {
    int i = 0;
    if (mycontroller[1].text.isEmpty) {
      i = i + 1;
      feedbackLead = 'Give your feedback *';
    } else {
      feedbackLead = 'Give your feedback*';
    }
    if (valueChosedReason == null) {
      i = i + 1;
      hinttextforLostLead = 'Select Reason: *';
    } else {
      hinttextforLostLead = 'Select Reason:*';
    }
    if (isSelectedFollowUp == '') {
      i = i + 1;
      followup = 'How you made the follow up? *';
    } else {
      followup = 'How you made the follow up?*';
    }
    hinttextforWonLead = "Select Status:*";
    orderBillRefer = 'Order/Bill Reference*';
    orderBillDate = 'Order/Bill Date*';
    nextFollowupDate = 'Next Follow up:*';
    hinttextforOpenLead = "Select Status:*";
    if (i < 1) {
      Allfollowupupdate(followDocEntry, leadDocEntry, mycontroller[1].text, "",
          "", "", "", "");

      // lostSave(followDocEntry, leadDocEntry, valueChosedReason,
      //     mycontroller[1].text, isSelectedFollowUp);
    }
    notifyListeners();
  }

  bool iscorectime2 = false;
  String forwarderrorVisitTime = "";
  String forwaVisitTime = '';
  String get getVisitTime => VisitTime;
  String? assignvisitDt = '';
  String? assignVisitTime = 'Followup Time:*';
  forwardVisitTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay startTime = TimeOfDay(hour: 7, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);
    if (forwardnextWonFD.isNotEmpty) {
      forwarderrorVisitTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );

      if (newTime != null) {
        timee = newTime;
//          if (timee.hour < startTime.hour ||
//               timee.hour > endTime.hour) {
//                 forwaVisitTime = "";
//  iscorectime2=true;
//             assignVisitTime = 'Followup Time:*';
//             notifyListeners();
//               }else{
        if (forwardnextWonFD ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              (timee.hour == TimeOfDay.now().hour &&
                  timee.minute < TimeOfDay.now().minute)) {
            forwarderrorVisitTime = "Please Choose Correct Time";
            forwaVisitTime = "";
            iscorectime2 = true;
            notifyListeners();
            print("error");
          } else {
            errorVisitTime = "";
            print("correct11");
            iscorectime2 = false;
            forwaVisitTime = timee.format(context).toString();
          }
        } else {
          errorVisitTime = "";
          print("correct22");
          timee = newTime;
          iscorectime2 = false;
          forwaVisitTime = timee.format(context).toString();
        }
        // }
        notifyListeners();
      }
      notifyListeners();
    } else {
      forwaVisitTime = "";
      forwarderrorVisitTime = "Please Choose First Date";
      iscorectime2 = true;
      notifyListeners();
    }
    notifyListeners();
  }

  Allfollowupupdate(
      String followDocEntry,
      String leadDocEntry,
      feedback,
      nextFPdate,
      billwonDate,
      billreference,
      String salesPersonEmpId,
      String checkstatus) async {
    forwardDialogSuccessMsg = '';
    isLodingDialog = true;
    viewDetailsClicked = false;
    updateFrowardDialog = false;
    forwardDialogClicked = false;
    String? reasondetails;
    ForwardLeadUserDataOpen forwardLeadUserDataOpen =
        new ForwardLeadUserDataOpen();
    log("valueChosedStatus::" + valueChosedStatus.toString());
    if (caseStatusSelected == "Open") {
      for (int i = 0; i < leadStatusOpen.length; i++) {
        if (leadStatusOpen[i].code == valueChosedStatus) {
          reasondetails = leadStatusOpen[i].name;
          log("reasondetails::" + reasondetails.toString());
        }
        notifyListeners();
      }
      if (nextFDTime != '') {
        Config config = Config();

        forwardLeadUserDataOpen.nextFD =
            config.alignDateforFollow(nextFDTime, nextFPdate);
      } else {
        forwardLeadUserDataOpen.nextFD = nextFPdate;
      }

      if (visitDt != '') {
        Config config = Config();
        forwardLeadUserDataOpen.visitreq = 1;
        forwardLeadUserDataOpen.visitdate =
            config.alignDateforFollow(VisitTime, apivisitate);
      } else {
        forwardLeadUserDataOpen.visitreq = 0;
        forwardLeadUserDataOpen.visitdate = null;
      }
      forwardLeadUserDataOpen.curentDate = config.currentDate();
      forwardLeadUserDataOpen.ReasonCode = valueChosedStatus;
      forwardLeadUserDataOpen.Reasoname = reasondetails;
      forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;

      forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
      forwardLeadUserDataOpen.feedback = feedback;
      forwardLeadUserDataOpen.status = caseStatusSelectedcode;
      notifyListeners();
    } else if (caseStatusSelected == "Won") {
      for (int i = 0; i < leadStatusWon.length; i++) {
        if (leadStatusWon[i].code == valueChosedStatusWon) {
          reasondetails = leadStatusWon[i].name;
          log("reasondetails::" + reasondetails.toString());
        }
        notifyListeners();
      }

      forwardLeadUserDataOpen.ReasonCode = valueChosedStatusWon;
      forwardLeadUserDataOpen.Reasoname = reasondetails;
      forwardLeadUserDataOpen.billDate = billwonDate;
      forwardLeadUserDataOpen.billRef = billreference;
      forwardLeadUserDataOpen.curentDate = config.currentDate();
      forwardLeadUserDataOpen.feedback = feedback;
      forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;
      forwardLeadUserDataOpen.nextFD = null;
      forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
      forwardLeadUserDataOpen.status = caseStatusSelectedcode;
      notifyListeners();
    } else if (caseStatusSelected == "Lost") {
      for (int i = 0; i < leadStatusLost.length; i++) {
        if (leadStatusLost[i].code == valueChosedReason) {
          reasondetails = leadStatusLost[i].code;
          log("reasondetails::" + reasondetails.toString());
        }
        notifyListeners();
      }
      forwardLeadUserDataOpen.ReasonCode = valueChosedReason;
      forwardLeadUserDataOpen.Reasoname = reasondetails;
      forwardLeadUserDataOpen.curentDate = config.currentDate();
      forwardLeadUserDataOpen.feedback = feedback;
      forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;
      forwardLeadUserDataOpen.nextFD = null;
      forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
      forwardLeadUserDataOpen.status = caseStatusSelectedcode;
      notifyListeners();
    } else {
      for (int i = 0; i < leadStatusOpen.length; i++) {
        if (leadStatusOpen[i].name == checkstatus) {
          reasondetails = leadStatusOpen[i].code;
          log("reasondetails::" + reasondetails.toString());
        }

        notifyListeners();
      }
      Config config = Config();

      forwardLeadUserDataOpen.nextFD =
          config.alignDateforFollow(forwaVisitTime, apiforwardNextFollowUPDate);
      forwardLeadUserDataOpen.ReasonCode =
          reasondetails == null || reasondetails.isEmpty
              ? leadStatusOpen[0].code
              : reasondetails;
      forwardLeadUserDataOpen.Reasoname =
          reasondetails == null || reasondetails.isEmpty
              ? leadStatusOpen[0].name
              : checkstatus;
      forwardLeadUserDataOpen.status = "01";
      forwardLeadUserDataOpen.curentDate = config.currentDate();

      forwardLeadUserDataOpen.nextUser = salesPersonEmpId;
      notifyListeners();
    }

    await AllSaveLeadApi.getData(leadDocEntry, forwardLeadUserDataOpen)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardDialogSuccessMsg = '${value.error!}..!!';
        isLodingDialog = false;
        notifyListeners();

        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardDialogSuccessMsg = '${value.error!}..!!${value.stCode}...!!';
        isLodingDialog = false;
        notifyListeners();
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardDialogSuccessMsg =
            '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
    // checkValues();
  }
//     openSave(String followDocEntry, status, feedback, nextFPdate,nextfpTime) async {
//     forwardDialogSuccessMsg = '';
//       isLodingDialog = true;
//       viewDetailsClicked = false;
//       updateFrowardDialog = false;
//       forwardDialogClicked = false;
//       notifyListeners();
//     ForwardLeadUserDataOpen forwardLeadUserDataOpen =
//         new ForwardLeadUserDataOpen();
//     forwardLeadUserDataOpen.curentDate = config.currentDateOnly();
//     forwardLeadUserDataOpen.ReasonCode = valueChosedStatus;
//     forwardLeadUserDataOpen.followupMode = isSelectedFollowUp;
//     // forwardLeadUserDataOpen.nextFD = nextFPdate;
//     forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
//     forwardLeadUserDataOpen.feedback = feedback;

//     if(nextfpTime != ''){
//       Config config=Config();

// forwardLeadUserDataOpen.nextFD=
// config.alignDateforFollow(nextfpTime,nextFPdate);

//     }else{
// forwardLeadUserDataOpen.nextFD = nextFPdate;
//     }
//     notifyListeners();
//     // OpenSaveLeadApi.printjson(followDocEntry, forwardLeadUserDataOpen);

//     // Future.delayed(Duration(seconds: 3),(){
//     //      forwardDialogSuccessMsg = 'Done..!!';
//     //   isLodingDialog = false;
//     //   viewDetailsClicked = false;
//     //   updateFrowardDialog = false;
//     //   forwardDialogClicked = false;
//     // });
//     // await OpenSaveLeadApi.getData(followDocEntry, forwardLeadUserDataOpen)
//     //     .then((value) {
//     //   if (value.stCode >= 200 && value.stCode <= 210) {
//     //     forwardDialogSuccessMsg = 'Successfully Saved..!!';
//     //   isLodingDialog = false;
//     //     notifyListeners();
//     //   } else if (value.stCode >= 400 && value.stCode <= 410) {
//     //     forwardDialogSuccessMsg = value.error!.message!.value!;
//     //     isLodingDialog = false;
//     //     notifyListeners();
//     //   } else if (value.stCode == 500) {
//     //     forwardDialogSuccessMsg = 'Some thing went wrong try agin..!!';
//     //     isLodingDialog = false;
//     //     notifyListeners();
//     //   }
//     // });
//   }

  WonSave(followDocEntry, String leadDocEntry, status, feedback, followup,
      billwonDate, billreference) async {
    forwardDialogSuccessMsg = '';
    isLodingDialog = true;
    viewDetailsClicked = false;
    updateFrowardDialog = false;
    forwardDialogClicked = false;
    notifyListeners();
    ForwardLeadUserDataWon forwardLeadUserDataWon =
        new ForwardLeadUserDataWon();
    forwardLeadUserDataWon.ReasonCode = status;
    forwardLeadUserDataWon.billDate = billwonDate;
    forwardLeadUserDataWon.billRef = billreference;
    forwardLeadUserDataWon.curentDate = config.currentDateOnly();
    forwardLeadUserDataWon.feedback = feedback;
    forwardLeadUserDataWon.followupMode = followup;
    forwardLeadUserDataWon.nextFD = null;
    forwardLeadUserDataWon.updatedBy = ConstantValues.slpcode;

    // WonSaveLeadApi.prinjson( followDocEntry,forwardLeadUserDataWon);
    await WonSaveLeadApi.getData(followDocEntry, forwardLeadUserDataWon)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardDialogSuccessMsg = 'Successfully Saved..!!';
        isLodingDialog = false;
        notifyListeners();
        // callCloseApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardDialogSuccessMsg = value.error!;
        isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardDialogSuccessMsg =
            '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  }

  lostSave(followDocEntry, String leadDocEntry, reason, feedback,
      followupMode) async {
    forwardDialogSuccessMsg = '';
    isLodingDialog = true;
    viewDetailsClicked = false;
    updateFrowardDialog = false;
    forwardDialogClicked = false;
    notifyListeners();
    ForwardLeadUserDataLost forwardLeadUserDataLost =
        new ForwardLeadUserDataLost();

    forwardLeadUserDataLost.ReasonCode = reason;
    forwardLeadUserDataLost.curentDate = config.currentDateOnly();
    forwardLeadUserDataLost.feedback = feedback;
    forwardLeadUserDataLost.followupMode = followupMode;
    forwardLeadUserDataLost.nextFD = null;
    forwardLeadUserDataLost.updatedBy = ConstantValues.slpcode;

    // LostSaveLeadApi.prinjson(followDocEntry,forwardLeadUserDataLost);
    await LostSaveLeadApi.getData(followDocEntry, forwardLeadUserDataLost)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardDialogSuccessMsg = 'Successfully Saved..!!';
        isLodingDialog = false;
        notifyListeners();
        // callCancelApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardDialogSuccessMsg = value.error!;
        isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardDialogSuccessMsg =
            '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  }

  //   callCloseApi(String leadDocEntry) async {
  //   await CloseLeadApi.getData(leadDocEntry).then((value) {
  //     if (value.stCode >= 200 && value.stCode <= 210) {
  //       forwardDialogSuccessMsg = 'Successfully Saved..!!';
  //       isLodingDialog = false;
  //       notifyListeners();
  //     } else if (value.stCode >= 400 && value.stCode <= 490) {
  //       forwardDialogSuccessMsg = '${value.error!.message}';
  //       isLodingDialog = false;
  //       notifyListeners();
  //     } else {
  //       forwardDialogSuccessMsg = 'Something wemt wrong..!!';
  //       isLodingDialog = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  // callCancelApi(String leadDocEntry) async {
  //   await CancelLeadApi.getData(leadDocEntry).then((value) {
  //     if (value.stCode >= 200 && value.stCode <= 210) {
  //       forwardDialogSuccessMsg = 'Successfully Saved..!!';
  //       isLodingDialog = false;
  //       notifyListeners();
  //     } else if (value.stCode >= 400 && value.stCode <= 490) {
  //       forwardDialogSuccessMsg = 'Something wemt wrong..!!';
  //       isLodingDialog = false;
  //       notifyListeners();
  //     } else {
  //       forwardDialogSuccessMsg = 'Something wemt wrong..!!';
  //       isLodingDialog = false;
  //       notifyListeners();
  //     }
  //   });
  // }
}
