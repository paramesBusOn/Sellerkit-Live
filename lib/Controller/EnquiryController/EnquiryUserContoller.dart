// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/ResonModel.dart';
import 'package:sellerkit/Models/leadexmodel/agemodel.dart';
import 'package:sellerkit/Models/leadexmodel/cameasmodel.dart';
import 'package:sellerkit/Models/leadexmodel/gendermodel.dart';
import 'package:sellerkit/Services/LeadexApi/AgeApi.dart';
import 'package:sellerkit/Services/LeadexApi/GenderApi.dart';
import 'package:sellerkit/Services/LeadexApi/cameasApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Pages/Enquiries/EnquiriesUser/Widgets/OpenUserDialog.dart';
import '../../Pages/Enquiries/EnquiriesUser/Widgets/WarningDialog.dart';
import '../../Services/PostQueryApi/EnquiriesApi/AssignedToUserApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqPrevDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/EnquiriesApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/ResonApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/UpdateEnq.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import '../LeadController/LeadNewController.dart';
import 'NewEnqController.dart';

class EnquiryUserContoller extends ChangeNotifier {
  Config config = new Config();
  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  


  String errorMsg = '';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  String? lottie='';

  String eMsgUList = '';
  bool exceptionUList = false;
  bool get getexceptionUList => exceptionUList;
  String get geteMsgUList => eMsgUList;

  bool datagotByApi = false;
  bool get getdatagotByApi => datagotByApi;

List<EnquiriesData> GetAllEnqData = [];
List<EnquiriesData> GetfromdbEnqData = [];
  List<EnquiriesData> openEnqData = [];
  List<EnquiriesData> closedEnqdata = [];
  List<EnquiriesData> lostEnqUserdata = [];
   List<EnquiriesData> filteropenEnqData = [];
  List<EnquiriesData> filterclosedEnqdata = [];
  List<EnquiriesData> filterlostEnqUserdata = [];

  List<EnquiriesData> get getopenEnqData => openEnqData;
  List<EnquiriesData> get getclosedEnqdata => closedEnqdata;
  List<EnquiriesData> get getlostEnqUserdata => lostEnqUserdata;

  //for alert dialog
  bool assignto = false;
  bool get getassignto => assignto;

  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
List<UserListData> filteruserLtData = [];
  List<UserListData> get getfiltergetuserLtData => filteruserLtData;

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
  showSuccessDia() {
    statusUpdate = true;
    statusUpdateApiResp = 'abcd';
  }
  SearchFilterOpenTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filteropenEnqData = openEnqData
          .where((e) =>
              (e).CardName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Lookingfor!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .CardCode
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase())
              // ||
              // (e)
              //     .Value!
              //     .toDouble()
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e)
              //     .NextFollowup
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e).Status.toString().toLowerCase().contains(v.toLowerCase()
              // )
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteropenEnqData = openEnqData;
      notifyListeners();
    }
  }
setListData(){
    filteropenEnqData = openEnqData;
      filterclosedEnqdata = closedEnqdata;
       filterlostEnqUserdata = lostEnqUserdata;
       notifyListeners();
}
  SearchFilterWonTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterclosedEnqdata = closedEnqdata
          .where((e) =>
               (e).CardName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Lookingfor!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .CardCode
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase())
              // (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) ||
              // (e).Product!.toLowerCase().contains(v.toLowerCase()) ||
              // (e)
              //     .LeadNum!
              //     .toInt()
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e)
              //     .Value!
              //     .toDouble()
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e)
              //     .NextFollowup
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e).Status.toString().toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterclosedEnqdata = closedEnqdata;
      notifyListeners();
    }
  }

  SearchFilterLostTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterlostEnqUserdata = lostEnqUserdata
          .where((e) =>
           (e).CardName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Lookingfor!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .CardCode
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase())
              // (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) ||
              // (e).Product!.toLowerCase().contains(v.toLowerCase()) ||
              // (e)
              //     .LeadNum!
              //     .toInt()
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e)
              //     .Value!
              //     .toDouble()
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e)
              //     .NextFollowup
              //     .toString()
              //     .toLowerCase()
              //     .contains(v.toLowerCase()) ||
              // (e).Status.toString().toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterlostEnqUserdata = lostEnqUserdata;
      notifyListeners();
    }
  }
// context.read<EnquiryUserContoller>().getassignto == false && 
// context.read<EnquiryUserContoller>().getassigntoApiCall == false && 
// context.read<EnquiryUserContoller>().getassignedToApiActResp == '' && 
// context.read<EnquiryUserContoller>().getstatusUpdate == true && 
// context.read<EnquiryUserContoller>().getstatusUpdateLoading == false && 
// context.read<EnquiryUserContoller>().getstatusUpdateApiResp != '' && 
// context.read<EnquiryUserContoller>().getisAnotherBranchEnq == false
                             
  Future<void> swipeRefreshIndicator() async {
    mycontroller[5].clear();
    datagotByApi = false;
    resonData.clear();
    userLtData.clear();
    notifyListeners();
    callApi();
    callUserListApi();
    callResonApi();
  }

initcall()async{
  final Database db = (await DBHelper.getInstance())!;
 await DBOperation.truncareEnqfilter(db);
  mycontroller[5].clear();
    GetAllEnqData.clear();
      GetfromdbEnqData.clear();
      openEnqData.clear();
      closedEnqdata.clear();
      lostEnqUserdata.clear();
      filterclosedEnqdata.clear();
      filterlostEnqUserdata.clear();
      filteropenEnqData.clear();
  callApi();
       
callUserListApi();

  notifyListeners();
}
 filterListAssignData(String v) {
   for(int i=0;i<filteruserLtData.length;i++){
filteruserLtData[i].color=0;
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
String? assignvalue;
   String? cusnamevalue;
   String? cardnamevalue;
   String? Enquirystatusvalue;
   String? lookingforvalue;
   List<bool> lookingforvalue22=[];
    String? interestlevelvalue;
     String? ordertypevalue;
     
bool? islookloading=false;
clearfilterval() {
  checkdate=null;
    assignvalue = null;
    cusnamevalue = null;
    islookingfor=false;
    selectedlookingfor.clear();
    isenqstatus=false;
    selectedenqstatus.clear();
    selectedcusgoup.clear();
    selectedcusname.clear();
    iscusgroup=false;
    iscusname=false;
    isassignto=false;
    isorder=false;
    isinterest=false;
    selectedinterest.clear();
    selectedorder.clear();
    selectedassignto.clear();
    Enquirystatusvalue=null;
    lookingforvalue=null;
    ordertypevalue=null;
    islookloading=false;
    interestlevelvalue=null;
    lookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    GetfromdbEnqData.clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    cardnamevalue=null;

    notifyListeners();
  }
  getdatafil(List<EnquiriesData> GetfromdbEnqData2){
  for (int i = 0; i < GetfromdbEnqData2.length; i++) {
            if (GetfromdbEnqData2[i].Slp_Status_Tab == 'Open') {
              openEnqData.add(EnquiriesData(
                InterestLevel:GetfromdbEnqData2[i].InterestLevel ,
                OrderType:GetfromdbEnqData2[i].OrderType ,
                contactName: GetfromdbEnqData2[i].contactName,
                altermobileNo: GetfromdbEnqData2[i].altermobileNo,
                customerGroup: GetfromdbEnqData2[i].customerGroup,
                comapanyname: GetfromdbEnqData2[i].comapanyname,
                visitTime: GetfromdbEnqData2[i].visitTime,
                remindOn: GetfromdbEnqData2[i].remindOn,
                isClosed: GetfromdbEnqData2[i].isClosed,
                isVisitRequired: GetfromdbEnqData2[i].isVisitRequired,
                storecode: GetfromdbEnqData2[i].storecode,
                area: GetfromdbEnqData2[i].area,
                district: GetfromdbEnqData2[i].district,
                itemCode: GetfromdbEnqData2[i].itemCode,
                itemname: GetfromdbEnqData2[i].itemname,
                leadConverted: GetfromdbEnqData2[i].leadConverted,
                createdBy: GetfromdbEnqData2[i].createdBy,
                createdDateTime: GetfromdbEnqData2[i].createdDateTime,
                updatedBy: GetfromdbEnqData2[i].updatedBy,
                updatedDateTime: GetfromdbEnqData2[i].updatedDateTime,
                enquirydscription: GetfromdbEnqData2[i].enquirydscription,
                quantity: GetfromdbEnqData2[i].quantity,
                customermobile: GetfromdbEnqData2[i].customermobile,
                  Mgr_UserName: GetfromdbEnqData2[i].Mgr_UserName,
                  EnqID: GetfromdbEnqData2[i].EnqID,
                  CardCode: GetfromdbEnqData2[i].CardCode,
                  Status: GetfromdbEnqData2[i].Status,
                  CardName: GetfromdbEnqData2[i].CardName,
                  AssignedTo_User: GetfromdbEnqData2[i].AssignedTo_User,
                  EnqDate: GetfromdbEnqData2[i].EnqDate,
                  Followup: GetfromdbEnqData2[i].Followup,
                  Mgr_UserCode: GetfromdbEnqData2[i].Mgr_UserCode,
                  AssignedTo_UserName: GetfromdbEnqData2[i].AssignedTo_UserName,
                  EnqType: GetfromdbEnqData2[i].EnqType,
                  Lookingfor: GetfromdbEnqData2[i].Lookingfor,
                  PotentialValue: GetfromdbEnqData2[i].PotentialValue,
                  Address_Line_1: GetfromdbEnqData2[i].Address_Line_1,
                  Address_Line_2: GetfromdbEnqData2[i].Address_Line_2,
                  Pincode: GetfromdbEnqData2[i].Pincode,
                  City: GetfromdbEnqData2[i].City,
                  State: GetfromdbEnqData2[i].State,
                  Country: GetfromdbEnqData2[i].Country,
                  Manager_Status_Tab: GetfromdbEnqData2[i].Manager_Status_Tab,
                  Slp_Status_Tab: GetfromdbEnqData2[i].Slp_Status_Tab, 
                  email: GetfromdbEnqData2[i].email,
                  referal:GetfromdbEnqData2[i].referal ));
           filteropenEnqData=openEnqData;
            }
            if (GetfromdbEnqData2[i].Slp_Status_Tab == 'Closed') {
              closedEnqdata.add(EnquiriesData(
                InterestLevel:GetfromdbEnqData2[i].InterestLevel ,
                OrderType:GetfromdbEnqData2[i].OrderType ,
                contactName: GetfromdbEnqData2[i].contactName,
                altermobileNo: GetfromdbEnqData2[i].altermobileNo,
                customerGroup: GetfromdbEnqData2[i].customerGroup,
                comapanyname: GetfromdbEnqData2[i].comapanyname,
                visitTime: GetfromdbEnqData2[i].visitTime,
                remindOn: GetfromdbEnqData2[i].remindOn,
                isClosed: GetfromdbEnqData2[i].isClosed,
                isVisitRequired: GetfromdbEnqData2[i].isVisitRequired,
                storecode: GetfromdbEnqData2[i].storecode,
                area: GetfromdbEnqData2[i].area,
                district: GetfromdbEnqData2[i].district,
                itemCode: GetfromdbEnqData2[i].itemCode,
                itemname: GetfromdbEnqData2[i].itemname,
                leadConverted: GetfromdbEnqData2[i].leadConverted,
                createdBy: GetfromdbEnqData2[i].createdBy,
                createdDateTime: GetfromdbEnqData2[i].createdDateTime,
                updatedBy: GetfromdbEnqData2[i].updatedBy,
                updatedDateTime: GetfromdbEnqData2[i].updatedDateTime,
                enquirydscription: GetfromdbEnqData2[i].enquirydscription,
                quantity: GetfromdbEnqData2[i].quantity,
                customermobile: GetfromdbEnqData2[i].customermobile,
                  Mgr_UserName: GetfromdbEnqData2[i].Mgr_UserName,
                  EnqID: GetfromdbEnqData2[i].EnqID,
                  CardCode: GetfromdbEnqData2[i].CardCode,
                  Status: GetfromdbEnqData2[i].Status,
                  CardName: GetfromdbEnqData2[i].CardName,
                  AssignedTo_User: GetfromdbEnqData2[i].AssignedTo_User,
                  EnqDate: GetfromdbEnqData2[i].EnqDate,
                  Followup: GetfromdbEnqData2[i].Followup,
                  Mgr_UserCode: GetfromdbEnqData2[i].Mgr_UserCode,
                  AssignedTo_UserName: GetfromdbEnqData2[i].AssignedTo_UserName,
                  EnqType: GetfromdbEnqData2[i].EnqType,
                  Lookingfor: GetfromdbEnqData2[i].Lookingfor,
                  PotentialValue: GetfromdbEnqData2[i].PotentialValue,
                  Address_Line_1: GetfromdbEnqData2[i].Address_Line_1,
                  Address_Line_2: GetfromdbEnqData2[i].Address_Line_2,
                  Pincode: GetfromdbEnqData2[i].Pincode,
                  City: GetfromdbEnqData2[i].City,
                  State: GetfromdbEnqData2[i].State,
                  Country: GetfromdbEnqData2[i].Country,
                  Manager_Status_Tab: GetfromdbEnqData2[i].Manager_Status_Tab,
                  Slp_Status_Tab: GetfromdbEnqData2[i].Slp_Status_Tab,
                  email: GetfromdbEnqData2[i].email,
                  referal:GetfromdbEnqData2[i].referal));
           filterclosedEnqdata=closedEnqdata;
            }
            if (GetfromdbEnqData2[i].Slp_Status_Tab == 'Lost') {
              lostEnqUserdata.add(EnquiriesData(
                InterestLevel:GetfromdbEnqData2[i].InterestLevel ,
                OrderType:GetfromdbEnqData2[i].OrderType ,
                contactName: GetfromdbEnqData2[i].contactName,
                altermobileNo: GetfromdbEnqData2[i].altermobileNo,
                customerGroup: GetfromdbEnqData2[i].customerGroup,
                comapanyname: GetfromdbEnqData2[i].comapanyname,
                visitTime: GetfromdbEnqData2[i].visitTime,
                remindOn: GetfromdbEnqData2[i].remindOn,
                isClosed: GetfromdbEnqData2[i].isClosed,
                isVisitRequired: GetfromdbEnqData2[i].isVisitRequired,
                storecode: GetfromdbEnqData2[i].storecode,
                area: GetfromdbEnqData2[i].area,
                district: GetfromdbEnqData2[i].district,
                itemCode: GetfromdbEnqData2[i].itemCode,
                itemname: GetfromdbEnqData2[i].itemname,
                leadConverted: GetfromdbEnqData2[i].leadConverted,
                createdBy: GetfromdbEnqData2[i].createdBy,
                createdDateTime: GetfromdbEnqData2[i].createdDateTime,
                updatedBy: GetfromdbEnqData2[i].updatedBy,
                updatedDateTime: GetfromdbEnqData2[i].updatedDateTime,
                enquirydscription: GetfromdbEnqData2[i].enquirydscription,
                quantity: GetfromdbEnqData2[i].quantity,
                customermobile: GetfromdbEnqData2[i].customermobile,
                  Mgr_UserName:GetfromdbEnqData2[i].Mgr_UserName,
                  EnqID: GetfromdbEnqData2[i].EnqID,
                  CardCode: GetfromdbEnqData2[i].CardCode,
                  Status: GetfromdbEnqData2[i].Status,
                  CardName: GetfromdbEnqData2[i].CardName,
                  AssignedTo_User: GetfromdbEnqData2[i].AssignedTo_User,
                  EnqDate: GetfromdbEnqData2[i].EnqDate,
                  Followup: GetfromdbEnqData2[i].Followup,
                  Mgr_UserCode: GetfromdbEnqData2[i].Mgr_UserCode,
                  AssignedTo_UserName: GetfromdbEnqData2[i].AssignedTo_UserName,
                  EnqType: GetfromdbEnqData2[i].EnqType,
                  Lookingfor: GetfromdbEnqData2[i].Lookingfor,
                  PotentialValue: GetfromdbEnqData2[i].PotentialValue,
                  Address_Line_1: GetfromdbEnqData2[i].Address_Line_1,
                  Address_Line_2: GetfromdbEnqData2[i].Address_Line_2,
                  Pincode: GetfromdbEnqData2[i].Pincode,
                  City: GetfromdbEnqData2[i].City,
                  State: GetfromdbEnqData2[i].State,
                  Country: GetfromdbEnqData2[i].Country,
                  Manager_Status_Tab: GetfromdbEnqData2[i].Manager_Status_Tab,
                  Slp_Status_Tab: GetfromdbEnqData2[i].Slp_Status_Tab,
                  email: GetfromdbEnqData2[i].email,
                  referal:GetfromdbEnqData2[i].referal
                  )
                  );
           filterlostEnqUserdata=lostEnqUserdata;
            }
          }
          datagotByApi = true;
          notifyListeners();
}
List<Distcolumn> assigncolumn = [];

List<Distcolumn> assigncolumn22 = [];
   List<Distcusgroupcolumn> cusgroupcolumn = [];
 List<DistEnqstatuscolumn> enqstatuscolumn = [];
 List<Distlookingforcolumn> lookingforcolumn = [];
 List<Distlookingforcolumn> filterlookingforcolumn = [];
 List<Distlookingforcolumn> lookingforcolumnforshow = [];
 List<Distlevelcolumn> intlevelcolumn = [];
 List<Distordercolumn> ordercolumn = [];
 List<Distcustnamecolumn> cusnamecolumn = [];
 List<String> selectedinterest=[];
 List<String> selectedorder=[];
 List<String> selectedlookingfor=[];
 List<String> selectedenqstatus=[];
 List<String> selectedcusgoup=[];
  List<String> selectedcusname=[];
 List<String> selectedassignto=[];
 bool isenqstatus=false;
 bool islookingfor=false;
 bool iscusgroup=false;
 bool iscusname=false;
 bool isassignto=false;
 bool isinterest=false;
 bool isorder=false;
 ontaporder(){
   isorder = !isorder;
   notifyListeners();
    }
    ontapinterest(){
   isinterest = !isinterest;
   notifyListeners();
    }
 ontapassignto(){
   isassignto = !isassignto;
   notifyListeners();
    }
     itemselectinterest(String itemvalue,bool isselected){
      interestlevelvalue='';
  if(isselected){
    selectedinterest.add(itemvalue);
  }else{
    selectedinterest.remove(itemvalue);
  }
  interestlevelvalue=selectedinterest.join(', ');
  log("selectedinterest::"+selectedinterest.toString());
  log("interestlevelvalue::"+interestlevelvalue.toString());
  notifyListeners();
 }
     itemselectorder(String itemvalue,bool isselected){
      ordertypevalue='';
  if(isselected){
    selectedorder.add(itemvalue);
  }else{
    selectedorder.remove(itemvalue);
  }
  ordertypevalue=selectedorder.join(', ');
  log("selectedorder::"+selectedorder.toString());
  log("ordertypevalue::"+ordertypevalue.toString());
  notifyListeners();
 }
 itemselectassignto(String itemvalue,bool isselected){
  assignvalue='';
  if(isselected){
    selectedassignto.add(itemvalue);
    notifyListeners();
  }else{
    selectedassignto.remove(itemvalue);
    notifyListeners();
  }
  assignvalue=selectedassignto.join(', ');
  log("selectedassignto::"+selectedassignto.toString());
  log("assignvalue::"+assignvalue.toString());
  notifyListeners();
 }
 itemselectCusgroup(String itemvalue,bool isselected){
  cusnamevalue ='';
  if(isselected){
    selectedcusgoup.add(itemvalue);
  }else{
    selectedcusgoup.remove(itemvalue);
  }
  cusnamevalue=selectedcusgoup.join(', ');
  log("selectedcusgoup::"+selectedcusgoup.toString());
   log("cusnamevalue::"+cusnamevalue.toString());
  notifyListeners();
 }
 itemselectCusname(String itemvalue,bool isselected){
  cardnamevalue ='';
  if(isselected){
    selectedcusname.add(itemvalue);
  }else{
    selectedcusname.remove(itemvalue);
  }
  cardnamevalue=selectedcusname.join(', ');
  log("selectedcusgoup::"+selectedcusgoup.toString());
   log("cardnamevalue::"+cardnamevalue.toString());
  notifyListeners();
 }
 ontapcusgroup(){
   iscusgroup = !iscusgroup;
   notifyListeners();
    }
    ontapcusname(){
   iscusname = !iscusname;
   notifyListeners();
    }
 ontaplooking(){
   islookingfor = !islookingfor;
   notifyListeners();
    }
    onenqstatus(){
   isenqstatus = !isenqstatus;
   notifyListeners();
    }
     itemselectenqstatus(String itemvalue,bool isselected){
      Enquirystatusvalue='';
  if(isselected){
    selectedenqstatus.add(itemvalue);
  }else{
    selectedenqstatus.remove(itemvalue);
  }
  Enquirystatusvalue=selectedenqstatus.join(', ');
  log("selectedlookingfor::"+selectedenqstatus.toString());
   log("Enquirystatusvalue::"+Enquirystatusvalue.toString());
  notifyListeners();
 }
 itemselect(String itemvalue,bool isselected){
  lookingforvalue='';
  if(isselected){
    selectedlookingfor.add(itemvalue);
  }else{
    selectedlookingfor.remove(itemvalue);
  }
  lookingforvalue=selectedlookingfor.join(', ');
  log("selectedlookingfor::"+selectedlookingfor.toString());
  log("lookingforvalue::"+lookingforvalue.toString());
  notifyListeners();
 }
  Future<void> dataget(List<Map<String, Object?>> assignDB,cusgropDB,enqstatusDB,lookingforDB,intlevelDB,ordertypeDB,cusnametype) async {
    assigncolumn.clear();
    cusgroupcolumn.clear();
    enqstatuscolumn.clear();
    lookingforcolumn.clear();
    filterlookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    intlevelcolumn.clear();
    ordercolumn.clear();
    cusnamecolumn.clear();
   
    notifyListeners();
    for (int i = 0; i < assignDB.length; i++) {
      assigncolumn.add(Distcolumn(name: assignDB[i]['AssignedToUserName'].toString()));
   log("assigncolumn::" + assigncolumn[i].name.toString());
     assigncolumn.sort((a,b)=>a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      // assigncolumn22 =
   log("assigncolumn222::" + assigncolumn[i].name.toString());   
      notifyListeners();
    }
    for (int i = 0; i < cusgropDB.length; i++) {
      cusgroupcolumn.add(Distcusgroupcolumn(name: cusgropDB[i]['CustomerGroup'].toString()));
      log("cusgroupcolumn::" + cusgroupcolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < enqstatusDB.length; i++) {
      enqstatuscolumn.add(DistEnqstatuscolumn(name: enqstatusDB[i]['SlpStatusTab'].toString()));
      log("enqstatuscolumn::" + enqstatuscolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < lookingforDB.length; i++) {
      lookingforcolumn.add(Distlookingforcolumn(name: lookingforDB[i]['Lookingfor'].toString(),ischecck: false));
     
       filterlookingforcolumn=lookingforcolumn;
      //   log("lookingforcolumn::" + filterlookingforcolumn.length.toString());
        
      notifyListeners();
    }
  //  for(int i=0;i<lookingforcolumn.length;i++){
  //   filterlookingforcolumn.add(Distlookingforcolumn(name: lookingforcolumn[i].name.toString(),ischecck: lookingforcolumn[i].ischecck));
  //    log("lookingforcolumn::" + filterlookingforcolumn[i].ischecck.toString());
  //    notifyListeners();
  //  }
    notifyListeners();
    for (int i = 0; i < intlevelDB.length; i++) {
      intlevelcolumn.add(Distlevelcolumn(name: intlevelDB[i]['InterestLevel'].toString()));
      log("intlevelcolumn::" + intlevelcolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < ordertypeDB.length; i++) {
      ordercolumn.add(Distordercolumn(name: ordertypeDB[i]['OrderType'].toString()));
      log("assigncolumn::" + ordercolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < cusnametype.length; i++) {
      cusnamecolumn.add(Distcustnamecolumn(name: cusnametype[i]['CardName'].toString()));
      // log("cusnamecolumn::" + cusnamecolumn.length.toString());
      notifyListeners();
    }
   
  }
  getdbmodel()async{
    GetfromdbEnqData.clear();
    openEnqData.clear();
      closedEnqdata.clear();
      lostEnqUserdata.clear();
      filterclosedEnqdata.clear();
      filterlostEnqUserdata.clear();
      filteropenEnqData.clear();
     final Database db = (await DBHelper.getInstance())!;
GetfromdbEnqData = await DBOperation.getEnqdatafilter(db);
log("GetfromdbEnqData::"+GetfromdbEnqData.length.toString());
 List<Map<String, Object?>> assignDB =
        await DBOperation.getEnqftr("AssignedToUserName", db);
        List<Map<String, Object?>> cusgropDB =
        await DBOperation.getEnqftr("CustomerGroup", db);
        List<Map<String, Object?>> enqstatusDB =
        await DBOperation.getEnqftr("SlpStatusTab", db);
        List<Map<String, Object?>> lookingforDB =
        await DBOperation.getEnqftr("Lookingfor", db);
        List<Map<String, Object?>> intlevelDB =
        await DBOperation.getEnqftr("InterestLevel", db);
        List<Map<String, Object?>> ordertypeDB =
        await DBOperation.getEnqftr("OrderType", db);
         List<Map<String, Object?>> cusnametypeDB =
        await DBOperation.getEnqftr("CardName", db);
        notifyListeners();
        
        await dataget(assignDB,cusgropDB,enqstatusDB,lookingforDB,intlevelDB,ordertypeDB,cusnametypeDB);
 await getdatafil(GetfromdbEnqData);
          notifyListeners();
  }
   
  String apiwonpurchaseDate = '';
 DateTime? checkdate;
void showfromDate(BuildContext context) {

  log("(2050)::"+checkdate.toString());
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
        mycontroller[17].clear();
      String chooseddate = value.toString();
      checkdate=value;
      log("checkdate::"+checkdate.toString());
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[16].text = chooseddate;
      notifyListeners();
    });
  }
  void showToDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate:checkdate ?? DateTime.now(),
      firstDate:checkdate ?? DateTime(2020),
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
      apiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[17].text = chooseddate;
      notifyListeners();
    });
  }
 onfilterapply()async{
     final Database db = (await DBHelper.getInstance())!;
    
      await DBOperation.getEnqfilterapply(
            db,
            assignvalue == null ? '' : assignvalue!,
            cardnamevalue== null ? '' : cardnamevalue!,
            cusnamevalue == null ? '' : cusnamevalue!,
            Enquirystatusvalue == null ? '' : Enquirystatusvalue!,
            lookingforvalue == null ? '' : lookingforvalue!,
              interestlevelvalue == null ? '' : interestlevelvalue!,
            ordertypevalue == null ? '' : ordertypevalue!,
             mycontroller[18].text.isEmpty ? 0.0 : double.parse(mycontroller[18].text),
          
            mycontroller[16].text.isEmpty ? '0000-00-00' : config.alignDate1(mycontroller[16].text),
            mycontroller[17].text.isEmpty ? '9999-12-31' :config.alignDate1( mycontroller[17].text),
           
           )
        .then((value) async {
      GetfromdbEnqData.clear();
openEnqData.clear();
      closedEnqdata.clear();
      lostEnqUserdata.clear();
      filterclosedEnqdata.clear();
      filterlostEnqUserdata.clear();
      filteropenEnqData.clear();
      GetfromdbEnqData = value;
      log("GetfromdbEnqData::"+GetfromdbEnqData.length.toString());
       await getdatafil(GetfromdbEnqData);
      clearfilterval();
      notifyListeners();
    });

  }
  tableinsert(List<EnquiriesData> enqadddata)async{
 final Database db = (await DBHelper.getInstance())!;
 await DBOperation.truncareEnqfilter(db);


   await DBOperation.insertEnqdata(enqadddata, db);
   notifyListeners();
   await getdbmodel();
   notifyListeners();
  }
  callApi() async {
    log("ANBUlenin");
      assigncolumn.clear();
      GetAllEnqData.clear();
      GetfromdbEnqData.clear();
      openEnqData.clear();
      closedEnqdata.clear();
      lostEnqUserdata.clear();
      filterclosedEnqdata.clear();
      filterlostEnqUserdata.clear();
      filteropenEnqData.clear();
      notifyListeners();
    exception = false;
    datagotByApi = false;
    notifyListeners();
    await EnquiryApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      lottie='';
     
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata!.datadetail != null && value.itemdata!.datadetail!.isNotEmpty) {
          exception = false;
          // datagotByApi = true;
             GetAllEnqData=value.itemdata!.datadetail!;
          log("GetAllEnqData::"+GetAllEnqData.length.toString());
          tableinsert(GetAllEnqData);
          notifyListeners();
          //assignedEnqData = value.itemdata!;
          // for (int i = 0; i < value.itemdata!.datadetail!.length; i++) {
          //   if (value.itemdata!.datadetail![i].Slp_Status_Tab == 'Open') {
          //     openEnqData.add(EnquiriesData(
          //       InterestLevel:value.itemdata!.datadetail![i].InterestLevel ,
          //       OrderType:value.itemdata!.datadetail![i].OrderType ,
          //       contactName: value.itemdata!.datadetail![i].contactName,
          //       altermobileNo: value.itemdata!.datadetail![i].altermobileNo,
          //       customerGroup: value.itemdata!.datadetail![i].customerGroup,
          //       comapanyname: value.itemdata!.datadetail![i].comapanyname,
          //       visitTime: value.itemdata!.datadetail![i].visitTime,
          //       remindOn: value.itemdata!.datadetail![i].remindOn,
          //       isClosed: value.itemdata!.datadetail![i].isClosed,
          //       isVisitRequired: value.itemdata!.datadetail![i].isVisitRequired,
          //       storecode: value.itemdata!.datadetail![i].storecode,
          //       area: value.itemdata!.datadetail![i].area,
          //       district: value.itemdata!.datadetail![i].district,
          //       itemCode: value.itemdata!.datadetail![i].itemCode,
          //       itemname: value.itemdata!.datadetail![i].itemname,
          //       leadConverted: value.itemdata!.datadetail![i].leadConverted,
          //       createdBy: value.itemdata!.datadetail![i].createdBy,
          //       createdDateTime: value.itemdata!.datadetail![i].createdDateTime,
          //       updatedBy: value.itemdata!.datadetail![i].updatedBy,
          //       updatedDateTime: value.itemdata!.datadetail![i].updatedDateTime,
          //       enquirydscription: value.itemdata!.datadetail![i].enquirydscription,
          //       quantity: value.itemdata!.datadetail![i].quantity,
          //       customermobile: value.itemdata!.datadetail![i].customermobile,
          //         Mgr_UserName: value.itemdata!.datadetail![i].Mgr_UserName,
          //         EnqID: value.itemdata!.datadetail![i].EnqID,
          //         CardCode: value.itemdata!.datadetail![i].CardCode,
          //         Status: value.itemdata!.datadetail![i].Status,
          //         CardName: value.itemdata!.datadetail![i].CardName,
          //         AssignedTo_User: value.itemdata!.datadetail![i].AssignedTo_User,
          //         EnqDate: value.itemdata!.datadetail![i].EnqDate,
          //         Followup: value.itemdata!.datadetail![i].Followup,
          //         Mgr_UserCode: value.itemdata!.datadetail![i].Mgr_UserCode,
          //         AssignedTo_UserName: value.itemdata!.datadetail![i].AssignedTo_UserName,
          //         EnqType: value.itemdata!.datadetail![i].EnqType,
          //         Lookingfor: value.itemdata!.datadetail![i].Lookingfor,
          //         PotentialValue: value.itemdata!.datadetail![i].PotentialValue,
          //         Address_Line_1: value.itemdata!.datadetail![i].Address_Line_1,
          //         Address_Line_2: value.itemdata!.datadetail![i].Address_Line_2,
          //         Pincode: value.itemdata!.datadetail![i].Pincode,
          //         City: value.itemdata!.datadetail![i].City,
          //         State: value.itemdata!.datadetail![i].State,
          //         Country: value.itemdata!.datadetail![i].Country,
          //         Manager_Status_Tab: value.itemdata!.datadetail![i].Manager_Status_Tab,
          //         Slp_Status_Tab: value.itemdata!.datadetail![i].Slp_Status_Tab, email: value.itemdata!.datadetail![i].email,referal:value.itemdata!.datadetail![i].referal ));
          //  filteropenEnqData=openEnqData;
          //   }
          //   if (value.itemdata!.datadetail![i].Slp_Status_Tab == 'Closed') {
          //     closedEnqdata.add(EnquiriesData(
          //       InterestLevel:value.itemdata!.datadetail![i].InterestLevel ,
          //       OrderType:value.itemdata!.datadetail![i].OrderType ,
          //       contactName: value.itemdata!.datadetail![i].contactName,
          //       altermobileNo: value.itemdata!.datadetail![i].altermobileNo,
          //       customerGroup: value.itemdata!.datadetail![i].customerGroup,
          //       comapanyname: value.itemdata!.datadetail![i].comapanyname,
          //       visitTime: value.itemdata!.datadetail![i].visitTime,
          //       remindOn: value.itemdata!.datadetail![i].remindOn,
          //       isClosed: value.itemdata!.datadetail![i].isClosed,
          //       isVisitRequired: value.itemdata!.datadetail![i].isVisitRequired,
          //       storecode: value.itemdata!.datadetail![i].storecode,
          //       area: value.itemdata!.datadetail![i].area,
          //       district: value.itemdata!.datadetail![i].district,
          //       itemCode: value.itemdata!.datadetail![i].itemCode,
          //       itemname: value.itemdata!.datadetail![i].itemname,
          //       leadConverted: value.itemdata!.datadetail![i].leadConverted,
          //       createdBy: value.itemdata!.datadetail![i].createdBy,
          //       createdDateTime: value.itemdata!.datadetail![i].createdDateTime,
          //       updatedBy: value.itemdata!.datadetail![i].updatedBy,
          //       updatedDateTime: value.itemdata!.datadetail![i].updatedDateTime,
          //       enquirydscription: value.itemdata!.datadetail![i].enquirydscription,
          //       quantity: value.itemdata!.datadetail![i].quantity,
          //       customermobile: value.itemdata!.datadetail![i].customermobile,
          //         Mgr_UserName: value.itemdata!.datadetail![i].Mgr_UserName,
          //         EnqID: value.itemdata!.datadetail![i].EnqID,
          //         CardCode: value.itemdata!.datadetail![i].CardCode,
          //         Status: value.itemdata!.datadetail![i].Status,
          //         CardName: value.itemdata!.datadetail![i].CardName,
          //         AssignedTo_User: value.itemdata!.datadetail![i].AssignedTo_User,
          //         EnqDate: value.itemdata!.datadetail![i].EnqDate,
          //         Followup: value.itemdata!.datadetail![i].Followup,
          //         Mgr_UserCode: value.itemdata!.datadetail![i].Mgr_UserCode,
          //         AssignedTo_UserName: value.itemdata!.datadetail![i].AssignedTo_UserName,
          //         EnqType: value.itemdata!.datadetail![i].EnqType,
          //         Lookingfor: value.itemdata!.datadetail![i].Lookingfor,
          //         PotentialValue: value.itemdata!.datadetail![i].PotentialValue,
          //         Address_Line_1: value.itemdata!.datadetail![i].Address_Line_1,
          //         Address_Line_2: value.itemdata!.datadetail![i].Address_Line_2,
          //         Pincode: value.itemdata!.datadetail![i].Pincode,
          //         City: value.itemdata!.datadetail![i].City,
          //         State: value.itemdata!.datadetail![i].State,
          //         Country: value.itemdata!.datadetail![i].Country,
          //         Manager_Status_Tab: value.itemdata!.datadetail![i].Manager_Status_Tab,
          //         Slp_Status_Tab: value.itemdata!.datadetail![i].Slp_Status_Tab,
          //         email: value.itemdata!.datadetail![i].email,referal:value.itemdata!.datadetail![i].referal));
          //  filterclosedEnqdata=closedEnqdata;
          //   }
          //   if (value.itemdata!.datadetail![i].Slp_Status_Tab == 'Lost') {
          //     lostEnqUserdata.add(EnquiriesData(
          //       InterestLevel:value.itemdata!.datadetail![i].InterestLevel ,
          //       OrderType:value.itemdata!.datadetail![i].OrderType ,
          //       contactName: value.itemdata!.datadetail![i].contactName,
          //       altermobileNo: value.itemdata!.datadetail![i].altermobileNo,
          //       customerGroup: value.itemdata!.datadetail![i].customerGroup,
          //       comapanyname: value.itemdata!.datadetail![i].comapanyname,
          //       visitTime: value.itemdata!.datadetail![i].visitTime,
          //       remindOn: value.itemdata!.datadetail![i].remindOn,
          //       isClosed: value.itemdata!.datadetail![i].isClosed,
          //       isVisitRequired: value.itemdata!.datadetail![i].isVisitRequired,
          //       storecode: value.itemdata!.datadetail![i].storecode,
          //       area: value.itemdata!.datadetail![i].area,
          //       district: value.itemdata!.datadetail![i].district,
          //       itemCode: value.itemdata!.datadetail![i].itemCode,
          //       itemname: value.itemdata!.datadetail![i].itemname,
          //       leadConverted: value.itemdata!.datadetail![i].leadConverted,
          //       createdBy: value.itemdata!.datadetail![i].createdBy,
          //       createdDateTime: value.itemdata!.datadetail![i].createdDateTime,
          //       updatedBy: value.itemdata!.datadetail![i].updatedBy,
          //       updatedDateTime: value.itemdata!.datadetail![i].updatedDateTime,
          //       enquirydscription: value.itemdata!.datadetail![i].enquirydscription,
          //       quantity: value.itemdata!.datadetail![i].quantity,
          //       customermobile: value.itemdata!.datadetail![i].customermobile,
          //         Mgr_UserName:value.itemdata!.datadetail![i].Mgr_UserName,
          //         EnqID: value.itemdata!.datadetail![i].EnqID,
          //         CardCode: value.itemdata!.datadetail![i].CardCode,
          //         Status: value.itemdata!.datadetail![i].Status,
          //         CardName: value.itemdata!.datadetail![i].CardName,
          //         AssignedTo_User: value.itemdata!.datadetail![i].AssignedTo_User,
          //         EnqDate: value.itemdata!.datadetail![i].EnqDate,
          //         Followup: value.itemdata!.datadetail![i].Followup,
          //         Mgr_UserCode: value.itemdata!.datadetail![i].Mgr_UserCode,
          //         AssignedTo_UserName: value.itemdata!.datadetail![i].AssignedTo_UserName,
          //         EnqType: value.itemdata!.datadetail![i].EnqType,
          //         Lookingfor: value.itemdata!.datadetail![i].Lookingfor,
          //         PotentialValue: value.itemdata!.datadetail![i].PotentialValue,
          //         Address_Line_1: value.itemdata!.datadetail![i].Address_Line_1,
          //         Address_Line_2: value.itemdata!.datadetail![i].Address_Line_2,
          //         Pincode: value.itemdata!.datadetail![i].Pincode,
          //         City: value.itemdata!.datadetail![i].City,
          //         State: value.itemdata!.datadetail![i].State,
          //         Country: value.itemdata!.datadetail![i].Country,
          //         Manager_Status_Tab: value.itemdata!.datadetail![i].Manager_Status_Tab,
          //         Slp_Status_Tab: value.itemdata!.datadetail![i].Slp_Status_Tab,
          //         email: value.itemdata!.datadetail![i].email,referal:value.itemdata!.datadetail![i].referal));
          //  filterlostEnqUserdata=lostEnqUserdata;
          //   }
          // }
          notifyListeners();
        } else if (value.itemdata!.datadetail == null || value.itemdata!.datadetail!.isEmpty) {
          datagotByApi = true;
          exception = true;
          lottie='Assets/no-data.png';
          errorMsg = 'No data found..!!';
          notifyListeners();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          lottie='';
        datagotByApi = true;
        exception = true;
        errorMsg = '${value.stcode}..!!${value.message}..! \n${value.exception}..!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        datagotByApi = true;
        exception = true;
          lottie='Assets/NetworkAnimation.json';
        errorMsg = '${value.stcode}..!!Network Issue\nTry again Later..!!';
        notifyListeners();
      }
    });
 
 await callResonApi();
 notifyListeners();
  }

  callPrevEnqDatilsApi(BuildContext context, int enqData) async {
    print("EnqPrevDetailsApi");
    await EnqPrevDetailsApi.getData(enqData).then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          openEnqData.clear();
          closedEnqdata.clear();
          lostEnqUserdata.clear();
          exception = false;
          datagotByApi = true;
          isAlreadyenqOpen = false;
          //assignedEnqData = value.itemdata!;
          for (int i = 0; i < value.itemdata!.length; i++) {
            if (value.itemdata![i].Slp_Status_Tab == 'Open') {
              openEnqData.add(EnquiriesData(
                InterestLevel:'' ,
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
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab,
                  email: value.itemdata![i].email,referal:value.itemdata![i].referal));
            }
            if (value.itemdata![i].Slp_Status_Tab == 'Closed') {
              closedEnqdata.add(EnquiriesData(
                InterestLevel:"" ,
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
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab,email: value.itemdata![i].email,referal:value.itemdata![i].referal));
            }
            if (value.itemdata![i].Slp_Status_Tab == 'Lost') {
              lostEnqUserdata.add(EnquiriesData(
                InterestLevel:"" ,
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
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab,email: value.itemdata![i].email,referal:value.itemdata![i].referal));
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
        errorMsg = '${value.message}..! \n${value.exception}..!! ';
        notifyListeners();
      } else if (value.stcode == 500) {
        isAlreadyenqOpen = false;
        datagotByApi = false;
        exception = true;
        errorMsg = '${value.message}..! \nNetwork Issue\nTry again Later..!!';
        notifyListeners();
      }
    });
  }

mapValuesToOrder(EnquiriesData  openEnqData) {
  OrderNewController.dataenq.clear();

    OrderNewController.dataenq.add(openEnqData.CardCode!);
    OrderNewController.dataenq.add(openEnqData.CardName!);
    OrderNewController.dataenq.add(openEnqData.Address_Line_1!);
    OrderNewController.dataenq.add(openEnqData.Address_Line_2!);
    OrderNewController.dataenq.add(openEnqData.Pincode!);
    OrderNewController.dataenq.add(openEnqData.City!); //isSelectedCsTag
    OrderNewController.dataenq.add(openEnqData.EnqID.toString());
    OrderNewController.dataenq.add(openEnqData.email.toString());
    OrderNewController.dataenq.add(openEnqData.referal.toString());
    OrderNewController.dataenq.add(openEnqData.State.toString());
    OrderNewController.dataenq.add(openEnqData.customerGroup.toString());
    OrderNewController.dataenq.add(openEnqData.altermobileNo.toString());
    OrderNewController.dataenq.add(openEnqData.contactName.toString());
    OrderNewController.dataenq.add(openEnqData.area.toString());
    
      OrderNewController.dataenq.add(openEnqData.OrderType.toString());
    
    //openEnqData[].
    OrderBookNewState.iscomfromLead = true;
    
     Get.toNamed(ConstantRoutes.ordernew);
    notifyListeners();
    // OrderNewController.dataenq.clear();

    // OrderNewController.dataenq.add(openEnqData[ind].CardCode!);
    // OrderNewController.dataenq.add(openEnqData[ind].CardName!);
    // OrderNewController.dataenq.add(openEnqData[ind].Address_Line_1!);
    // OrderNewController.dataenq.add(openEnqData[ind].Address_Line_2!);
    // OrderNewController.dataenq.add(openEnqData[ind].Pincode!);
    // OrderNewController.dataenq.add(openEnqData[ind].City!); //isSelectedCsTag
    // OrderNewController.dataenq.add(openEnqData[ind].EnqID.toString());
    // OrderNewController.dataenq.add(openEnqData[ind].email.toString());
    // OrderNewController.dataenq.add(openEnqData[ind].referal.toString());
    // OrderNewController.dataenq.add(openEnqData[ind].State.toString());

    // //openEnqData[].
    // OrderNewController.isComeFromEnq = true;
    // notifyListeners();
    // Get.toNamed(ConstantRoutes.ordernew);
  }



  mapValuesToLead(EnquiriesData  openEnqData) {
    LeadNewController.dataenq.clear();

    LeadNewController.dataenq.add(openEnqData.CardCode!);
    LeadNewController.dataenq.add(openEnqData.CardName!);
    LeadNewController.dataenq.add(openEnqData.Address_Line_1!);
    LeadNewController.dataenq.add(openEnqData.Address_Line_2!);
    LeadNewController.dataenq.add(openEnqData.Pincode!);
    LeadNewController.dataenq.add(openEnqData.City!); //isSelectedCsTag
    LeadNewController.dataenq.add(openEnqData.EnqID.toString());
    LeadNewController.dataenq.add(openEnqData.email.toString());
    LeadNewController.dataenq.add(openEnqData.referal.toString());
    LeadNewController.dataenq.add(openEnqData.State.toString());
    LeadNewController.dataenq.add(openEnqData.customerGroup.toString());
    LeadNewController.dataenq.add(openEnqData.altermobileNo.toString());
    LeadNewController.dataenq.add(openEnqData.contactName.toString());
    LeadNewController.dataenq.add(openEnqData.area.toString());
     LeadNewController.dataenq.add(openEnqData.InterestLevel.toString());
      LeadNewController.dataenq.add(openEnqData.OrderType.toString());
    
    //openEnqData[].
    LeadNewController.isComeFromEnq = true;
    
    Get.toNamed(ConstantRoutes.leads);
    notifyListeners();
  }

  mapValuesToEnq() {
    log("openEnqData[0].CardCode!: ${openEnqData.length}");
    NewEnqController.comeFromEnq.clear();
    NewEnqController.comeFromEnq.add(openEnqData[0].CardCode!);
    NewEnqController.comeFromEnq.add(openEnqData[0].CardName!);
    NewEnqController.comeFromEnq.add(openEnqData[0].Address_Line_1!);
    NewEnqController.comeFromEnq.add(openEnqData[0].Address_Line_2!);
    NewEnqController.comeFromEnq.add(openEnqData[0].Pincode!);
    NewEnqController.comeFromEnq.add(openEnqData[0].City!);
    notifyListeners();
    Get.toNamed(ConstantRoutes.newEnq);
  }

  callDialog(BuildContext context, i) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          assignto = false;
          resetUserSelection();
          return AssignedToDialogUser(
            indx: i,openenqdata: openEnqData[0],
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
          return WarningDialog();
        }).then((value) {
      //resetAll(context);
    });
  }

  /// for lead other branch
  ///
  callOtherLead(String docentry) {
    //call SK_GET_LEAD_DETAILS_QTH this appi and load the data in new lead
    GetLeadQTHApi.getData(docentry).then((value) {
      // lead
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
    
    final Database db = (await DBHelper.getInstance())!;
    userLtData = await DBOperation.getUserList(db);
    filteruserLtData = userLtData;
    // log("AANBGY:" + userLtData[0].slpcode.toString());
    exceptionUList = false;
    notifyListeners();
  }

//alert dialog actions
  int? selectedIdxFUser = null;
  selectUser(int ij) {
    for (int i = 0; i < filteruserLtData.length; i++) {
      if (filteruserLtData[i].SalesEmpID == filteruserLtData[ij].SalesEmpID) {
        filteruserLtData[i].color = 1;
        getUserKey = filteruserLtData[ij].SalesEmpID;
      } else {
        filteruserLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  setForwardDataList(){
    List<UserListData> filteruserLtData2 =[];
// print("List Length"+filteruserLtData.length.toString());
    for(int i=0;i<filteruserLtData.length;i++){
      // print("User slp::${ConstantValues.slpcode}--${filteruserLtData[i].slpcode}");
      if(filteruserLtData[i].slpcode != ConstantValues.slpcode){
      filteruserLtData2.add(UserListData(
        userCode: filteruserLtData[i].userCode,
        storeid: filteruserLtData[i].storeid,
      mngSlpcode: filteruserLtData[i].mngSlpcode,
      UserName: filteruserLtData[i].UserName,
      color: filteruserLtData[i].color,
      slpcode: filteruserLtData[i].slpcode,
      SalesEmpID: filteruserLtData[i].SalesEmpID) );
      }
    }

    if(filteruserLtData2.isNotEmpty){
    filteruserLtData=[];
    filteruserLtData=filteruserLtData2;
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
        // temp2=null;
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
    mycontroller[1].text='';//filter

    valueChosedReason = null;
    temp2 = null;
    apidate = null;
    for (int i = 0; i < userLtData.length; i++) {
      userLtData[i].color = 0;

    }
    for (int i = 0; i < resonData.length; i++) {
      resonData[i].color = 0;
    }
    // getUserKey = null;
        filteruserLtData=userLtData;

    //notifyListeners();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //  callAsignedToApi(EnquiriesData enqID, String userkey, ResonData data,String update,
  //     BuildContext context) {
  //   assigntoApical = true;
  //   notifyListeners();
  //   // log("SalesEmpID"+getuserLtData[0
  //   //                             ]
  //   //                         .slpcode //changeddd UserKey
  //   //                         .toString());
  //   AssignedToUserApi.getData(enqID, userkey, data,update).then((value) {
  //     //
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       if (value.userLtData != null) {
  //         isSuccessforward = true;
  //         assigntoApical = false;
  //         assignedToApiActResp = value.userLtData!.closed!;
  //         // assignedToApiActRespMsg = value.userLtData![0].actionResponseMessage!;
  //         // print("assignedToApiActResp: "+assignedToApiActResp);
  //         // print("value.userLtData![0].actionResponce!: "+value.userLtData![0].actionResponce!);
  //         notifyListeners();

  //         disabledialog(context);
  //       } else if (value.userLtData == null) {
  //         assigntoApical = false;
  //         assignedToApiActResp = 'Something went wrog..!!';
  //         assignedToApiActRespMsg = 'Try agin..!!';
  //         notifyListeners();
  //         disabledialog(context);
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       assigntoApical = false;
  //       assignedToApiActResp = 'Something went wrog...!!';
  //       assignedToApiActRespMsg = 'Try agin...!!';
  //       notifyListeners();
  //       disabledialog(context);
  //     } else if (value.stcode == 500) {
  //       assigntoApical = false;
  //       assignedToApiActResp = 'Something went wrog...!!';
  //       assignedToApiActRespMsg = 'Try agin....!!';
  //       notifyListeners();
  //       disabledialog(context);
  //     }
  //   });
  // }

  // disabledialog(BuildContext context) {
  //   Future.delayed(Duration(seconds: 2), () {
  //     // Navigator.pop(context);
  //   });
  // }

  callAsignedToApi(EnquiriesData enqID, String userkey,String update,
      BuildContext context,String checking) {
        log("checking:::"+checking.toString());
    
    if(checking =='Update'){
 statusUpdateLoading = true;
   notifyListeners();
    }else{
       assigntoApical = true;
         notifyListeners();
    }
   
  
   
    AssignedToUserApi.getData(enqID, userkey,update).then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
            if(checking =="Update"){
             statusUpdateLoading = false;
          isSuccessupdate=true;
 statusUpdateApiResp =
              value.userLtData!.datadetail![0].isClosed.toString(); 
              notifyListeners();
          }else{
            //  statusUpdateLoading = false;
            //  statusUpdate=false;
          // isSuccessupdate=true;
            // statusUpdateLoading=false;
            // isSuccessupdate=true;
 isSuccessforward = true;
          assigntoApical = false;
          assignedToApiActResp = value.userLtData!.respType!;
          }
          
       
         
          
         
         
          notifyListeners();

          disabledialog(context);
        } else if (value.userLtData == null) {
            statusUpdateLoading = false;
          isSuccessupdate=true;
 isSuccessforward = true;
          assigntoApical = false;
          assignedToApiActResp = 'Something went wrongg..!!';
          assignedToApiActRespMsg = 'Try again..!!';
          notifyListeners();
          // disabledialog(context);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        if(checking =='Update'){
          
  statusUpdateLoading = false;
          isSuccessupdate=false;
        statusUpdateApiResp = '${value.message}...!!'; //'Failure..!!';
        statusUpdateApiRespMsg = '${value.exception}...!!';
         notifyListeners();
        }else{
       isSuccessforward = false;
          assigntoApical = false;
        assignedToApiActResp = '${value.message}...!!';
        assignedToApiActRespMsg = '${value.exception}';
        notifyListeners();
        }
        // disabledialog(context);
      } else if (value.stcode == 500) {
        if(checking =='Update'){
          
 isSuccessforward = false;
          statusUpdate = false;
        statusUpdateApiResp = 'Network Issue..!!'; //'Failure..!!';
        statusUpdateApiRespMsg = 'Try again Later..!!';
         notifyListeners();
        }else{
          
 isSuccessforward = false;
        assigntoApical = false;
        assignedToApiActResp = 'Network Issue..\nTry again Later..!!';
        assignedToApiActRespMsg = '';
          notifyListeners();
        }
        notifyListeners();
        // disabledialog(context);
      }
    });
  }

  disabledialog(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      // Navigator.pop(context);
    });
  }

  bool isSuccessupdate = false;
  bool isSuccessforward = false;
  static bool isAlreadyenqOpen = false;
  bool get getisAlreadyenqOpen => isAlreadyenqOpen;
  static int enqDataprev = 0;
  static String typeOfDataCus = '';
  static String typeOfDataCusBranch = '';

  resetAll(BuildContext context)async {
    mycontroller[5].clear();
    final Database db = (await DBHelper.getInstance())!;
 await DBOperation.truncareEnqfilter(db);
  mycontroller[5].clear();
    GetAllEnqData.clear();
      GetfromdbEnqData.clear();
      openEnqData.clear();
      closedEnqdata.clear();
      lostEnqUserdata.clear();
      filterclosedEnqdata.clear();
      filterlostEnqUserdata.clear();
      filteropenEnqData.clear();
    //NewEnqController.comeFromEnq.clear();
    isAnotherBranchEnq = false;
    callApi();
      callResonApi();
      callUserListApi();
      notifyListeners();
    //isAlreadyenqOpen = false;
    //log("EnquiryUserContoller.enqDataprev: ${EnquiryUserContoller.enqDataprev}");
    if (isAlreadyenqOpen == false) {
      // log("EnquiryUserContoller.5555: ${EnquiryUserContoller.enqDataprev}");
      callApi();
      callResonApi();
      callUserListApi();
      notifyListeners();
      
    } else {
      if (typeOfDataCus == 'Enquiry') {
        //  log("EnquiryUserContoller.22222: ${EnquiryUserContoller.enqDataprev}");
        callPrevEnqDatilsApi(context, enqDataprev);
      } else {
        if (typeOfDataCusBranch == 'this') {
          //  log("EnquiryUserContoller.33333: ${EnquiryUserContoller.enqDataprev}");
          isAlreadyenqOpen = false;
          alertDialogOpenLeadOREnq(context, typeOfDataCus);
        } else {
          // log("EnquiryUserContoller.4444: ${EnquiryUserContoller.enqDataprev}");
          // print("Other bra
          // nch");
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
    resonData.clear();
    await ResonApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
          log("value.userLtData!.length::"+value.userLtData!.length.toString());
          for(int i=0;i<value.userLtData!.length;i++){
            if(value.userLtData![i].nextStatus !=1){
             resonData.add(ResonData(
              CODE: value.userLtData![i].CODE, 
              color: value.userLtData![i].color, 
              createdBy: value.userLtData![i].createdBy, 
              createdOn: value.userLtData![i].createdOn, 
              description: value.userLtData![i].description, 
              id: value.userLtData![i].id, 
              mastertypeid: value.userLtData![i].mastertypeid, 
              parentMasterId: value.userLtData![i].parentMasterId, 
              status: value.userLtData![i].status, 
              updatedBy: value.userLtData![i].updatedBy, 
              updatedOn: value.userLtData![i].updatedOn, 
              nextStatus: value.userLtData![i].nextStatus
              )); 
            }
            // log("value.userLtData!.length::"+resonData.length.toString());
            notifyListeners();
          }
          // resonData = value.userLtData!;
          log("DONR::" + resonData.length.toString());
          notifyListeners();
        } else if (value.userLtData == null) {
          log("DONR222");
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
  //   //
  //   statusUpdateLoading = true;
  //   notifyListeners();
  //   UpdateEnqApi.getData(enqID, temp2, apidate).then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       statusUpdateLoading = false;
  //       if (value.userLtData != null) {
  //         isSuccessupdate = true;
  //         statusUpdateApiResp =
  //             value.userLtData!.closed!.toString(); //'Failure..!!';
  //         // statusUpdateApiRespMsg = value.userLtData!.customerCode!;
  //         notifyListeners();

  //         Future.delayed(Duration(seconds: 1), () {
  //           if (statusUpdateApiResp.toLowerCase().contains("Y")) {
  //             // statusUpdateApiResp="Success";
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
class Distcolumn {
  String name;
  Distcolumn({
    required this.name,
  });
}
 
class Distcusgroupcolumn {
  String name;
  Distcusgroupcolumn({
    required this.name,
  });
}
class DistEnqstatuscolumn {
  String name;
  DistEnqstatuscolumn({
    required this.name,
  });
}
class Distlookingforcolumn {
  String name;
  bool ischecck;
  Distlookingforcolumn({
    required this.name,
    required this.ischecck
  });
}
class Distlevelcolumn {
  String name;
  Distlevelcolumn({
    required this.name,
  });
}
class Distordercolumn {
  String name;
  Distordercolumn({
    required this.name,
  });
}

class Distcustnamecolumn {
  String name;
  Distcustnamecolumn({
    required this.name,
  });
}
