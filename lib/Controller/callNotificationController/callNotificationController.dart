import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Constant/Utils.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/newleadopenmodel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/newphonemodel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Pages/callerNotification/custom_overlayNew.dart';
import 'package:sellerkit/Pages/callerNotification/widgets/custom_text_field.dart';
import 'package:sellerkit/Services/PostQueryApi/ItemMasterApi/ItemCatagoryApi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetAllLeads.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/NewopenAPi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/Newphoneapi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../../DBHelper/DBHelper.dart';


class CallNotificationController extends ChangeNotifier {
  CallNotificationController() {
    init();
  }
  List<TextEditingController> mycontrollertext =
      List.generate(25, (i) => TextEditingController());
      bool isquickEnq=false;
      bool get getisquickEnq => isquickEnq;
      callquickenq(){
         
      }
      setcatagorydata() {
//   for(int i=0;i<userLtData.length;i++){
// userLtData[i].color=0;
//   }
    filtercatagorydata = catagorydata;

    notifyListeners();
  }
  List<GetLeadPhoneData> leadphonedata = [];
  List<GetLeadPhoneData> get getleadphonedata => leadphonedata;
  List<GetAllLeadData> leadOpenAllData = [];
   callGetAllApi() async {
    leadOpenAllData.clear();

    // lottie='';//  final Database db = (await DBHelper.getInstance())!;
    // leadStatusLost = await DBOperation.getLeadStatusLost(db);
    await GetAllLeadApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckheader!.leadcheckdata != null && value.leadcheckheader!.leadcheckdata!.isNotEmpty ) {
          // isLoading = false;
          // log("not null"+value.leadcheckheader!.length.toString());
          mapValues(value.leadcheckheader!.leadcheckdata!);
        } else if (value.leadcheckheader!.leadcheckdata == null || value.leadcheckheader!.leadcheckdata!.isEmpty) {
          //    isLoading = false;
          //      lottie='Assets/no-data.png';
          // excepMsg = 'No Data...!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        //     isLoading = false;
        //       lottie='';
        // excepMsg = '${value.message}..!! ${value.exception}..!!';
     
        notifyListeners();
        

         } else if (value.stcode == 500) {
    //  isLoading = false;
    //    lottie='Assets/NetworkAnimation.json';
    //     excepMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
      notifyListeners();
    });
  //  await callusermobileApi();
  }

  mapValues(List<GetAllLeadData> leadcheckdata) async {
    leadOpenAllData.clear();
    notifyListeners();
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status == "Open") {
        print("Open Lead follDate" + leadcheckdata[i].NextFollowup.toString());
        leadOpenAllData.add(GetAllLeadData(
          InterestLevel:leadcheckdata[i].InterestLevel ,
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
      log("leadOpenAllData:::"+leadOpenAllData.length.toString());
    }
    // await mapvaluestoDB(leadOpenAllData);

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

  
 
  callleadApi()async{
    await GetLeadopenApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadopendata = value.leadopendata!;
        log("leadopendataleadopendata::"+leadopendata.length.toString());
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        // excepMsg = "Something went wrong";
        notifyListeners();
      } else {
        // excepMsg = "${value.stcode!}..!!Network Issue..\nTry again Later..!!";

        notifyListeners();
      }
    });
await GetLeadphoneApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadphonedata = value.leadphonedata!;

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        // excepMsg = "Something went wrong";
        notifyListeners();
      } else {
        // excepMsg = "${value.stcode!}..!!Network Issue..\nTry again Later..!!";
        notifyListeners();
      }
    });
    
  }
 
  apicalling() async{
    log("i am in");
// await clearall();
//  String? getUrl = await HelperFunctions.getHostDSP();
//         log("getUrlgetUrl444::"+getUrl.toString());
//         Utils.queryApi = 'http://${getUrl.toString()}/api/';
//         Utils.queryApi = 'http://${getUrl.toString()}/api/';
//         log("Utils.queryApi444::::+"+Utils.queryApi.toString());
  await getCatagoryApi();
   await getUserAssingData();
   await callleadApi();
    // await getDataOnLoad();
  await callGetAllApi();
 
   notifyListeners();
  }
  List<GetLeadopenData> leadopendata = [];
  List<GetLeadopenData> get getleadopendata => leadopendata;
  
  init() async {
   

            String? ip = await HelperFunctions.getHostDSP();
            String? username = await HelperFunctions.getdbUserName();
            String? password = await HelperFunctions.getPasswordSharedPreference();
            String? tenentId = await HelperFunctions.getTenetIDSharedPreference();
      print("$ip+$username+$password+$tenentId");
        String? getToken = await HelperFunctions.getTokenSharedPreference();
    Utils.token = getToken;
  await HelperFunctions.getHostDSP().then((value) {
          log("getUrl $value");
        });
    // categoryValue = null;
    // enqReffeValue = null;
    // cusTagValue = null;
    // stateValue = null;
    // stateData = [];
    // filtercatagorydata = [];
    // cusTagList = [];
    // enqReffList = [];
    // catagorydata = [];
    // getCusTagType();
  
    // getEnqRefferes();
    // getStatelist();
    notifyListeners();
  }


  
  // final formkey = GlobalKey<FormState>();
  // List<TextEditingController> mycontroller =
  //     List.generate(40, (i) => TextEditingController());
  List<stateHeaderData> stateData = [];
  List<stateHeaderData> filterstateData = [];
  bool statebool = false;
  validate(){
    if(formkey.currentState!.validate()){
      
    }
  }
  getStatelist() async {
    stateData.clear();
    filterstateData.clear();

    final Database db = (await DBHelper.getInstance())!;
    stateData = await DBOperation.getstateData(db);
    filterstateData = stateData;
    log("getCustomerListFromDB length::" + filterstateData.length.toString());
    notifyListeners();
  }

  List<CustomerTagTypeData> cusTagList = [];
  List<CustomerTagTypeData> get getCusTagList => cusTagList;
  String isSelectedCsTag = '';
  String get getisSelectedCsTag => isSelectedCsTag;

  List<EnqRefferesData> enqReffList = [];
  List<EnqRefferesData> get getenqReffList => enqReffList;

  getCusTagType() async {
    final Database db = (await DBHelper.getInstance())!;
    cusTagList = await DBOperation.getCusTagData(db);
    notifyListeners();
  }

  getEnqRefferes() async {
    final Database db = (await DBHelper.getInstance())!;

    enqReffList = await DBOperation.getEnqRefferes(db);
    notifyListeners();
  }

  choosedType(String? val) {
    categoryValue = val;
    notifyListeners();
  }

  choosedRefferType(String? val) {
    enqReffeValue = val;
    notifyListeners();
  }

  choosedCustomerGroupType(String? val) {
    cusTagValue = val;
    notifyListeners();
  }

  choosedStateType(String? val) {
    stateValue = val;
    notifyListeners();
  }

  String? categoryValue;
  String? enqReffeValue;
  String? cusTagValue;
  String? stateValue;

  List<String> catagorydata = [];
  List<String> filtercatagorydata = [];
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
  setUserdata() {
//   for(int i=0;i<userLtData.length;i++){
// userLtData[i].color=0;
//   }
    filteruserLtData = userLtData;

    notifyListeners();
  }
  
  getUserAssingData() async {
    final Database db = (await DBHelper.getInstance())!;

    userLtData = await DBOperation.getUserList(db);
    filteruserLtData = userLtData;

    notifyListeners();
  }
 final formkey = GlobalKey<FormState>();
 
  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
  List<UserListData> filteruserLtData = [];
  List<UserListData> get getfiltergetuserLtData => filteruserLtData;
   int? selectedIdxFUser = null;
  selectedAssignedUser() {
    // setState(() {
     CustomTextFieldState.assigntofor =   filteruserLtData[selectedIdxFUser!].UserName!;
     notifyListeners();
    // });
   
  }
  String? getslpID;
  String? managerSlpCode;
  selectUser(int ij) async {
    log("IJJJ::" + ij.toString());
  //  setState(() {
     for (int i = 0; i < filteruserLtData.length; i++) {
      log("filteruserLtData[i].slpcode == filteruserLtData[ij].slpcode:::" +
         filteruserLtData[ij].userCode.toString());
      if (filteruserLtData[i].userCode == filteruserLtData[ij].userCode) {
       filteruserLtData[i].color = 1;
        getslpID = filteruserLtData[ij].userCode!.isEmpty
            ? "0"
            : filteruserLtData[ij].userCode.toString();
        managerSlpCode =filteruserLtData[ij].mngSlpcode;
        log("User:" + getslpID.toString());
        // log("Manager" + managerSlpCode.toString());
        selectedIdxFUser = ij;
      } else {
        filteruserLtData[i].color = 0;
      }
    }
    notifyListeners();
  //  });
    // filteruserLtData=userLtData;
   
  }
  String? lookingfor='';
  iscateSeleted(BuildContext context, String select) {
   CustomTextFieldState.lookingfor = select;
  //  mycontroller[25].text=lookingfor.toString();
    // log("mycontroller[25].text:::"+lookingfor.toString());
    Navigator.pop(context);
    notifyListeners();
  }
  filterListcatagoryData(String v) {
    // for (int i = 0; i < catagorydata.length; i++) {
    //   catagorydata[i].color = 0;
    // }
    if (v.isNotEmpty) {
      filtercatagorydata = catagorydata
          .where((e) => e!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.s!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtercatagorydata = catagorydata;
      notifyListeners();
    }
  }
  getCatagoryApi() async {
    catagorydata.clear();
    filtercatagorydata.clear();
    // String? meth1 = ConstantApiUrl.getItemCategoryApi;
String? getUrl = await HelperFunctions.getHostDSP();
String? token=await HelperFunctions. getTokenSharedPreference();
        log("getUrlgetUrl555::"+getUrl.toString());
        Utils.queryApi = 'http://${getUrl.toString()}/api/';
        log("Utils.queryAp5555::::+"+Utils.queryApi.toString());
        ConstantValues.token =token.toString();
    await ItemMasterCatagoryApiNew.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        catagorydata = value.itemdata!;
        filtercatagorydata = catagorydata;
        log("filtercatagorydata::"+filtercatagorydata.length.toString());
      }
    });
    notifyListeners();
  }

  selectCsTag(String selected) {
    if (isSelectedCsTag == selected) {
      isSelectedCsTag = '';
    } else {
      isSelectedCsTag = selected;
    }
    notifyListeners();
  }

  
}
