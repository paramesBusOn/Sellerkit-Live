// ignore_for_file: empty_constructor_bodies, unnecessary_new, unused_import, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/DBModel/leadopenDBmodel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetLeadSummary.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/newleadopenmodel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/newphonemodel.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';
import 'package:sellerkit/Pages/Quoatation/newqoute.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/CancelLeadWonApi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/NewopenAPi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/Newphoneapi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTL.dart';
import '../../Pages/Leads/Widgets/FollowDialog.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Services/PostQueryApi/LeadsApi/CloseLeadwonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/ForwardLeadUserApi.dart';
import '../../Services/PostQueryApi/LeadsApi/GetAllLeads.dart';

import '../../Services/PostQueryApi/LeadsApi/GetLeadSummaryApi.dart';
import '../../Services/PostQueryApi/LeadsApi/LostSaveLeadApi.dart';
import '../../Services/PostQueryApi/LeadsApi/OpenSaveApi.dart';
import '../../Services/PostQueryApi/LeadsApi/WonSaveApi.dart';
import '../EnquiryController/NewEnqController.dart';
import '../OrderController/OrderNewController.dart';

class LeadTabController extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());

  Config config = new Config();
 List<GetAllLeadData> GetAllEnqData = [];
 List<GetAllLeadData> GetfromdbEnqData = [];
  List<GetAllLeadData> leadOpenAllData = [];
  List<GetAllLeadData> get getAllLeadData => leadOpenAllData;
  List<GetAllLeadData> filterleadOpenAllData = [];
  List<GetAllLeadData> get getFilterleadOpenAllData => filterleadOpenAllData;
  //
  List<GetAllLeadData> leadClosedAllData = [];
  List<GetAllLeadData> get getleadClosedAllData => leadClosedAllData;
  List<GetAllLeadData> filterleadClosedAllData = [];
  List<GetAllLeadData> get getFilterleadClosedAllData =>
      filterleadClosedAllData;
  //
  List<GetAllLeadData> leadLostAllData = [];
  List<GetAllLeadData> get getleadLostAllData => leadLostAllData;
  List<GetAllLeadData> filterleadLostAllData = [];
  List<GetAllLeadData> get getFilterleadLostAllData => filterleadLostAllData;
  //
  String leadCheckDataExcep = '';
  String get getLeadCheckDataExcep => leadCheckDataExcep;
  List<UserListData> filteruserLtData = [];
  List<UserListData> get getfiltergetuserLtData => filteruserLtData;

String? filterapiwonpurchaseDate='';
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
void showfromDate(BuildContext context) {
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
      filterapiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[21].text = chooseddate;
      notifyListeners();
    });
  }
  void showToDate(BuildContext context) {
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
      filterapiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[22].text = chooseddate;
      notifyListeners();
    });
  }
  printLogic() {
    log("leadCheckDataExcep: ${leadCheckDataExcep}");
    log("leadSummaryLost: ${leadSummaryLost.length}");
    log("leadSummaryOpen: ${leadSummaryOpen.length}");
    log("leadSummaryWon: ${leadSummaryWon.length}");
    log("leadOpenAllData: ${leadOpenAllData.length}");
    log("leadClosedAllData: ${leadClosedAllData.length}");
    log("leadLostAllData: ${leadLostAllData.length}");
  }

  clearAllListData() {
    clearbool();
    VisitTime='';
    errorVisitTime = "";
 forwarderrorVisitTime = "";
    mycontroller[1].clear();
    mycontroller[0].clear();
    datagotByApi=false;
    leadCheckDataExcep = '';
    leadSummaryOpen.clear();
    leadSummaryWon.clear();
    leadSummaryLost.clear();
    leadOpenAllData.clear();
    filterleadOpenAllData.clear();
    filterleadClosedAllData.clear();
    filterleadLostAllData.clear();
    GetAllEnqData.clear();
     GetfromdbEnqData.clear();
    leadLostAllData.clear();
    leadClosedAllData.clear();
     leadDeatilsQTHData!.clear();
     leadDeatilsQTLData.clear();
      leadDeatilsLData.clear();
    mycontroller[5].clear();
    caseStatusSelectedcode="";
    caseStatusSelected="";
    isSelectedFollowUp='';
    isSelectedFollowUpcode='';
     iscorectime=false;
    iscorectime2=false;

    notifyListeners();
  }

  refershAfterClosedialog() {
    clearbool();
    forwaVisitTime='';
    forwardnextWonFD='';
    nextpurchasedate='';
    nextpurchasedate='';
    mycontroller[5].clear();
    leadCheckDataExcep = '';
    iscorectime=false;
    iscorectime2=false;
    // leadOpenAllData.clear();
    // leadClosedAllData.clear();
    // leadLostAllData.clear();
    // filterleadOpenAllData.clear();
    
    // filterleadClosedAllData.clear();
    // filterleadClosedAllData.clear();
    leadSummaryOpen.clear();
    
    leadSummaryWon.clear();
    leadSummaryLost.clear();
    comeFromEnq = -1;
    viewDetailsdialog = false;
    isSameBranch = true;
    quataDate = "";
    apiQuaDate = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    forwardSuccessMsg = "";
    updateConvertToQuatationUpdialog = false;
    caseStatusSelectedcode="";
    caseStatusSelected="";
    isSelectedFollowUp='';
    isSelectedFollowUpcode='';
    assignVisitTime="Followup Time";
     leadDeatilsQTHData!.clear();
     leadDeatilsQTLData.clear();
      leadDeatilsLData.clear();
      selectedUserList='';
     
     
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
  Future<void> swipeRefreshIndiactor() async {
    // return Future.delayed(Duration.zero,(){
    refershAfterClosedialog();
   await clearAllListData();
  await  callGetAllApi();
    // callSummaryApi();

    //});
  }
List<Distcolumn> assigncolumn = [];
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
  }else{
    selectedassignto.remove(itemvalue);
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
  log("selectedcusname::"+selectedcusname.toString());
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
 String? assignvalue;
   String? cusnamevalue;
   String? cardnamevalue;
   String? Enquirystatusvalue;
   String? lookingforvalue;
   
    String? interestlevelvalue;
     String? ordertypevalue;
     
bool? islookloading=false;

  bool datagotByApi = false;
clearfilterval() {
   checkdate=null;
    assignvalue = null;
    cusnamevalue = null;
    cardnamevalue=null;
    islookingfor=false;
    selectedlookingfor.clear();
    isenqstatus=false;
    selectedenqstatus.clear();
    selectedcusgoup.clear();
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
    selectedcusname.clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();
    

    notifyListeners();
  }
Future<void> dataget(List<Map<String, Object?>> assignDB,cusgropDB,enqstatusDB,intlevelDB,ordertypeDB,cusnametype) async {
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
      assigncolumn.add(Distcolumn(name: assignDB[i]['AssignedTo'].toString()));
      assigncolumn.sort((a,b)=>a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      log("assigncolumn::" + assigncolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < cusgropDB.length; i++) {
      cusgroupcolumn.add(Distcusgroupcolumn(name: cusgropDB[i]['Cusgroup'].toString()));
      log("cusgroupcolumn::" + cusgroupcolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < enqstatusDB.length; i++) {
      enqstatuscolumn.add(DistEnqstatuscolumn(name: enqstatusDB[i]['Status'].toString()));
      log("enqstatuscolumn::" + enqstatuscolumn.length.toString());
      notifyListeners();
    }
    // for (int i = 0; i < lookingforDB.length; i++) {
    //   lookingforcolumn.add(Distlookingforcolumn(name: lookingforDB[i]['Lookingfor'].toString(),ischecck: false));
     
    //    filterlookingforcolumn=lookingforcolumn;
    //   //   log("lookingforcolumn::" + filterlookingforcolumn.length.toString());
        
    //   notifyListeners();
    // }
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
      cusnamecolumn.add(Distcustnamecolumn(name: cusnametype[i]['CustomerName'].toString()));
      log("cusnamecolumn::" + cusnamecolumn.length.toString());
      notifyListeners();
    }
   
  }
   getdbmodel()async{
    GetfromdbEnqData.clear();
    leadOpenAllData.clear();
    leadClosedAllData.clear();
    leadLostAllData.clear();
    filterleadOpenAllData.clear();
    filterleadClosedAllData.clear();
    filterleadLostAllData.clear();
     final Database db = (await DBHelper.getInstance())!;
GetfromdbEnqData = await DBOperation.getLeaddatafilter(db);
log("GetfromdbEnqData::"+GetfromdbEnqData.length.toString());
 List<Map<String, Object?>> assignDB =
        await DBOperation.getleadftr("AssignedTo", db);
        List<Map<String, Object?>> cusgropDB =
        await DBOperation.getleadftr("Cusgroup", db);
        List<Map<String, Object?>> enqstatusDB =
        await DBOperation.getleadftr("Status", db);
        // List<Map<String, Object?>> lookingforDB =
        // await DBOperation.getleadftr("Mobile", db);
        List<Map<String, Object?>> intlevelDB =
        await DBOperation.getleadftr("InterestLevel", db);
        List<Map<String, Object?>> ordertypeDB =
        await DBOperation.getleadftr("OrderType", db);
         List<Map<String, Object?>> cusnametypeDB =
        await DBOperation.getleadftr("CustomerName", db);
        notifyListeners();
        
        await dataget(assignDB,cusgropDB,enqstatusDB,intlevelDB,ordertypeDB,cusnametypeDB);
 await mapValues(GetfromdbEnqData);
          notifyListeners();
  }
   
  String dbfilterpurchaseDate = '';
 
 DateTime? checkdate;
void showfromDatefilter(BuildContext context) {
 
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
       mycontroller[22].clear();
      String chooseddate = value.toString();
        checkdate=value;
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      dbfilterpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[21].text = chooseddate;
      notifyListeners();
    });
  }
  void showToDatefilter(BuildContext context) {
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
      dbfilterpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[22].text = chooseddate;
      notifyListeners();
    });
  }
 onfilterapply()async{
     final Database db = (await DBHelper.getInstance())!;
    
      await DBOperation.getleadfilterapply(
            db,
            assignvalue == null ? '' : assignvalue!,
            cardnamevalue== null ? '' : cardnamevalue!,
            cusnamevalue == null ? '' : cusnamevalue!,
            Enquirystatusvalue == null ? '' : Enquirystatusvalue!,
          
              interestlevelvalue == null ? '' : interestlevelvalue!,
            ordertypevalue == null ? '' : ordertypevalue!,
             mycontroller[23].text.isEmpty ? 0.0 : double.parse(mycontroller[23].text),
          
            mycontroller[21].text.isEmpty ? '0000-00-00' : config.alignDate1(mycontroller[21].text),
            mycontroller[22].text.isEmpty ? '9999-12-31' : config.alignDate1(mycontroller[22].text),
           
           )
        .then((value) async {
     
//  GetAllEnqData.clear();
     GetfromdbEnqData.clear();
     
    leadOpenAllData.clear();
    leadClosedAllData.clear();
    leadLostAllData.clear();
    filterleadOpenAllData.clear();
    filterleadClosedAllData.clear();
    filterleadLostAllData.clear();
    notifyListeners();
      GetfromdbEnqData = value;
      log("GetfromdbEnqData::"+GetfromdbEnqData.length.toString());
      datagotByApi=false;
      notifyListeners();
       await mapValues(GetfromdbEnqData);
      clearfilterval();
      
      log("datagotByApi::"+datagotByApi.toString());
      log("leadCheckDataExcep::"+leadCheckDataExcep.toString());
      notifyListeners();
    });

  }
   tableinsert(List<GetAllLeadData> enqadddata)async{
 final Database db = (await DBHelper.getInstance())!;
 await DBOperation.truncareleadfilter(db);


   await DBOperation.insertleaddata(enqadddata, db);
   notifyListeners();
   await getdbmodel();
   notifyListeners();
  }
bool isbool=false;
String lottie='';
  callGetAllApi() async {
    leadCheckDataExcep='';
    datagotByApi=false;
    notifyListeners();
     GetAllEnqData.clear();
     GetfromdbEnqData.clear();
    leadOpenAllData.clear();
    leadClosedAllData.clear();
    leadLostAllData.clear();
    lottie='';
    // filterleadOpenAllData.clear();
    
    // filterleadClosedAllData.clear();
    // filterleadLostAllData.clear();
    log("leadOpenAllData::"+leadOpenAllData.length.toString());
    log("filterleadOpenAllData::"+filterleadOpenAllData.length.toString());
    isbool=true;
    //  final Database db = (await DBHelper.getInstance())!;
    // leadStatusLost = await DBOperation.getLeadStatusLost(db);
    await GetAllLeadApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckheader!.leadcheckdata != null && value.leadcheckheader!.leadcheckdata!.isNotEmpty) {
          // log("not null"+value.leadcheckheader!.length.toString());
         GetAllEnqData=value.leadcheckheader!.leadcheckdata!;
         tableinsert(GetAllEnqData);
          // mapValues(value.leadcheckheader!.leadcheckdata!);
        } 
        else if (value.leadcheckheader!.leadcheckdata == null || value.leadcheckheader!.leadcheckdata!.isEmpty) {
          datagotByApi=true;
          lottie='Assets/no-data.png';
          leadCheckDataExcep = 'No Leads..!!';
          log("ANBU"+leadCheckDataExcep.toString());
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
         lottie='';
         isbool=false;
         datagotByApi=true;
           notifyListeners();
        leadCheckDataExcep =
            '${value.message}..!! ${value.exception}..!!';
            
      } else if (value.stcode == 500) {
         isbool=false;
         datagotByApi=true;
           notifyListeners();
            lottie='Assets/NetworkAnimation.json';
        leadCheckDataExcep =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
            notifyListeners();
      }
      notifyListeners();
    });
    // log("GetAll Lead Exception :::" + leadCheckDataExcep.toString());
  }
  

  mapValues(List<GetAllLeadData> leadcheckdata) async {
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
        filterleadOpenAllData = leadOpenAllData;
      // await  mapvaluestoDB(filterleadOpenAllData);
       } else if (leadcheckdata[i].Status == "Won") {
        leadClosedAllData.add(GetAllLeadData(
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
        filterleadClosedAllData = leadClosedAllData;
      } else if (leadcheckdata[i].Status == "Lost") {
        leadLostAllData.add(GetAllLeadData(
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
        filterleadLostAllData = leadLostAllData;
      }
    }
    await callSummaryApi();
  await  callinitApi();
   
          // notifyListeners();
    notifyListeners();
  }
List<leadopenDBmodel> leadopendb=[];
mapvaluestoDB(List<GetAllLeadData> leadOpenAllData)async{
  for(int i=0;i<=leadOpenAllData.length;i++){
    leadopendb.add(leadopenDBmodel(
      City: leadOpenAllData[i].City, 
      CustomerName: leadOpenAllData[i].CustomerName, 
      DocDate: leadOpenAllData[i].DocDate, 
      FollowupEntry: leadOpenAllData[i].FollowupEntry, 
      LastUpdateMessage: leadOpenAllData[i].LastUpdateMessage, 
      LastUpdateTime: leadOpenAllData[i].LastUpdateTime, 
      LeadDocEntry: leadOpenAllData[i].LeadDocEntry, 
      LeadNum: leadOpenAllData[i].LeadNum, 
      Mobile: leadOpenAllData[i].Mobile, 
      NextFollowup: leadOpenAllData[i].NextFollowup, 
      Product: leadOpenAllData[i].Product, 
      Status: leadOpenAllData[i].Status, 
      Value: leadOpenAllData[i].Value, 
      add1: leadOpenAllData[i].add1, 
      add2: leadOpenAllData[i].add2, 
      agegroup: leadOpenAllData[i].agegroup, 
      area: leadOpenAllData[i].area, 
      assignedTo: leadOpenAllData[i].assignedTo, 
      cameAs: leadOpenAllData[i].cameAs, 
      companyname: leadOpenAllData[i].companyname, 
      country: leadOpenAllData[i].country, 
      createdBy: leadOpenAllData[i].createdBy, 
      createdDate: leadOpenAllData[i].createdDate, 
      cusEmail: leadOpenAllData[i].cusEmail, 
      cusgroup: leadOpenAllData[i].cusgroup, 
      customermob: leadOpenAllData[i].customermob, 
      dealDescription: leadOpenAllData[i].dealDescription, 
      district: leadOpenAllData[i].district, 
      gender: leadOpenAllData[i].gender, 
      headcount: leadOpenAllData[i].headcount, 
      lastFollowupDate: leadOpenAllData[i].lastFollowupDate, 
      maxbudget: leadOpenAllData[i].maxbudget, 
      pincode: leadOpenAllData[i].pincode, 
      purchasePlan: leadOpenAllData[i].purchasePlan, 
      refferal: leadOpenAllData[i].refferal, 
      state: leadOpenAllData[i].state, 
      storecode: leadOpenAllData[i].storecode, 
      traceId: leadOpenAllData[i].traceId, 
      updatedBy: leadOpenAllData[i].updatedBy, 
      updatedDate: leadOpenAllData[i].updatedDate));
    
  }
  notifyListeners();
   final Database db = (await DBHelper.getInstance())!;
   log("leadopendb: " + leadopendb.length.toString());
    await DBOperation.insertopenleadMaster(leadopendb, db);
    notifyListeners();
}
  // call summary api
  List<SummaryLeadData> leadSummaryOpen = [];
  List<SummaryLeadData> leadSummaryWon = [];
  List<SummaryLeadData> leadSummaryLost = [];

  List<SummaryLeadData> get getleadSummaryOpen => leadSummaryOpen;
  List<SummaryLeadData> get getleadSummaryWon => leadSummaryWon;
  List<SummaryLeadData> get getleadSummaryLost => leadSummaryLost;

  callSummaryApi() async {
    leadSummaryOpen.clear();
    leadSummaryWon.clear();
    leadSummaryLost.clear();
    lottie='';
    // openlea();
    await GetLeadSummaryApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadSummaryheader != null) {
          mapValuesSummary(value.leadSummaryheader!.leadSumarydata!);
          isbool=false;
          notifyListeners();
        } else if (value.leadSummaryheader == null) {
           datagotByApi = true;
           lottie='Assets/no-data.png';
          leadCheckDataExcep = 'No Leads..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
         isbool=false;
          datagotByApi = true;
          lottie='';
        leadCheckDataExcep =
            'Some thing went wrong \n${value.message} ${value.exception}..!!';
            notifyListeners();
      } else if (value.stcode == 500) {
         isbool=false;
          datagotByApi = true;
            lottie='Assets/NetworkAnimation.json';
        leadCheckDataExcep =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
     notifyListeners();
      }
      notifyListeners();
    });
  }

  mapValuesSummary(List<SummaryLeadData> leadcheckdata) {
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status == "Open") {
        leadSummaryOpen.add(SummaryLeadData(
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            btg: leadcheckdata[i].btg,
            column: leadcheckdata[i].column));
      } else if (leadcheckdata[i].Status == "Won") {
        leadSummaryWon.add(SummaryLeadData(
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            btg: leadcheckdata[i].btg,
            column: leadcheckdata[i].column));
      } else if (leadcheckdata[i].Status == "Lost") {
        leadSummaryLost.add(SummaryLeadData(
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            btg: leadcheckdata[i].btg,
            column: leadcheckdata[i].column));
      }
    }
    datagotByApi = true;
    notifyListeners();
  }

  /////  for fialog
  String isSelectedFollowUp = '';
  String get getisSelectedFollowUp => isSelectedFollowUp;
  String isSelectedFollowUpcode='';
  String get getisSelectedFollowUpcode => isSelectedFollowUpcode;
  selectFollowUp(String selected,String selectcode) {
    isSelectedFollowUp = selected;
    isSelectedFollowUpcode=selectcode;
    notifyListeners();
  }

  bool updateFollowUpDialog = false;
  bool get getupdateFollowUpDialog => updateFollowUpDialog;
  bool leadForwarddialog = false;
  bool get getleadForwarddialog => leadForwarddialog;
  bool leadWondialog = false;
  bool get getleadWondialog => leadWondialog;
  bool leadLostdialog = false;
  bool get getleadLostdialog => leadLostdialog;
  bool leadLoadingdialog = false;
  bool get getleadLoadingdialog => leadLoadingdialog;
  bool updateFollowUpdialog = false;
  bool get getupdateFollowUpdialog => updateFollowUpdialog;
  bool viewDetailsdialog = false;
  bool get getviewDetailsdialog => viewDetailsdialog;
  bool updateConvertToQuatationUpdialog = false;
  bool get getupdateConvertToQuatationUpdialog =>
      updateConvertToQuatationUpdialog;

  printLogic2() {
    log("updateFollowUpDialog: ${updateFollowUpDialog}");
    log("leadForwarddialog: ${leadForwarddialog}");
    log("leadLoadingdialog: ${leadLoadingdialog}");
    log("viewDetailsdialog: ${viewDetailsdialog}");
    log("forwardSuccessMsg: ${forwardSuccessMsg}");
  }

  changetoFolloweUp() {
    updateFollowUpDialog = true;
    notifyListeners();
  }

  String apiFDate = '';
  String nextFD = '';
  String get getnextFD => nextFD;

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
      VisitTime='';
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

  String apiWonFDate = '';
  String nextWonFD = '';
   String apiwonpurchaseDate = '';
  String nextpurchasedate = '';
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


  void showpurchaseupateDate(BuildContext context) {
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
      apiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiWonFDate);

      nextpurchasedate = chooseddate;
      notifyListeners();
    });
  }

  String apiQuaDate = '';
  String quataDate = '';
  String get getQuataDate => quataDate;

  void showQuatationDate(BuildContext context) {
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
      apiQuaDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiQuaDate);

      quataDate = chooseddate;
      notifyListeners();
    });
  }

  String apiforwardNextFollowUPDate = '';
  String forwardnextWonFD = '';
  String get getforwardnextWonFD => forwardnextWonFD;
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
      forwaVisitTime='';
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

  resetValuesIS1() async {
    final Database db = (await DBHelper.getInstance())!;
    isSelectedFollowUp = '';
    nextFD = '';
    updateFollowUpDialog = false;
    leadForwarddialog = false;
    leadWondialog = false;
    leadLostdialog = false;
    nextpurchasedate='';
    leadLoadingdialog = false;
    valueChosedReason = null;
    valueChosedStatus = null;
    valueChosedStatusWon = null;
    viewDetailsdialog = false;
    forwardSuccessMsg = '';
    caseStatusSelected = '';
    selectedUserList = '';
    forwardnextWonFD = '';
    forwaVisitTime='';
    iscorectime=false;
    iscorectime2=false;
    hinttextforOpenLead = 'Select Status:* ';
    hinttextforWonLead = 'Select Status:* ';
    hinttextforLostLead = 'Select Reason*';
    feedbackLead = 'Feed back:';
    nextFollowupDate = 'Next Follow up:*';
    mycontroller[1].clear();
    mycontroller[0].clear();
    mycontroller[2].clear();
    mycontroller[5].clear();
    selectedUserList='';

    hinttextforWonLead = "Select Status:*";
    hinttextforLostLead = "Select Status:*";
    hinttextforOpenLead = "Select Status:*";
    orderBillRefer = 'Order/Bill Reference*';
    feedbackLead = 'Give your feedback*';
    nextFollowupDate = 'Next Follow up:*';
    orderBillDate = 'Order/Bill Date:*';
    followup = 'How you made the follow up?*';
    forwardNextFollowDate = 'Next FollowUp:*';
    assignVisitTime='FollowUp Time*';
    leadOpenSaveClicked = false;
    leadWonSaveClicked = false;
    leadLostSaveClicked = false;
    nextWonFD = '';
    quataDate = '';
    userLtData = await DBOperation.getUserList(db);
     filteruserLtData = userLtData;
    setForwardDataList();
   
    
    notifyListeners();
  }

  // resetValuesISnot1() async {
  //   isSelectedFollowUp = '';
  //   nextFD = '';
  //   updateFollowUpDialog = false;
  //   leadForwarddialog = false;
  //   leadWondialog = false;
  //   leadLostdialog = false;
  //   leadLoadingdialog = false;
  //   valueChosedReason = null;
  //   valueChosedStatus = null;
  //   valueChosedStatusWon = null;
  //   viewDetailsdialog = true;
  //   forwardSuccessMsg = '';
  //   caseStatusSelected = '';
  //   selectedUserList = '';
  //   forwardnextWonFD = '';
  //   hinttextforOpenLead = 'Select Status: ';
  //   hinttextforWonLead = 'Select Status: ';
  //   hinttextforLostLead = 'Select Reason';
  //   feedbackLead = 'Feed back:';
  //   nextFollowupDate = 'Next Follow up:';
  //   mycontroller[1].clear();
  //   mycontroller[0].clear();
  //   mycontroller[2].clear();
  //   hinttextforWonLead = "Select Status:";
  //   hinttextforLostLead = "Select Status:";
  //   hinttextforOpenLead = "Select Status:";
  //   orderBillRefer = 'Order/Bill Reference';
  //   feedbackLead = 'Give your feedback';
  //   nextFollowupDate = 'Next Follow up:';
  //   orderBillDate = 'Order/Bill Date:';
  //   followup = 'How you made the follow up?';
  //   forwardNextFollowDate = 'Next FollowUp';
  //   leadOpenSaveClicked = false;
  //   leadWonSaveClicked = false;
  //   leadLostSaveClicked = false;
  //   nextWonFD = '';
  //   userLtData = await dbHelper.getUserList();
  //   notifyListeners();
  // }

  // for dialog
  String? valueChosedReason; //cl
  String? get getvalueChosedReason => valueChosedReason;
  String? valueChosedStatus; //cl
  String? get getvalueChosedStatus => valueChosedStatus;
  String? valueChosedStatusWon; //cl
  String? get getvalueChosedStatusWon => valueChosedStatusWon;
  List<String> data = ['', 'a'];

  String? hinttextforOpenLead = 'Select Status*: '; //cl
  String? get gethinttextforOpenLead => hinttextforOpenLead;
  String? hinttextforWonLead = 'Select Status*: '; //cl
  String? get gethinttextforWonLead => hinttextforWonLead;
  String? hinttextforLostLead = 'Select Reason*'; //cl
  String? get gethinttextforLostLead => hinttextforLostLead;
  String? feedbackLead = 'Give your feedback*'; //cl Give your feedback
  String? get getfeedbackLead => feedbackLead;
  String? nextFollowupDate = 'Next Follow up Date:*'; //cl
  String? get getnextFollowupDate => nextFollowupDate;
  String? orderBillRefer = 'Order/Bill Reference*'; //cl
  String? get getorderBillRefer => orderBillRefer;
  String? orderBillDate = 'Order/Bill Date:*'; //cl
  String? get getorderBillDate => orderBillDate;
  String? followup =
      'How you made the follow up?*'; //cl How the follow up has been made
  String? get getfollowup => followup;
  String? forwardNextFollowDate = 'Next Followup:*'; //cl
  String? get getforwardNextFollowDate => forwardNextFollowDate;
  //
  String? textquatationDate = 'Quatation Date'; //cl
  String? get gettextquatationDate => textquatationDate;
  String? textquatationNo = 'Quatation No'; //cl
  String? get gettextquatationNo => textquatationNo;
  String? textquatationValue = 'Quatation Value'; //cl
  String? get gettextquatationValue => textquatationValue;

  choosedReason(String val) {
    valueChosedReason = val;
    notifyListeners();
  }

  converToQuatation() {
    updateFollowUpDialog = false;
    leadForwarddialog = false;
    leadLoadingdialog = false;
    viewDetailsdialog = false;
    updateConvertToQuatationUpdialog = true;
    forwardSuccessMsg = "";
    isSameBranch = false;
    notifyListeners();
  }

  choosedStatus(String val) {
    log("val::"+val.toString());
    valueChosedStatus = val;
    notifyListeners();
  }

  choosedStatusWon(String val) {
    valueChosedStatusWon = val;
    notifyListeners();
  }

  String caseStatusSelected = ''; //cl
  String? get getcaseStatusSelected => caseStatusSelected;
  String caseStatusSelectedcode = ''; //cl
  String? get getcaseStatusSelectedcode => caseStatusSelectedcode;
  String emptyQuataDate = ''; //cl
  String? get getemptyQuataDate => emptyQuataDate;

  caseStatusSelectBtn(String val,String code) {
    caseStatusSelected = val;
    caseStatusSelectedcode=code;
    log("caseStatusSelected::"+caseStatusSelected.toString());
     log("caseStatusSelectedcode::"+caseStatusSelectedcode.toString());
    notifyListeners();
  }

  ///get lead status api
  List<GetLeadStatusData> leadStatusOpen = [];
  List<GetLeadStatusData> leadStatusLost = [];
  List<GetLeadStatusData> leadStatusWon = [];
  List<GetLeadStatusData> get getleadStatusOpen => leadStatusOpen;
  List<GetLeadStatusData> get getleadStatusLost => leadStatusLost;
  List<GetLeadStatusData> get getleadStatusWon => leadStatusWon;

  /// gget user list frpm db

  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
  

  String selectedUserList = '';
  String get getselectedUserList => selectedUserList;
  List<String> openlead = [];
  List<String> get getopenlead => openlead;
  List<String> wonlead = [];
  List<String> get getwonlead => wonlead;
  List<String> lostlead = [];
  List<String> get getlostlead => lostlead;

  getLeadStatus() async {
    leadStatusOpen.clear();
    leadStatusWon.clear();
    leadStatusLost.clear();
    final Database db = (await DBHelper.getInstance())!;
    leadStatusOpen = await DBOperation.getLeadStatusOpen(db);
    leadStatusLost = await DBOperation.getLeadStatusLost(db);
    // log("leadStatusOpen:" + leadStatusOpen[0].name.toString());
    leadStatusWon = await DBOperation.getLeadStatusWon(db);
    userLtData = await DBOperation.getUserList(db);
    filteruserLtData = userLtData;
    setForwardDataList();
   

    notifyListeners();
  }

  openlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusOpen.length; i++) {
      var openleadcode = leadStatusOpen[i].code!;
      openlead = leadStatusOpen[i].name!.split(',');
      //  return openlead[i];
      log("openlea" + openlead[i].toString());
      notifyListeners();
    }
    notifyListeners();
  }

  wonlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusWon.length; i++) {
      var wonleadcode = leadStatusWon[i].code!;
      wonlead = leadStatusWon[i].name!.split(',');

      log("openlea" + openlead[i].toString());
    }

    notifyListeners();
  }

  lostlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusLost.length; i++) {
      var lostleadcode = leadStatusLost[i].code!;
      lostlead = leadStatusLost[i].name!.split(',');
      // return openlead[i];
      log("openlea" + openlead[i].toString());
      notifyListeners();
    }
    notifyListeners();
  }

  getSelectedUserSalesEmpId(int i) {
    selectedUserList = filteruserLtData[i].userCode.toString();
    log("selectedUserList::"+selectedUserList.toString());
    selectUser(i);
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
    leadForwarddialog = !leadForwarddialog;
    notifyListeners();
  }

  viweDetailsClicked() {
    viewDetailsdialog = !viewDetailsdialog;
    notifyListeners();
  }
  //callGetLeadDeatilsApi();

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  bool leadOpenSaveClicked = false;
  bool leadWonSaveClicked = false;
  bool leadLostSaveClicked = false;

  clickLeadSaveBtn(String followDocEntry, String leadDocEntry,String purchasedate) {
    if (caseStatusSelected == 'Open') {
      leadOpenSaveClicked = true;
      leadWonSaveClicked = false;
      leadLostSaveClicked = false;
      log("followDocEntry: $followDocEntry");
      log("leadDocEntry: $leadDocEntry");

      callRequiredOpen(followDocEntry,leadDocEntry,purchasedate);
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
String errorVisitTime = "";
 String VisitTime = '';
 String forwarderrorVisitTime = "";
 String forwaVisitTime = '';
  String get getVsitTime => VisitTime;
  callRequiredOpen(String followDocEntry,String leadDocEntry,String purchasedate) {
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
     if (VisitTime == '') {
      i = i + 1;
      nextVisitTime = 'Followup Time: *';
     } else {
      nextVisitTime = 'Followup Time:*';
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
      Allfollowupupdate(followDocEntry,leadDocEntry, mycontroller[1].text, apiFDate,"", "","","",purchasedate);
    
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

      orderBillRefer = 'Order/Bill Reference: *';
    } else {
      orderBillRefer = 'Order/Bill Reference:*';
    }
    if (mycontroller[1].text.isEmpty) {
      i = i + 1;
      print("2");
feedbackLead = 'Give your feedback *';
      // orderBillRefer = 'Order/Bill Reference: *';
    } else {
     feedbackLead = 'Give your feedback*';
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
      followup = 'How you made the follow up? *';
    } else {
      followup = 'How you made the follow up?*';
    }
    
    nextFollowupDate = 'Next Follow up:*';
    hinttextforLostLead = 'Select Reason:*';
    hinttextforOpenLead = "Select Status:*";
    print(i);
    if (i < 1) {
      print("ssssss");
      Allfollowupupdate(followDocEntry,leadDocEntry, mycontroller[1].text, "",apiWonFDate, mycontroller[0].text,'',"",'');
      
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
Allfollowupupdate(followDocEntry,leadDocEntry, mycontroller[1].text, "","", "","","",'');
     
      // lostSave(followDocEntry, leadDocEntry, valueChosedReason,
      //     mycontroller[1].text, isSelectedFollowUp);
    }
    notifyListeners();
  }

  validatebtnChanged() {
    if (caseStatusSelected == "Open") {
      if (leadOpenSaveClicked == true) {
        hinttextforOpenLead = "Select Status: *";
        feedbackLead = 'Give your feedback *';
        nextFollowupDate = 'Next Follow up: *';
        followup = 'How you made the follow up? *';
        nextVisitTime='Followup Time: *';
      } else {
        hinttextforOpenLead = "Select Status:";
        feedbackLead = 'Give your feedback*';
        nextFollowupDate = 'Next Follow up:*';
        followup = 'How you made the follow up?*';
        nextVisitTime='Followup Time:*';
      }
    } else {}

    if (caseStatusSelected == "Won") {
      if (leadWonSaveClicked == true) {
        hinttextforWonLead = "Select Status: *";
        orderBillRefer = 'Order/Bill Reference *';
         feedbackLead = 'Give your feedback *';
        followup = 'How you made the follow up? *';
      } else {
        hinttextforWonLead = "Select Status:*";
        orderBillRefer = 'Order/Bill Reference*';
        feedbackLead = 'Give your feedback*';
        nextFollowupDate = 'Next Follow up:*';
        followup = 'How you made the follow up?*';
      }
      nextFD = '';
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
      nextWonFD = '';
    } else {}
    notifyListeners();
  }

  convertToQuatatioMethod() {
    print("${mycontroller[3].text}"); //Quata No
    print("${mycontroller[4].text}"); //Quata Value
    print("${apiQuaDate}");
    if (mycontroller[3].text.trim().isNotEmpty &&
        mycontroller[4].text.trim().isNotEmpty &&
        apiQuaDate.isNotEmpty) {
      // textquatationDate = '';
      // textquatationNo = '';
      // textquatationValue = '';
      Get.toNamed(ConstantRoutes.quatation);
      notifyListeners();
    } else {
      //
      if (apiQuaDate.isEmpty) {
        // emptyQuataDate = "required field..!!";
        textquatationDate = 'Quatation Date*';
        notifyListeners();
      }
      //
      if (mycontroller[3].text.trim().isEmpty) {
        textquatationNo = 'Quatation No*';
        notifyListeners();
      }
      //
      if (mycontroller[4].text.trim().isEmpty) {
        textquatationValue = 'Quatation Value*';
        notifyListeners();
      }
      //
      emptyQuataDate = "";
      notifyListeners();
    }
    //quatation Data
    notifyListeners();
  }

  ///cal forwardApi
  String forwardSuccessMsg = '';
  String get getforwardSuccessMsg => forwardSuccessMsg;
  String forwardSuccessMsgtype = '';
  String get getforwardSuccessMsgtype => forwardSuccessMsgtype;

  forwardApi(String followDocEntry, int salesPersonEmpId) async {
    notifyListeners();
    if (forwardnextWonFD.isEmpty) {
      //selectedUserList
      forwardNextFollowDate = 'Next Followup*';
      notifyListeners();
    } else {
      forwardSuccessMsg = '';
      leadLoadingdialog = true;
      ForwardLeadUserData forwardLeadUserData = new ForwardLeadUserData();
      forwardLeadUserData.curentDate = config.currentDateOnly();
      forwardLeadUserData.nextFD = apiforwardNextFollowUPDate;
      forwardLeadUserData.nextUser = salesPersonEmpId;
      await ForwardLeadUserApi.getData(followDocEntry, forwardLeadUserData)
          .then((value) {
        if (value.stCode >= 200 && value.stCode <= 210) {
          forwardSuccessMsg = 'Successfully Forwarded..!!';
          leadLoadingdialog = false;
          notifyListeners();
        } else if (value.stCode >= 400 && value.stCode <= 410) {
          forwardSuccessMsg = value.error!;
          leadLoadingdialog = false;
          notifyListeners();
        } else if (value.stCode == 500) {
          forwardSuccessMsg = '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
          leadLoadingdialog = false;
          notifyListeners();
        }
      });
      checkValues();
    }
  }
   clearbool(){
  visitDt='';
  VisitTime='';
  errorVisitTime='';
  notifyListeners();
 }
 String visitDt = '';
 String? nextVisitTime = 'Followup Time:';
  String? get getnextVisitTime => nextVisitTime;
  String? assignvisitDt='';
String? assignVisitTime = 'Followup Time:';
  String? get getassignVisitTime => assignVisitTime;
 bool iscorectime=false;
   selectVisitTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay   startTime = TimeOfDay(hour: 7, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0); 
    if (nextFD.isNotEmpty) {
      errorVisitTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );
      
      if (newTime != null) {
        timee = newTime;
//          if (timee.hour < startTime.hour ||
//               timee.hour > endTime.hour || (timee.hour == endTime.hour && timee.minute > endTime.minute)) {
//                 VisitTime = "";
//  iscorectime=true;
//             nextVisitTime = 'Followup Time:*';
//             notifyListeners();
//               }else{

            log("date::"+DateFormat('dd-MM-yyyy').format(DateTime.now()));
        if (nextFD ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute)) {
            errorVisitTime = "Please Choose Correct Time";
            VisitTime = "";
             iscorectime=true;
            notifyListeners();
            print("error");
          } else {
            errorVisitTime = "";
            print("correct11");
             iscorectime=false;
            VisitTime = timee.format(context).toString();
          }
        } else {
          errorVisitTime = "";
          print("correct22");
          timee = newTime;
           iscorectime=false;
          VisitTime = timee.format(context).toString();
        }
 nextVisitTime = 'Followup Time';
        notifyListeners();
    // }
      }
       
      notifyListeners();
    } else {
      VisitTime = "";
      errorVisitTime = "Please Choose First Date";
       iscorectime=true;
      notifyListeners();
    }
    notifyListeners();
  }
bool iscorectime2=false;
  forwardVisitTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay   startTime = TimeOfDay(hour: 7, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0); 
    if (forwardnextWonFD.isNotEmpty) {
      forwarderrorVisitTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );
      
      if (newTime != null) {
        timee = newTime;

//           if (timee.hour < startTime.hour ||
//               timee.hour > endTime.hour || (timee.hour == endTime.hour && timee.minute > endTime.minute)) {
//                 forwaVisitTime = "";
//  iscorectime2=true;
//             assignVisitTime = 'Followup Time:*';
//             notifyListeners();
//               }else{
log("DATTTA::"+DateFormat('dd-MM-yyyy').format(DateTime.now()));

log("DATTTA222::"+forwardnextWonFD.toString());

             
        if (forwardnextWonFD ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute)) {
            forwarderrorVisitTime = "Please Choose Correct Time";
            forwaVisitTime = "";
            iscorectime2=true;
            notifyListeners();
            print("error");
          } else {
            errorVisitTime = "";
            print("correct11");
            iscorectime2=false;
            forwaVisitTime = timee.format(context).toString();
          }
        } else {
          errorVisitTime = "";
          print("correct22");
          timee = newTime;
           iscorectime2=false;
          forwaVisitTime = timee.format(context).toString();
        }
//  }
        notifyListeners();
      }
      notifyListeners();
    } else {
      VisitTime = "";
      forwarderrorVisitTime = "Please Choose First Date";
      iscorectime2=true;
      notifyListeners();
    }
    notifyListeners();
  }
 
 Allfollowupupdate(String followDocEntry,String leadDocEntry, feedback, nextFPdate,billwonDate, billreference,String salesPersonEmpId,String checkstatus,purchasedate) async {
    log("purchasedate:::"+purchasedate.toString());
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    String? reasondetails;
    ForwardLeadUserDataOpen forwardLeadUserDataOpen =
        new ForwardLeadUserDataOpen();
        log("valueChosedStatus::"+valueChosedStatus.toString());
    if(caseStatusSelected == "Open"){
 for(int i=0;i<leadStatusOpen.length;i++){
  if(leadStatusOpen[i].code==valueChosedStatus){
reasondetails=leadStatusOpen[i].name;
log("reasondetails::"+reasondetails.toString());
  }
  notifyListeners();
 }
  if(VisitTime != ''){
      Config config=Config();

forwardLeadUserDataOpen.nextFD=
config.alignDateforFollow(VisitTime,nextFPdate);
 
    }else{
forwardLeadUserDataOpen.nextFD = nextFPdate;
    }
    forwardLeadUserDataOpen.visitdate=null;
    forwardLeadUserDataOpen.curentDate = config.currentDate();
    forwardLeadUserDataOpen.ReasonCode = valueChosedStatus;
    forwardLeadUserDataOpen.Reasoname=reasondetails;
    forwardLeadUserDataOpen.Purchasedate=nextpurchasedate==null||nextpurchasedate==''||nextpurchasedate.isEmpty?purchasedate:apiwonpurchaseDate;
    forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;
    
    forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
    forwardLeadUserDataOpen.feedback = feedback;
    forwardLeadUserDataOpen.status=caseStatusSelectedcode;
    notifyListeners();
    }
    else if(caseStatusSelected == "Won"){
       for(int i=0;i<leadStatusWon.length;i++){
  if(leadStatusWon[i].code==valueChosedStatusWon){
reasondetails=leadStatusWon[i].name;
log("reasondetails::"+reasondetails.toString());
  }
  notifyListeners();
 }

    forwardLeadUserDataOpen.ReasonCode = valueChosedStatusWon;
    forwardLeadUserDataOpen.Reasoname=reasondetails;
    forwardLeadUserDataOpen.billDate = billwonDate;
    forwardLeadUserDataOpen.billRef = billreference;
    forwardLeadUserDataOpen.curentDate = config.currentDate();
    forwardLeadUserDataOpen.feedback = feedback;
   forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;
    forwardLeadUserDataOpen.nextFD = null;
    forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
     forwardLeadUserDataOpen.status=caseStatusSelectedcode;
     notifyListeners();

    }else if(caseStatusSelected == "Lost"){
      for(int i=0;i<leadStatusLost.length;i++){
  if(leadStatusLost[i].code==valueChosedReason){
reasondetails=leadStatusLost[i].code;
log("reasondetails::"+reasondetails.toString());
  }
  notifyListeners();
 }
  forwardLeadUserDataOpen.ReasonCode = valueChosedReason;
    forwardLeadUserDataOpen.Reasoname=reasondetails;
    forwardLeadUserDataOpen.curentDate = config.currentDate();
    forwardLeadUserDataOpen.feedback = feedback;
   forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;
    forwardLeadUserDataOpen.nextFD = null;
    forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
     forwardLeadUserDataOpen.status=caseStatusSelectedcode;
     notifyListeners();
    }else {
       
    
 
    
    
for(int i=0;i<leadStatusOpen.length;i++){
  if(leadStatusOpen[i].name==checkstatus){
reasondetails=leadStatusOpen[i].code;
log("reasondetails::"+reasondetails.toString());
  }
  
  notifyListeners();
 }
    Config config=Config();

forwardLeadUserDataOpen.nextFD=
config.alignDateforFollow(forwaVisitTime,apiforwardNextFollowUPDate);
    forwardLeadUserDataOpen.ReasonCode =reasondetails==null||reasondetails.isEmpty? leadStatusOpen[0].code:reasondetails;
    forwardLeadUserDataOpen.Reasoname=reasondetails==null||reasondetails.isEmpty?leadStatusOpen[0].name:checkstatus;
 forwardLeadUserDataOpen.status="01";
 forwardLeadUserDataOpen.curentDate = config.currentDate();
    
      forwardLeadUserDataOpen.nextUser = salesPersonEmpId;
      notifyListeners();
      
    }
   

   
    await AllSaveLeadApi.getData(leadDocEntry, forwardLeadUserDataOpen)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = "${value.error!}";
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = "${value.error!}..!!${value.stCode}..!!";
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg = "${value.stCode!}..!!Network Issue..\nTry again Later..!!";
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }
  // openSave(String followDocEntry, status, feedback, nextFPdate) async {
  //   forwardSuccessMsg = '';
  //   leadLoadingdialog = true;
  //   leadForwarddialog = true;
  //   updateFollowUpDialog = false;
  //   ForwardLeadUserDataOpen forwardLeadUserDataOpen =
  //       new ForwardLeadUserDataOpen();
  //   forwardLeadUserDataOpen.curentDate = config.currentDateOnly();
  //   forwardLeadUserDataOpen.ReasonCode = valueChosedStatus;
  //   forwardLeadUserDataOpen.followupMode = isSelectedFollowUp;
  //   forwardLeadUserDataOpen.nextFD = nextFPdate;
  //   forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
  //   forwardLeadUserDataOpen.feedback = feedback;
  //   notifyListeners();

  //   //OpenSaveLeadApi.printjson(followDocEntry,forwardLeadUserDataOpen);
  //   await OpenSaveLeadApi.getData(followDocEntry, forwardLeadUserDataOpen)
  //       .then((value) {
  //     if (value.stCode >= 200 && value.stCode <= 210) {
  //       forwardSuccessMsg = 'Successfully Saved..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else if (value.stCode >= 400 && value.stCode <= 410) {
  //       forwardSuccessMsg = value.error!.message!.value!;
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else if (value.stCode == 500) {
  //       forwardSuccessMsg = 'Some thing went wrong try agin..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     }
  //   });
  //   checkValues();
  // }

  WonSave(followDocEntry, String leadDocEntry, status, feedback, followup,
      billwonDate, billreference) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
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

    //WonSaveLeadApi.prinjson( followDocEntry,forwardLeadUserDataWon);
    await WonSaveLeadApi.getData(followDocEntry, forwardLeadUserDataWon)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
        // callCloseApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = "Some thing went wrong try agin..!!";
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg = '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }

  lostSave(followDocEntry, String leadDocEntry, reason, feedback,
      followupMode) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
    ForwardLeadUserDataLost forwardLeadUserDataLost =
        new ForwardLeadUserDataLost();

    forwardLeadUserDataLost.ReasonCode = reason;
    forwardLeadUserDataLost.curentDate = config.currentDateOnly();
    forwardLeadUserDataLost.feedback = feedback;
    forwardLeadUserDataLost.followupMode = followupMode;
    forwardLeadUserDataLost.nextFD = null;
    forwardLeadUserDataLost.updatedBy = ConstantValues.slpcode;

    //LostSaveLeadApi.prinjson(followDocEntry,forwardLeadUserDataLost);

    await LostSaveLeadApi.getData(followDocEntry, forwardLeadUserDataLost)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
        // callCancelApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = "Some thing went wrong try agin..!!";
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg = '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }

  showMsgDialog() {
    forwardSuccessMsg = 'hello';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
  }

  // callCloseApi(String leadDocEntry) async {
  //   await CloseLeadApi.getData(leadDocEntry).then((value) {
  //     if (value.stCode >= 200 && value.stCode <= 210) {
  //       forwardSuccessMsg = 'Successfully Saved..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else if (value.stCode >= 400 && value.stCode <= 490) {
  //       forwardSuccessMsg = '${value.error!.message}';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else {
  //       forwardSuccessMsg = 'Something wemt wrong..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  // callCancelApi(String leadDocEntry) async {
  //   await CancelLeadApi.getData(leadDocEntry).then((value) {
  //     if (value.stCode >= 200 && value.stCode <= 210) {
  //       forwardSuccessMsg = 'Successfully Saved..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else if (value.stCode >= 400 && value.stCode <= 490) {
  //       forwardSuccessMsg = 'Something wemt wrong..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else {
  //       forwardSuccessMsg = 'Something wemt wrong..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     }
  //   });
  // }

 List< GetLeadDeatilsQTHData>? leadDeatilsQTHData=[];
  List<GetLeadDeatilsQTHData>? get getleadDeatilsQTHData => leadDeatilsQTHData;

  List<GetLeadQTLData> leadDeatilsQTLData = [];
  List<GetLeadQTLData> get getleadDeatilsQTLData => leadDeatilsQTLData;

  List<GetLeadDeatilsLData> leadDeatilsLData = [];
  List<GetLeadDeatilsLData> get getleadDeatilsLeadData => leadDeatilsLData;
List<GetLeadopenData> leadopendata=[];
List<GetLeadopenData> get getleadopendata=>leadopendata;
 List<GetLeadPhoneData> leadphonedata=[];
  List<GetLeadPhoneData> get getleadphonedata=>leadphonedata;
callinitApi()async{
   await GetLeadopenApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
       leadopendata=value.leadopendata!;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
       leadCheckDataExcep="Something went wrong";
        notifyListeners();
      } else {
       leadCheckDataExcep="${value.stcode!}..!!Network Issue..\nTry again Later..!!";
        
        notifyListeners();
      }
    });
     await GetLeadphoneApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadphonedata=value.leadphonedata!;
       
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
       leadCheckDataExcep="No data..!!";
        notifyListeners();
      } else {
      leadCheckDataExcep="${value.stcode!}..!!Network Issue..\nTry again Later..!!";
        notifyListeners();
      }
    });
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
  callGetLeadDeatilsApi(String leadDocEnt) async {
    leadDeatilsQTHData!.clear();
     leadDeatilsQTLData.clear();
      leadDeatilsLData.clear();
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
    await GetLeadQTHApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if(value.leadDeatilheadsData !=null ){
 leadDeatilsQTHData = value.leadDeatilheadsData!.leadcheckQTHdata!;
 leadDeatilsQTLData = value.leadDeatilheadsData!.leadDeatilsQTLData!;
if(value.leadDeatilheadsData!.leadDeatilsLeadData !=null){
leadDeatilsLData = value.leadDeatilheadsData!.leadDeatilsLeadData!;

// log("leadDeatilsLData::"+leadDeatilsLData[4].Feedback.toString());
}

leadLoadingdialog = false;
        leadForwarddialog = false;
        updateFollowUpDialog = false;
        viewDetailsdialog = true;
        notifyListeners();
 
        
       
        }
       
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardSuccessMsg = '${value.message}..!!${value.exception}..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

   
    
  }

  ///
  static int comeFromEnq = -1;
  static int isanyExcep = 0;
  static bool isSameBranch = true;
  bool get getisSameBranch => isSameBranch;

  mapValuestoorder(GetAllLeadData leadOpenAllData) {
    // log("AAAAA" + ind.toString());
    OrderNewController.datafromlead.clear();
    log("leadOpenAllData[ind].City!::"+leadOpenAllData.City!.toString());
    // OrderNewController.datafromlead.add(leadOpenAllData[ind].)
    OrderNewController.datafromlead.add(leadOpenAllData.Mobile!);
    OrderNewController.datafromlead.add(leadOpenAllData.CustomerName!);
    OrderNewController.datafromlead.add(leadOpenAllData.add1!.toString());
    OrderNewController.datafromlead.add(leadOpenAllData.add2!.toString());
    OrderNewController.datafromlead.add(leadOpenAllData.pincode!.toString());
    OrderNewController.datafromlead.add(leadOpenAllData.City!.toString()); //isSelectedCsTag
    OrderNewController.datafromlead.add(leadOpenAllData.LeadNum.toString());
    OrderNewController.datafromlead.add(leadOpenAllData.cusEmail.toString());
    OrderNewController.datafromlead.add(leadOpenAllData.state.toString());
    OrderNewController.datafromlead.add(leadOpenAllData.cusgroup.toString());
    
    OrderNewController.datafromlead.add(leadOpenAllData.area.toString());
    OrderNewController.datafromlead.add(leadOpenAllData.OrderType.toString());

OrderBookNewState.iscomfromLead = true;
          Get.toNamed(ConstantRoutes.ordernew);
          notifyListeners();
   
  }
mapValuestoquotes(GetAllLeadData leadOpenAllData) {
    // log("AAAAA" + ind.toString());
    NewquoteController.datafromlead.clear();
    log("leadOpenAllData[ind].City!::"+leadOpenAllData.City!.toString());
    // OrderNewController.datafromlead.add(leadOpenAllData[ind].)
    NewquoteController.datafromlead.add(leadOpenAllData.Mobile!);
    NewquoteController.datafromlead.add(leadOpenAllData.CustomerName!);
    NewquoteController.datafromlead.add(leadOpenAllData.add1!.toString());
    NewquoteController.datafromlead.add(leadOpenAllData.add2!.toString());
    NewquoteController.datafromlead.add(leadOpenAllData.pincode!.toString());
    NewquoteController.datafromlead.add(leadOpenAllData.City!.toString()); //isSelectedCsTag
    NewquoteController.datafromlead.add(leadOpenAllData.LeadNum.toString());
    NewquoteController.datafromlead.add(leadOpenAllData.cusEmail.toString());
    NewquoteController.datafromlead.add(leadOpenAllData.state.toString());
    NewquoteController.datafromlead.add(leadOpenAllData.cusgroup.toString());
    
    NewquoteController.datafromlead.add(leadOpenAllData.area.toString());
    NewquoteController.datafromlead.add(leadOpenAllData.OrderType.toString());

QuoteNewState.iscomfromLead = true;
          Get.toNamed(ConstantRoutes.quotesnew);
          notifyListeners();
   
  }
  SearchFilterOpenTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterleadOpenAllData = leadOpenAllData
          .where((e) =>
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Product!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .LeadNum!
                  .toInt()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .Value!
                  .toDouble()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .NextFollowup
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e).customermob.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterleadOpenAllData = leadOpenAllData;
      notifyListeners();
    }
  }

  SearchFilterWonTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterleadClosedAllData = leadClosedAllData
          .where((e) =>
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Product!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .LeadNum!
                  .toInt()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .Value!
                  .toDouble()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .NextFollowup
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e).customermob.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterleadClosedAllData = leadClosedAllData;
      notifyListeners();
    }
  }

  SearchFilterLostTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterleadLostAllData = leadLostAllData
          .where((e) =>
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Product!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .LeadNum!
                  .toInt()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .Value!
                  .toDouble()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .NextFollowup
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e).customermob.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterleadLostAllData = leadLostAllData;
      notifyListeners();
    }
  }

  setListData() {
    filterleadOpenAllData = leadOpenAllData;
    filterleadClosedAllData = leadClosedAllData;
    notifyListeners();
  }

  comeFromEnqApi(BuildContext context, String comeFromEnqdata) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    viewDetailsdialog = false;
    notifyListeners();
    //printLogic2();
    await GetLeadQTHApi.getData(comeFromEnqdata).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadDeatilheadsData != null) {
          leadDeatilsQTHData = value.leadDeatilheadsData!.leadcheckQTHdata!;
          leadDeatilsQTLData = value.leadDeatilheadsData!.leadDeatilsQTLData!;
        } else {
          isanyExcep = -2;
          forwardSuccessMsg = 'Some internal error..!!';
          leadLoadingdialog = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        isanyExcep = -2;
        forwardSuccessMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

    // await GetLeadQTLApi.getData(comeFromEnqdata).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if(value.leadDeatilsQTLData != null){
    //     leadDeatilsQTLData = value.leadDeatilsQTLData!;
    //     }
    //      else{
    //        isanyExcep = -2;
    //        forwardSuccessMsg = 'Some internal error..!!';
    //        leadLoadingdialog = false;
    //        notifyListeners();
    //     }
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     isanyExcep = -2;
    //     forwardSuccessMsg = 'Something went wrong try again!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   } else {
    //     isanyExcep = -2;
    //     forwardSuccessMsg = 'Something went wrong try again!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   }
    // });

    // await GetLeadDetailsLApi.getData(comeFromEnqdata).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if (value.leadDeatilsLeadData != null) {
    //       leadDeatilsLData = value.leadDeatilsLeadData!;
    //       leadLoadingdialog = false;
    //       leadForwarddialog = false;
    //       updateFollowUpDialog = false;
    //       viewDetailsdialog = true;
    //       notifyListeners();
    //     } else {
    //       isanyExcep = -2;
    //       forwardSuccessMsg = 'Some internal error..!!';
    //       leadLoadingdialog = false;
    //       notifyListeners();
    //     }
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     isanyExcep = -2;
    //     forwardSuccessMsg = 'Something went wrong try again!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   } else {
    //     isanyExcep = -2;
    //     forwardSuccessMsg = 'Something went wrong try again!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   }
    // });
    await showLeadDeatilsDialog(context);
    printLogic2();
  }

  mapValuesToEnq(BuildContext context) {
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].CardCode!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].CardName!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].Address1!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].Address2!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].Pincode!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].City!);
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.newEnq);
  }

  mapValuesToLead(BuildContext context) {
    LeadNewController.dataenq.add(leadDeatilsQTHData![0].CardCode!);
    LeadNewController.dataenq.add(leadDeatilsQTHData![0].CardName!);
    LeadNewController.dataenq.add(leadDeatilsQTHData![0].Address1!);
    LeadNewController.dataenq.add(leadDeatilsQTHData![0].Address2!);
    LeadNewController.dataenq.add(leadDeatilsQTHData![0].Pincode!);
    LeadNewController.dataenq.add(leadDeatilsQTHData![0].City!);
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.leads);
  }

  showLeadDeatilsDialog(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          updateFollowUpDialog = false;
          // context.read<LeadTabController>().resetValues();
          return FollowDialog(
            index: 0,
            leadopenalldata: leadOpenAllData[0],
          );
        }).then((value) {
      refershAfterClosedialog();
      callGetAllApi();
      // callSummaryApi();
    });
  }

  checkValues() {
    print("getupdateFollowUpDialog: " + getupdateFollowUpDialog.toString());
    print("getleadForwarddialog: " + getleadForwarddialog.toString());
    print("getleadLoadingdialog: " + getleadLoadingdialog.toString());
    print("getforwardSuccessMsg: " + getforwardSuccessMsg.toString());
  }
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

/// phone call -> Phone
/// sms/whats => Text
/// store  vist => Visit cj
/// other => Other
