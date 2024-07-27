// ignore_for_file: prefer_const_constructors, prefer_is_empty, unnecessary_new, unnecessary_string_interpolations, avoid_print, prefer_interpolation_to_compose_strings
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/OrderTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/levelofinterestModel.dart';
import 'package:sellerkit/Pages/Leads/Widgets/shorefdialog.dart';
import 'package:sellerkit/Services/refrealpartnerApi/refpartnerApi.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/CustomerCreationModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import 'package:sellerkit/Models/leadexmodel/agemodel.dart';
import 'package:sellerkit/Models/leadexmodel/cameasmodel.dart';
import 'package:sellerkit/Models/leadexmodel/gendermodel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Pages/Leads/Screens/LeadSuccessPage.dart';
import 'package:sellerkit/Pages/Leads/Widgets/WarningDialoglead.dart';
import 'package:sellerkit/Services/LeadexApi/AgeApi.dart';
import 'package:sellerkit/Services/LeadexApi/GenderApi.dart';
import 'package:sellerkit/Services/LeadexApi/cameasApi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/LeadCheckPostApi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/SaveLeadApi.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/ItemMasertDBModel.dart';
import '../../Models/AddEnqModel/AddEnqModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CheckEnqCusDetailsModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';
import '../../Pages/Leads/Widgets/LeadWarningDialog.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqCutomerDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Services/PostQueryApi/LeadsApi/LeadCheckListApi.dart';
import '../../Services/PostQueryApi/LeadsApi/LeadFollowupApi.dart';
import '../../Services/RabbitMqPush/RabbitmqApi.dart';
import '../../Services/ServiceLayerApi/CreatNewCus/CreateNewCustApi.dart';
import '../../Widgets/AlertDilog.dart';
import '../EnquiryController/EnquiryMngController.dart';
import '../EnquiryController/EnquiryUserContoller.dart';
import 'TabLeadController.dart';

class LeadNewController extends ChangeNotifier {
  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
  LeadNewController() {
    clearAllData();
    // checkComeFromEnq();
    getCusTagType();
    getdataFromDb();
     callrefparnerApi();
    getLeveofType();
    stateApicallfromDB();
    callAgeApi();
    getEnqRefferes();
    callLeadCheckApi();
  }

  refreshh() async{
    clearAllData();
   await getdataFromDb();
   await  getLeveofType();
   await callrefparnerApi();
   await callAgeApi();
   await getEnqRefferes();
  await  callLeadCheckApi();
  }

List<Levelofinterest> levelofinterest=[
  Levelofinterest(name: "Hot"),
  Levelofinterest(name: "Cold"),
  Levelofinterest(name: "Warm"),

];
  ontapvalid(BuildContext context) {
    methidstate(mycontroller[16].text,context);
    FocusScope.of(context).requestFocus(focusNode1);
    statebool = false;
    notifyListeners();
  }
scannerreset(){
itemAlreadyscanned = false;
  indexscanning=null;
  notifyListeners();
  }
  int? indexscanning;
  bool itemAlreadyscanned = false;
  String? Scancode;
  scanneddataget(BuildContext context){
  // log("code:::::"+code.toString());

  


   
   notifyListeners();
  
  // Get.back();
// Navigator.pop(context);
notifyListeners();
   for (int ij=0;ij<allProductDetails.length;ij++){
    if(allProductDetails[ij].itemCode ==Scancode){
      itemAlreadyscanned=true;
      indexscanning =ij;
        notifyListeners();
      break;
    
    }
   
   }
    if(itemAlreadyscanned ==true){
      resetItems(indexscanning!);
showBottomSheetInsert(context, indexscanning!);
 notifyListeners();
   }else{
    showtoastforscanning();
     notifyListeners();
   }
   
 


//  checkscannedcode(code);
 notifyListeners();

  }
  void showtoastforscanning() {
    Fluttertoast.showToast(
        msg: "No Data Found..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  FocusNode focusNode1 = FocusNode();
  bool timebool = false;
  bool Datebool = false;
  List<GlobalKey<FormState>> formkey =
      new List.generate(3, (i) => new GlobalKey<FormState>(debugLabel: "Lead"));
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());

  Config config = new Config();

  String isSelectedGender = '';
  String get getisSelectedGender => isSelectedGender;

  String isSelectedAge = '';
  String get getisSelectedAge => isSelectedAge;

  String isSelectedcomeas = '';
  String get getisSelectedcomeas => isSelectedcomeas;

  String isSelectedAdvertisement = '';
  String get getisSelectedAdvertisement => isSelectedAdvertisement;

  String isSelectedCsTag = '';
  String get getisSelectedCsTag => isSelectedCsTag;

  bool showItemList = true;
  bool get getshowItemList => showItemList;
  bool comefromAcc = false;
  bool isUpdateClicked = false;

  bool validateGender = false;
  bool validateAge = false;
  bool validateComas = false;
  bool validateCsTag = false;

  bool get getvalidateGender => validateGender;
  bool get getvalidateAge => validateAge;
  bool get getvalidateComas => validateComas;
  bool get getvalidateCsTag => validateCsTag;

  // List<ProductDetails> productDetails = [];
  // List<ProductDetails> get getProduct => productDetails;

  List<DocumentLines> productDetails = [];
  List<DocumentLines> get getProduct => productDetails;

  List<ItemMasterDBModel> allProductDetails = [];
  List<ItemMasterDBModel> filterProductDetails = [];

  List<ItemMasterDBModel> get getAllProductDetails => allProductDetails;

  String? selectedItemCode;
  String? get getselectedItemCode => selectedItemCode;

  String? selectedItemName;
  String? get getselectedItemName => selectedItemName;

  double? unitPrice;
  int? quantity;
  double total = 0.00;

  List<EnquiryTypeData> enqList = [];
  List<EnquiryTypeData> get getEnqList => enqList;
  List<CustomerTagTypeData> cusTagList = [];
  List<CustomerTagTypeData> get getCusTagList => cusTagList;

  String isSelectedenquirytype = '';
  String get getisSelectedenquirytype => isSelectedenquirytype;

  bool visibleEnqType = false;
  bool get getvisibleEnqType => visibleEnqType;

  List<EnqRefferesData> enqReffList = [];
  List<EnqRefferesData> get getenqReffList => enqReffList;

  String isSelectedenquiryReffers = '';
  String isSelectedrefcode = '';
  String get getisSelectedenquiryReffers => isSelectedenquiryReffers;
  String? EnqRefer;
  bool visiblefollTime = false;
  bool visibleRefferal = false;
  bool get getvisibleRefferal => visibleRefferal;

  static bool isComeFromEnq = false;

  int? enqID;
  int? basetype;

  selectEnqReffers(String selected, String refercode, String code) {
    isSelectedenquiryReffers = selected;
    EnqRefer = refercode;
    isSelectedrefcode = code;
    log("AN11:" + isSelectedenquiryReffers.toString());

    log("AN22:" + EnqRefer.toString());

    log("AN33:" + isSelectedrefcode.toString());
    notifyListeners();
  }

  getCusTagType() async {
    cusTagList.clear();
    final Database db = (await DBHelper.getInstance())!;

    cusTagList = await DBOperation.getCusTagData(db);
    
    notifyListeners();
  }

  getEnqRefferes() async {
    final Database db = (await DBHelper.getInstance())!;
    enqReffList = await DBOperation.getEnqRefferes(db);
    notifyListeners();
  }
String? valueChosedStatus;
String? valueChosedCusType;
choosedType(String? val){
  valueChosedCusType=val;
  notifyListeners();

}
choosedStatus(String? val){
  valueChosedStatus=val;
notifyListeners();
}
  int? EnqTypeCode;
  selectEnqMeida(String selected, int enqtypecode) {
    isSelectedenquirytype = selected;
    EnqTypeCode = enqtypecode;

    notifyListeners();
  }

  getEnqType() async {
    final Database db = (await DBHelper.getInstance())!;
    enqList = await DBOperation.getEnqData(db);
    notifyListeners();
  }

  getdataFromDb() async {
    final Database db = (await DBHelper.getInstance())!;
    allProductDetails = await DBOperation.getAllProducts(db);
    filterProductDetails = allProductDetails;
  }

  changeVisible() {
    showItemList = !showItemList;
    notifyListeners();
  }

  selectGender(String selected) {
    isSelectedGender = selected;
    notifyListeners();
  }

  selectage(String selected) {
    isSelectedAge = selected;
    notifyListeners();
  }

  selectComeas(String selected) {
    isSelectedcomeas = selected;
    notifyListeners();
  }
iscateSeleted(String name ,String code,BuildContext context,){
selectedapartcode =code.toString();
mycontroller[46].text=name.toString();
selectedapartname=name.toString();
Navigator.pop(context);
notifyListeners();
  }
  filterListrefData(String v) {
    if (v.isNotEmpty) {
      filterrefpartdata = refpartdata
          .where((e) =>
              e.PartnerName!.toLowerCase().contains(v.toLowerCase()) ||
              e.PartnerCode!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterrefpartdata = refpartdata;
      notifyListeners();
    }
  }
   List<refdetModalData> refpartdata=[];
   List<refdetModalData> filterrefpartdata=[];
   String selectedapartcode='';
  String selectedapartname='';
callrefparnerApi()async{
  refpartdata.clear();
  filterrefpartdata.clear();
  await refpartnerApi.getData().then((value){
 if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata!.itemdata != null && value.itemdata!.itemdata!.isNotEmpty) {
          refpartdata = value.itemdata!.itemdata!;
          filterrefpartdata=refpartdata;
log("refpartdata:::"+refpartdata.length.toString());
log("filterrefpartdata:::"+filterrefpartdata.length.toString());
          notifyListeners();
        } else if (value.itemdata!.itemdata == null  || value.itemdata!.itemdata!.isEmpty) {
          // log("DONR222");
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        notifyListeners();
      } else if (value.stcode == 500) {
        notifyListeners();
      }
  });

}
  selectAdvertisement(String selected) {
    isSelectedAdvertisement = selected;
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

  String? taxRate;
  String? taxCode;
// int linenum=0;
  addProductDetails(BuildContext context) {
    if (formkey[1].currentState!.validate()) {
      bool itemAlreadyAdded = false;

      for (int i = 0; i < productDetails.length; i++) {
        if (productDetails[i].ItemCode == selectedItemCode) {
          itemAlreadyAdded = true;
          break;
        }
      }

      if (itemAlreadyAdded) {
        showItemList = false;
        mycontroller[12].clear();
        Navigator.pop(context);
        isUpdateClicked = false;
        notifyListeners();
         showtoastforall();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Item Already Added..!!'),
        //     backgroundColor: Colors.red,
        //     elevation: 10,
        //     behavior: SnackBarBehavior.floating,
        //     margin: EdgeInsets.all(5),
        //     dismissDirection: DismissDirection.up,
        //   ),
        // );
      } else {
        productDetails.add(
          DocumentLines(
            id: 0,
            docEntry: 0,
            linenum: 0,
            ItemCode: selectedItemCode,
            ItemDescription: selectedItemName,
            Quantity: quantity,
            LineTotal: total,
            Price: unitPrice,
            TaxCode: "notax",
            TaxLiable: "tNO",
            isfixedprice:  isfixedpriceorder,
            partcode: selectedapartcode ==null || selectedapartcode.isEmpty?
   null:selectedapartcode,
   partname: selectedapartname==null||selectedapartname.isEmpty?
                  null:selectedapartname,
          ),
        );

        showItemList = false;
        mycontroller[12].clear();
        Navigator.pop(context);
        isUpdateClicked = false;
        notifyListeners();
      }
// }

      // productDetails.add(DocumentLines(
      //   id: 0,
      //   docEntry: 0,
      //   linenum: 0,
      //   ItemCode: selectedItemCode,
      //   ItemDescription: selectedItemName,
      //   Quantity: quantity,
      //   LineTotal: total,
      //   Price: unitPrice,
      //   TaxCode: "notax",
      //   TaxLiable: "tNO",
      // ));
      // showItemList = false;
      // mycontroller[12].clear();
      // Navigator.pop(context);
      // isUpdateClicked = false;
      // notifyListeners();
    }
  }
void showtoastforall() {
    Fluttertoast.showToast(
        msg: "Item Already Added..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  updateProductDetails(BuildContext context, int i) {
    if (formkey[1].currentState!.validate()) {
      productDetails[i].Quantity = quantity;
      productDetails[i].Price = unitPrice;
      productDetails[i].LineTotal = total;
      productDetails[i].partcode=selectedapartcode == null || selectedapartcode.isEmpty
                  ? productDetails[i].partcode
                  : selectedapartcode;
                  productDetails[i].partname=selectedapartname==null||selectedapartname.isEmpty?
                  productDetails[i].partname:selectedapartname;
      showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
    }
  }

  resetItems(int i) {
    unitPrice = 0.00;
    quantity = 0;
    total = 0.00;
    mycontroller[10].text = allProductDetails[i].sp!.toStringAsFixed(2);
    //.clear();
    mycontroller[11].clear();
    mycontroller[46].clear();
    selectedapartname='';
      selectedapartcode='';
  }

  filterList(String v) {
    if (v.isNotEmpty) {
      allProductDetails = filterProductDetails
          .where((e) =>
              e.itemCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemName.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      allProductDetails = filterProductDetails;
      notifyListeners();
    }
  }

  static List<String> dataAcc = [];
  mapvaluesAcc() async{
    await getCusTagType();
    await getdataFromDb();
   await  getLeveofType();
   await callrefparnerApi();
    await stateApicallfromDB();
    await callAgeApi();
    await getEnqRefferes();
    await callLeadCheckApi();
    for (int i = 0; i < cusTagList.length; i++) {
      if (cusTagList[i].Name == dataAcc[8]) {
        isSelectedCsTag = cusTagList[i].Code.toString();
        notifyListeners();
      }
      log("isSelectedCsTag::" + dataAcc[8].toString());
      notifyListeners();
    }
    log("OUTOUT" + dataAcc[8]);
    mycontroller[0].text = dataAcc[0] ==null||dataAcc[0] =="null"||dataAcc[0].isEmpty?'':dataAcc[0];
    mycontroller[1].text = dataAcc[1] ==null||dataAcc[1] =="null"||dataAcc[1].isEmpty?'':dataAcc[1];
    mycontroller[2].text = dataAcc[2] ==null||dataAcc[2] =="null"||dataAcc[2].isEmpty?'':dataAcc[2];
    mycontroller[3].text = dataAcc[3] ==null||dataAcc[3] =="null"||dataAcc[3].isEmpty?'':dataAcc[3];
    mycontroller[4].text = dataAcc[4] ==null||dataAcc[4] =="null"||dataAcc[4] =="0"||dataAcc[4].isEmpty?'':dataAcc[4];
    mycontroller[5].text = dataAcc[5] ==null||dataAcc[5] =="null"||dataAcc[5].isEmpty?'':dataAcc[5];
    mycontroller[6].text = dataAcc[6] ==null||dataAcc[6] =="null"||dataAcc[6].isEmpty?'':dataAcc[6];
    mycontroller[7].text = dataAcc[7] ==null||dataAcc[7] =="null"||dataAcc[7].isEmpty?'':dataAcc[7];
    mycontroller[15].text = dataAcc[10] ==null||dataAcc[10] =="null"||dataAcc[10].isEmpty?'':dataAcc[10];
    mycontroller[17].text = dataAcc[9] ==null||dataAcc[9] =="null"||dataAcc[9].isEmpty?'':dataAcc[9];
    mycontroller[16].text = dataAcc[11] ==null||dataAcc[11] =="null"||dataAcc[11].isEmpty?'':dataAcc[11];
    
    customerapicLoading = false;
    dataAcc.clear();
    notifyListeners();
  }

  ///call customer api

  bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;
  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;
  bool oldcutomer = false;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
  List<GetCustomerData>? customerdetails;
  List<GetenquiryData> enquirydetails=[];
  List<GetenquiryData> leaddetails=[];
  List<GetenquiryData> quotationdetails=[];
  List<GetenquiryData> orderdetails=[];

  callApi(BuildContext context) {
    //
    //fs
    customerapicLoading = true;
    notifyListeners();
    GetCutomerDetailsApi.getData(
            mycontroller[0].text, "${ConstantValues.slpcode}")
        .then((value) {
      //
      // log("value" + value.itemdata.toString());
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          if (value.itemdata!.customerdetails!.isNotEmpty &&
              value.itemdata!.customerdetails != null) {
            log("INININ::");
            customerdetails = value.itemdata!.customerdetails;
            mapValues(value.itemdata!.customerdetails![0]);
            notifyListeners();
  // if (
  //               value.itemdata!.enquirydetails!.isNotEmpty &&
  //               value.itemdata!.enquirydetails != null) {
  //             AssignedToDialogUserState.LookingFor =
  //                 value.itemdata!.enquirydetails![0].DocType;
  //             AssignedToDialogUserState.Store =
  //                 value.itemdata!.enquirydetails![0].Store;
  //             AssignedToDialogUserState.handledby =
  //                 value.itemdata!.enquirydetails![0].AssignedTo;
  //             AssignedToDialogUserState.currentstatus =
  //                 value.itemdata!.enquirydetails![0].CurrentStatus;
  //             alertDialogOpenLeadOREnq(context, "Enquiry");
  //           }
            //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            //             value.itemdata!.orderdetails != null) {
            //                log("Anbuenq");
            //           orderdetails = value.itemdata!.orderdetails;
            //           alertDialogOpenLeadOREnq(context,"Orders");
            //         }
             if (value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
              log("Anbulead");
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
                }else   if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
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
                }else if(value.itemdata!.enquirydetails![i].DocType =="Order"){
orderdetails!.add(GetenquiryData(
  DocType: value.itemdata!.enquirydetails![i].DocType, 
  AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo, 
  BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue, 
  CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus, 
  DocDate: value.itemdata!.enquirydetails![i].DocDate, 
  DocNum: value.itemdata!.enquirydetails![i].DocNum, 
  Status: value.itemdata!.enquirydetails![i].Status, 
  Store: value.itemdata!.enquirydetails![i].Store
  ));
                }

              }
              if(leaddetails!.isNotEmpty){
 AssignedToDialogUserState.LookingFor =
                  leaddetails![0].DocType;
              AssignedToDialogUserState.Store =
                  leaddetails![0].Store;
              AssignedToDialogUserState.handledby =
                 leaddetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  leaddetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq(context, "Lead");
              }else if(enquirydetails!.isNotEmpty){
AssignedToDialogUserState.LookingFor =
                  enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                 enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                  enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  enquirydetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq(context, "enquiry");
              }else if(orderdetails!.isNotEmpty){
AssignedToDialogUserState.LookingFor =
                  orderdetails![0].DocType;
              AssignedToDialogUserState.Store =
                  orderdetails![0].Store;
              AssignedToDialogUserState.handledby =
                  orderdetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  orderdetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq(context, "Order");
             }
             
            } 
            // else if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //       for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
              

            //   }
            //   log("Anbuenq");
            //   enquirydetails = value.itemdata!.enquirydetails;
              
            // }
            // if (value.itemdata!.leaddetails!.isNotEmpty &&
            //     value.itemdata!.leaddetails != null &&
            //     value.itemdata!.leaddetails!.isNotEmpty &&
            //     value.itemdata!.leaddetails != null &&
            //     value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.leaddetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.leaddetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.leaddetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.leaddetails![0].currentStatus;
            //   alertDialogOpenLeadOREnq(context, "Lead");
            // }
            // //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            // //             value.itemdata!.orderdetails != null) {
            // //                log("Anbuenq");
            // //           orderdetails = value.itemdata!.orderdetails;
            // //           alertDialogOpenLeadOREnq(context,"Orders");
            // //         }
            // else if (value.itemdata!.leaddetails!.isNotEmpty &&
            //     value.itemdata!.leaddetails != null) {
            //   log("Anbulead");
            //   leaddetails = value.itemdata!.leaddetails;
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.leaddetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.leaddetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.leaddetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.leaddetails![0].currentStatus;

            //   alertDialogOpenLeadOREnq(context, "Lead");
            // } else if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //   log("Anbuenq");
            //   enquirydetails = value.itemdata!.enquirydetails;
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.enquirydetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.enquirydetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.enquirydetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.enquirydetails![0].currentStatus;

            //   alertDialogOpenLeadOREnq(context, "enquiry");
            // }

            // else  if (value.itemdata!.quotationdetails!.isNotEmpty &&
            //       value.itemdata!.quotationdetails != null) {
            //         log("Anbuquote");
            //     quotationdetails = value.itemdata!.quotationdetails;
            //     alertDialogOpenLeadOREnq(context,"Quotations");
            //   }
          } else {
            oldcutomer = false;
            customerapicLoading = false;
            notifyListeners();
          }

          oldcutomer = true;
          customerapicLoading = false;
          notifyListeners();

          //  }
          //  else{
          //   oldcutomer = false;
          //   customerapicLoading = false;
          //   notifyListeners();

          //  }
        } else if (value.itemdata == null) {
          oldcutomer = false;
          customerapicLoading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = '${value.respDesc!}..!! ${value.exception}....!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
  }

  // callApi() {
  //   customerapicLoading = true;
  //   notifyListeners();
  //   GetCutomerDetailsApi.getData(
  //           mycontroller[0].text, "${ConstantValues.slpcode}")
  //       .then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       if (value.itemdata != null) {
  //         //  itemdata = value.itemdata!;
  //         // mapValues(value.itemdata!);
  //         oldcutomer = true;
  //         notifyListeners();
  //       } else if (value.itemdata == null) {
  //         oldcutomer = false;
  //         customerapicLoading = false;
  //         notifyListeners();
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = 'Some thing went wrong \n${value.stcode} ${value.exception}..!!';
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = 'Some thing went wrong \n${value.stcode} ${value.exception}..!!';
  //       notifyListeners();
  //     }
  //     //  print("olddd cusss : "+oldcutomer.toString());
  //   });
  //   log("Oldcustomer::"+oldcutomer.toString());
  // }

  // callCheckEnqDetailsApi(
  //   BuildContext context,
  // ) {
  //   customerapicLoading = true;
  //   notifyListeners();
  //   CheckEnqDetailsApi.getData(ConstantValues.slpcode, mycontroller[0].text)
  //       .then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       if (value.checkEnqDetailsData != null&& value.checkEnqDetailsData!.isNotEmpty) {
  //         // clearAllData();

  //         checkEnqDetailsData = value.checkEnqDetailsData!;
  //         //  log("data DocEntry: ${value.checkEnqDetailsData![0].DocEntry}");
  //         // log("data Type!: ${value.checkEnqDetailsData![0].Type!}");

  //         if (value.checkEnqDetailsData![0].Type == 'Enquiry') {
  //           callEnqPageSB(context, value.checkEnqDetailsData!);
  //         } else if (value.checkEnqDetailsData![0].Type == 'Lead') {
  //           typeOfLeadOrEnq = value.checkEnqDetailsData![0].Type!;

  //           if (value.checkEnqDetailsData![0].Current_Branch ==
  //               value.checkEnqDetailsData![0].User_Branch) {
  //             branchOfLeadOrEnq = 'this';
  //             //   log("111111");
  //             // callLeadPageSB(context,value.checkEnqDetailsData!);
  //             alertDialogOpenLeadOREnq(context);
  //           } else {
  //             //  log("22222");
  //             branchOfLeadOrEnq =
  //                 value.checkEnqDetailsData![0].Current_Branch!.currentBranch!;
  //             // callLeadPageNSB(context,value.checkEnqDetailsData!);
  //             alertDialogOpenLeadOREnq(context);
  //           }
  //         }
  //       } else if (value.checkEnqDetailsData == null&& value.checkEnqDetailsData!.isEmpty) {

  //       }
  //       notifyListeners();
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = 'Some thing went wrong \n${value.stcode} ${value.exception}..!!';
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = 'Some thing went wrong \n${value.stcode} ${value.exception}..!!';
  //       notifyListeners();
  //     }
  //   });
  //    callApi();
  // }
  bool isText1Correct = false;
  List<CheckEnqDetailsData> checkEnqDetailsData = [];
  callLeadPageSB(
    BuildContext context,
  ) {
    LeadTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
    LeadTabController.isSameBranch = true;
    Navigator.pop(context);
    Get.offAllNamed(ConstantRoutes.leadstab);
    notifyListeners();
  }

  methidstate(String name,BuildContext context) {
    statecode = '';
    statename = '';
    countrycode = '';

    log("ANBU");
    for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].stateName.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        statecode = filterstateData[i].statecode.toString();
        statename = filterstateData[i].stateName.toString();
        countrycode = filterstateData[i].countrycode.toString();
        isText1Correct = false;
 FocusScope.of(context).unfocus();
        log("statecode:::" + statecode.toString());
      }else{
        
      }
    }
    //  notifyListeners();
  }

  static String typeOfLeadOrEnq = '';
  static String branchOfLeadOrEnq = '';

  callLeadPageNSB(BuildContext context) {
    LeadTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
    LeadTabController.isSameBranch = false;
    //  Navigator.pop(context);
    //  callApi();
    //  customerapicLoading = false;
    //  exceptionOnApiCall = '';
    //  mycontroller[0].clear();
    Navigator.pop(context);
    Get.offAllNamed(ConstantRoutes.leadstab);
    notifyListeners();
  }

  cancelDialog(BuildContext context) {
    exceptionOnApiCall = '';
    customerapicLoading = false;
    mycontroller[0].clear();
    notifyListeners();
    Navigator.pop(context);
  }

  bool isAnother = true;
  FocusNode focusNode2 = FocusNode();
  void alertDialogOpenLeadOREnq(BuildContext context, String typeOfDataCus) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          AssignedToDialogUserState.typeOfDataCus = typeOfDataCus;
          return WarningDialog();
        }).then((value) {
      if (isAnother == false) {
        FocusScope.of(context).requestFocus(focusNode2);
      } else {}
    });
  }

  clearnum() {
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    mycontroller[17].clear();
    mycontroller[16].clear();
    mycontroller[15].clear();
    isSelectedCsTag = '';
    customerapicalled = false;
    notifyListeners();
  }

  clearwarning() {
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    mycontroller[17].clear();
    mycontroller[16].clear();
    mycontroller[15].clear();
    isSelectedCsTag = '';
    customerapicalled = false;
    notifyListeners();
  }

  mapValues(GetCustomerData itemdata) {
    log("ANBU" + mycontroller[1].text);
    for (int i = 0; i < cusTagList.length; i++) {
      if (cusTagList[i].Name == itemdata.customerGroup) {
        isSelectedCsTag = cusTagList[i].Code.toString();
      }
      notifyListeners();
    }
    //  mycontroller[0].text = itemdata[0].CardCode!;
    mycontroller[1].text = itemdata.customerName!;
    mycontroller[2].text = itemdata.Address_Line_1.toString().isEmpty ||
            itemdata.Address_Line_1 == null ||
            itemdata.Address_Line_1 == "null"
        ? ""
        : itemdata.Address_Line_1!;
    log("ANBU" + mycontroller[1].text);
    mycontroller[3].text = itemdata.Address_Line_2.toString().isEmpty ||
            itemdata.Address_Line_2 == null ||
            itemdata.Address_Line_2 == "null"
        ? ""
        : itemdata.Address_Line_2!;
    mycontroller[4].text = itemdata.Pincode.toString().isEmpty ||
            itemdata.Pincode == null ||
            itemdata.Pincode == "null"||itemdata.Pincode == "0"
        ? ""
        : itemdata.Pincode!;
    mycontroller[5].text = itemdata.City.toString().isEmpty ||
            itemdata.City == null ||
            itemdata.City == "null"
        ? ""
        : itemdata.City!;
    mycontroller[6].text = itemdata.altermobileNo.toString().isEmpty ||
            itemdata.altermobileNo == null ||
            itemdata.altermobileNo == "null"
        ? ""
        : itemdata.altermobileNo!;
    mycontroller[7].text = itemdata.area.toString().isEmpty ||
            itemdata.area == null ||
            itemdata.area == "null"
        ? ""
        : itemdata.email!;
    mycontroller[15].text = itemdata.area.toString().isEmpty ||
            itemdata.area == null ||
            itemdata.area == "null"
        ? ''
        : itemdata.area!;
    mycontroller[16].text = itemdata.State.toString().isEmpty ||
            itemdata.State == null ||
            itemdata.State == "null"
        ? ''
        : itemdata.State!;
    mycontroller[17].text = itemdata.contactName.toString().isEmpty ||
            itemdata.contactName == null ||
            itemdata.contactName == "null"
        ? ''
        : itemdata.contactName!;
    customerapicLoading = false;

    notifyListeners();
  }

  // checkComeFromAcc() {
  //   clearAllData();
  //   log("INININI" + dataAcc.length.toString());
  //   if (dataAcc.length > 0) {
  //     log("INININIDONEEE");
  //     mapvaluesAcc();
  //   }
  // }

  static bool comeFromEnquiry = false;
  get getcomeFromEnquiry => comeFromEnquiry;
  static List<String> dataenq = [];
  static List<String> datasiteout = [];
 DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.leadstab);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
restricteddialog(BuildContext context){
  final theme = Theme.of(context);
  showDialog(
    // barrierDismissible: true,
    context: context, builder: (_){
    return WillPopScope(
      onWillPop: onbackpress,
      child: AlertDialog(
        // insetPadding: EdgeInsets.all(0),
        contentPadding:EdgeInsets.all(0),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Container(
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          SizedBox(
            height: Screens.padingHeight(context)*0.06,
            width: Screens.width(context),
            child: ElevatedButton(
              
              onPressed: (){}, 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                )
              ),
            child:Text("Alert",style: theme.textTheme.bodyText1!.copyWith(color: Colors.white),) 
            ),
          ),
          SizedBox(
            height: Screens.padingHeight(context)*0.02,
          ),
          Container(
    
            child: Text("This User is assigned to multiple stores. Creating new lead is not possible",
            style:  theme.textTheme.bodyText1?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Screens.padingHeight(context)*0.02,
          ),
          SizedBox(
            height: Screens.padingHeight(context)*0.06,
            width: Screens.width(context),
            child: ElevatedButton(
              
              onPressed: (){
                 Get.offAllNamed(ConstantRoutes.leadstab);
                 notifyListeners();
              }, 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                )
              ),
            child:Text("ok",style: theme.textTheme.bodyText1!.copyWith(color: Colors.white,fontSize: 18),) 
            ),
          ),
       
        ],)
        ),
    
      ),
    );

  });
}

  checkComeFromEnq() async {
    log("datasiteout::" + datasiteout.length.toString());
    clearAllData();
     
    //  customerapicLoading = true;
    //   notifyListeners();
    

    // log("dataenq.length"+dataenq.length.toString());
    //  log("dataenq.length"+dataenq[0]);
    if (dataenq.length > 0) {
      // clearAllData();
      print("datatatatata: .....");
      customerapicLoading = true;
      await mapValues3();
    }
    notifyListeners();
    if (dataAcc.length > 0) {
      log("ANBU");
      customerapicLoading = true;
      mapvaluesAcc();
    }
    notifyListeners();
    if (datasiteout.length > 0) {
      log("ANBUSiteOut");
      // clearAllData();
      customerapicLoading = true;
      mapvaluessiteout();
    }
    await  getLeveofType();
    await getCusTagType();
    await getdataFromDb();
   await callrefparnerApi();
    await stateApicallfromDB();
    await callAgeApi();
    await getEnqRefferes();
    await callLeadCheckApi();
    notifyListeners();
  }

  mapvaluessiteout() async{
    await getCusTagType();
    await getdataFromDb();
    await callrefparnerApi();
   await  getLeveofType();
    await stateApicallfromDB();
    await callAgeApi();
    await getEnqRefferes();
    await callLeadCheckApi();
    mycontroller[0].text =datasiteout[1]==null|| datasiteout[1] == "null"|| datasiteout[1].isEmpty 
        ? ""
        : datasiteout[1];
        mycontroller[1].text=datasiteout[2]==null|| datasiteout[2] == "null"|| datasiteout[2].isEmpty 
        ? ""
        : datasiteout[2];
        mycontroller[17].text=datasiteout[5]==null|| datasiteout[5] == "null"|| datasiteout[5].isEmpty 
        ? ""
        : datasiteout[5];
        mycontroller[2].text=datasiteout[6]==null|| datasiteout[6] == "null"|| datasiteout[6].isEmpty 
        ? ""
        : datasiteout[6];
        mycontroller[3].text=datasiteout[7]==null|| datasiteout[7] == "null"|| datasiteout[7].isEmpty 
        ? ""
        : datasiteout[7];
        mycontroller[4].text=datasiteout[12]==null|| datasiteout[12] == "null"||datasiteout[12] == "0"|| datasiteout[12].isEmpty 
        ? ""
        : datasiteout[12];
        mycontroller[5].text=datasiteout[9]==null|| datasiteout[9] == "null"|| datasiteout[9].isEmpty 
        ? ""
        : datasiteout[9];
        mycontroller[15].text=datasiteout[8]==null|| datasiteout[8] == "null"|| datasiteout[8].isEmpty 
        ? ""
        : datasiteout[8];
if(datasiteout[10] != null&& datasiteout[10].isNotEmpty 
       ){
for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].statecode.toString().toLowerCase() ==
          datasiteout[10].toString().toLowerCase()) {
             mycontroller[16].text=
             filterstateData[i].stateName.toString();
       
      }
    }
        }
 
       
        // basetype=6;
        // enqID=int.parse(datasiteout[0]);
    // log("mycontroller[0].text::" + mycontroller[0].text.toString());

    // mycontroller[1].text = datasiteout[1];
    // mycontroller[6].text = datasiteout[2];
    // mycontroller[7].text = datasiteout[3];
    // mycontroller[2].text = datasiteout[4];
    // mycontroller[3].text = datasiteout[5];
    // mycontroller[5].text = datasiteout[6];

    // mycontroller[15].text = datasiteout[7];
    // mycontroller[4].text = datasiteout[8];
    // isSelectedenquiryReffers = datasiteout[9];
    // // enqID = int.parse(datasiteout[6]);
    // log("AAAA" + mycontroller[0].text.toString());
    // isSelectedCsTag = datasiteout[9];
    customerapicLoading = false;
    datasiteout.clear();
    notifyListeners();
  }

  mapValues3() async {
    await getCusTagType();
    await getdataFromDb();
    await callrefparnerApi();
   await  getLeveofType();
    await stateApicallfromDB();
    await callAgeApi();
    await getEnqRefferes();
    await callLeadCheckApi();
    log("AAAAENQID" + dataenq[6].toString());
    // log("dataenq[10]::" + dataenq[2].toString());
    // log("ANBY::" + dataenq[7].toString());
    for (int i = 0; i < cusTagList.length; i++) {
      if (cusTagList[i].Name == dataenq[10]) {
        isSelectedCsTag = cusTagList[i].Code.toString();
        notifyListeners();
      }
      log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
    mycontroller[0].text =
        dataenq[0].isEmpty || dataenq[0] == "null" ? "" : dataenq[0];
    mycontroller[1].text =
        dataenq[1].isEmpty || dataenq[1] == "null" ? "" : dataenq[1];
    mycontroller[2].text = dataenq[2] == "null" ? "" : dataenq[2];
    mycontroller[3].text =
        dataenq[3].isEmpty || dataenq[3] == "null" ? "" : dataenq[3];
    mycontroller[4].text =
        dataenq[4].isEmpty || dataenq[4] == "null" ||dataenq[4] == "0"? "" : dataenq[4];
    mycontroller[5].text =
        dataenq[5].isEmpty || dataenq[5] == "null" ? "" : dataenq[5];
    mycontroller[7].text =
        dataenq[7].isEmpty || dataenq[7] == "null" ? "" : dataenq[7];
    mycontroller[16].text =
        dataenq[9].isEmpty || dataenq[9] == "null" ? "" : dataenq[9];
    mycontroller[15].text =
        dataenq[13].isEmpty || dataenq[13] == "null" ? "" : dataenq[13];
    mycontroller[6].text =
        dataenq[11].isEmpty || dataenq[11] == "null" ? "" : dataenq[11];
    mycontroller[17].text =
        dataenq[12].isEmpty || dataenq[12] == "null" ? "" : dataenq[12];
       if(dataenq[14] !=null ||dataenq[14] != "null"||dataenq[14].isNotEmpty) {
for(int i=0;i<leveofdata.length;i++){
          if(leveofdata[i].Name==dataenq[14]){
valueChosedStatus=leveofdata[i].Code;
          }
        }
       }
        if(dataenq[15] !=null ||dataenq[15] != "null"||dataenq[15].isNotEmpty) {
for(int i=0;i<ordertypedata.length;i++){
          if(ordertypedata[i].Name==dataenq[15]){
valueChosedCusType=ordertypedata[i].Code;
          }
        }
       }
        
    // isSelectedenquiryReffers =
    //     dataenq[8].isEmpty || dataenq[8] == "null" ? "" : dataenq[8];
    enqID = int.parse(dataenq[6]);
    basetype = 1;
    //  isSelectedrefcode
    for (int i = 0; i < enqReffList.length; i++) {
      if (enqReffList[i].Name == dataenq[8]) {
        isSelectedrefcode = enqReffList[i].Code.toString();
        isSelectedenquiryReffers = enqReffList[i].Name.toString();
        EnqRefer = enqReffList[i].Code.toString();
      }
    }
    customerapicLoading = false;
    dataenq.clear();
    notifyListeners();
    // log("enq: ${enqID}");
    // log("isSelectedCsTag: ${isSelectedCsTag}");
  }

  callEnqPageSB(
      BuildContext context, List<CheckEnqDetailsData> checkEnqDetailsData) {
    if (ConstantValues.sapUserType == 'Manager') {
      gotoMrgPage(context);
    } else {
      gotoUserPage(context);
    }
  }

  gotoUserPage(BuildContext context) {
    EnquiryUserContoller.isAlreadyenqOpen = true;
    EnquiryUserContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
    EnquiryUserContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    mycontroller[0].clear();
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.enquiriesUser);
    notifyListeners();
  }

  gotoMrgPage(BuildContext context) {
    EnquiryMangerContoller.isAlreadyenqOpen = true;
    EnquiryMangerContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
    EnquiryMangerContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    mycontroller[0].clear();
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.enquiriesManager);
    notifyListeners();
  }

  callEnqPageNSB(
      BuildContext context, List<CheckEnqDetailsData> checkEnqDetailsData) {
    EnquiryUserContoller.isAlreadyenqOpen = true;
    EnquiryUserContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
    EnquiryUserContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    mycontroller[0].clear();
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.enquiriesUser);
    notifyListeners();
  }

  clearbool() {
    timebool = false;
    Datebool = false;
  }

  getDate2(BuildContext context) async {
    errorTime = "";

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
//  firstDate: DateTime.now().subtract(Duration(days: 1)),
//   lastDate: DateTime(2100),
    if (pickedDate != null) {
      mycontroller[17].text = "";
      print(pickedDate);
      var datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[16].text = datetype;
      // mycontroller[44].text = datetype!;
      // print(datetype);
    } else {
      print("Date is not selected");
    }
    notifyListeners();
  }

  String errorTime2 = "";
  

  List<LevelofData> leveofdata=[];
 List<OrderTypeData> ordertypedata=[];
   getLeveofType() async {
    leveofdata.clear();
    ordertypedata.clear();
    final Database db = (await DBHelper.getInstance())!;

    leveofdata = await DBOperation.getlevelofData(db);
    ordertypedata=await DBOperation.getordertypeData(db);
    notifyListeners();
  }

  clearAllData() {
    excError='';
    errorTime='';
    selectedapartname='';
      selectedapartcode='';
     refpartdata.clear();
      mycontroller[46].clear();
  filterrefpartdata.clear();
    leveofdata.clear();
    ordertypedata.clear();
     enquirydetails.clear();
     leaddetails.clear();
     orderdetails.clear();
    valueChosedStatus=null;
    valueChosedCusType=null;
    visiblefollTime = false;
    //above new variable
    remswitch=false;
    istimevalid = false;
    mycontroller[19].clear();
    isSelectedrefcode = '';
    clearbool();
     reyear=null;
 remonth=null;
 reday=null;
 rehours=null;
 reminutes=null;
    isText1Correct = false;
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    String statecode = '';
    String countrycode = '';
    String statename = '';
    statebool = false;
    isAnother == true;

    isSelectedenquirytype = '';
    isSelectedAge = '';
    isSelectedcomeas = '';
    isSelectedGender = '';
    isSelectedAdvertisement = '';
    isSelectedenquiryReffers = '';
    EnqRefer = null;
    customerapicalled = false;
    oldcutomer = false;
    customerapicLoading = false;
    productDetails.clear();
    exceptionOnApiCall = '';
    pageChanged = 0;
    showItemList = true;
    isSelectedCsTag = '';
    cusTagList.clear();
    // isComeFromEnq = false;s
    isloadingBtn = false;
    enqID = null;
    nextFDTime = '';
    resetListSelection();
    notifyListeners();
  }

  checkDate() {}

  String apiFDate = '';
  void showpurchaseDate(BuildContext context) {
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
      mycontroller[14].text='';
      mycontroller[19].text='';
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00";
      log("APIFpurchase::" + apiFDate);
      isdatevalid = false;
      mycontroller[13].text = chooseddate;
      notifyListeners();
    });
  }

  String apiNdate = '';
  String excError = '';
  bool isdatevalid = false;
  void showFollowDate(BuildContext context) {
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
      mycontroller[19].text='';
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiNdate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiNdate);
       reyear=date.year;
   remonth=date.month;
   reday=date.day;
   notifyListeners();
      if ( mycontroller[13].text.isNotEmpty) {
        DateTime planPurDate;
        DateTime Nextfdate;
        planPurDate = DateTime.parse(apiFDate);
        Nextfdate = DateTime.parse(apiNdate);
        if (Nextfdate.isAfter(planPurDate)) {
          mycontroller[14].text = '';
          isdatevalid = true;
          excError = 'Choose less then Purchase Date';
          notifyListeners();
        } else {
          mycontroller[14].text = chooseddate;
          visiblefollTime = true;
          isdatevalid = false;
          notifyListeners();
        }
      } else {
        mycontroller[14].text = '';
        isdatevalid = true;
        excError = 'Choose Purchase Date';
        notifyListeners();
      }
    });
  }

  //lead check list Api

  List<LeadCheckData> leadcheccklist = [];
  List<LeadCheckData> leadcheckdatas = [];
  List<LeadCheckData> get getleadcheckdatas => leadcheckdatas;
  String LeadCheckDataExcep = '';
  String get getLeadCheckDataExcep => LeadCheckDataExcep;

  callLeadCheckApi() {
    GetLeadCheckListApi.getData('${ConstantValues.slpcode}').then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckdata != null) {
          leadcheckdatas = value.leadcheckdata!;
          log("ininin");
//           for(int i=0;i<=value.leadcheckdata!.length;i++){
// leadcheckdatas[0].linenum=  int.parse(value.leadcheckdata![i].toString());
// log("linenummmm:"+leadcheckdatas[0].linenum.toString());
// log("linenummmm:"+value.leadcheckdata![i].toString());

//           }
        } else if (value.leadcheckdata == null) {
          LeadCheckDataExcep = 'Lead check data not found..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      } else if (value.stcode == 500) {
        LeadCheckDataExcep = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      }
    });
  }

  LeadcheckListClicked(bool? v, int i) {
    leadcheckdatas[i].ischecked = v;
    notifyListeners();
  }

  resetListSelection() {
    for (int i = 0; i < leadcheckdatas.length; i++) {
      leadcheckdatas[i].ischecked = false;
    }
  }

  int docnum = 0;

//save all values tp server
int? reyear;
int? remonth;
int? reday;
int? rehours;
int? reminutes;
  saveToServer(BuildContext context) {
    log("enqID::" + enqID.toString());
    String date = config.currentDateOnly();
    PatchExCus patch = new PatchExCus();
    patch.CardCode = mycontroller[0].text;
    patch.CardName = mycontroller[1].text;
    //patch.CardType =  mycontroller[2].text;
    patch.U_Address1 =
        mycontroller[2].text == null || mycontroller[2].text.isEmpty
            ? null
            : mycontroller[2].text;
    patch.U_Address2 =
        mycontroller[3].text == null || mycontroller[3].text.isEmpty
            ? null
            : mycontroller[3].text;
    patch.U_Pincode =
        mycontroller[4].text == null || mycontroller[4].text.isEmpty
            ? null
            : mycontroller[4].text;
    patch.U_City = mycontroller[5].text == null || mycontroller[5].text.isEmpty
        ? null
        : mycontroller[5].text;
    //patch.U_Country =  mycontroller[6].text;
    patch.U_EMail = mycontroller[7].text == null || mycontroller[7].text.isEmpty
        ? null
        : mycontroller[7].text;
    patch.U_Type = isSelectedCsTag == null || isSelectedCsTag.isEmpty
        ? null
        : isSelectedCsTag;
    patch.area = mycontroller[15].text == null || mycontroller[15].text.isEmpty
        ? null
        : mycontroller[15].text;
    patch.U_State = statecode;
    patch.U_Country = countrycode;
    patch.altermobileNo =
        mycontroller[6].text == null || mycontroller[6].text.isEmpty
            ? null
            : mycontroller[6].text;
    patch.cantactName =
        mycontroller[17].text == null || mycontroller[17].text.isEmpty
            ? null
            : mycontroller[17].text;
    patch.enqid = enqID == null ? 0 : enqID;
    patch.enqtype = basetype == null ? 0 : basetype;
  patch.levelof=valueChosedStatus==null ||valueChosedStatus!.isEmpty?null:valueChosedStatus;
        patch.ordertype=valueChosedCusType==null ||valueChosedCusType!.isEmpty?null:valueChosedCusType;

    PostLead postLead = new PostLead();
    postLead.docEntry = 0;
    postLead.docnum = 0;
    postLead.docstatus = "O";
    postLead.DocType = "dDocument_Items";
    postLead.CardCode = mycontroller[0].text;
    postLead.CardName = mycontroller[1].text;
    postLead.DocDate = date;
    postLead.U_sk_Address1 =
        mycontroller[2].text.isEmpty || mycontroller[2].text == null
            ? null
            : mycontroller[2].text;
    postLead.U_sk_Address2 =
        mycontroller[3].text.isEmpty || mycontroller[3].text == null
            ? null
            : mycontroller[3].text;
    postLead.U_sk_Pincode =
        mycontroller[4].text.isEmpty || mycontroller[4].text == null
            ? null
            : mycontroller[4].text;
    postLead.U_sk_City =
        mycontroller[5].text.isEmpty || mycontroller[5].text == null
            ? null
            : mycontroller[5].text;
    postLead.U_sk_alternatemobile =
        mycontroller[6].text.isEmpty || mycontroller[6].text == null
            ? null
            : mycontroller[6].text;
    postLead.U_sk_email =
        mycontroller[7].text.isEmpty || mycontroller[7].text == null
            ? null
            : mycontroller[7].text;
    postLead.U_sk_headcount =
        mycontroller[8].text.isEmpty || mycontroller[8].text == null
            ? "0"
            : mycontroller[8].text;
    postLead.U_sk_budget =
        mycontroller[9].text.isEmpty || mycontroller[9].text == null
            ? "0"
            : mycontroller[9].text;
    postLead.U_sk_gender = isSelectedcomeas.isEmpty || isSelectedcomeas == null
        ? null
        : isSelectedGender;
    postLead.U_sk_Agegroup =
        isSelectedcomeas.isEmpty || isSelectedcomeas == null
            ? null
            : isSelectedAge;
    postLead.U_sk_cameas = isSelectedcomeas.isEmpty || isSelectedcomeas == null
        ? null
        : isSelectedcomeas;
    postLead.U_sk_Referals = isSelectedrefcode;
    postLead.U_sk_NextFollowDt =
        config.alignDateforFollow(nextFDTime, apiNdate);
    postLead.U_sk_planofpurchase = apiFDate;
    postLead.docLine = productDetails;
    postLead.slpCode = ConstantValues.slpcode; //enqID
    postLead.enqID = enqID;

    // RaabitMQApi.getData(patch).then((value) {
    //      if (value.stcode! >= 200 && value.stcode! <= 210) {
    //       print("${value.message}");
    //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
    //      isloadingBtn = false;
    //     notifyListeners();
    //      showLeadDeatilsDialog(context, " Some thing wrong Try agin..!!");
    //   } else if (value.stcode! >= 500) {
    //     isloadingBtn = false;
    //     notifyListeners();
    //      showLeadDeatilsDialog(context, " Some thing wrong Try agin..!!");
    //   }
    // });
    if (getnextFDTime == null || getnextFDTime.isEmpty) {
      errorTime = '';
      errorTime = 'Choose Next Followup Time';
    } else {
      errorTime = '';
      if (isComeFromEnq == true) {
        oldcutomer = true;
      }

      if (oldcutomer == true) {
        isloadingBtn = true;
        notifyListeners();
        callNewCus(context, patch, postLead);
      } else {
        isloadingBtn = true;
        notifyListeners();
        callNewCus(context, patch, postLead);
      }
    }
  }

  //call save lead api
  late List<leadmaster> successRes = [];
  List<leadmaster> get getsuccessRes => successRes;
  // LeadSavePostModal get getsuccessRes => successRes;
  // late LeadSavePostModal successRes;
  // LeadSavePostModal get getsuccessRes => successRes;

  // callLeadSavePostApi(BuildContext context, PostLead postLead) {
  //   //fs
  //   log("ANBUUU" + postLead.docstatus.toString());
  //   print(ConstantValues.sapUserType);
  //   LeadSavePostApi.getData(ConstantValues.sapUserType, postLead).then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       successRes = value;
  //       LeadSuccessPageState.getsuccessRes = value;
  //       log("docno : " + successRes.DocNo.toString());
  //       notifyListeners();
  //       callCheckListApi(context, value.DocEntry!);
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(context, value.exception!);
  //     } else if (value.stcode! >= 500) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(context, " Some thing wrong \n${value.stcode} ${value.exception}..!!");
  //     }
  //   });
  // }

  // call save apis
  String statecode = '';
  String countrycode = '';
  String statename = '';

  stateontap(int i) {
    log("AAAA::" + i.toString());
    statebool = false;
    mycontroller[16].text = filterstateData[i].stateName.toString();
    statecode = filterstateData[i].statecode.toString();
    statename = filterstateData[i].stateName.toString();
    countrycode = filterstateData[i].countrycode.toString();
    log("statecode::" + statecode.toString());
    log("statecode::" + countrycode.toString());
    notifyListeners();
  }

  List<stateHeaderData> stateData = [];
  List<stateHeaderData> filterstateData = [];
  bool statebool = false;
  List<AgeData> ageData = [];

  List<GenderData> genderData = [];
  List<CameAsData> camaAsData = [];

  callAgeApi() async {
    await AgeApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.ageLtData != null) {
          ageData = value.ageLtData!;

          notifyListeners();
        } else if (value.ageLtData == null) {
          log("DONR222");
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        notifyListeners();
      } else if (value.stcode == 500) {
        notifyListeners();
      }
    });

    //gender Api
    await GenderApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.genderLtData != null) {
          genderData = value.genderLtData!;

          notifyListeners();
        } else if (value.genderLtData == null) {
          log("DONR222");
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        notifyListeners();
      } else if (value.stcode == 500) {
        notifyListeners();
      }
    });

    //cameAsApi
    await CameAsApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.camaAsData != null) {
          camaAsData = value.camaAsData!;

          notifyListeners();
        } else if (value.camaAsData == null) {
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

  stateApicallfromDB() async {
    stateData.clear();
    filterstateData.clear();

    final Database db = (await DBHelper.getInstance())!;
    stateData = await DBOperation.getstateData(db);
    filterstateData = stateData;
    log("getCustomerListFromDB length::" + filterstateData.length.toString());
    notifyListeners();
  }

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
      filterstateData = stateData;
      notifyListeners();
    }
  }

  bool isloadingBtn = false;
  bool get getisloadingBtn => isloadingBtn;

  callNewCus(BuildContext context, PatchExCus? patch, PostLead? postLead) {
    String date = config.currentDateOnly();
    for (int i = 0; i < leadcheckdatas.length; i++) {
      if (leadcheckdatas[i].ischecked == true) {
        leadcheccklist.add(LeadCheckData(
          linenum: leadcheckdatas[i].linenum,
          id: leadcheckdatas[i].id,
          Name: leadcheckdatas[i].Name,
          MasterTypeId: leadcheckdatas[i].MasterTypeId,
          ischecked: leadcheckdatas[i].ischecked,
          Code: leadcheckdatas[i].Code,
        ));
        log("linenummmm:" + leadcheckdatas[i].Code.toString());
      }
    }

    NewCustCretApi.getData(
            ConstantValues.sapUserType, patch!, leadcheccklist, postLead!)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        successRes = value.datali!.leaddetail!;
        LeadSuccessPageState.getsuccessRes = value.datali!;
        log("docno : " + successRes[0].DocNo.toString());
        isloadingBtn = false;
        isComeFromEnq = false;
        enqID = null;
        notifyListeners();
        Get.toNamed(ConstantRoutes.successLead);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
            context, "${value.message}..!! ${value.exception}....!!");
        // config.msgDialog(
        //     context, "Some thing wrong..!!", value.error!.message!.value!);
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "${value.stcode!}..!!Network Issue..\nTry again Later..!!",
        );
        // config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
      }
    });
  }
  // callNewCus(BuildContext context, PatchExCus? patch, PostLead? postLead) {
  //   NewCustCretApi.getData(ConstantValues.sapUserType, patch!, postLead!)
  //       .then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       callLeadSavePostApi(context, postLead);
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(context, "${value.stcode} ${value.exception}");
  //       // config.msgDialog(
  //       //     context, "Some thing wrong..!!", value.error!.message!.value!);
  //     } else if (value.stcode! >= 500) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(
  //         context,
  //         "Some thing wrong \n${value.stcode} ${value.exception}..!!",
  //       );
  //       // config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
  //     }
  //   });
  // }

  fortest() {
    for (int i = 0; i <= leadcheckdatas.length; i++) {
      leadcheckdatas[i].linenum = i + 1;
      log("linenummmm:" + leadcheckdatas[i].linenum.toString());
// log("linenummmm:"+value.leadcheckdata![i].toString());
    }
  }

  //
  int docnum1 = 0;
  callCheckListApi(BuildContext context, int docEntry) {
    //  LeadCheckPostApi.printData(leadcheckdatas, docEntry);
    String date = config.currentDateOnly();
    for (int i = 0; i < leadcheckdatas.length; i++) {
      int line = i + 1;
      leadcheckdatas[i].linenum = line;
      log("linenummmm:" + leadcheckdatas[i].linenum.toString());
// log("linenummmm:"+value.leadcheckdata![i].toString());
    }
    LeadCheckPostApi.getData(
            ConstantValues.sapUserType, leadcheckdatas, docEntry, docnum1)
        .then((value) {
      if (value >= 200 && value <= 210) {
        LeadFollowupApiData leadFollowupApiData = new LeadFollowupApiData();
        leadFollowupApiData.date = date;
        leadFollowupApiData.nextFollowUp =
            config.alignDateforFollow(nextFDTime, apiNdate);
        leadFollowupApiData.name = isSelectedenquiryReffers;
        leadFollowupApiData.code = isSelectedrefcode;
        callFollowupLead(context, leadFollowupApiData, docEntry);
        //  isloadingBtn = false;
        //  notifyListeners();
        //  Get.toNamed(ConstantRoutes.successLead);

        //  config.msgDialog(  --old
        //  context, "Success..!!", "Lead Successfully created..!!");
      } else if (value >= 400 && value <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "Some thing wrong..!!",
        );
        // config.msgDialog(context, "Some thing wrong..!!","Try agin..!!");
      } else if (value >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "${value!}..!!Network Issue..\nTry again Later..!!",
        );
        //config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
      }
    });
  }

  bool remswitch = false;
  switchremainder(bool val,String? title) {
    remswitch = val;
    if(remswitch ==true){
      addgoogle(title);
      notifyListeners();
    }
    notifyListeners();
  }
addgoogle(String? title){
   Config config2 = Config();
    tz.TZDateTime? tzChosenDate;
  final DateTime chosenDate = DateTime(reyear!, remonth!, reday!, rehours!, reminutes!);
 final tz.Location indian = tz.getLocation('Asia/Kolkata');
         tzChosenDate = tz.TZDateTime.from(chosenDate, indian);
          config2.  addEventToCalendar(tzChosenDate!,"$title","Lead");
}
  // Followup Lead

  callFollowupLead(
    BuildContext context,
    LeadFollowupApiData leadFollowupApiData,
    int docEntry,
  ) {
    //fs
    LeadFollowupApi.getData(
            ConstantValues.slpcode, leadFollowupApiData, docEntry)
        .then((value) {
      if (value >= 200 && value <= 210) {
        isloadingBtn = false;
        isComeFromEnq = false;
        enqID = null;
        notifyListeners();
        Get.toNamed(ConstantRoutes.successLead);
        //  Future.delayed(Duration(seconds: 2),(){
        //  // Navigator.pop(context);
        //   Get.offAllNamed(ConstantRoutes.leadstab);
        //  });

        //  config.msgDialog(  --old
        //  context, "Success..!!", "Lead Successfully created..!!");
      } else if (value >= 400 && value <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "Some thing wrong ..!!",
        );
        //config.msgDialog(context, "Some thing wrong..!!","Try agin..!!");
      } else if (value >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "${value}..!!Network Issue..\nTry again Later..!!",
        );
        //config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
      }
    });
  }

  //for success page

  //next btns

  firstPageNextBtn(BuildContext context) {
    int passed = 0;
    log("pageChanged: ${pageChanged}");
    // if (isSelectedGender.isEmpty) {
    //   passed = passed + 1;
    //   validateGender = true;
    // }
    // if (isSelectedAge.isEmpty) {
    //   passed = passed + 1;
    //   validateAge = true;
    // }
    // if (isSelectedcomeas.isEmpty) {
    //   print("object");
    //   passed = passed + 1;
    //   validateComas = true;
    // }
    if (mycontroller[16].text.isNotEmpty) {
      methidstate(mycontroller[16].text,context);
      notifyListeners();
    }
    log("message" + statecode.toString());
    if (formkey[0].currentState!.validate()) {
      if(isSelectedCsTag.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Enter Customer Group..!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        ); 
      }
      else if (mycontroller[16].text.isEmpty|| statecode.isEmpty && countrycode.isEmpty) {
        isText1Correct = true;
        notifyListeners();
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select Correct State"),));
      }
      
      else{

      
    
      if  (passed == 0) {
        FocusScope.of(context).unfocus();
        pageController.animateToPage(++pageChanged,
            duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
        resetValidate();
      }
      
      }
      
    }
    notifyListeners();
  }

  seconPageBtnClicked() {
    if (productDetails.length > 0) {
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else {
      Get.snackbar("Field Empty", "Choose products..!!",
          backgroundColor: Colors.red);
    }
  }

  thirPageBtnClicked(BuildContext context) {
    int passed = 0;
    errorTime='';
    excError='';
    if (formkey[1].currentState!.validate()) {
      if (passed == 0) {
        // LeadSavePostApi.printData(postLead);
        saveToServer(context);
      }
    }
    if (isSelectedenquiryReffers.isEmpty) {
      visibleRefferal = true;
    }
    notifyListeners();
  }

  showLeadDeatilsDialog(BuildContext context, String msg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(msg: msg);
        });
  }

  resetValidate() {
    validateGender = false;
    validateAge = false;
    validateComas = false;
    notifyListeners();
  }

  resetValidateThird() {
    visibleRefferal = false;
    notifyListeners();
  }

  String errorTime = "";
  String nextFDTime = '';
  bool istimevalid = false;
  String get getnextFDTime => nextFDTime;
  selectTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay startTime = TimeOfDay(hour: 7, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);
    if (mycontroller[14].text.isNotEmpty) {
      errorTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );

      if (newTime != null) {
        log("newTime111::" + newTime.toString());

        timee = newTime;
        log("timee::" + timee.toString());
        // if (timee.hour < startTime.hour || timee.hour > endTime.hour|| (timee.hour == endTime.hour && timee.minute > endTime.minute)) {
        //   istimevalid = true;
        //   errorTime = "Schedule Time between 7AM to 10PM";
        //   nextFDTime = "";
        //   mycontroller[19].text ='';
        //   notifyListeners();
        // } else {
           log("mycontroller[5256162e].text :::"+DateFormat('dd-MM-yyyy').format(DateTime.now()));
          log("mycontroller[14].text :::"+mycontroller[14].text.toString());
          if (mycontroller[14].text == DateFormat('dd-MM-yyyy').format(DateTime.now())) {
            if (timee.hour < TimeOfDay.now().hour||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute) ) {
              errorTime = "Please Choose Correct Time";
              nextFDTime = "";
              istimevalid = true;
              mycontroller[19].clear();
              notifyListeners();
              print("error");
            } else {
              errorTime = "";
              print("correct11");
              istimevalid = false;
              nextFDTime = timee.format(context).toString();
               mycontroller[19].text = nextFDTime;
                rehours=timee.hour;
             reminutes=timee.minute;

              log("nextFDTime::"+nextFDTime.toString());
            }
          } else {
            errorTime = "";
            print("correct22");
            timee = newTime;
            nextFDTime = timee.format(context).toString();
            mycontroller[19].text = nextFDTime;
             rehours=timee.hour;
             reminutes=timee.minute;
             istimevalid = false;
             notifyListeners();
          }
          istimevalid = false;
        // }
        notifyListeners();
      }
      notifyListeners();
    } else {
      nextFDTime = "";
      errorTime = "Please Choose First Date";
      istimevalid = true;
      notifyListeners();
    }
    notifyListeners();
  }
   
  showBottomSheetInsert2forEdit(BuildContext context, int i) {
    final theme = Theme.of(context);
     int? indexshow;
    selectedItemName = productDetails[i].ItemDescription.toString();
    selectedItemCode = productDetails[i].ItemCode.toString();
     for( int ij=0 ;ij<allProductDetails.length;ij++){
      if(allProductDetails[ij].itemCode ==selectedItemCode){
indexshow=ij;
break;
      }
    }
    // mycontroller[27].text =
    //     productDetails[i].sp == null ? "0" : productDetails[i].sp.toString();
    // mycontroller[28].text = productDetails[i].slpprice == null
    //     ? "0"
    //     : productDetails[i].slpprice.toString();
    // mycontroller[29].text = productDetails[i].storestock == null
    //     ? "0"
    //     : productDetails[i].storestock.toString();
    // mycontroller[30].text = productDetails[i].whsestock == null
    //     ? "0"
    //     : productDetails[i].whsestock.toString();

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Container(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: Screens.width(context)*0.8,
                        child: Text(productDetails[i].ItemCode.toString(),
                            style: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor)),
                      ),
                      Container(
                        width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text(
                            productDetails[i].ItemDescription.toString(),
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       createTable4(theme, indexshow!),
                      // SizedBox(
                      //   height: Screens.padingHeight(context) * 0.06,
                      //   child: TextFormField(
                      //     enabled: true,
                      //     controller: mycontroller[27],
                      //     readOnly: true,
                      //     style: TextStyle(fontSize: 15),
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 1, color: theme.primaryColor),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),

                      //       alignLabelWithHint: true,
                      //       hintText: "",
                      //       labelText: "SP",
                      //       labelStyle: theme.textTheme.bodyText1
                      //           ?.copyWith(color: theme.primaryColor),

                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 10),

                      //       // border: OutlineInputBorder(

                      //       //   borderRadius: BorderRadius.all(
                      //       //     Radius.circular(10),
                      //       //   ),
                      //       // ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: Screens.width(context) * 0.44,
                      //       height: Screens.padingHeight(context) * 0.06,
                      //       child: TextFormField(
                      //         // enabled: tr,
                      //         controller: mycontroller[28],
                      //         readOnly: true,
                      //         style: TextStyle(fontSize: 15),
                      //         decoration: InputDecoration(
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 width: 1, color: theme.primaryColor),
                      //             borderRadius: BorderRadius.circular(10),
                      //           ),
                      //           alignLabelWithHint: true,
                      //           hintText: "",
                      //           labelText: "Cost",
                      //           labelStyle: theme.textTheme.bodyText1
                      //               ?.copyWith(color: theme.primaryColor),
                      //           contentPadding: EdgeInsets.symmetric(
                      //               vertical: 10, horizontal: 10),
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(8),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: Screens.width(context) * 0.44,
                      //       height: Screens.padingHeight(context) * 0.06,
                      //       child: TextFormField(
                      //         // enabled: tr,
                      //         controller: mycontroller[41],
                      //         readOnly: true,
                      //         style: TextStyle(fontSize: 15),
                      //         decoration: InputDecoration(
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 width: 1, color: theme.primaryColor),
                      //             borderRadius: BorderRadius.circular(10),
                      //           ),
                      //           alignLabelWithHint: true,
                      //           hintText: "",
                      //           labelText: "MRP",
                      //           labelStyle: theme.textTheme.bodyText1
                      //               ?.copyWith(color: theme.primaryColor),
                      //           contentPadding: EdgeInsets.symmetric(
                      //               vertical: 10, horizontal: 10),
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(8),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 5,
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      //  SizedBox(
                      //       width: 15,
                      //     ),
                      createTable(theme, indexshow!),
                      SizedBox(
                        height: 5,
                      ),
                      createTable2(theme, indexshow!),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Store Age Slab:",
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                       createTable5(theme, indexshow!),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Whse Age Slab:",
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      createTable6(theme, indexshow!),
                      Divider(
                        color: theme.primaryColor,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // SizedBox(
                      //   child: TextFormField(
                      //     // enabled: isTextFieldEnabled,
                      //     controller: mycontroller[29],
                      //     readOnly: true,
                      //     style: TextStyle(fontSize: 15),
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 1, color: theme.primaryColor),
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       alignLabelWithHint: true,
                      //       hintText: "",
                      //       labelText: "Store Stock",
                      //       labelStyle: theme.textTheme.bodyText1
                      //           ?.copyWith(color: theme.primaryColor),
                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 10),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(10),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SizedBox(
                      //   child: TextFormField(
                      //     enabled: true,
                      //     controller: mycontroller[30],
                      //     readOnly: true,
                      //     style: TextStyle(fontSize: 15),
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 1, color: theme.primaryColor),
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       alignLabelWithHint: true,
                      //       hintText: "",
                      //       labelText: "Whs Stock",
                      //       labelStyle: theme.textTheme.bodyText1
                      //           ?.copyWith(color: theme.primaryColor),
                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 10),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(8),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      createTable3(theme, indexshow),
                       SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Fixed Price",
                                    style: theme.textTheme.bodyText1
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  child: Text(
                                    ":",
                                    style: theme.textTheme.bodyText1?.copyWith(),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      // color: Colors.green[200],
                                      borderRadius: BorderRadius.circular(4)),
                                  child: allProductDetails[indexshow].isFixedPrice==true?
                                        Icon(Icons.check,color: Colors.green,): 
                                        Icon(Icons.close,color: Colors.red,)
                                ),
                              ],
                            ),
                          ),
                        Container(
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                "Allow Negative Stock",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: theme.primaryColor),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              child: Text(
                                ":",
                                style: theme.textTheme.bodyText1?.copyWith(),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  // color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(4)),
                              child: allProductDetails[indexshow].allowNegativeStock==true?
                                Icon(Icons.check,color: Colors.green,): 
                                Icon(Icons.close,color: Colors.red,)
                            ),
                          ],
                        ),
                      ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Accept Below cost Price",
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            child: Text(
                              ":",
                              style: theme.textTheme.bodyText1?.copyWith(),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                // color: Colors.green[200],
                                borderRadius: BorderRadius.circular(4)),
                            child: allProductDetails[indexshow].allowOrderBelowCost==true?
                              Icon(Icons.check,color: Colors.green,): 
                              Icon(Icons.close,color: Colors.red,)
                          ),
                        ],
                      ),
                     
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              notifyListeners();
                            },
                            child: Text("ok")),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

showBottomSheetInsertedit(BuildContext context, int i) {
    final theme = Theme.of(context);
    selectedItemName = productDetails[i].ItemDescription.toString();
    selectedItemCode = productDetails[i].ItemCode.toString();
     isfixedpriceorder=productDetails[i].isfixedprice;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, st) {
        return Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Form(
              key: formkey[1],
              child: Container(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Screens.width(context)*0.8,
                                child: Text(productDetails[i].ItemCode.toString(),
                                    style: theme.textTheme.bodyText1
                                        ?.copyWith(color: theme.primaryColor)),
                              ),
                          
                          Container(
                        width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text(productDetails[i].ItemDescription.toString(),
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),  ],
                          ),
                       InkWell(
                            onTap: () {
                              // mycontroller[27].clear();
                              // mycontroller[28].clear();
                              // mycontroller[29].clear();
                              // mycontroller[30].clear();
                              // mycontroller[41].clear();

                              showBottomSheetInsert2forEdit(context, i);
                              notifyListeners();
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              //  padding: const EdgeInsets.only(right:10 ),
                              width: Screens.width(context) * 0.05,
                              height: Screens.padingHeight(context) * 0.04,
                              child: Center(
                                  child: Icon(Icons.more_vert,
                                      color: Colors.white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        // width: 270,
                        // height: 40,
                        child: new TextFormField(
                          controller: mycontroller[10],
                          onChanged: (val) {
                            st(() {
                              if (val.length > 0) {
                                if (mycontroller[10].text.length > 0 &&
                                    mycontroller[11].text.length > 0) {
                                  unitPrice =
                                      double.parse(mycontroller[10].text);
                                  quantity = int.parse(mycontroller[11].text);
                                  total = unitPrice! * quantity!;
                                  print(total);
                                }
                              }
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "ENTER UNIT PRICE";
                            }
                            return null;
                          },
                          readOnly:  productDetails[i].isfixedprice ==false ?false:
                           true,
                          keyboardType:  TextInputType.numberWithOptions(decimal: true),
                           inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "Unit Price",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        // width: 270,
                        // height: 40,
                        child: new TextFormField(
                          controller: mycontroller[11],
                          onChanged: (val) {
                            st(() {
                              if (val.length > 0) {
                                if (mycontroller[10].text.length > 0 &&
                                    mycontroller[11].text.length > 0) {
                                  unitPrice =
                                      double.parse(mycontroller[10].text);
                                  quantity = int.parse(mycontroller[11].text);
                                  total = unitPrice! * quantity!;
                                  print(total);
                                }
                              }
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "ENTER QUANTITY";
                            }
                            return null;
                          },
                          // readOnly: isDescriptionSelected == "TRANSPORTCHARGES"
                          //     ? true
                          //     : false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "quantity",
                          ),
                        ),
                      ),
                      //  ),
                       SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap:(){
                                 showDialog<dynamic>(
                                                          context: context,
                                                          builder: (_) {
                                                            return ShowSearchDialog();
                                                          }).then((value) {
                                                            mycontroller[29].clear();
                                                            filterrefpartdata=refpartdata;
                                                            notifyListeners();
                                                          //  context
                                                          //   .read<
                                                          //       NewEnqController>()
                                                          //   .setcatagorydata();    
                                                            });

                        },
                        child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Referal Partner",
                                    style: theme.textTheme.bodyText1!.copyWith(
                                        color: theme.primaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                      ),
                      // SizedBox(
                      //   // width: 270,
                      //   // height: 40,
                      //   child: new TextFormField(
                      //     controller: mycontroller[46],
                          
                      //     readOnly: true ,
                      //     onTap: (){
                      //        showDialog<dynamic>(
                      //                                     context: context,
                      //                                     builder: (_) {
                      //                                       return ShowSearchDialog();
                      //                                     }).then((value) {
                      //                                       mycontroller[29].clear();
                      //                                       filterrefpartdata=refpartdata;
                      //                                       notifyListeners();
                      //                                     //  context
                      //                                     //   .read<
                      //                                     //       NewEnqController>()
                      //                                     //   .setcatagorydata();    
                      //                                       });
                      //     },
                      //     // validator: (value) {
                      //     //   if (value!.isEmpty) {
                      //     //     return "ENTER QUANTITY";
                      //     //   }
                      //     //   return null;
                      //     // },
                          
                      //     style: TextStyle(fontSize: 15),
                      //     decoration: InputDecoration(
                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 10),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(10),
                      //         ),
                      //       ),
                      //       labelText: "referal partner",
                      //       suffixIcon: Icon(Icons.search)
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Total: $total")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("cancel")),
                          isUpdateClicked == false
                              ? ElevatedButton(
                                  onPressed: () {
                                     if(mycontroller[11].text.isNotEmpty&&int.parse(mycontroller[11].text) > 0){
 mycontroller[12].clear();
                                    addProductDetails(context);
                                     }else{

                                      showtoastproduct();
                                       

                                    }
                                   
                                  },
                                  child: Text("ok"))
                              : ElevatedButton(
                                  onPressed: () {
                                    if(mycontroller[11].text.isNotEmpty&&int.parse(mycontroller[11].text) > 0){
  updateProductDetails(context, i);
                                    }else{
                                       showtoastproduct();
                                    }
                                  
                                  },
                                  child: Text("Update")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
bool? isfixedpriceorder=false;

 Widget createTable(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp1}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp2}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp3}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp4}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp5}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp1.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp2.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp5.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(1.0),
      2: FlexColumnWidth(1.0),
      3: FlexColumnWidth(1.0),
      4: FlexColumnWidth(1.0),
    }, children: rows);
  }
  Widget createTable3(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Store Stock",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Whs Stock",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
     
    ]));
   
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].storeStock.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].whsStock.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(2.0),
     
    }, children: rows);
  }

  Widget createTable4(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "SP",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Cost",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "MRP",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
     
    ]));
   
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].sp.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(2.0),
      2: FlexColumnWidth(2.0),
     
    }, children: rows);
  }
Widget createTable5(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab1}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab2}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab3}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab4}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
     
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].storeAgeSlab1.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].storeAgeSlab2.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].storeAgeSlab3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].storeAgeSlab4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
     
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(1.5),
      3: FlexColumnWidth(1.5),
      
    }, children: rows);
  }

  Widget createTable6(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab1}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab2}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab3}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab4}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
     
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].whsAgeSlab1.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].whsAgeSlab2.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].whsAgeSlab3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].whsAgeSlab4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
     
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(1.5),
      3: FlexColumnWidth(1.5),
      
    }, children: rows);
  }
  
   Widget createTable2(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp1_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp2_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp3_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp4_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp5_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp5Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(1.0),
      2: FlexColumnWidth(1.0),
      3: FlexColumnWidth(1.0),
      4: FlexColumnWidth(1.0),
    }, children: rows);
  }
  showBottomSheetInsert2(BuildContext context, int i) {
    final theme = Theme.of(context);
    selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    // mycontroller[27].text = allProductDetails[i].sp == null
    //     ? "0"
    //     : allProductDetails[i].sp.toString();
    // mycontroller[28].text = allProductDetails[i].slpPrice == null
    //     ? "0"
    //     : allProductDetails[i].slpPrice.toString();
    // mycontroller[29].text = allProductDetails[i].storeStock == null
    //     ? "0"
    //     : allProductDetails[i].storeStock.toString();
    // mycontroller[30].text = allProductDetails[i].whsStock == null
    //     ? "0"
    //     : allProductDetails[i].whsStock.toString();
    // mycontroller[41].text = allProductDetails[i].mgrPrice == null
    //     ? "0"
    //     : allProductDetails[i].mgrPrice.toString();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Container(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        // width: Screens.width(context)*0.8,
                        child: Text(allProductDetails[i].itemCode.toString(),
                            style: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor)),
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text(allProductDetails[i].itemName.toString(),
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      createTable4(theme, i),
                      // SizedBox(
                      //   height: Screens.padingHeight(context) * 0.06,
                      //   child: TextFormField(
                      //     enabled: true,
                      //     controller: mycontroller[27],
                      //     readOnly: true,
                      //     style: TextStyle(fontSize: 15),
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 1, color: theme.primaryColor),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),

                      //       alignLabelWithHint: true,
                      //       hintText: "",
                      //       labelText: "SP",
                      //       labelStyle: theme.textTheme.bodyText1
                      //           ?.copyWith(color: theme.primaryColor),

                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 10),

                      //       // border: OutlineInputBorder(

                      //       //   borderRadius: BorderRadius.all(
                      //       //     Radius.circular(10),
                      //       //   ),
                      //       // ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: Screens.width(context) * 0.44,
                      //       height: Screens.padingHeight(context) * 0.06,
                      //       child: TextFormField(
                      //         // enabled: tr,
                      //         controller: mycontroller[28],
                      //         readOnly: true,
                      //         style: TextStyle(fontSize: 15),
                      //         decoration: InputDecoration(
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 width: 1, color: theme.primaryColor),
                      //             borderRadius: BorderRadius.circular(10),
                      //           ),
                      //           alignLabelWithHint: true,
                      //           hintText: "",
                      //           labelText: "Cost",
                      //           labelStyle: theme.textTheme.bodyText1
                      //               ?.copyWith(color: theme.primaryColor),
                      //           contentPadding: EdgeInsets.symmetric(
                      //               vertical: 10, horizontal: 10),
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(8),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: Screens.width(context) * 0.44,
                      //       height: Screens.padingHeight(context) * 0.06,
                      //       child: TextFormField(
                      //         // enabled: tr,
                      //         controller: mycontroller[41],
                      //         readOnly: true,
                      //         style: TextStyle(fontSize: 15),
                      //         decoration: InputDecoration(
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 width: 1, color: theme.primaryColor),
                      //             borderRadius: BorderRadius.circular(10),
                      //           ),
                      //           alignLabelWithHint: true,
                      //           hintText: "",
                      //           labelText: "MRP",
                      //           labelStyle: theme.textTheme.bodyText1
                      //               ?.copyWith(color: theme.primaryColor),
                      //           contentPadding: EdgeInsets.symmetric(
                      //               vertical: 10, horizontal: 10),
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(8),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 5,
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      //  SizedBox(
                      //       width: 15,
                      //     ),
                      createTable(theme, i),
                      SizedBox(
                        height: 5,
                      ),
                      createTable2(theme, i),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Store Age Slab:",
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                       createTable5(theme, i),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Whse Age Slab:",
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      createTable6(theme, i),
                      Divider(
                        color: theme.primaryColor,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      createTable3(theme, i),
                      // SizedBox(
                      //   height: Screens.padingHeight(context) * 0.06,
                      //   child: TextFormField(
                      //     // enabled: isTextFieldEnabled,
                      //     controller: mycontroller[29],
                      //     readOnly: true,
                      //     style: TextStyle(fontSize: 15),
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 1, color: theme.primaryColor),
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       alignLabelWithHint: true,
                      //       hintText: "",
                      //       labelText: "Store Stock",
                      //       labelStyle: theme.textTheme.bodyText1
                      //           ?.copyWith(color: theme.primaryColor),
                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 10),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(10),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SizedBox(
                      //   height: Screens.padingHeight(context) * 0.06,
                      //   child: TextFormField(
                      //     enabled: true,
                      //     controller: mycontroller[30],
                      //     readOnly: true,
                      //     style: TextStyle(fontSize: 15),
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             width: 1, color: theme.primaryColor),
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       alignLabelWithHint: true,
                      //       hintText: "",
                      //       labelText: "Whs Stock",
                      //       labelStyle: theme.textTheme.bodyText1
                      //           ?.copyWith(color: theme.primaryColor),
                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 10, horizontal: 10),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(8),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "Fixed Price",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(color: theme.primaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        child: Text(
                                          ":",
                                          style: theme.textTheme.bodyText1?.copyWith(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            // color: Colors.green[200],
                                            borderRadius: BorderRadius.circular(4)),
                                        child:allProductDetails[i].isFixedPrice==true?
                                        Icon(Icons.check,color: Colors.green,): 
                                        Icon(Icons.close,color: Colors.red,)
                                        // Text(
                                        //   "${allProductDetails[i].isFixedPrice}",
                                        //   style: theme.textTheme.bodyText1?.copyWith(
                                        //     color: Colors.green[700],
                                        //   ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                             Container(
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                "Allow Negative Stock",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: theme.primaryColor),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              child: Text(
                                ":",
                                style: theme.textTheme.bodyText1?.copyWith(),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  // color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(4)),
                              child:allProductDetails[i].allowNegativeStock==true?
                              Icon(Icons.check,color: Colors.green,): 
                              Icon(Icons.close,color: Colors.red,)
                              //  Text(
                              //   "${allProductDetails[i].allowNegativeStock}",
                              //   style: theme.textTheme.bodyText1?.copyWith(
                              //     color: Colors.green[700],
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                              ],
                            ),
                          
                      
                         Container(
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                "Accept Below cost Price",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: theme.primaryColor),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              child: Text(
                                ":",
                                style: theme.textTheme.bodyText1?.copyWith(),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  // color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(4)),
                              child: allProductDetails[i].allowOrderBelowCost==true?
                              Icon(Icons.check,color: Colors.green,): 
                              Icon(Icons.close,color: Colors.red,)
                              // Text(
                              //   "${allProductDetails[i].allowOrderBelowCost}",
                              //   style: theme.textTheme.bodyText1?.copyWith(
                              //     color: Colors.green[700],
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                     
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              notifyListeners();
                            },
                            child: Text("ok")),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
String? valueChosedrefcode;
  showBottomSheetInsert(BuildContext context, int i) {
    final theme = Theme.of(context);
    selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
     isfixedpriceorder=allProductDetails[i].isFixedPrice;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, st) {
        return Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Form(
              key: formkey[1],
              child: Container(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                     
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                                       width: Screens.width(context)*0.8,
                                                       child: Text(allProductDetails[i].itemCode.toString(),
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: theme.primaryColor)),
                                                     ),
                            Container(
                            width: Screens.width(context)*0.7,
                            // color: Colors.red,
                            child: Text(allProductDetails[i].itemName.toString(),
                                style: theme.textTheme.bodyText1
                                    ?.copyWith() //color: theme.primaryColor
                                ),
                          ),
                             ],
                           ),
                         InkWell(
                                onTap: () {
                                  // mycontroller[27].clear();
                                  // mycontroller[28].clear();
                                  // mycontroller[29].clear();
                                  // mycontroller[30].clear();
                                  // mycontroller[41].clear();

                                  showBottomSheetInsert2(context, i);
                                  notifyListeners();
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  //  padding: const EdgeInsets.only(right:10 ),
                                  width: Screens.width(context) * 0.05,
                                  height: Screens.padingHeight(context) * 0.04,
                                  child: Center(
                                      child: Icon(Icons.more_vert,
                                          color: Colors.white)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        // width: 270,
                        // height: 40,
                        child: new TextFormField(
                          
                          controller: mycontroller[10],
                          onChanged: (val) {
                            st(() {
                              if (val.length > 0) {
                                if (mycontroller[10].text.length > 0 &&
                                    mycontroller[11].text.length > 0) {
                                  unitPrice =
                                      double.parse(mycontroller[10].text);
                                  quantity = int.parse(mycontroller[11].text);
                                  total = unitPrice! * quantity!;
                                  print(total);
                                }
                              }
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "ENTER UNIT PRICE";
                            }
                            return null;
                          },
                          readOnly:  allProductDetails[i].isFixedPrice ==false ?false:
                           true,
                          keyboardType:  TextInputType.numberWithOptions(decimal: true),
                           inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          ],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "Unit Price",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        // width: 270,
                        // height: 40,
                        child: new TextFormField(
                          controller: mycontroller[11],
                          onChanged: (val) {
                            st(() {
                              if (val.length > 0) {
                                if (mycontroller[10].text.length > 0 &&
                                    mycontroller[11].text.length > 0) {
                                  unitPrice =
                                      double.parse(mycontroller[10].text);
                                  quantity = int.parse(mycontroller[11].text);
                                  total = unitPrice! * quantity!;
                                  print(total);
                                }
                              }
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "ENTER QUANTITY";
                            }
                            return null;
                          },
                          // readOnly: isDescriptionSelected == "TRANSPORTCHARGES"
                          //     ? true
                          //     : false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "quantity",
                          ),
                        ),
                      ),
                      //  ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap:(){
                                 showDialog<dynamic>(
                                                          context: context,
                                                          builder: (_) {
                                                            return ShowSearchDialog();
                                                          }).then((value) {
                                                            mycontroller[29].clear();
                                                            filterrefpartdata=refpartdata;
                                                            notifyListeners();
                                                          //  context
                                                          //   .read<
                                                          //       NewEnqController>()
                                                          //   .setcatagorydata();    
                                                            });

                        },
                        child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Referal Partner",
                                    style: theme.textTheme.bodyText1!.copyWith(
                                        color: theme.primaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                      ),
                      // Container(
                      //             // height: Screens.padingHeight(context) * 0.06,
                      //             width: Screens.width(context),
                      //             child: DropdownButtonFormField(
                      //               decoration: InputDecoration(
                      //                 // hintText: 'Email',
                      //                 labelText: 'referal partner',
                      //                 border: UnderlineInputBorder(),
                      //                 enabledBorder: UnderlineInputBorder(
                      //                   borderSide:
                      //                       BorderSide(color: Colors.grey),
                      //                 ),
                      //                 focusedBorder: UnderlineInputBorder(
                      //                   borderSide:
                      //                       BorderSide(color: Colors.grey),
                      //                 ),
                      //                 errorBorder: UnderlineInputBorder(),
                      //                 focusedErrorBorder:
                      //                     UnderlineInputBorder(),
                      //               ),
                      //               // hint: Text(
                      //               //   context
                      //               //       .watch<NewEnqController>()
                      //               //       .gethinttextforOpenLead!,
                      //               //   style: theme.textTheme.bodyText2?.copyWith(
                      //               //       color: context
                      //               //               .watch<NewEnqController>()
                      //               //               .gethinttextforOpenLead!
                      //               //               .contains(" *")
                      //               //           ? Colors.red
                      //               //           : Colors.black),
                      //               // ),
                      //               value:valueChosedrefcode,
                      //               //dropdownColor:Colors.green,
                      //               icon: Icon(Icons.arrow_drop_down),
                      //               iconSize: 30,
                      //               style: TextStyle(
                      //                   color: Colors.black, fontSize: 16),
                      //               isExpanded: true,
                      //               onChanged: (String? val) {
                      //                 // setState(() {
                      //                   st((){
                      //                     valueChosedrefcode=val!;
                      //                   });
                      //                   // choosedrefer(val.toString());
                      //                 // });
                      //               },
                      //               items: <String>['data1', 'data2', 'data3', 'data4']
                      //                   .map((e) {
                      //                 return DropdownMenuItem(
                      //                     // ignore: unnecessary_brace_in_string_interps
                      //                     value: "${e}",
                      //                     child: Container(
                      //                         // height: Screens.bodyheight(context)*0.1,
                      //                         child: Text("${e}")));
                      //               }).toList(),
                      //             ),
                      //           ),
                       
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Total: $total")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("cancel")),
                          isUpdateClicked == false
                              ? ElevatedButton(
                                  onPressed: () {
                                     if(mycontroller[11].text.isNotEmpty&&int.parse(mycontroller[11].text)>0 ){
 mycontroller[12].clear();
                                    addProductDetails(context);
                                     }else{

                                      showtoastproduct();
                                       

                                    }
                                   
                                  },
                                  child: Text("ok"))
                              : ElevatedButton(
                                  onPressed: () {
                                    if(mycontroller[11].text.isNotEmpty&&int.parse(mycontroller[11].text)>0){
  updateProductDetails(context, i);
                                    }else{
                                       showtoastproduct();
                                    }
                                  
                                  },
                                  child: Text("Update")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }


}
 void showtoastproduct() {
    Fluttertoast.showToast(
        msg: "Quantity should be greater than 0..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
class ProductDetails {
  String? itemcode;
  String? itemName;
  int? qty;
  double? unitPrice;
  double? total;

  ProductDetails(
      {required this.itemName,
      required this.itemcode,
      required this.qty,
      required this.unitPrice,
      required this.total});
}
class Levelofinterest{
  String? name;
  Levelofinterest({
    required this.name

  });
}
