// ignore_for_file: unnecessary_new
import 'dart:developer';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Controller/VisitplanController/NewVisitController.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/WarningDialog.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/successbox.dart';
import 'package:sellerkit/Services/PostQueryApi/ItemMasterApi/ItemCatagoryApi.dart';
import 'package:sellerkit/Services/createvisitplanApi/createpostvisitApi.dart';
import 'package:sellerkit/Services/createvisitplanApi/updatevisit.dart';
import 'package:sellerkit/Services/purposeofvisitApi/purposeofvisit.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/NewVisitModel/NewVisitModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
import '../../Models/purposeofvistModel/purposeofvisitmodel.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqCutomerDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Widgets/AlertDilog.dart';
import 'NewVisitController.dart';

class NewVisitplanController extends ChangeNotifier {
  Config config = new Config();
  init() async {
    clearData();
    await getvisitpurpose();
    await stateApicallfromDB();
    await catagoryApi();
   await getUserAssingData();
   await setdefaultUserName();
    // getDataMethod();
  }
 List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
  List<UserListData> filteruserLtData = [];
  List<UserListData> get getfiltergetuserLtData => filteruserLtData;
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
  int? selectedIdxFUser = null;
  String? getslpID;

  selectedAssignedUser() {
    mycontroller[19].text = userLtData[selectedIdxFUser!].UserName!;
    notifyListeners();
  }
  setUserdata() {
//   for(int i=0;i<userLtData.length;i++){
// userLtData[i].color=0;
//   }
    filteruserLtData = userLtData;

    notifyListeners();
  }
  setdefaultUserName() async {
    mycontroller[19].text = ConstantValues.firstName.toString();
    for (int i = 0; i < filteruserLtData.length; i++) {
      print(
          "object::${filteruserLtData[i].UserName.toString()}==${ConstantValues.firstName.toString()}");
      if (filteruserLtData[i].UserName.toString() ==
          ConstantValues.firstName.toString()) {
        // selectedIdxFUser = i;
        mycontroller[19].text = filteruserLtData[i].UserName.toString();
        selectedIdxFUser = i;
        await selectUser(i);
        notifyListeners();
      }
    }
    notifyListeners();

// selectedIdxFUser = ind;
//           context.read<NewEnqController>().selectUser(ind);
  }
   getUserAssingData() async {
    final Database db = (await DBHelper.getInstance())!;

    userLtData = await DBOperation.getUserList(db);
    filteruserLtData = userLtData;

    notifyListeners();
  }
  FocusNode focusNode1 = FocusNode();
  ontapvalid(BuildContext context) {
    methidstate(mycontroller[8].text,context);
    FocusScope.of(context).requestFocus(focusNode1);
    statebool = false;
    notifyListeners();
  }

  String statecode = '';
  String countrycode = '';
  String statename = '';
  List<stateHeaderData> stateData = [];
  List<stateHeaderData> filterstateData = [];
  filterListState2(String v) {
    if (v.isNotEmpty) {
      filterstateData = stateData
          .where((e) => e.stateName!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterstateData = filterstateData;
      notifyListeners();
    }
  }

  stateontap(int i) {
    log("AAAA::" + i.toString());
    statebool = false;
    mycontroller[8].text = filterstateData[i].stateName.toString();
    statecode = filterstateData[i].statecode.toString();
    statename = filterstateData[i].stateName.toString();
    countrycode = filterstateData[i].countrycode.toString();
    log("statecode::" + statecode.toString());
    log("statecode::" + countrycode.toString());
    notifyListeners();
  }

  stateApicallfromDB() async {
    stateData.clear();
    filterstateData.clear();

    final Database db = (await DBHelper.getInstance())!;
    stateData = await DBOperation.getstateData(db);
    filterstateData = stateData;
    log("getCustomerListFromDB length::" + filterstateData.length.toString());
    notifyListeners();
  }

  methidstate(String name,BuildContext context) {
    log("ANBU");
    statecode = '';
    statename = '';
    countrycode = '';
    for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].stateName.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        statecode = filterstateData[i].statecode.toString();
        statename = filterstateData[i].stateName.toString();
        countrycode = filterstateData[i].countrycode.toString();
 FocusScope.of(context).unfocus();
        log("statecode:::" + statecode.toString());
        // notifyListeners();
      }
    }
    if (statecode.isEmpty) {
      print("testing");
    }
    //  notifyListeners();
  }

  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<ExistingCusData> existCusDataList = [];
  List<ExistingCusData> get getexistCusDataList => existCusDataList;
  List<ExistingCusData> filterexistCusDataList = [];
  bool customerbool = false;
  bool areabool = false;
  bool citybool = false;
  bool pincodebool = false;
  bool statebool = false;

  bool timebool = false;
  bool Datebool = false;
  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;

  bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
  bool oldcutomer = false;
  bool get getoldcutomer => oldcutomer;

  List<purposeofVisitData> purposeofVisitList = [];
  List<visitpurpose>? purposevisit = [];
  static List<String> datafrommodify = [];
  
  static List<String> datafromAcc = [];
  checkcomefrom(BuildContext context) async {
    clearData();

    if (datafrommodify.length > 0) {
      customerapicLoading = true;
      mapvaluesfromvisit(context);
      notifyListeners();
    }
    if (datafromAcc.length > 0) {
      customerapicLoading = true;
      mapvaluesfromAccounts(context);
      notifyListeners();
    }
  }

  mapvaluesfromAccounts(BuildContext context) async {
    await getvisitpurpose();
    await stateApicallfromDB();
    await catagoryApi();
    await getUserAssingData();
   await setdefaultUserName();
    notifyListeners();
    
    notifyListeners();
 mycontroller[1].text = datafromAcc[0];
    mycontroller[0].text = datafromAcc[1];
   
    mycontroller[2].text = datafromAcc[9] == null ||
            datafromAcc[9] == "null" ||
            datafromAcc[9].isEmpty
        ? ""
        : datafromAcc[9];
    mycontroller[3].text = datafromAcc[2] == null ||
            datafromAcc[2] == "null" ||
            datafromAcc[2].isEmpty
        ? ""
        : datafromAcc[2];
    mycontroller[4].text = datafromAcc[3] == null ||
            datafromAcc[3] == "null" ||
            datafromAcc[3].isEmpty
        ? ""
        : datafromAcc[3];
    mycontroller[5].text = datafromAcc[10] == null ||
            datafromAcc[10] == "null" ||
            datafromAcc[10].isEmpty
        ? ""
        : datafromAcc[10];
    mycontroller[6].text = datafromAcc[5] == null ||
            datafromAcc[5] == "null" ||
            datafromAcc[5].isEmpty
        ? ""
        : datafromAcc[5];
    mycontroller[7].text = datafromAcc[4] == null ||
            datafromAcc[4] == "null"||datafromAcc[4] == "0" ||
            datafromAcc[4].isEmpty
        ? ""
        : datafromAcc[4];
//            if( datafromAcc[11] == null ||
//              datafromAcc[11] == "null" ||
//              datafromAcc[11].isEmpty){
// for(int i=0;i<filterstateData.length ;i++){
//         if(filterstateData[i].statecode == datafromAcc[11]){
//  mycontroller[8].text = filterstateData[i].stateName.toString();

        
//         }

//       }  
//             }else{
//            mycontroller[8].text ='';  
//             }
    mycontroller[8].text = datafromAcc[11] == null ||
            datafromAcc[11] == "null" ||
            datafromAcc[11].isEmpty
        ? ""
        : datafromAcc[11];
    
    mycontroller[17].text = datafromAcc[7] == null ||
            datafromAcc[7] == "null" ||
            datafromAcc[7].isEmpty
        ? ""
        : datafromAcc[7];
   
         customerapicLoading = false;
         
        //  iscateSeleted(context,datafrommodify[11]);
    datafromAcc.clear();
    
    // productDetails.clear();
    notifyListeners();
  }

  bool iscomeforupdate = false;
  int? visitid;
  mapvaluesfromvisit(BuildContext context) async {
    await getvisitpurpose();
    await stateApicallfromDB();
    await catagoryApi();
    await getUserAssingData();
   await setdefaultUserName();
    notifyListeners();
    iscomeforupdate = true;
    notifyListeners();

    mycontroller[0].text = datafrommodify[2];
    mycontroller[1].text = datafrommodify[1];
    mycontroller[2].text = datafrommodify[3] == null ||
            datafrommodify[3] == "null" ||
            datafrommodify[3].isEmpty
        ? ""
        : datafrommodify[3];
    mycontroller[3].text = datafrommodify[4] == null ||
            datafrommodify[4] == "null" ||
            datafrommodify[4].isEmpty
        ? ""
        : datafrommodify[4];
    mycontroller[4].text = datafrommodify[5] == null ||
            datafrommodify[5] == "null" ||
            datafrommodify[5].isEmpty
        ? ""
        : datafrommodify[5];
    mycontroller[5].text = datafrommodify[6] == null ||
            datafrommodify[6] == "null" ||
            datafrommodify[6].isEmpty
        ? ""
        : datafrommodify[6];
    mycontroller[6].text = datafrommodify[7] == null ||
            datafrommodify[7] == "null" ||
            datafrommodify[7].isEmpty
        ? ""
        : datafrommodify[7];
    mycontroller[7].text = datafrommodify[8] == null ||
            datafrommodify[8] == "null"||datafrommodify[8] == "0" ||
            datafrommodify[8].isEmpty
        ? ""
        : datafrommodify[8];
    mycontroller[8].text = datafrommodify[9] == null ||
            datafrommodify[9] == "null" ||
            datafrommodify[9].isEmpty
        ? ""
        : datafrommodify[9];
    // mycontroller[9].text = datafrommodify[11] == null ||
    //         datafrommodify[11] == "null" ||
    //         datafrommodify[11].isEmpty
    //     ? ""
    //     : datafrommodify[11];
    // mycontroller[16].text = datafrommodify[3] == null ||
    //         datafrommodify[3] == "null" ||
    //         datafrommodify[3].isEmpty
    //     ? ""
    //     : datafrommodify[3];
    mycontroller[17].text = datafrommodify[12] == null ||
            datafrommodify[12] == "null" ||
            datafrommodify[12].isEmpty
        ? ""
        : datafrommodify[12];
    mycontroller[18].text = datafrommodify[10] == null ||
            datafrommodify[10] == "null" ||
            datafrommodify[10].isEmpty
        ? ""
        : datafrommodify[10];
        baseid=datafrommodify[13] == null ||
            datafrommodify[13] == "null" ||
            datafrommodify[13].isEmpty
        ? null
        : int.parse(datafrommodify[13]);
        basetype=datafrommodify[14] == null ||
            datafrommodify[14] == "null" ||
            datafrommodify[14].isEmpty
        ? null
        : int.parse(datafrommodify[14]);
        potentialvalue=datafrommodify[15] == null ||
            datafrommodify[15] == "null" ||
            datafrommodify[15].isEmpty
        ? null
        : double.parse(datafrommodify[15]);
         customerapicLoading = false;
         visitid=int.parse(datafrommodify[0].toString());
         for(int i=0;i<purposevisit!.length;i++){
          if(purposevisit![i].description ==datafrommodify[11]){
            mycontroller[9].text=purposevisit![i].description.toString();
            purposecode=purposevisit![i].code.toString();
            notifyListeners();
          }

         }
        //  iscateSeleted(context,datafrommodify[11]);
    datafrommodify.clear();
    
    // productDetails.clear();
    notifyListeners();
  }

  clearnum() {
    mycontroller[0].clear();

    mycontroller[2].clear();

    mycontroller[3].clear();

    mycontroller[4].clear();

    mycontroller[5].clear();

    mycontroller[6].clear();

    mycontroller[7].clear();

    mycontroller[8].clear();

    mycontroller[9].clear();
mycontroller[16].clear();
mycontroller[17].clear();
    notifyListeners();
  }

  clearwarning() {
    mycontroller[0].clear();
mycontroller[1].clear();
    mycontroller[2].clear();
mycontroller[16].clear();
mycontroller[17].clear();
    mycontroller[3].clear();

    mycontroller[4].clear();

    mycontroller[5].clear();

    mycontroller[6].clear();

    mycontroller[7].clear();

    mycontroller[8].clear();

    mycontroller[9].clear();

    notifyListeners();
  }

  getvisitpurpose() async {
    await purposeofvisitApi.getOfferZone().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.purposevisit != null) {
          purposevisit = value.purposevisit;
          filterpurposeofVisitList = purposevisit!;
          notifyListeners();
        } else if (value.purposevisit == null) {
          log("NONONDATA");
          notifyListeners();
        }
      }
    });
  }

  List<GetCustomerData>? customerdetails;
  List<GetenquiryData> enquirydetails=[];
  List<GetenquiryData> viewenquirydetails=[];
  List<GetenquiryData> leaddetails=[];
  List<GetenquiryData> viewleaddetails=[];
  List<GetQuotationData>? quotationdetails;
  List<GetorderData>? orderdetails;
  int? baseid;
  int? basetype;
  callenquirydetails(GetenquiryData enquirydetails,BuildContext context){
    viewenquirydetails!.clear();
   bool isalreadyadd=false;
    customerapicLoading=true;
    notifyListeners();
    for(int i=0;i<viewenquirydetails!.length;i++){
      if(viewenquirydetails![i].DocNum ==enquirydetails.DocNum){
        isalreadyadd=true;
        
        notifyListeners();
      break;
      }

    }
    if(isalreadyadd){
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recent Activity already Added..!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        );
    }else{
 viewenquirydetails!.add(GetenquiryData(
   DocType:enquirydetails.DocType, 
  AssignedTo: enquirydetails.AssignedTo, 
  BusinessValue: enquirydetails.BusinessValue, 
  CurrentStatus: enquirydetails.CurrentStatus, 
  DocDate: enquirydetails.DocDate, 
  DocNum: enquirydetails.DocNum, 
  Status:enquirydetails.Status, 
  Store: enquirydetails.Store
      
      ));
      baseid=viewenquirydetails![0].DocNum;
      basetype=1;
    }
   
      customerapicLoading=false;
      notifyListeners();

  }

   callleaddetails(GetenquiryData leaddetails,BuildContext context){
    viewleaddetails!.clear();
   bool isalreadyadd=false;
    customerapicLoading=true;
    notifyListeners();
    for(int i=0;i<viewleaddetails!.length;i++){
      if(viewleaddetails![i].DocNum ==leaddetails.DocNum){
        isalreadyadd=true;
        
        notifyListeners();
      break;
      }

    }
    if(isalreadyadd){
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recent Activity already Added..!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        );
    }else{
 viewleaddetails!.add(GetenquiryData(
       DocType:leaddetails.DocType, 
  AssignedTo: leaddetails.AssignedTo, 
  BusinessValue: leaddetails.BusinessValue, 
  CurrentStatus: leaddetails.CurrentStatus, 
  DocDate: leaddetails.DocDate, 
  DocNum: leaddetails.DocNum, 
  Status:leaddetails.Status, 
  Store: leaddetails.Store
      ));
      baseid=viewleaddetails![0].DocNum;
      basetype=2;
    }
   
      customerapicLoading=false;
      notifyListeners();

  }


  callApi(BuildContext context) {
    //
    //fs
    log("APIININININ");
    customerapicLoading = true;
    notifyListeners();
    GetCutomerDetailsApi.getData(
            mycontroller[1].text, "${ConstantValues.slpcode}")
        .then((value) {
      //
      // log("value" + value.itemdata.toString());
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          if (value.itemdata!.customerdetails!.isNotEmpty &&
              value.itemdata!.customerdetails != null) {
            customerdetails = value.itemdata!.customerdetails;
            mapValues(value.itemdata!.customerdetails![0]);
            oldcutomer = true;

            notifyListeners();

             if (value.itemdata!.enquirydetails != null &&
                value.itemdata!.enquirydetails!.isNotEmpty 
                ) {
                   for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
                if(value.itemdata!.enquirydetails![i].DocType =="Lead"){
leaddetails!.add(GetenquiryData(
  DocType: value.itemdata!.enquirydetails![i].DocType, 
  AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo, 
  BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue, 
  CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus, 
  DocDate: value.itemdata!.enquirydetails![i].DocDate, 
  DocNum: value.itemdata!.enquirydetails![i].DocNum, 
  Status: value.itemdata!.enquirydetails![i].Status, 
  Store: value.itemdata!.enquirydetails![i].Store
  ));
  log("leaddetails::"+leaddetails!.length.toString());
                }else if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
                //  if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
enquirydetails!.add(GetenquiryData(
  DocType: value.itemdata!.enquirydetails![i].DocType, 
  AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo, 
  BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue, 
  CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus, 
  DocDate: value.itemdata!.enquirydetails![i].DocDate, 
  DocNum: value.itemdata!.enquirydetails![i].DocNum, 
  Status: value.itemdata!.enquirydetails![i].Status, 
  Store: value.itemdata!.enquirydetails![i].Store
  ));
           
  log("enquirydetails::"+enquirydetails!.length.toString());     // }  
                }

              }
              AssignedToDialogUserState.LookingFor =
                  value.itemdata!.enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                  value.itemdata!.enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                  value.itemdata!.enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  value.itemdata!.enquirydetails![0].CurrentStatus;
              alertDialogOpenLeadOREnq(context, "enquiry");
            }
            //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            //             value.itemdata!.orderdetails != null) {
            //                log("Anbuenq");
            //           orderdetails = value.itemdata!.orderdetails;
            //           alertDialogOpenLeadOREnq(context,"Orders");
            //         }
//             else if (value.itemdata!.enquirydetails!.isNotEmpty &&
//                 value.itemdata!.enquirydetails != null) {
//               log("Anbulead");
//               for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
//                 if(value.itemdata!.enquirydetails![i].DocType =="Lead"){
// leaddetails!.add(GetenquiryData(
//   DocType: value.itemdata!.enquirydetails![i].DocType, 
//   AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo, 
//   BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue, 
//   CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus, 
//   DocDate: value.itemdata!.enquirydetails![i].DocDate, 
//   DocNum: value.itemdata!.enquirydetails![i].DocNum, 
//   Status: value.itemdata!.enquirydetails![i].Status, 
//   Store: value.itemdata!.enquirydetails![i].Store
//   ));
//                 }

//               }
              
//               AssignedToDialogUserState.LookingFor =
//                   value.itemdata!.enquirydetails![0].DocType;
//               AssignedToDialogUserState.Store =
//                   value.itemdata!.enquirydetails![0].Store;
//               AssignedToDialogUserState.handledby =
//                  value.itemdata!.enquirydetails![0].AssignedTo;
//               AssignedToDialogUserState.currentstatus =
//                   value.itemdata!.enquirydetails![0].CurrentStatus;

//               alertDialogOpenLeadOREnq(context, "Lead");
//             } else if (value.itemdata!.enquirydetails!.isNotEmpty &&
//                 value.itemdata!.enquirydetails != null) {
//                   for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
//                 if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
// enquirydetails!.add(GetenquiryData(
//   DocType: value.itemdata!.enquirydetails![i].DocType, 
//   AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo, 
//   BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue, 
//   CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus, 
//   DocDate: value.itemdata!.enquirydetails![i].DocDate, 
//   DocNum: value.itemdata!.enquirydetails![i].DocNum, 
//   Status: value.itemdata!.enquirydetails![i].Status, 
//   Store: value.itemdata!.enquirydetails![i].Store
//   ));
//                 }

//               }
//               log("Anbuenq");
//               enquirydetails = value.itemdata!.enquirydetails;
//               AssignedToDialogUserState.LookingFor =
//                   value.itemdata!.enquirydetails![0].DocType;
//               AssignedToDialogUserState.Store =
//                   value.itemdata!.enquirydetails![0].Store;
//               AssignedToDialogUserState.handledby =
//                   value.itemdata!.enquirydetails![0].AssignedTo;
//               AssignedToDialogUserState.currentstatus =
//                   value.itemdata!.enquirydetails![0].CurrentStatus;

//               alertDialogOpenLeadOREnq(context, "enquiry");
//             }
          } else {
            oldcutomer = false;
            customerapicLoading = false;
            notifyListeners();
          }
        } else if (value.itemdata == null) {
          oldcutomer = false;
          customerapicLoading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = '${value.respCode!}..!! ${value.exception}..!! ';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
  }

  bool isAnother = true;
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  void alertDialogOpenLeadOREnq(BuildContext context, typeOfDataCus) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          AssignedToDialogUserState.typeOfDataCus = typeOfDataCus;
          // assignto = false;
          return WarningDialog();
        }).then((value) {
      if (isAnother == false) {
        FocusScope.of(context).requestFocus(focusNode2);
      } else {}

      // clearAllData(context);
    });
  }

  bool isText1Correct = false;
  mapValues(GetCustomerData itemdata) {
    PatchExCus patch = new PatchExCus();
    //  forid=itemdata.id!;itemdata.mobileNo!;
    //  forcustcode=itemdata.customerCode!;
    mycontroller[0].text =
        itemdata.customerName == 'null' ? "" : itemdata.customerName!;
    mycontroller[1].text =
        itemdata.mobileNo == 'null' ? "" : itemdata.mobileNo!;
    mycontroller[2].text = itemdata.contactName.toString().isEmpty ||
            itemdata.contactName == null ||
            itemdata.contactName == "null"
        ? ''
        : itemdata.contactName!;
    mycontroller[3].text = itemdata.Address_Line_1.toString().isEmpty ||
            itemdata.Address_Line_1 == null ||
            itemdata.Address_Line_1 == "null"
        ? ''
        : itemdata.Address_Line_1!;
    mycontroller[4].text = itemdata.Address_Line_2.toString().isEmpty ||
            itemdata.Address_Line_2 == null ||
            itemdata.Address_Line_2 == "null"
        ? ''
        : itemdata.Address_Line_2!;
    mycontroller[7].text = itemdata.Pincode.toString().isEmpty ||
            itemdata.Pincode == null ||
            itemdata.Pincode == "null"||itemdata.Pincode == "0"
        ? ''
        : itemdata.Pincode!;
    mycontroller[6].text = itemdata.City.toString().isEmpty ||
            itemdata.City == null ||
            itemdata.City == "null"
        ? ''
        : itemdata.City!;
    mycontroller[17].text = itemdata.email.toString().isEmpty ||
            itemdata.email == null ||
            itemdata.email == "null"
        ? ''
        : itemdata.email!;
    mycontroller[5].text = itemdata.area.toString().isEmpty ||
            itemdata.area == null ||
            itemdata.area == "null"
        ? ''
        : itemdata.area!;
    mycontroller[8].text = itemdata.State.toString().isEmpty ||
            itemdata.State == null ||
            itemdata.State == "null"
        ? ''
        : itemdata.State!;
    mycontroller[16].text = itemdata.altermobileNo.toString().isEmpty ||
            itemdata.altermobileNo == null ||
            itemdata.altermobileNo == "null"
        ? ''
        : itemdata.altermobileNo!;
    customerapicLoading = false;
    // isSelectedCsTag = itemdata.tag!;
    notifyListeners();
  }

  callCheckEnqDetailsApi(String mob) {
    //fs
    log("INININ");
    customerapicLoading = true;
    notifyListeners();
    CheckEnqDetailsApi.getData(ConstantValues.slpcode, mob).then((value) {
      log("INININ"); //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        log("INININ");
        if (value.checkEnqDetailsData != null &&
            value.checkEnqDetailsData!.isNotEmpty) {
          if (value.checkEnqDetailsData![0].Type == 'Enquiry') {
            if (ConstantValues.sapUserType != 'Manager') {
              // callEnqUserPage(value);
            } else {
              // callEnqMgrPage(value);
            }
          } else if (value.checkEnqDetailsData![0].Type == 'Lead') {
            log("LEadssssssssssssss");
            if (ConstantValues.sapUserType != 'Manager') {
              // callLeadUsrPage(value);
            } else {
              // callLeadMgrPage(value);
            }
          }
        } else if (value.checkEnqDetailsData == null &&
            value.message != "Success") {
          customerapicLoading = false;
          exceptionOnApiCall = value.message;
          notifyListeners();
        } else if (value.checkEnqDetailsData == null &&
            value.checkEnqDetailsData!.isEmpty) {
          // callApi();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = 'Some thing went wrong try again!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
    // callApi();
  }
  // getDataMethod() {
  //   existCusDataList = [
  //     ExistingCusData(
  //       Customer: "Arun Store",
  //       Mobile: "1234567890",
  //       CantactName: "Arun",
  //       U_Address1: "104 West Street ,",
  //       U_Address2: "Srirangam,Trichy",
  //       U_City: "Trichy",

  //       U_Pincode: "6200005",
  //       U_State: "Tamil Nadu",
  //       Meeting_Date: "24-01-2023",
  //       Meeting_Time: "12:00 AM",
  //       U_Area: "Srirangam",
  //        PurposOfVisit: "Enquiry Visit",
  //     ),
  //     ExistingCusData(
  //         Customer: "Raja Store",
  //         Mobile: "9876543210",
  //         CantactName: "Raja",
  //         U_Address1: "124 KK Nagar Street ,",
  //         U_Address2: "Karur main Road,Karur",
  //         U_City: "Somur",

  //          U_Pincode: "6200024",
  //         U_State: "Tamil Nadu",
  //         PurposOfVisit: "New Demo",
  //         Meeting_Time: "10:20 AM",
  //          U_Area: "Karur",
  //         Meeting_Date: "12-03-2023"),
  //   ];
  //   purposeofVisitList = [
  //     purposeofVisitData(purpose: "Courtesy Visit"),
  //     purposeofVisitData(purpose: "Enquiry Visit"),
  //     purposeofVisitData(purpose: "Routine Visit"),
  //     purposeofVisitData(purpose: "Collection"),
  //     purposeofVisitData(purpose: "Customer Appointment"),
  //     purposeofVisitData(purpose: "New Demo"),
  //     purposeofVisitData(purpose: "Complaint Call Visit")
  //   ];
  //       filterpurposeofVisitList = purposeofVisitList;

  //   filterexistCusDataList = existCusDataList;
  //   print(purposeofVisitList.length.toString());
  //   notifyListeners();
  // }
  List<String> catagorydata = [];
  List<String> filtercatagorydata = [];
  catagoryApi() async {
    catagorydata.clear();
    filtercatagorydata.clear();
    await ItemMasterCatagoryApiNew.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        catagorydata = value.itemdata!;
        filtercatagorydata=catagorydata;
        log("catagorydata::" + catagorydata.length.toString());
      } else {
        log("ANBBBUUUU");
      }
    });
  }
 selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].slpcode == userLtData[ij].slpcode) {
        userLtData[i].color = 1;
        getslpID = userLtData[ij].slpcode;
        selectedIdxFUser = ij;
      } else {
        userLtData[i].color = 0;
      }
    }
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
  setcatagorydata() {
//   for(int i=0;i<userLtData.length;i++){
// userLtData[i].color=0;
//   }
    filtercatagorydata = catagorydata;

    notifyListeners();
  }

  clearData() {
    clearbool();
    visitid=null;
    purposecode='';
    islodingtime=false;
    potentialvalue=null;
    iscomeforupdate = false;
    viewenquirydetails!.clear();
    basetype=null;
    baseid=null;
    filtercatagorydata.clear();
    catagorydata.clear();
    filterpurposeofVisitList.clear();
    purposevisit!.clear();
    existCusDataList.clear();
    filterexistCusDataList.clear();
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    mycontroller[9].text = "";
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[16].text = "";
    mycontroller[19].text = "";
    mycontroller[17].text = "";
    mycontroller[18].text = "";
    isText1Correct = false;
    isAnother == true;
    customerapicalled = false;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    oldcutomer = false;
    viewenquirydetails.clear();
    viewleaddetails.clear();
    notifyListeners();
  }

  clearbool() {
    customerbool = false;
    areabool = false;
    citybool = false;
    pincodebool = false;
    statebool = false;
    timebool = false;
    Datebool = false;
    notifyListeners();
  }

  filterListcustomer(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.Customer!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListArea(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_Area!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListCity(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_City!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListPincode(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_Pincode!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListState(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_State!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  List<visitpurpose> filterpurposeofVisitList = [];
  filterListPurposeOfVisit(String v) {
    if (v.isNotEmpty) {
      filterpurposeofVisitList = purposevisit!
          .where((e) => e.description!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterpurposeofVisitList = purposevisit!;
      notifyListeners();
    }
  }
String? purposecode='';
  iscateSeleted(BuildContext context, String select,String code) {
    mycontroller[9].text = select;
    purposecode=code;
    log("purposecode::"+purposecode.toString());
    if(purposecode == '05' ||purposecode == '06'){
      viewenquirydetails!.clear();
      viewleaddetails!.clear();
      
      if(purposecode == '05' &&enquirydetails !=null && enquirydetails.isNotEmpty){

callenquirydetails(enquirydetails![0],context);
Navigator.pop(context);
    notifyListeners();
      }
     else if(purposecode == '06' &&leaddetails !=null && leaddetails.isNotEmpty) {
      callleaddetails(leaddetails![0],context); 
      Navigator.pop(context);
    }else{
 Navigator.pop(context);
    }
 
    }else{
 Navigator.pop(context);
    }
   
    notifyListeners();
  }

  iscateSeleted2(BuildContext context, String select) {
    mycontroller[18].text = select;
    Navigator.pop(context);
    notifyListeners();
  }

  getExiCustomerData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].Customer) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiAreaData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_Area) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExicityData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_City) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExipincodeData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_Pincode) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExistateData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_State) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getDate(BuildContext context) async {
    errorTime = "";

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
//  firstDate: DateTime.now().subtract(Duration(days: 1)),
//   lastDate: DateTime(2100),
    if (pickedDate != null) {
      mycontroller[11].text = "";
      print(pickedDate);
      var datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[10].text = datetype;
      // mycontroller[44].text = datetype!;
      // print(datetype);
    } else {
      print("Date is not selected");
    }
    notifyListeners();
  }

  String errorTime = "";

  bool istimevalid = false;
  void selectTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay startTime = TimeOfDay(hour: 7, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);
    if (mycontroller[10].text.isNotEmpty) {
      errorTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );
      // if (mycontroller[10].text ==
      //     DateFormat('dd-MM-yyyy').format(DateTime.now())) {
      //   print(newTime!.hour);
      //   print(TimeOfDay.now().hour);
      //   print(newTime.minute);
      //   print(TimeOfDay.now().minute);
      //   if (timee.hour < TimeOfDay.now().hour ||
      //       timee.minute < TimeOfDay.now().minute) {
      //     print("error");
      //   } else if (timee.hour >= TimeOfDay.now().hour &&
      //       timee.minute >= TimeOfDay.now().minute) {
      //     print("correct");
      //   }
      // } else {

      if (newTime != null) {
        timee = newTime;
//         if (timee.hour < startTime.hour || timee.hour > endTime.hour) {
//           istimevalid = true;
//           mycontroller[11].text = "";
//           errorTime = "Schedule Time between 7AM to 10PM*";
// islodingtime=false;
//           notifyListeners();
//         } else {
          if (mycontroller[10].text ==
              DateFormat('dd-MM-yyyy').format(DateTime.now())) {
            if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute)) {
              errorTime = "Please Choose Correct Time";
              islodingtime=false;
              mycontroller[11].text = "";
              notifyListeners();
              print("error");
            } else {
              errorTime = "";
              print("correct11");
              mycontroller[11].text = timee.format(context).toString();
            }
          } else {
            errorTime = "";
            print("correct22");
            timee = newTime;
            mycontroller[11].text = timee.format(context).toString();
          }
          istimevalid = false;
          notifyListeners();
        // }
      }
      notifyListeners();
    } else {
      mycontroller[11].text = "";
      errorTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }

  successmsge(BuildContext context) {
    isloding = false;
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return SuccessDialogPG(
            heading: 'Response',
            msg: 'Visit Plan Created Successfully..!!',
          );
        }).then((value) {
      Get.offAllNamed(ConstantRoutes.visitplan);
    });
  }

  callAlertDialog3(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        // barrierDismissible: false,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {
      Get.offAllNamed(ConstantRoutes.visitplan);
    });
  }
  double? potentialvalue;
deletelist(){
   if(viewleaddetails!.isNotEmpty ){
      viewleaddetails!.clear();
      notifyListeners();
   }else{
    viewenquirydetails!.clear();
      notifyListeners();
   }
}
  callAlertDialog2(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {});
  }

  bool isloding = false;
  bool islodingtime = false;
  validateSchedule(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      if (statecode.isEmpty && countrycode.isEmpty) {
        isText1Correct = true;
        notifyListeners();
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select Correct State"),));
      }else if(mycontroller[10].text.isEmpty ||mycontroller[11].text.isEmpty){
        errorTime='';
islodingtime=true;
notifyListeners();
      } else {
islodingtime=false;

notifyListeners();
        if(iscomeforupdate ==true){

 isloding = true;
        Config config2 = Config();
        await Future.delayed(Duration(seconds: 2));
        String newdateformat = config2.alignDatevisit(mycontroller[10].text);
        String newdate = config2.alignDateforvisit(mycontroller[11].text);
        log("mycontroller[11].text::" +
            mycontroller[10].text +
            "T" +
            newdate.toString());
        postscheduledata postvistdata = postscheduledata();
        postvistdata.customername = mycontroller[0].text;
        postvistdata.add1 =
            mycontroller[3].text.isEmpty ? null : mycontroller[3].text;
        postvistdata.contactname =
            mycontroller[2].text.isEmpty ? null : mycontroller[2].text;
        postvistdata.add2 =
            mycontroller[4].text.isEmpty ? null : mycontroller[4].text;
        postvistdata.area =
            mycontroller[5].text.isEmpty ? null : mycontroller[5].text;
        postvistdata.city =
            mycontroller[6].text.isEmpty ? null : mycontroller[6].text;
        postvistdata.pincode =
            mycontroller[7].text.isEmpty ? 0 : int.parse(mycontroller[7].text);
        postvistdata.state = statecode;
        postvistdata.country = countrycode;
        postvistdata.email =
            mycontroller[17].text.isEmpty ? null : mycontroller[17].text;
        postvistdata.altermobile =
            mycontroller[16].text.isEmpty ? null : mycontroller[16].text;
        postvistdata.lookingfor =
            mycontroller[18].text.isEmpty ? null : mycontroller[18].text;
postvistdata.potential=potentialvalue==null?null:potentialvalue;
        postvistdata.customercode = mycontroller[1].text;
        postvistdata.purposeofvisit = purposecode;
        postvistdata.assignslpcode = ConstantValues.Usercode;
        postvistdata.meetingtime = newdateformat + "T" + newdate;
        postvistdata.createdby = int.parse(ConstantValues.UserId);
        postvistdata.userid = int.parse(ConstantValues.UserId);
        postvistdata.visitid2 =visitid==null?-1:visitid;
         postvistdata.baseid=baseid==null? 0:baseid;
        postvistdata.basetype=basetype==null?-1:basetype;

        await UpdatevisitApi.postvisit(postvistdata).then((value) {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            successmsge(context);
          } else if (value.stcode! >= 400 && value.stcode! <= 410) {
            isloding = false;
            notifyListeners();
            callAlertDialog2(
                context, '${value.message}..!!${value.exception}..!!');
          } else if (value.stcode! >= 500) {
            isloding = false;
            notifyListeners();
            callAlertDialog2(context, '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
          }
        });
        isloding = false;
        notifyListeners();
      }


        
        else{
 isloding = true;
        Config config2 = Config();
        await Future.delayed(Duration(seconds: 2));
        String newdateformat = config2.alignDatevisit(mycontroller[10].text);
        String newdate = config2.alignDateforvisit(mycontroller[11].text);
        log("mycontroller[11].text::" +
            mycontroller[10].text +
            "T" +
            newdate.toString());
        postscheduledata postvistdata = postscheduledata();
        postvistdata.customername = mycontroller[0].text;
        postvistdata.add1 =
            mycontroller[3].text.isEmpty ? null : mycontroller[3].text;
        postvistdata.contactname =
            mycontroller[2].text.isEmpty ? null : mycontroller[2].text;
        postvistdata.add2 =
            mycontroller[4].text.isEmpty ? null : mycontroller[4].text;
        postvistdata.area =
            mycontroller[5].text.isEmpty ? null : mycontroller[5].text;
        postvistdata.city =
            mycontroller[6].text.isEmpty ? null : mycontroller[6].text;
        postvistdata.pincode =
            mycontroller[7].text.isEmpty ? 0 : int.parse(mycontroller[7].text);
        postvistdata.state = statecode;
        postvistdata.country = countrycode;
        postvistdata.potential=potentialvalue==null?null:potentialvalue;
        postvistdata.email =
            mycontroller[17].text.isEmpty ? null : mycontroller[17].text;
        postvistdata.altermobile =
            mycontroller[16].text.isEmpty ? null : mycontroller[16].text;
        postvistdata.lookingfor =
            mycontroller[18].text.isEmpty ? null : mycontroller[18].text;

        postvistdata.customercode = mycontroller[1].text;
        postvistdata.purposeofvisit = purposecode;
        postvistdata.assignslpcode = ConstantValues.Usercode;
        postvistdata.meetingtime = newdateformat + "T" + newdate;
        postvistdata.createdby = int.parse(ConstantValues.UserId);
        postvistdata.userid = int.parse(ConstantValues.UserId);
        postvistdata.baseid=baseid==null? 0:baseid;
        postvistdata.basetype=basetype==null?-1:basetype;
        await newscheduleApi.postvisit(postvistdata).then((value) {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            successmsge(context);
          } else if (value.stcode! >= 400 && value.stcode! <= 410) {
            isloding = false;
            notifyListeners();
            callAlertDialog2(
                context, '${value.message}..!!${value.exception}..!!');
          } else if (value.stcode! >= 500) {
            isloding = false;
            notifyListeners();
            callAlertDialog2(context, '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
          }
        });
        isloding = false;
        notifyListeners();
      }
        }
       
      notifyListeners();
    }
  }
}

class purposeofVisitData {
  String purpose;
  purposeofVisitData({required this.purpose});
}
