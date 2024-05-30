// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/ResonModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../DBHelper/DBOperation.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Pages/Enquiries/EnquiriesUser/Widgets/OpenUserDialog.dart';
import '../../Pages/Enquiries/EnquiriesUser/Widgets/WarningDialog.dart';
import '../../Pages/Enquiries/EnquiryManger/Widgets/AssignedtoDilaog.dart';
import '../../Pages/Enquiries/EnquiryManger/Widgets/WarningMgrDialog.dart';
import '../../Services/PostQueryApi/EnquiriesApi/AssignedToUserApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqPrevDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/EnquiriesApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/ResonApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/UpdateEnq.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import '../LeadController/LeadNewController.dart';
import 'NewEnqController.dart';

class EnquiryMangerContoller extends ChangeNotifier {
  Config config = new Config();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String errorMsg = '';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;

  String eMsgUList = '';
  bool exceptionUList = false;
  bool get getexceptionUList => exceptionUList;
  String get geteMsgUList => eMsgUList;

  bool datagotByApi = false;
  bool get getdatagotByApi => datagotByApi;

  List<EnquiriesData> assignedEnqData = [];
  List<EnquiriesData> unassignedEnqdata = [];
  List<EnquiriesData> lostEnqdata = [];

  List<EnquiriesData> get getassignedEnqData => assignedEnqData;
  List<EnquiriesData> get getunassignedEnqdata => unassignedEnqdata;
  List<EnquiriesData> get getlostEnqdata => lostEnqdata;
//for alert dialog
  bool assignto = false;
  bool get getassignto => assignto;

  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;

  int? getUserKey;

  String assignedToApiActResp = '';
  String get getassignedToApiActResp => assignedToApiActResp;

  String assignedToApiActRespMsg = '';
  String get getassignedToApiActRespMsg => assignedToApiActRespMsg;

  bool assigntoApical = false;
  bool get getassigntoApiCall => assigntoApical;

  //status update

  bool statusUpdate = false;
  bool get getstatusUpdate => statusUpdate;

  bool statusUpdateLoading = false;
  bool get getstatusUpdateLoading => statusUpdateLoading;

  bool isAnotherBranchEnq = false;
  bool get getisAnotherBranchEnq => isAnotherBranchEnq;

  String statusUpdateApiResp = '';
  String get getstatusUpdateApiResp => statusUpdateApiResp;

  String statusUpdateApiRespMsg = '';
  String get getstatusUpdateApiRespMsg => statusUpdateApiRespMsg;

  String? valueChosedReason;
  String? get getvalueChosedReason => valueChosedReason;

  List<String> reasonMaster = ["purchased", "lost"];

  List<String> get getreasonMaster => reasonMaster;

  List<ResonData> resonData = [];
  List<ResonData> get getresonData => resonData;

  String? apidate;

  showSuccessDia() {
    statusUpdate = true;
    statusUpdateApiResp = 'abcd';
  }

  Future<void> swipeRefreshIndicator() async {
    datagotByApi = false;
    notifyListeners();
    callApi();
    callUserListApi();
    callResonApi();
  }

  callApi() async {
    exception = false;
    datagotByApi = false;
    notifyListeners();
    await EnquiryApi.getData("${ConstantValues.slpcode}").then((value) {
      assignedEnqData.clear();
      unassignedEnqdata.clear();
      lostEnqdata.clear();
      notifyListeners();
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          exception = false;
          datagotByApi = true;
          //assignedEnqData = value.itemdata!;
          for (int i = 0; i < value.itemdata!.datadetail!.length; i++) {
            if (value.itemdata!.datadetail![i].Manager_Status_Tab!.toLowerCase() ==
                'assigned') {
              assignedEnqData.add(
                
                EnquiriesData(
                  InterestLevel:value.itemdata!.datadetail![i].InterestLevel ,
                OrderType:value.itemdata!.datadetail![i].OrderType ,
                  contactName: value.itemdata!.datadetail![i].contactName,
                altermobileNo: value.itemdata!.datadetail![i].altermobileNo,
                customerGroup: value.itemdata!.datadetail![i].customerGroup,
                comapanyname: value.itemdata!.datadetail![i].comapanyname,
                visitTime: value.itemdata!.datadetail![i].visitTime,
                remindOn: value.itemdata!.datadetail![i].remindOn,
                isClosed: value.itemdata!.datadetail![i].isClosed,
                isVisitRequired: value.itemdata!.datadetail![i].isVisitRequired,
                storecode: value.itemdata!.datadetail![i].storecode,
                area: value.itemdata!.datadetail![i].area,
                district: value.itemdata!.datadetail![i].district,
                itemCode: value.itemdata!.datadetail![i].itemCode,
                itemname: value.itemdata!.datadetail![i].itemname,
                leadConverted: value.itemdata!.datadetail![i].leadConverted,
                createdBy: value.itemdata!.datadetail![i].createdBy,
                createdDateTime: value.itemdata!.datadetail![i].createdDateTime,
                updatedBy: value.itemdata!.datadetail![i].updatedBy,
                updatedDateTime: value.itemdata!.datadetail![i].updatedDateTime,
                enquirydscription: value.itemdata!.datadetail![i].enquirydscription,
                quantity: value.itemdata!.datadetail![i].quantity,
                customermobile: value.itemdata!.datadetail![i].customermobile,
                  email: value.itemdata!.datadetail![i].email,referal:value.itemdata!.datadetail![i].referal,
                  Mgr_UserName: value.itemdata!.datadetail![i].Mgr_UserName,
                  EnqID: value.itemdata!.datadetail![i].EnqID,
                  CardCode: value.itemdata!.datadetail![i].CardCode,
                  Status: value.itemdata!.datadetail![i].Status,
                  CardName: value.itemdata!.datadetail![i].CardName,
                  AssignedTo_User: value.itemdata!.datadetail![i].AssignedTo_User,
                  EnqDate: value.itemdata!.datadetail![i].EnqDate,
                  Followup: value.itemdata!.datadetail![i].Followup,
                  Mgr_UserCode: value.itemdata!.datadetail![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata!.datadetail![i].AssignedTo_UserName,
                  EnqType: value.itemdata!.datadetail![i].EnqType,
                  Lookingfor: value.itemdata!.datadetail![i].Lookingfor,
                  PotentialValue: value.itemdata!.datadetail![i].PotentialValue,
                  Address_Line_1: value.itemdata!.datadetail![i].Address_Line_1,
                  Address_Line_2: value.itemdata!.datadetail![i].Address_Line_2,
                  Pincode: value.itemdata!.datadetail![i].Pincode,
                  City: value.itemdata!.datadetail![i].City,
                  State: value.itemdata!.datadetail![i].State,
                  Country: value.itemdata!.datadetail![i].Country,
                  Manager_Status_Tab: value.itemdata!.datadetail![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata!.datadetail![i].Slp_Status_Tab));
            }
            if (value.itemdata!.datadetail![i].Manager_Status_Tab!.toLowerCase() ==
                'unassigned') {
              unassignedEnqdata.add(EnquiriesData(
                InterestLevel:value.itemdata!.datadetail![i].InterestLevel ,
                OrderType:value.itemdata!.datadetail![i].OrderType ,
                contactName: value.itemdata!.datadetail![i].contactName,
                altermobileNo: value.itemdata!.datadetail![i].altermobileNo,
                customerGroup: value.itemdata!.datadetail![i].customerGroup,
                comapanyname: value.itemdata!.datadetail![i].comapanyname,
                visitTime: value.itemdata!.datadetail![i].visitTime,
                remindOn: value.itemdata!.datadetail![i].remindOn,
                isClosed: value.itemdata!.datadetail![i].isClosed,
                isVisitRequired: value.itemdata!.datadetail![i].isVisitRequired,
                storecode: value.itemdata!.datadetail![i].storecode,
                area: value.itemdata!.datadetail![i].area,
                district: value.itemdata!.datadetail![i].district,
                itemCode: value.itemdata!.datadetail![i].itemCode,
                itemname: value.itemdata!.datadetail![i].itemname,
                leadConverted: value.itemdata!.datadetail![i].leadConverted,
                createdBy: value.itemdata!.datadetail![i].createdBy,
                createdDateTime: value.itemdata!.datadetail![i].createdDateTime,
                updatedBy: value.itemdata!.datadetail![i].updatedBy,
                updatedDateTime: value.itemdata!.datadetail![i].updatedDateTime,
                enquirydscription: value.itemdata!.datadetail![i].enquirydscription,
                quantity: value.itemdata!.datadetail![i].quantity,
                customermobile: value.itemdata!.datadetail![i].customermobile,
                email: value.itemdata!.datadetail![i].email,referal:value.itemdata!.datadetail![i].referal,
                  Mgr_UserName: value.itemdata!.datadetail![i].Mgr_UserName,
                  EnqID: value.itemdata!.datadetail![i].EnqID,
                  CardCode: value.itemdata!.datadetail![i].CardCode,
                  Status: value.itemdata!.datadetail![i].Status,
                  CardName: value.itemdata!.datadetail![i].CardName,
                  AssignedTo_User: value.itemdata!.datadetail![i].AssignedTo_User,
                  EnqDate: value.itemdata!.datadetail![i].EnqDate,
                  Followup: value.itemdata!.datadetail![i].Followup,
                  Mgr_UserCode: value.itemdata!.datadetail![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata!.datadetail![i].AssignedTo_UserName,
                  EnqType: value.itemdata!.datadetail![i].EnqType,
                  Lookingfor: value.itemdata!.datadetail![i].Lookingfor,
                  PotentialValue: value.itemdata!.datadetail![i].PotentialValue,
                  Address_Line_1: value.itemdata!.datadetail![i].Address_Line_1,
                  Address_Line_2: value.itemdata!.datadetail![i].Address_Line_2,
                  Pincode: value.itemdata!.datadetail![i].Pincode,
                  City: value.itemdata!.datadetail![i].City,
                  State: value.itemdata!.datadetail![i].State,
                  Country: value.itemdata!.datadetail![i].Country,
                  Manager_Status_Tab: value.itemdata!.datadetail![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata!.datadetail![i].Slp_Status_Tab));
            }
            if (value.itemdata!.datadetail![i].Manager_Status_Tab!.toLowerCase() ==
                'lost') {
              lostEnqdata.add(EnquiriesData(
                InterestLevel:value.itemdata!.datadetail![i].InterestLevel ,
                OrderType:value.itemdata!.datadetail![i].OrderType ,
                contactName: value.itemdata!.datadetail![i].contactName,
                altermobileNo: value.itemdata!.datadetail![i].altermobileNo,
                customerGroup: value.itemdata!.datadetail![i].customerGroup,
                comapanyname: value.itemdata!.datadetail![i].comapanyname,
                visitTime: value.itemdata!.datadetail![i].visitTime,
                remindOn: value.itemdata!.datadetail![i].remindOn,
                isClosed: value.itemdata!.datadetail![i].isClosed,
                isVisitRequired: value.itemdata!.datadetail![i].isVisitRequired,
                storecode: value.itemdata!.datadetail![i].storecode,
                area: value.itemdata!.datadetail![i].area,
                district: value.itemdata!.datadetail![i].district,
                itemCode: value.itemdata!.datadetail![i].itemCode,
                itemname: value.itemdata!.datadetail![i].itemname,
                leadConverted: value.itemdata!.datadetail![i].leadConverted,
                createdBy: value.itemdata!.datadetail![i].createdBy,
                createdDateTime: value.itemdata!.datadetail![i].createdDateTime,
                updatedBy: value.itemdata!.datadetail![i].updatedBy,
                updatedDateTime: value.itemdata!.datadetail![i].updatedDateTime,
                enquirydscription: value.itemdata!.datadetail![i].enquirydscription,
                quantity: value.itemdata!.datadetail![i].quantity,
                customermobile: value.itemdata!.datadetail![i].customermobile,
                email: value.itemdata!.datadetail![i].email,referal:value.itemdata!.datadetail![i].referal,
                  Mgr_UserName: value.itemdata!.datadetail![i].Mgr_UserName,
                  EnqID: value.itemdata!.datadetail![i].EnqID,
                  CardCode: value.itemdata!.datadetail![i].CardCode,
                  Status: value.itemdata!.datadetail![i].Status,
                  CardName: value.itemdata!.datadetail![i].CardName,
                  AssignedTo_User: value.itemdata!.datadetail![i].AssignedTo_User,
                  EnqDate: value.itemdata!.datadetail![i].EnqDate,
                  Followup: value.itemdata!.datadetail![i].Followup,
                  Mgr_UserCode: value.itemdata!.datadetail![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata!.datadetail![i].AssignedTo_UserName,
                  EnqType: value.itemdata!.datadetail![i].EnqType,
                  Lookingfor: value.itemdata!.datadetail![i].Lookingfor,
                  PotentialValue: value.itemdata!.datadetail![i].PotentialValue,
                  Address_Line_1: value.itemdata!.datadetail![i].Address_Line_1,
                  Address_Line_2: value.itemdata!.datadetail![i].Address_Line_2,
                  Pincode: value.itemdata!.datadetail![i].Pincode,
                  City: value.itemdata!.datadetail![i].City,
                  State: value.itemdata!.datadetail![i].State,
                  Country: value.itemdata!.datadetail![i].Country,
                  Manager_Status_Tab: value.itemdata!.datadetail![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata!.datadetail![i].Slp_Status_Tab));
            }
          }
          notifyListeners();
        } else if (value.itemdata == null) {
          datagotByApi = false;
          exception = true;
          errorMsg = 'No data found..!!';
          notifyListeners();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
  }

  callPrevEnqDatilsApi(BuildContext context, int enqData) async {
    print("EnqPrevDetailsApi");
    await EnqPrevDetailsApi.getData(enqData).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          assignedEnqData.clear();
          unassignedEnqdata.clear();
          lostEnqdata.clear();
          exception = false;
          datagotByApi = true;
          isAlreadyenqOpen = false;
          //assignedEnqData = value.itemdata!;
          for (int i = 0; i < value.itemdata!.length; i++) {
            if (value.itemdata![i].Manager_Status_Tab!.toLowerCase() ==
                'assigned') {
              assignedEnqData.add(EnquiriesData(
                InterestLevel:'',
                OrderType:'' ,
                 contactName: '',
                altermobileNo: '',
                customerGroup: '',
                comapanyname: '',
                visitTime: '',
                remindOn: '',
                isClosed: '',
                isVisitRequired: '',
                storecode: '',
                area: '',
                district: '',
                itemCode: '',
                itemname: '',
                leadConverted: false,
                createdBy:0,
                createdDateTime: '',
                updatedBy: 0,
                updatedDateTime: '',
                enquirydscription: '',
                quantity: 0.0,
                customermobile: '',
                email: value.itemdata![i].email,referal:value.itemdata![i].referal,
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
            if (value.itemdata![i].Manager_Status_Tab!.toLowerCase() ==
                'unassigned') {
              unassignedEnqdata.add(
                
                EnquiriesData(
                  InterestLevel:"" ,
                OrderType:"" ,
                   contactName: '',
                altermobileNo: '',
                customerGroup: '',
                comapanyname: '',
                visitTime: '',
                remindOn: '',
                isClosed: '',
                isVisitRequired: '',
                storecode: '',
                area: '',
                district: '',
                itemCode: '',
                itemname: '',
                leadConverted: false,
                createdBy:0,
                createdDateTime: '',
                updatedBy: 0,
                updatedDateTime: '',
                enquirydscription: '',
                quantity: 0.0,
                customermobile: '',
                  email: value.itemdata![i].email,referal:value.itemdata![i].referal,
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
            if (value.itemdata![i].Manager_Status_Tab!.toLowerCase() ==
                'lost') {
              lostEnqdata.add(EnquiriesData(
                InterestLevel:"" ,
                OrderType:"" ,
                 contactName: '',
                altermobileNo: '',
                customerGroup: '',
                comapanyname: '',
                visitTime: '',
                remindOn: '',
                isClosed: '',
                isVisitRequired: '',
                storecode: '',
                area: '',
                district: '',
                itemCode: '',
                itemname: '',
                leadConverted: false,
                createdBy:0,
                createdDateTime: '',
                updatedBy: 0,
                updatedDateTime: '',
                enquirydscription: '',
                quantity: 0.0,
                customermobile: '',
                email: value.itemdata![i].email,referal:value.itemdata![i].referal,
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
          }
          if (value.itemdata![0].User_Branch ==
              value.itemdata![0].Current_Branch) {
            // callDialog(context,0);
            // value.itemdata![0].
            isAnotherBranchEnq = false;
            typeOfDataCusBranch = 'this';
            alertDialogOpenLeadOREnq(context, typeOfDataCus);
          } else {
            isAnotherBranchEnq = true;
            typeOfDataCusBranch = value.itemdata![0].Current_Branch!;
            alertDialogOpenLeadOREnq(context, typeOfDataCus);
          }
          notifyListeners();
        } else if (value.itemdata == null) {
          isAlreadyenqOpen = false;
          datagotByApi = false;
          exception = true;
          errorMsg = 'No data found..!!';
          notifyListeners();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isAlreadyenqOpen = false;
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        isAlreadyenqOpen = false;
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
  }

  mapValuesToLead(int ind) {
    LeadNewController.dataenq.add(assignedEnqData[ind].CardCode!);
    LeadNewController.dataenq.add(assignedEnqData[ind].CardName!);
    LeadNewController.dataenq.add(assignedEnqData[ind].Address_Line_1!);
    LeadNewController.dataenq.add(assignedEnqData[ind].Address_Line_2!);
    LeadNewController.dataenq.add(assignedEnqData[ind].Pincode!);
    LeadNewController.dataenq.add(assignedEnqData[ind].City!);
    LeadNewController.isComeFromEnq = true;
    notifyListeners();
    Get.toNamed(ConstantRoutes.leads);
  }

  mapValuesToEnq() {
    log("assignedEnqData[0].CardCode!: ${assignedEnqData.length}");
    NewEnqController.comeFromEnq.clear();
    NewEnqController.comeFromEnq.add(assignedEnqData[0].CardCode!);
    NewEnqController.comeFromEnq.add(assignedEnqData[0].CardName!);
    NewEnqController.comeFromEnq.add(assignedEnqData[0].Address_Line_1!);
    NewEnqController.comeFromEnq.add(assignedEnqData[0].Address_Line_2!);
    NewEnqController.comeFromEnq.add(assignedEnqData[0].Pincode!);
    NewEnqController.comeFromEnq.add(assignedEnqData[0].City!);
    notifyListeners();
    Get.toNamed(ConstantRoutes.newEnq);
  }

  callDialog(BuildContext context, i) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          assignto = false;
          resetUserSelection();
          log("iii ${i}");
          return AssignedToDialogManager(
            indx: i,
          );
        }).then((value) {
      resetAll(context);
    });
  }

  void alertDialogOpenLeadOREnq(BuildContext context, typeOfDataCus) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          assignto = false;
          return WarningDialogMngr();
        }).then((value) {
      //resetAll(context);
    });
  }

  /// for lead other branch
  ///
  callOtherLead(String docentry) {
    //call SK_GET_LEAD_DETAILS_QTH this appi and load the data in new lead
    GetLeadQTHApi.getData(docentry).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadDeatilheadsData != null) {
          mapValuesToLead2(value.leadDeatilheadsData!.leadcheckQTHdata![0]);
        } else {
          //   customerapicLoading = false;
          //   isanyExcep = -2;
          // forwardSuccessMsg = 'Some internal error..!!';
          // leadLoadingdialog = false;
          // notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        //customerapicLoading = false;
        //   isanyExcep = -2;
        // forwardSuccessMsg = 'Something went wrong try again!!';
        // leadLoadingdialog = false;
        // notifyListeners();
      } else {
        //customerapicLoading = false;
        //   isanyExcep = -2;
        // forwardSuccessMsg = 'Something went wrong try again!!';
        // leadLoadingdialog = false;
        // notifyListeners();
      }
    });
  }

  mapValuesToLead2(GetLeadDeatilsQTHData leadDeatilsQTHDat) {
    LeadNewController.dataenq.add(leadDeatilsQTHDat.CardCode!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat.CardName!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat.Address1!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat.Address2!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat.Pincode!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat.City!);
    notifyListeners();
    // Get.toNamed(ConstantRoutes.leads);
  }

  checkDialogCon() {
    log("isAnotherBranchEnq: " + isAnotherBranchEnq.toString());
    log("statusUpdateApiResp: " + statusUpdateApiResp.toString());
    log("statusUpdateLoading: " + statusUpdateLoading.toString());
    log("statusUpdate: " + statusUpdate.toString());
    log("assignedToApiActResp: " + assignedToApiActResp.toString());
    log("assigntoApical: " + assigntoApical.toString());
    log("assignto: " + assignto.toString());
  }

  showSpecificDialog() {
    assignto = false;
    assigntoApical = false;
    assignedToApiActResp = '';
    statusUpdate = true;
    statusUpdateLoading = false;
    statusUpdateApiResp = 'hello';
    isAnotherBranchEnq == false;
  }

  callUserListApi() async {
    // GetUserApi.getData("${ConstantValues.sapUserID}").then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if (value.userLtData != null) {
    //       eMsgUList = '';
    //       exceptionUList = false;
    //       userLtData = value.userLtData!;
    //       notifyListeners();
    //     } else if (value.userLtData == null) {
    //       eMsgUList = 'No Data...!!';
    //       exceptionUList = true;
    //       notifyListeners();
    //     }
    //     notifyListeners();
    //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
    //     eMsgUList = 'Some thing went wrong..try again!!';
    //     exceptionUList = true;
    //     notifyListeners();
    //   } else if (value.stcode == 500) {
    //     eMsgUList = 'Some thing went wrong..try again!!';
    //     exceptionUList = true;
    //     notifyListeners();
    //   }
    // });
    final Database db = (await DBHelper.getInstance())!;
    userLtData = await DBOperation.getUserList(db);
    exceptionUList = false;
    notifyListeners();
  }

//alert dialog actions
  int? selectedIdxFUser = null;
  selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].SalesEmpID == userLtData[ij].SalesEmpID) {
        userLtData[i].color = 1;
        getUserKey = userLtData[ij].SalesEmpID;
      } else {
        userLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  ResonData? temp2;
  selectReason(ResonData? temp) {
    for (int i = 0; i < resonData.length; i++) {
      if (resonData[i].CODE == temp!.CODE) {
        resonData[i].color = 1;
        temp2 = resonData[i];
      } else {
        resonData[i].color = 0;
      }
    }
    notifyListeners();
  }

  resetUserSelection() {
    getUserKey = null;
    assignto = false;
    assigntoApical = false;
    assignedToApiActResp = '';
    assignedToApiActRespMsg = '';
    statusUpdateLoading = false;
    statusUpdate = false;
    statusUpdateApiResp = '';
    statusUpdateApiRespMsg = '';
    mycontroller[0].clear();
    valueChosedReason = null;
    apidate = null;
    temp2 = null;

    for (int i = 0; i < userLtData.length; i++) {
      userLtData[i].color = 0;
    }
    for (int i = 0; i < resonData.length; i++) {
      resonData[i].color = 0;
    }
    getUserKey = null;
    //notifyListeners();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  callAsignedToApi(EnquiriesData enqID, String userkey,String update,
      BuildContext context) {
    assigntoApical = true;
    notifyListeners();
    AssignedToUserApi.getData(enqID, userkey,update).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
          assigntoApical = false;
          assignedToApiActResp = value.userLtData!.respDesc!;
          // assignedToApiActRespMsg = value.userLtData![0].actionResponseMessage!;
          // print("assignedToApiActResp: "+assignedToApiActResp);
          // print("value.userLtData![0].actionResponce!: "+value.userLtData![0].actionResponce!);
          notifyListeners();
          disabledialog(context);
        } else if (value.userLtData == null) {
          assigntoApical = false;
          assignedToApiActResp = 'Something went wrog..!!';
          assignedToApiActRespMsg = 'Try agin..!!';
          notifyListeners();
          disabledialog(context);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        assigntoApical = false;
        assignedToApiActResp = 'Something went wrog...!!';
        assignedToApiActRespMsg = 'Try agin...!!';
        notifyListeners();
        disabledialog(context);
      } else if (value.stcode == 500) {
        assigntoApical = false;
        assignedToApiActResp = 'Something went wrog...!!';
        assignedToApiActRespMsg = 'Try agin....!!';
        notifyListeners();
        disabledialog(context);
      }
    });
  }

  disabledialog(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      // Navigator.pop(context);
    });
  }

  static bool isAlreadyenqOpen = false;
  bool get getisAlreadyenqOpen => isAlreadyenqOpen;
  static int enqDataprev = 0;
  static String typeOfDataCus = '';
  static String typeOfDataCusBranch = '';

  resetAll(BuildContext context) {
    //NewEnqController.comeFromEnq.clear();
    isAnotherBranchEnq = false;
    //isAlreadyenqOpen = false;
    if (isAlreadyenqOpen == false) {
      callApi();
    } else {
      if (typeOfDataCus == 'Enquiry') {
        callPrevEnqDatilsApi(context, enqDataprev);
      } else {
        if (typeOfDataCusBranch == 'this') {
          isAlreadyenqOpen = false;
          alertDialogOpenLeadOREnq(context, typeOfDataCus);
        } else {
          // print("Other branch");
          // callOtherLead(enqDataprev.toString());
          isAlreadyenqOpen = false;
          alertDialogOpenLeadOREnq(context, typeOfDataCus);
        }
      }
    }
  }

  resetdocEntry() {
    enqDataprev = 0;
  }

  /// staus update functions

  callResonApi() async {
    await ResonApi.getData("${ConstantValues.slpcode}").then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
          resonData = value.userLtData!;
          notifyListeners();
        } else if (value.userLtData == null) {
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        notifyListeners();
      } else if (value.stcode == 500) {
        notifyListeners();
      }
    });
  }

  resonChoosed(String res) {
    valueChosedReason = res;
    notifyListeners();
  }

  void showDate(BuildContext context) {
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
      apidate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apidate);

      mycontroller[0].text = chooseddate;
      notifyListeners();
    });
  }

  calllApiss(BuildContext context) {
    statusUpdateLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 2), () {
      statusUpdateLoading = false;
      statusUpdateApiResp = 'Failure..!!'; //'Success';//'Failure..!!';//
      notifyListeners();
      Future.delayed(Duration(seconds: 1), () {
        if (statusUpdateApiResp.toLowerCase().contains("success")) {
          disabledialog(context);
        } else if (statusUpdateApiResp.toLowerCase().contains("fail")) {
          print("fffff");
          statusUpdate = true;
          statusUpdateApiResp = '';
          notifyListeners();
        }
      });
    });
  }

  // callUpdateEnqApi(BuildContext context, EnquiriesData enqID) {
  //   statusUpdateLoading = true;
  //   notifyListeners();
  //   UpdateEnqApi.getData(enqID, temp2, apidate).then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       statusUpdateLoading = false;
  //       if (value.userLtData != null) {
  //         statusUpdateApiResp = value.userLtData!.closed!; //'Failure..!!';
  //         statusUpdateApiRespMsg = value.userLtData!.customerCode!.toString();
  //         notifyListeners();

  //         Future.delayed(Duration(seconds: 1), () {
  //           if (statusUpdateApiResp.toLowerCase().contains("Y")) {
  //             disabledialog(context);
  //           } else if (statusUpdateApiResp.toLowerCase().contains("Fail")) {
  //             statusUpdate = true;
  //             statusUpdateApiResp = '';
  //             statusUpdateApiRespMsg = '';
  //             notifyListeners();
  //           }
  //         });
  //       } else if (value.userLtData == null) {
  //         statusUpdate = true;
  //         statusUpdateApiResp = 'Somthing went wrong..!!'; //'Failure..!!';
  //         statusUpdateApiRespMsg = value.message; //'Try again..!!';
  //         notifyListeners();
  //         Future.delayed(Duration(seconds: 1), () {
  //           statusUpdate = true;
  //           statusUpdateApiResp = '';
  //           statusUpdateApiRespMsg = '';
  //           notifyListeners();
  //         });
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       statusUpdate = true;
  //       statusUpdateApiResp = 'Somthing went wrong...!!'; //'Failure..!!';
  //       statusUpdateApiRespMsg = 'Try again..!!';
  //       notifyListeners();
  //       Future.delayed(Duration(seconds: 1), () {
  //         statusUpdate = true;
  //         statusUpdateApiResp = '';
  //         statusUpdateApiRespMsg = '';
  //         notifyListeners();
  //       });
  //     } else if (value.stcode == 500) {
  //       statusUpdate = true;
  //       statusUpdateApiResp = 'Somthing went wrong...!!'; //'Failure..!!';
  //       statusUpdateApiRespMsg = 'Try again...!!';
  //       notifyListeners();
  //       Future.delayed(Duration(seconds: 1), () {
  //         statusUpdate = true;
  //         statusUpdateApiResp = '';
  //         statusUpdateApiRespMsg = '';
  //         notifyListeners();
  //       });
  //     }
  //   });
  // }
}
