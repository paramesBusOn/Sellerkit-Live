// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sellerkit/Models/AccountsModel/Accountspostmodel.dart';
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Models/CustomerMasterModel/CustomerMasterModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/OrderTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/levelofinterestModel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Services/AccountsApi/AccountspostApi.dart';
import 'package:sellerkit/Services/AccountsApi/AccountsupdateApi.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/SaveOrderApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/updateorderApi.dart';
import 'package:sellerkit/Widgets/AlertDilog.dart';
import 'package:sqflite/sqflite.dart';

import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Pages/Accounts/widgets/warningdialog.dart';
import '../../Widgets/SucessDialagBox.dart';

class NewCustomerContoller extends ChangeNotifier {


 init() async {
    clearAllData();
    // getdataFromDb();
    // getEnqRefferes();
  //  await getLeveofType();
    // await callLeadCheckApi();
    await stateApicallfromDB();
    // await callpaymodeApi();
    getCustomerTag();
    // getCustomerListFromDB();
  }

  
 List<LevelofData> leveofdata=[];
 List<OrderTypeData> ordertypedata=[];
//    getLeveofType() async {
//     leveofdata.clear();
//     ordertypedata.clear();
//     final Database db = (await DBHelper.getInstance())!;

//     leveofdata = await DBOperation.getlevelofData(db);
//     ordertypedata=await DBOperation.getordertypeData(db);
//     notifyListeners();
//   }
// customerdetData? customermodeldata;
// callcustomerapi()async{
//   await customerDetailApi.getData().then((value) {
//     if(value.stcode! >= 200 && value.stcode! <= 210){
// customermodeldata=value.leadcheckdata;
//     }
//   });

// }

  bool isTextFieldEnabled = true;
  bool customerbool = false;
  bool areabool = false;
  bool citybool = false;
  bool pincodebool = false;
  bool statebool = false;
  bool statebool2 = false;
  // bool autoIsselectTag = false;

  refreshh() {
    clearAllData();
  
    getEnqRefferes();
    //  getLeveofType();
    // callLeadCheckApi();
  }

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  ontapvalid(BuildContext context) {
    methidstate(mycontroller[18].text, context);
    FocusScope.of(context).requestFocus(focusNode1);
    statebool = false;
    notifyListeners();
  }

  ontapvalid2(BuildContext context) {
    methidstate2(mycontroller[24].text);
    FocusScope.of(context).requestFocus(focusNode3);
    statebool = false;
    notifyListeners();
  }

  List<CustomerData> customerList = [];
  List<CustomerData> get getCustomerList => customerList;
  List<CustomerData> filterCustomerList = [];
  List<CustomerData> get getfilterCustomerList => filterCustomerList;
//

  List<GlobalKey<FormState>> formkey =
      new List.generate(3, (i) => new GlobalKey<FormState>(debugLabel: "Lead"));
  List<TextEditingController> mycontroller =
      List.generate(35, (i) => TextEditingController());

  Config config = new Config();

  String isSelectedGender = '';
  String get getisSelectedGender => isSelectedGender;

  String isSelectedAge = '';
  String get getisSelectedAge => isSelectedAge;

  String isSelectedcomeas = '';
  String get getisSelectedcomeas => isSelectedcomeas;

  String isSelectedAdvertisement = '';
  String get getisSelectedAdvertisement => isSelectedAdvertisement;

  // String isSelectedCsTag = '';
  // String get getisSelectedCsTag => isSelectedCsTag;

  bool showItemList = true;
  bool get getshowItemList => showItemList;

  bool isUpdateClicked = false;

  bool validateGender = false;
  bool validateAge = false;
  bool validateComas = false;
  bool validateCsTag = false;

  bool get getvalidateGender => validateGender;
  bool get getvalidateAge => validateAge;
  bool get getvalidateComas => validateComas;
  bool get getvalidateCsTag => validateCsTag;

  List<CustomerTagTypeData> customerTagTypeData = [];

  // List<ProductDetails> productDetails = [];
  // List<ProductDetails> get getProduct => productDetails;

  // List<DocumentLines> productDetails = [];
  // List<DocumentLines> get getProduct => productDetails;

  List<ItemMasterDBModel> allProductDetails = [];
  List<ItemMasterDBModel> filterProductDetails = [];

  List<ItemMasterDBModel> get getAllProductDetails => allProductDetails;

  String? selectedItemCode;
  String? get getselectedItemCode => selectedItemCode;

  String? selectedItemName;
  String? get getselectedItemName => selectedItemName;

  double? unitPrice;
  double? quantity;
  double total = 0.00;
// List<Custype> custype=[
//   Custype(name: "Single"),
//    Custype(name: "Bulk"),
//     Custype(name: "Chain Order")
 
//   ];
  List<EnquiryTypeData> enqList = [];
  List<EnquiryTypeData> get getEnqList => enqList;

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
  //

  // List<PaymentTermsData> paymentTermsList = [
  //   PaymentTermsData(Name: "Cash", Code: "1"),
  //   PaymentTermsData(Name: "Card", Code: "2"),
  //   PaymentTermsData(Name: "Cheque", Code: "3"),
  //   PaymentTermsData(Name: "Finance", Code: "4"),
  //   PaymentTermsData(Name: "Wallet", Code: "5"),
  //   PaymentTermsData(Name: "Transfer", Code: "6"),
  //   PaymentTermsData(Name: "COD", Code: "7"),
  // ];
  // List<PaymentTermsData> get getpaymentTermsList => paymentTermsList;

  String isSelectedpaymentTermsList = '';
  String isSelectedpaymentTermsCode = '';
  String get getisSelectedpaymentTermsList => isSelectedpaymentTermsList;
  String? PaymentTerms;
//
//
  String isSelectedCusTag = '';
  String isSelectedCusTagcode = '';
  String get getisSelectedCusTag => isSelectedCusTag;
  String? CusTag;

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

  selectpaymentTerms(String selected, String refercode, String code) {
    isSelectedpaymentTermsList = selected;
    PaymentTerms = refercode;
    isSelectedpaymentTermsCode = code;
    // log("AN11:" + isSelectedpaymentTermsList.toString());

    // log("AN22:" + EnqRefer.toString());

    // log("AN33:" + isSelectedrefcode.toString());
    notifyListeners();
  }

  selectCustomerTag(String selected, String refercode, String code) {
    // if (autoIsselectTag == true) {
    //   customerTagTypeData = [];
    //   getCustomerTag();
    //   autoIsselectTag = false;
    //   notifyListeners();
    // }
    isSelectedCusTag = selected;
    CusTag = refercode;
    isSelectedCusTagcode = code;
    // log("AN11:" + isSelectedenquiryReffers.toString());

    // log("AN22:" + EnqRefer.toString());

    // log("AN33:" + isSelectedrefcode.toString());
    notifyListeners();
  }

  getEnqRefferes() async {
    final Database db = (await DBHelper.getInstance())!;
    enqReffList = await DBOperation.getEnqRefferes(db);
    notifyListeners();
  }

  getCustomerTag() async {
    customerTagTypeData = [];
    final Database db = (await DBHelper.getInstance())!;
    customerTagTypeData = await DBOperation.getCusTagData(db);
    notifyListeners();
  }

  getCustomerListFromDB() async {
    final Database db = (await DBHelper.getInstance())!;
    customerList = await DBOperation.getCustomerData(db);
    filterCustomerList = customerList;
    log("getCustomerListFromDB length::" +
        filterCustomerList.length.toString());
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
    notifyListeners();
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

  selectAdvertisement(String selected) {
    isSelectedAdvertisement = selected;
    notifyListeners();
  }

  // selectCsTag(String selected) {
  //   if (isSelectedCsTag == selected) {
  //     isSelectedCsTag = '';
  //   } else {
  //     isSelectedCsTag = selected;
  //   }
  //   notifyListeners();
  // }

  String? taxRate;
  String? taxCode;
// int linenum=0;
  // addProductDetails(BuildContext context) {
  //   log("sellect" + selectedItemCode.toString());
  //   log("sellect" + selectedItemName.toString());
  //   log("sellect" + quantity.toString());
  //   log("sellect" + productDetails.length.toString());

  //   if (formkey[1].currentState!.validate()) {
  //     bool itemAlreadyAdded = false;

  //     for (int i = 0; i < productDetails.length; i++) {
  //       if (productDetails[i].ItemCode == selectedItemCode) {
  //         itemAlreadyAdded = true;
  //         break;
  //       }
  //     }
  //     if (itemAlreadyAdded) {
  //       showItemList = false;
  //       mycontroller[12].clear();
  //       Navigator.pop(context);
  //       isUpdateClicked = false;
  //       notifyListeners();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Item Already Added..!!'),
  //           backgroundColor: Colors.red,
  //           elevation: 10,
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.all(5),
  //           dismissDirection: DismissDirection.up,
  //         ),
  //       );
  //     } else {
  //       productDetails.add(DocumentLines(
  //           id: 0,
  //           docEntry: 0,
  //           linenum: 0,
  //           ItemCode: selectedItemCode,
  //           ItemDescription: selectedItemName,
  //           Quantity: quantity,
  //           LineTotal: total,
  //           Price: unitPrice,
  //           TaxCode: 0.0,
  //           TaxLiable: "tNO",
  //           storecode: isselected[0] == true ? ConstantValues.Storecode : null,
  //           deliveryfrom: isselected[0] == true ? "store" : "Whse"));
  //       log("productslist" + productDetails.length.toString());
  //       log("product" + productDetails[0].deliveryfrom.toString());
  //       showItemList = false;
  //       mycontroller[12].clear();
  //       Navigator.pop(context);
  //       isUpdateClicked = false;
  //       notifyListeners();
  //     }
  //   }
  // }

  // updateProductDetails(BuildContext context, int i) {
  //   if (formkey[1].currentState!.validate()) {
  //     productDetails[i].Quantity = quantity;
  //     productDetails[i].Price = unitPrice;
  //     productDetails[i].LineTotal = total;
  //     showItemList = false;
  //     Navigator.pop(context);
  //     isUpdateClicked = false;
  //   }
  // }

  List<GetCustomerData>? customerdetails;
  resetItems(int i) {
    unitPrice = 0.00;
    quantity = 0;
    total = 0.00;
    mycontroller[10].text = allProductDetails[i].sp!.toStringAsFixed(2);
    //.clear();
    mycontroller[11].clear();
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

  ///call customer api

  bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;
  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;
  bool oldcutomer = false;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
  bool isAnother = true;
  List<GetenquiryData>? enquirydetails;
  List<GetenquiryData>? leaddetails;
  List<GetenquiryData>? quotationdetails;
  List<GetenquiryData>? orderdetails;
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
            customerdetails = value.itemdata!.customerdetails;
            mapValues(value.itemdata!.customerdetails![0]);
            oldcutomer = true;
            notifyListeners();
  if (
                value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
              AssignedToDialogUserState.LookingFor =
                  value.itemdata!.enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                  value.itemdata!.enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                  value.itemdata!.enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  value.itemdata!.enquirydetails![0].CurrentStatus;
              alertDialogOpenLeadOREnq2(context, "enquiry");
            }
            //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            //             value.itemdata!.orderdetails != null) {
            //                log("Anbuenq");
            //           orderdetails = value.itemdata!.orderdetails;
            //           alertDialogOpenLeadOREnq(context,"Orders");
            //         }
            else if (value.itemdata!.enquirydetails!.isNotEmpty &&
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
                }

              }
              
              // AssignedToDialogUserState.LookingFor =
              //     value.itemdata!.enquirydetails![0].DocType;
              // AssignedToDialogUserState.Store =
              //     value.itemdata!.enquirydetails![0].Store;
              // AssignedToDialogUserState.handledby =
              //    value.itemdata!.enquirydetails![0].AssignedTo;
              // AssignedToDialogUserState.currentstatus =
              //     value.itemdata!.enquirydetails![0].CurrentStatus;

              // alertDialogOpenLeadOREnq2(context, "Lead");
            } else if (value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
                  for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
                if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
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
                }

              }
              log("Anbuenq");
              enquirydetails = value.itemdata!.enquirydetails;
              // AssignedToDialogUserState.LookingFor =
              //     value.itemdata!.enquirydetails![0].DocType;
              // AssignedToDialogUserState.Store =
              //     value.itemdata!.enquirydetails![0].Store;
              // AssignedToDialogUserState.handledby =
              //     value.itemdata!.enquirydetails![0].AssignedTo;
              // AssignedToDialogUserState.currentstatus =
              //     value.itemdata!.enquirydetails![0].CurrentStatus;

              // alertDialogOpenLeadOREnq2(context, "enquiry");
            }
            // if (value.itemdata!.leaddetails!.isNotEmpty &&
            //         value.itemdata!.leaddetails != null ||
            //     value.itemdata!.orderdetails!.isNotEmpty &&
            //         value.itemdata!.orderdetails != null ||
            //     value.itemdata!.enquirydetails!.isNotEmpty &&
            //         value.itemdata!.enquirydetails != null) {
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.orderdetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.orderdetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.orderdetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.orderdetails![0].currentStatus;
            //   alertDialogOpenLeadOREnq2(context, "Orders");
            // } else if (value.itemdata!.leaddetails!.isNotEmpty &&
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

            //   alertDialogOpenLeadOREnq2(context, "Lead");
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

            //   alertDialogOpenLeadOREnq2(context, "enquiry");
            // } else if (value.itemdata!.orderdetails!.isNotEmpty &&
            //     value.itemdata!.orderdetails != null) {
            //   log("Anbuenq");
            //   orderdetails = value.itemdata!.orderdetails;
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.orderdetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.orderdetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.orderdetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.orderdetails![0].currentStatus;

            //   alertDialogOpenLeadOREnq2(context, "Orders");
            // }
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
        exceptionOnApiCall = '${value.message!}..!!${value.exception}..!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
  }

  FocusNode focusNode2 = FocusNode();
  void alertDialogOpenLeadOREnq2(BuildContext context, String typeOfDataCus) {
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
  // callApi() {
  //   customerapicLoading = true;
  //   notifyListeners();
  //   GetCutomerDetailsApi.getData(
  //           mycontroller[0].text, "${ConstantValues.slpcode}")
  //       .then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       // log("Old customer Data::"+oldcutomer.toString());
  //       if (value.itemdata != null) {
  //         log("Old customer Data::true");
  //         //  itemdata = value.itemdata!;
  //         // mapValues(value.itemdata!);
  //         oldcutomer = true;
  //         notifyListeners();
  //       } else if (value.itemdata == null) {
  //         log("Old customer Data::false");

  //         oldcutomer = false;
  //         customerapicLoading = false;
  //         notifyListeners();
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = '${value.exception}';
  //       print("Eeeeeeeeeeee");
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = '${value.exception}';
  //       print("Eeeeeeeeeeee");
  //       notifyListeners();
  //     }
  //     //  print("olddd cusss : "+oldcutomer.toString());
  //   });
  // }

  // callCheckEnqDetailsApi(
  //   BuildContext context,
  // ) {
  //   customerapicLoading = true;
  //   notifyListeners();
  //   CheckEnqDetailsApi.getData(ConstantValues.slpcode, mycontroller[0].text)
  //       .then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       if (value.checkEnqDetailsData != null && value.checkEnqDetailsData!.isNotEmpty) {
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
  //       } else if (value.checkEnqDetailsData == null && value.checkEnqDetailsData!.isEmpty) {
  //         // callApi();
  //       }
  //       notifyListeners();
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = '${value.exception}';
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       customerapicLoading = false;
  //       exceptionOnApiCall = '${value.exception}';
  //       notifyListeners();
  //     }
  //   });
  //    callApi();
  // }

  // List<CheckEnqDetailsData> checkEnqDetailsData = [];
  // callLeadPageSB(
  //   BuildContext context,
  // ) {
  //   OrderTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
  //   OrderTabController.isSameBranch = true;
  //   Navigator.pop(context);
  //   Get.offAllNamed(ConstantRoutes.leadstab);
  //   notifyListeners();
  // }

  static String typeOfLeadOrEnq = '';
  static String branchOfLeadOrEnq = '';

  // callLeadPageNSB(BuildContext context) {
  //   OrderTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
  //   OrderTabController.isSameBranch = false;
  //   //  Navigator.pop(context);
  //   //  callApi();
  //   //  customerapicLoading = false;
  //   //  exceptionOnApiCall = '';
  //   //  mycontroller[0].clear();
  //   Navigator.pop(context);
  //   Get.offAllNamed(ConstantRoutes.leadstab);
  //   notifyListeners();
  // }

  cancelDialog(BuildContext context) {
    exceptionOnApiCall = '';
    customerapicLoading = false;
    mycontroller[0].clear();
    notifyListeners();
    Navigator.pop(context);
  }

  // void alertDialogOpenLeadOREnq(BuildContext context) {
  //   showDialog<dynamic>(
  //       context: context,
  //       builder: (_) {
  //         return OrderWarningDialog();
  //       }).then((value) {});
  // }

  clearnum() {
    value3 = false;
    mycontroller[19].clear();
    mycontroller[20].clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();
    mycontroller[24].clear();
    mycontroller[16].clear();
    mycontroller[1].clear();
    mycontroller[25].clear();
    mycontroller[18].clear();
    mycontroller[2].clear();
    mycontroller[7].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[17].clear();
    mycontroller[3].clear();
    isSelectedCusTagcode = '';
    customerapicLoading = false;
    notifyListeners();
  }

  String statecode = '';
  String countrycode = '';
  String statename = '';
  bool isText1Correct = false;
  String statecode2 = '';
  String countrycode2 = '';
  String statename2 = '';
  bool isText1Correct2 = false;

  methidstate2(String name) {
    statecode2 = '';
    statename2 = '';
    countrycode2 = '';

    log("ANBU");
    for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].stateName.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        statecode2 = filterstateData[i].statecode.toString();
        statename2 = filterstateData[i].stateName.toString();
        countrycode2 = filterstateData[i].countrycode.toString();
        isText1Correct2 = false;

        log("statecode22:::" + statecode2.toString());
      }
    }
    //  notifyListeners();
  }

  methidstate(String name, BuildContext context) {
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
// FocusScope.of(context).unfocus();
        log("22222state:::" + statecode.toString());
      }
    }
    //  notifyListeners();
  }

  List<stateHeaderData> stateData = [];
  List<stateHeaderData> filterstateData = [];
  stateApicallfromDB() async {
    stateData.clear();
    filterstateData.clear();

    final Database db = (await DBHelper.getInstance())!;
    stateData = await DBOperation.getstateData(db);
    filterstateData = stateData;
    log("filterstateData length::" + filterstateData.length.toString());
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

  static List<String> dataenq = [];
  mapValues(GetCustomerData itemdata) {
    // mycontroller[0].text = itemdata[0].CardCode!;
    mycontroller[16].text = itemdata.customerName == null ||
            itemdata.customerName!.isEmpty ||
            itemdata.customerName == 'null'
        ? ''
        : itemdata.customerName!;
    mycontroller[1].text = itemdata.contactName == null ||
            itemdata.contactName == 'null' ||
            itemdata.contactName!.isEmpty
        ? ''
        : itemdata.contactName!;
    mycontroller[25].text = itemdata.gst == null ||
            itemdata.gst == '' ||
            itemdata.gst == 'null' ||
            itemdata.gst!.isEmpty
        ? ''
        : itemdata.gst!;
    mycontroller[18].text = itemdata.State == null ||
            itemdata.State == 'null' ||
            itemdata.State!.isEmpty
        ? ''
        : itemdata.State!;
    mycontroller[2].text = itemdata.Address_Line_1 == null ||
            itemdata.Address_Line_1!.isEmpty ||
            itemdata.Address_Line_1 == 'null'
        ? ''
        : itemdata.Address_Line_1!;
    mycontroller[7].text = itemdata.email == null ||
            itemdata.email!.isEmpty ||
            itemdata.email == 'null'
        ? ''
        : itemdata.email!;
    mycontroller[4].text = itemdata.Pincode == null ||
            itemdata.Pincode!.isEmpty ||
            itemdata.Pincode == 'null'||itemdata.Pincode == '0'
        ? ''
        : itemdata.Pincode!;
    mycontroller[5].text = itemdata.City == null ||
            itemdata.City!.isEmpty ||
            itemdata.City == 'null'
        ? ''
        : itemdata.City!;
    mycontroller[6].text = itemdata.altermobileNo == null ||
            itemdata.altermobileNo == 'null' ||
            itemdata.altermobileNo!.isEmpty
        ? ''
        : itemdata.altermobileNo!;
    mycontroller[17].text = itemdata.area == null ||
            itemdata.area == 'null' ||
            itemdata.area!.isEmpty
        ? ''
        : itemdata.area!;

    mycontroller[3].text = itemdata.Address_Line_2 == null ||
            itemdata.Address_Line_2 == 'null' ||
            itemdata.Address_Line_2!.isEmpty
        ? ''
        : itemdata.Address_Line_2!;
//          if(dataenq[14] !=null ||dataenq[14] != "null"||dataenq[14].isNotEmpty) {
// for(int i=0;i<ordertypedata.length;i++){
//           if(ordertypedata[i].Name==dataenq[14]){
// valueChosedStatus=ordertypedata[i].Code;
//           }
//         }
//        }
    customerapicLoading = false;
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == itemdata.customerGroup) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  static List<String> datafrommodify = [];
  static List<String> datafromquotes = [];
  static List<String> datafromlead = [];
  static List<String> datafromsiteout = [];
  static List<String> datafromfollow = [];
  static List<String> datafromopenlead = [];
  static String iscomfromSiteOutMobile = '';
  checkComeFromEnq(BuildContext context) async {
    log("ANBUUUU::");
    clearAllData();
    // customerapicLoading = true;
    // notifyListeners();
    //  getdataFromDb();
    // getEnqRefferes();
    // await callLeadCheckApi();
    await stateApicallfromDB();
    // getCustomerTag();
    // if (datafromfollow.length > 0) {
    //   print("datatatatata: .....");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluesfromFollowup(context);
    //   notifyListeners();
    // }
    // if (datafromopenlead.length > 0) {
    //   print("datatatatata: .....");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluesfromopenlead(context);
    //   notifyListeners();
    // }
    // if (dataenq.length > 0) {
    //    clearAllData();
    //   print("datatatatata: .....");
    //   customerapicLoading = true;
    //   mapValues3();
    // }
    // notifyListeners();
    // if (datafromlead.length > 0) {
    //   log("ANBUORDER");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluesfromlead(context);
    //   notifyListeners();
    // }

    if (datafrommodify.length > 0) {
      log("ANBUORDER");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfrommodify(context);
      notifyListeners();
    }
    // if (datafromquotes.length > 0) {
    //   log("ANBUORDER");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluesfromQuotes(context);
    //   notifyListeners();
    // }

    // if (datafromsiteout.length > 0) {
    //   log("ANBUORDER");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluessiteout();
    //   notifyListeners();
    // }

    if (iscomfromSiteOutMobile.isNotEmpty) {}
    // getdataFromDb();
    // getEnqRefferes();
    // await getLeveofType();
    // callLeadCheckApi();
    getCustomerTag();
    await stateApicallfromDB();
    // await callpaymodeApi();
    // getCustomerListFromDB();
    notifyListeners();
  }

  mapvaluessiteout() async {
    // getdataFromDb();
    // getEnqRefferes();
    // await callLeadCheckApi();
    getCustomerTag();
    // await getLeveofType();
    await stateApicallfromDB();
    // await callpaymodeApi();
    // getCustomerListFromDB();
    mycontroller[0].text = datafromsiteout[1] == null ||
            datafromsiteout[1] == "null" ||
            datafromsiteout[1].isEmpty
        ? ""
        : datafromsiteout[1];
    mycontroller[16].text = datafromsiteout[2] == null ||
            datafromsiteout[2] == "null" ||
            datafromsiteout[2].isEmpty
        ? ""
        : datafromsiteout[2];
    mycontroller[1].text = datafromsiteout[5] == null ||
            datafromsiteout[5] == "null" ||
            datafromsiteout[5].isEmpty
        ? ""
        : datafromsiteout[5];
    mycontroller[2].text = datafromsiteout[6] == null ||
            datafromsiteout[6] == "null" ||
            datafromsiteout[6].isEmpty
        ? ""
        : datafromsiteout[6];
    mycontroller[3].text = datafromsiteout[7] == null ||
            datafromsiteout[7] == "null" ||
            datafromsiteout[7].isEmpty
        ? ""
        : datafromsiteout[7];
    mycontroller[4].text = datafromsiteout[12] == null ||
            datafromsiteout[12] == "null"||datafromsiteout[12] == "0" ||
            datafromsiteout[12].isEmpty
        ? ""
        : datafromsiteout[12];
    mycontroller[5].text = datafromsiteout[9] == null ||
            datafromsiteout[9] == "null" ||
            datafromsiteout[9].isEmpty
        ? ""
        : datafromsiteout[9];
    mycontroller[17].text = datafromsiteout[8] == null ||
            datafromsiteout[8] == "null" ||
            datafromsiteout[8].isEmpty
        ? ""
        : datafromsiteout[8];
    if (datafromsiteout[10] != null && datafromsiteout[10].isNotEmpty) {
      for (int i = 0; i < filterstateData.length; i++) {
        if (filterstateData[i].statecode.toString().toLowerCase() ==
            datafromsiteout[10].toString().toLowerCase()) {
          mycontroller[18].text = filterstateData[i].stateName.toString();
        }
      }
    }

    // basetype=6;
    // enqID=int.parse(datafromsiteout[0]);
    // mycontroller[16].text = datafromsiteout[1];
    // mycontroller[6].text = datafromsiteout[2];
    // mycontroller[7].text = datafromsiteout[3];
    // mycontroller[2].text = datafromsiteout[4];
    // mycontroller[3].text = datafromsiteout[5];
    // mycontroller[5].text = datafromsiteout[6]; //city
    // mycontroller[4].text = datafromsiteout[8]; //pin
    // mycontroller[18].text = datafromsiteout[7]; //sta
    // mycontroller[16].text=datafromsiteout[1];
    // mycontroller[17].text=datafromsiteout[11];

    // enqID = int.parse(datafromlead[6]);

    // ItemCode: selectedItemCode,
    //     ItemDescription: selectedItemName,
    //     Quantity: quantity,
    //     LineTotal: total,
    //     Price: unitPrice,
    // isSelectedCusTag = datafromsiteout[9];
    customerapicLoading = false;
    datafromsiteout.clear();
    // productDetails.clear();
    notifyListeners();
  }

  mapvaluesfromopenlead(BuildContext context) async {
    // productDetails.clear();
    // // getdataFromDb();
    // // getEnqRefferes();
    // // await getLeveofType();
    // // await callLeadCheckApi();
    // await getCustomerTag();
    // await stateApicallfromDB();
    // // await callpaymodeApi();
    // // getCustomerListFromDB();
    // for (int i = 0; i < customerTagTypeData.length; i++) {
    //   if (customerTagTypeData[i].Name == datafromopenlead[9]) {
    //     isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
    //     notifyListeners();
    //   }
    //   // log("isSelectedCsTag::" + dataenq[2].toString());
    //   notifyListeners();
    // }
    // String? storecode;
    // String? deliveryfrom;
    // log("datafromlead" + datafromopenlead[9].toString());
    // mycontroller[0].text = datafromopenlead[0];
    // mycontroller[16].text = datafromopenlead[1];
    // // mycontroller[1].text = datafromlead[1];
    // mycontroller[2].text = datafromopenlead[2] == null ||
    //         datafromopenlead[2] == "null" ||
    //         datafromopenlead[2].isEmpty
    //     ? ""
    //     : datafromopenlead[2];
    // mycontroller[3].text = datafromopenlead[3] == null ||
    //         datafromopenlead[3] == "null" ||
    //         datafromopenlead[3].isEmpty
    //     ? ""
    //     : datafromopenlead[3];
    // mycontroller[4].text = datafromopenlead[4] == null ||
    //         datafromopenlead[4] == "null" ||
    //         datafromopenlead[4].isEmpty
    //     ? ""
    //     : datafromopenlead[4];
    // mycontroller[5].text = datafromopenlead[5] == null ||
    //         datafromopenlead[5] == "null" ||
    //         datafromopenlead[5].isEmpty
    //     ? ""
    //     : datafromopenlead[5];
    // // mycontroller[5].text = datafromlead[6];//city
    // mycontroller[18].text = datafromopenlead[8] == null ||
    //         datafromopenlead[8] == "null" ||
    //         datafromopenlead[8].isEmpty
    //     ? ""
    //     : datafromopenlead[8]; //pin
    // mycontroller[7].text = datafromopenlead[7] == null ||
    //         datafromopenlead[7] == "null" ||
    //         datafromopenlead[7].isEmpty
    //     ? ""
    //     : datafromfollow[7]; //sta
    // mycontroller[17].text = datafromopenlead[10] == null ||
    //         datafromopenlead[10] == "null" ||
    //         datafromopenlead[10].isEmpty
    //     ? ""
    //     : datafromopenlead[10];
    // enqID = int.parse(datafromopenlead[6]);
    // basetype = 2;

    // // enqID = int.parse(datafromlead[6]);

    // // ItemCode: selectedItemCode,
    // //     ItemDescription: selectedItemName,
    // //     Quantity: quantity,
    // //     LineTotal: total,
    // //     Price: unitPrice,

    // await GetLeadQTHApi.getData(datafromopenlead[6]).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     for (int i = 0;
    //         i < value.leadDeatilheadsData!.leadDeatilsQTLData!.length;
    //         i++) {
    //       selectedItemCode =
    //           value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
    //       selectedItemName =
    //           value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
    //       mycontroller[11].text = value
    //           .leadDeatilheadsData!.leadDeatilsQTLData![i].Quantity
    //           .toString();
    //       mycontroller[10].text = value
    //           .leadDeatilheadsData!.leadDeatilsQTLData![i].Price
    //           .toString();
    //       storecode = ConstantValues.Storecode;
    //       // value
    //       // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
    //       deliveryfrom = "store";
    //       // value
    //       // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
    //       // total=value.leadDeatilsQTHData!.DocTotal!;
    //       unitPrice = double.parse(mycontroller[10].text);
    //       quantity = double.parse(mycontroller[11].text);
    //       total = unitPrice! * quantity!;

    //       productDetails.add(DocumentLines(
    //           id: 0,
    //           docEntry: 0,
    //           linenum: 0,
    //           ItemCode: selectedItemCode,
    //           ItemDescription: selectedItemName,
    //           Quantity: quantity,
    //           LineTotal: total,
    //           Price: unitPrice,
    //           TaxCode: 0.0,
    //           TaxLiable: "tNO",
    //           storecode: storecode,
    //           deliveryfrom: deliveryfrom));
    //     }
    //     notifyListeners();

    //     log("productslist" + productDetails.length.toString());
    //     log("product" + productDetails[0].ItemDescription.toString());
    //     showItemList = false;
    //     // leadDeatilsQTHData = value.leadDeatilsQTHData;
    //     // leadDeatilsQTLData = value.leadDeatilsQTHData!.leadDeatilsQTLData!;
    //     // leadLoadingdialog = false;
    //     // leadForwarddialog = false;
    //     // updateFollowUpDialog = false;
    //     // viewDetailsdialog = true;
    //     notifyListeners();
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     // forwardSuccessMsg = 'Something wemt wrong..!!';
    //     // leadLoadingdialog = false;
    //     notifyListeners();
    //   } else {
    //     // forwardSuccessMsg = 'Something wemt wrong..!!';
    //     // leadLoadingdialog = false;
    //     notifyListeners();
    //   }
    // });
    // customerapicLoading = false;
    // datafromopenlead.clear();
    // notifyListeners();
  }

  mapvaluesfromFollowup(BuildContext context) async {
    // productDetails.clear();
    // getdataFromDb();
    // getEnqRefferes();
    // await getLeveofType();
    // await callLeadCheckApi();
    // await getCustomerTag();
    // await stateApicallfromDB();
    // await callpaymodeApi();
    // // getCustomerListFromDB();
    // for (int i = 0; i < customerTagTypeData.length; i++) {
    //   if (customerTagTypeData[i].Name == datafromfollow[9]) {
    //     isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
    //     notifyListeners();
    //   }
    //   // log("isSelectedCsTag::" + dataenq[2].toString());
    //   notifyListeners();
    // }
    // String? storecode;
    // String? deliveryfrom;
    // log("datafromlead" + datafromfollow[9].toString());
    // mycontroller[0].text = datafromfollow[0];
    // mycontroller[16].text = datafromfollow[1];
    // // mycontroller[1].text = datafromlead[1];
    // mycontroller[2].text = datafromfollow[2] == null ||
    //         datafromfollow[2] == "null" ||
    //         datafromfollow[2].isEmpty
    //     ? ""
    //     : datafromfollow[2];
    // mycontroller[3].text = datafromfollow[3] == null ||
    //         datafromfollow[3] == "null" ||
    //         datafromfollow[3].isEmpty
    //     ? ""
    //     : datafromfollow[3];
    // mycontroller[4].text = datafromfollow[4] == null ||
    //         datafromfollow[4] == "null" ||
    //         datafromfollow[4].isEmpty
    //     ? ""
    //     : datafromfollow[4];
    // mycontroller[5].text = datafromfollow[5] == null ||
    //         datafromfollow[5] == "null" ||
    //         datafromfollow[5].isEmpty
    //     ? ""
    //     : datafromfollow[5];
    // // mycontroller[5].text = datafromlead[6];//city
    // mycontroller[18].text = datafromfollow[8] == null ||
    //         datafromfollow[8] == "null" ||
    //         datafromfollow[8].isEmpty
    //     ? ""
    //     : datafromfollow[8]; //pin
    // mycontroller[7].text = datafromfollow[7] == null ||
    //         datafromfollow[7] == "null" ||
    //         datafromfollow[7].isEmpty
    //     ? ""
    //     : datafromfollow[7]; //sta
    // mycontroller[17].text = datafromfollow[10] == null ||
    //         datafromfollow[10] == "null" ||
    //         datafromfollow[10].isEmpty
    //     ? ""
    //     : datafromfollow[10];
    // enqID = int.parse(datafromfollow[6]);
    // basetype = 2;

    // // enqID = int.parse(datafromlead[6]);

    // // ItemCode: selectedItemCode,
    // //     ItemDescription: selectedItemName,
    // //     Quantity: quantity,
    // //     LineTotal: total,
    // //     Price: unitPrice,

    // await GetLeadQTHApi.getData(datafromfollow[6]).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     for (int i = 0;
    //         i < value.leadDeatilheadsData!.leadDeatilsQTLData!.length;
    //         i++) {
    //       selectedItemCode =
    //           value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
    //       selectedItemName =
    //           value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
    //       mycontroller[11].text = value
    //           .leadDeatilheadsData!.leadDeatilsQTLData![i].Quantity
    //           .toString();
    //       mycontroller[10].text = value
    //           .leadDeatilheadsData!.leadDeatilsQTLData![i].Price
    //           .toString();
    //       storecode = ConstantValues.Storecode;
    //       // value
    //       // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
    //       deliveryfrom = "store";
    //       // value
    //       // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
    //       // total=value.leadDeatilsQTHData!.DocTotal!;
    //       unitPrice = double.parse(mycontroller[10].text);
    //       quantity = double.parse(mycontroller[11].text);
    //       total = unitPrice! * quantity!;

    //       productDetails.add(DocumentLines(
    //           id: 0,
    //           docEntry: 0,
    //           linenum: 0,
    //           ItemCode: selectedItemCode,
    //           ItemDescription: selectedItemName,
    //           Quantity: quantity,
    //           LineTotal: total,
    //           Price: unitPrice,
    //           TaxCode: 0.0,
    //           TaxLiable: "tNO",
    //           storecode: storecode,
    //           deliveryfrom: deliveryfrom));
    //     }
    //     notifyListeners();

    //     log("productslist" + productDetails.length.toString());
    //     log("product" + productDetails[0].ItemDescription.toString());
    //     showItemList = false;
    //     // leadDeatilsQTHData = value.leadDeatilsQTHData;
    //     // leadDeatilsQTLData = value.leadDeatilsQTHData!.leadDeatilsQTLData!;
    //     // leadLoadingdialog = false;
    //     // leadForwarddialog = false;
    //     // updateFollowUpDialog = false;
    //     // viewDetailsdialog = true;
    //     notifyListeners();
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     // forwardSuccessMsg = 'Something wemt wrong..!!';
    //     // leadLoadingdialog = false;
    //     notifyListeners();
    //   } else {
    //     // forwardSuccessMsg = 'Something wemt wrong..!!';
    //     // leadLoadingdialog = false;
    //     notifyListeners();
    //   }
    // });
    // customerapicLoading = false;
    // datafromfollow.clear();
  }

  int? ordernum;

  int? ordocentry;
bool? comeforreadonly=false;
  mapvaluesfrommodify(BuildContext context) async {
   
  
    await getCustomerTag();
    await stateApicallfromDB();
  
    value3 == true;
    notifyListeners();
    iscomeforupdate = true;
    notifyListeners();
    log("iscomeforupdate::::" + iscomeforupdate.toString());
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafrommodify[18]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
  
    mycontroller[0].text = datafrommodify[0];
    mycontroller[16].text = datafrommodify[1];
    // mycontroller[1].text = datafromlead[1];
    mycontroller[2].text = datafrommodify[5] == null ||
            datafrommodify[5] == "null" ||
            datafrommodify[5].isEmpty
        ? ""
        : datafrommodify[5];
    mycontroller[3].text = datafrommodify[6] == null ||
            datafrommodify[6] == "null" ||
            datafrommodify[6].isEmpty
        ? ""
        : datafrommodify[6];
    mycontroller[4].text = datafrommodify[9] == null ||
            datafrommodify[9] == "null"||datafrommodify[9] == "0" ||
            datafrommodify[9].isEmpty
        ? ""
        : datafrommodify[9];
    mycontroller[5].text = datafrommodify[8] == null ||
            datafrommodify[8] == "null" ||
            datafrommodify[8].isEmpty
        ? ""
        : datafrommodify[8];
    // mycontroller[5].text = datafrommodify[6];//city
    mycontroller[18].text = datafrommodify[10] == null ||
            datafrommodify[10] == "null" ||
            datafrommodify[10].isEmpty
        ? ""
        : datafrommodify[10]; //pin
    mycontroller[7].text = datafrommodify[3] == null ||
            datafrommodify[3] == "null" ||
            datafrommodify[3].isEmpty
        ? ""
        : datafrommodify[3]; //sta
    mycontroller[17].text = datafrommodify[7] == null ||
            datafrommodify[7] == "null" ||
            datafrommodify[7].isEmpty
        ? ""
        : datafrommodify[7];
    mycontroller[1].text = datafrommodify[4] == null ||
            datafrommodify[4] == "null" ||
            datafrommodify[4].isEmpty
        ? ""
        : datafrommodify[4];
    mycontroller[6].text = datafrommodify[2] == null ||
            datafrommodify[2] == "null" ||
            datafrommodify[2].isEmpty
        ? ""
        : datafrommodify[2];
    mycontroller[19].text = datafrommodify[11] == null ||
            datafrommodify[11] == "null" ||
            datafrommodify[11].isEmpty
        ? ""
        : datafrommodify[11];
    mycontroller[20].text = datafrommodify[12] == null ||
            datafrommodify[12] == "null" ||
            datafrommodify[12].isEmpty
        ? ""
        : datafrommodify[12];
    mycontroller[21].text = datafrommodify[13] == null ||
            datafrommodify[13] == "null" ||
            datafrommodify[13].isEmpty
        ? ""
        : datafrommodify[13];
    mycontroller[22].text = datafrommodify[14] == null ||
            datafrommodify[14] == "null" ||
            datafrommodify[14].isEmpty
        ? ""
        : datafrommodify[14];
    mycontroller[23].text = datafrommodify[15] == null ||
            datafrommodify[15] == "null" ||datafrommodify[15] == "0"||
            datafrommodify[15].isEmpty
        ? ""
        : datafrommodify[15];
    mycontroller[24].text = datafrommodify[16] == null ||
            datafrommodify[16] == "null" ||
            datafrommodify[16].isEmpty
        ? ""
        : datafrommodify[16];
    mycontroller[25].text = datafrommodify[17] == null ||
            datafrommodify[17] == "null" ||
            datafrommodify[17].isEmpty
        ? ""
        : datafrommodify[17];
    // ordocentry = int.parse(datafrommodify[0]);
    // ordernum = int.parse(datafrommodify[18]);
    notifyListeners();
    String? storecode;
    String? deliveryfrom;
   
    customerapicLoading = false;
    datafrommodify.clear();
    // productDetails.clear();
    notifyListeners();
  }

  mapvaluesfromQuotes(BuildContext context) async {
//     productDetails.clear();
//     getdataFromDb();
//     getEnqRefferes();
//     await getLeveofType();
//     await callLeadCheckApi();
//     await getCustomerTag();
//     await stateApicallfromDB();
//     await callpaymodeApi();
//     // getCustomerListFromDB();
//     for (int i = 0; i < customerTagTypeData.length; i++) {
//       if (customerTagTypeData[i].Name == datafromquotes[20]) {
//         isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
//         notifyListeners();
//       }
//       // log("isSelectedCsTag::" + dataenq[2].toString());
//       notifyListeners();
//     }
//     // log("datafromlead" + datafromlead[5].toString());
//     mycontroller[0].text = datafromquotes[1];
//     mycontroller[16].text = datafromquotes[2];
//     // mycontroller[1].text = datafromlead[1];
//     mycontroller[2].text = datafromquotes[6] == null ||
//             datafromquotes[6] == "null" ||
//             datafromquotes[6].isEmpty
//         ? ""
//         : datafromquotes[6];
//     mycontroller[3].text = datafromquotes[7] == null ||
//             datafromquotes[7] == "null" ||
//             datafromquotes[7].isEmpty
//         ? ""
//         : datafromquotes[7];
//     mycontroller[4].text = datafromquotes[10] == null ||
//             datafromquotes[10] == "null" ||
//             datafromquotes[10].isEmpty
//         ? ""
//         : datafromquotes[10];
//     mycontroller[5].text = datafromquotes[9] == null ||
//             datafromquotes[9] == "null" ||
//             datafromquotes[9].isEmpty
//         ? ""
//         : datafromquotes[9];
//     // mycontroller[5].text = datafromquotes[6];//city
//     mycontroller[18].text = datafromquotes[11] == null ||
//             datafromquotes[11] == "null" ||
//             datafromquotes[11].isEmpty
//         ? ""
//         : datafromquotes[11]; //pin
//     mycontroller[7].text = datafromquotes[4] == null ||
//             datafromquotes[4] == "null" ||
//             datafromquotes[4].isEmpty
//         ? ""
//         : datafromquotes[4]; //sta
//     mycontroller[17].text = datafromquotes[8] == null ||
//             datafromquotes[8] == "null" ||
//             datafromquotes[8].isEmpty
//         ? ""
//         : datafromquotes[8];
//     mycontroller[1].text = datafromquotes[5] == null ||
//             datafromquotes[5] == "null" ||
//             datafromquotes[5].isEmpty
//         ? ""
//         : datafromquotes[5];
//     mycontroller[6].text = datafromquotes[3] == null ||
//             datafromquotes[3] == "null" ||
//             datafromquotes[3].isEmpty
//         ? ""
//         : datafromquotes[3];
//     mycontroller[19].text = datafromquotes[12] == null ||
//             datafromquotes[12] == "null" ||
//             datafromquotes[12].isEmpty
//         ? ""
//         : datafromquotes[12];
//     mycontroller[20].text = datafromquotes[13] == null ||
//             datafromquotes[13] == "null" ||
//             datafromquotes[13].isEmpty
//         ? ""
//         : datafromquotes[13];
//     mycontroller[21].text = datafromquotes[14] == null ||
//             datafromquotes[14] == "null" ||
//             datafromquotes[14].isEmpty
//         ? ""
//         : datafromquotes[14];
//     mycontroller[22].text = datafromquotes[15] == null ||
//             datafromquotes[15] == "null" ||
//             datafromquotes[15].isEmpty
//         ? ""
//         : datafromquotes[15];
//     mycontroller[23].text = datafromquotes[16] == null ||
//             datafromquotes[16] == "null" ||
//             datafromquotes[16].isEmpty
//         ? ""
//         : datafromquotes[16];
//     mycontroller[24].text = datafromquotes[17] == null ||
//             datafromquotes[17] == "null" ||
//             datafromquotes[17].isEmpty
//         ? ""
//         : datafromquotes[17];
//         mycontroller[25].text=datafromquotes[19] == null ||
//             datafromquotes[19] == "null" ||
//             datafromquotes[19].isEmpty
//         ? ""
//         : datafromquotes[19];
//           if(datafromquotes[21] !=null ||datafromquotes[21] != "null"||datafromquotes[21].isNotEmpty) {
// for(int i=0;i<ordertypedata.length;i++){
//           if(ordertypedata[i].Name==datafromquotes[21]){
// valueChosedCusType=ordertypedata[i].Code;
//           }
//         }
//        }
//     enqID = int.parse(datafromquotes[0]);
//     basetype = 3;
//     // log("datafromlead[6]::" + datafromlead[6].toString());

//     String? storecode;
//     String? deliveryfrom;
//     await GetQuotesQTHApi.getData(datafromquotes[0]).then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         for (int i = 0;
//             i < value.QuotesDeatilsheaderData!.OrderDeatilsQTLData!.length;
//             i++) {
//           selectedItemCode =
//               value.QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].ItemCode;
//           selectedItemName =
//               value.QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].ItemName;
//           mycontroller[11].text = value
//               .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].Quantity
//               .toString();
//           mycontroller[10].text = value
//               .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].Price
//               .toString();
//           storecode = ConstantValues.Storecode;
//           // value
//           // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
//           deliveryfrom = "store";
//           // value
//           // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
//           // total=value.leadDeatilsQTHData!.DocTotal!;
//           notifyListeners();
//           unitPrice = double.parse(mycontroller[10].text);
//           quantity = double.parse(mycontroller[11].text);
//           total = unitPrice! * quantity!;
//           productDetails.add(DocumentLines(
//               id: 0,
//               docEntry: 0,
//               linenum: 0,
//               ItemCode: selectedItemCode,
//               ItemDescription: selectedItemName,
//               Quantity: quantity,
//               LineTotal: total,
//               Price: unitPrice,
//               TaxCode: 0.0,
//               TaxLiable: "tNO",
//               storecode: storecode,
//               deliveryfrom: deliveryfrom));
//         }

//         log("productslist" + productDetails.length.toString());
//         log("product" + productDetails[0].ItemDescription.toString());
//         showItemList = false;
        
//         notifyListeners();
//       } else if (value.stcode! >= 400 && value.stcode! <= 490) {
//         // forwardSuccessMsg = 'Something wemt wrong..!!';
//         // leadLoadingdialog = false;
//         notifyListeners();
//       } else {
//         // forwardSuccessMsg = 'Something wemt wrong..!!';
//         // leadLoadingdialog = false;
//         notifyListeners();
//       }
//     });
//     customerapicLoading = false;
//     datafromquotes.clear();
//     // productDetails.clear();
//     notifyListeners();
  }

  mapvaluesfromlead(BuildContext context) async {
//     productDetails.clear();
//     getdataFromDb();
//     getEnqRefferes();
//     await getLeveofType();
//     await callLeadCheckApi();
//     await getCustomerTag();
//     await stateApicallfromDB();
//     await callpaymodeApi();
//     // getCustomerListFromDB();
//     for (int i = 0; i < customerTagTypeData.length; i++) {
//       if (customerTagTypeData[i].Name == datafromlead[9]) {
//         isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
//         notifyListeners();
//       }
//       // log("isSelectedCsTag::" + dataenq[2].toString());
//       notifyListeners();
//     }
//     log("datafromlead" + datafromlead[5].toString());
//     mycontroller[0].text = datafromlead[0];
//     mycontroller[16].text = datafromlead[1];
//     // mycontroller[1].text = datafromlead[1];
//     mycontroller[2].text = datafromlead[2] == null ||
//             datafromlead[2] == "null" ||
//             datafromlead[2].isEmpty
//         ? ""
//         : datafromlead[2];
//     mycontroller[3].text = datafromlead[3] == null ||
//             datafromlead[3] == "null" ||
//             datafromlead[3].isEmpty
//         ? ""
//         : datafromlead[3];
//     mycontroller[4].text = datafromlead[4] == null ||
//             datafromlead[4] == "null" ||
//             datafromlead[4].isEmpty
//         ? ""
//         : datafromlead[4];
//     mycontroller[5].text = datafromlead[5] == null ||
//             datafromlead[5] == "null" ||
//             datafromlead[5].isEmpty
//         ? ""
//         : datafromlead[5];
//     // mycontroller[5].text = datafromlead[6];//city
//     mycontroller[18].text = datafromlead[8] == null ||
//             datafromlead[8] == "null" ||
//             datafromlead[8].isEmpty
//         ? ""
//         : datafromlead[8]; //pin
//     mycontroller[7].text = datafromlead[7] == null ||
//             datafromlead[7] == "null" ||
//             datafromlead[7].isEmpty
//         ? ""
//         : datafromlead[7]; //sta
//     mycontroller[17].text = datafromlead[10] == null ||
//             datafromlead[10] == "null" ||
//             datafromlead[10].isEmpty
//         ? ""
//         : datafromlead[10];
//         log("datafromlead[11] !=null::"+datafromlead[11].toString());
//         if(datafromlead[11] !=null ||datafromlead[11] != "null"||datafromlead[11].isNotEmpty) {
// for(int i=0;i<ordertypedata.length;i++){
//           if(ordertypedata[i].Name==datafromlead[11]){
// valueChosedCusType=ordertypedata[i].Code;
//           }
//         }
//        }
//     enqID = int.parse(datafromlead[6]);
//     basetype = 2;
//     log("datafromlead[6]::" + datafromlead[6].toString());

//     String? storecode;
//     String? deliveryfrom;
//     await GetLeadQTHApi.getData(datafromlead[6]).then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         for (int i = 0;
//             i < value.leadDeatilheadsData!.leadDeatilsQTLData!.length;
//             i++) {
//           selectedItemCode =
//               value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
//           selectedItemName =
//               value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
//           mycontroller[11].text = value
//               .leadDeatilheadsData!.leadDeatilsQTLData![i].Quantity
//               .toString();
//           mycontroller[10].text = value
//               .leadDeatilheadsData!.leadDeatilsQTLData![i].Price
//               .toString();
//           storecode = ConstantValues.Storecode;
//           // value
//           // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
//           deliveryfrom = "store";
//           // value
//           // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
//           // total=value.leadDeatilsQTHData!.DocTotal!;
//           notifyListeners();
//           unitPrice = double.parse(mycontroller[10].text);
//           quantity = double.parse(mycontroller[11].text);
//           total = unitPrice! * quantity!;
//           productDetails.add(DocumentLines(
//               id: 0,
//               docEntry: 0,
//               linenum: 0,
//               ItemCode: selectedItemCode,
//               ItemDescription: selectedItemName,
//               Quantity: quantity,
//               LineTotal: total,
//               Price: unitPrice,
//               TaxCode: 0.0,
//               TaxLiable: "tNO",
//               storecode: storecode,
//               deliveryfrom: deliveryfrom));
//         }

//         log("productslist" + productDetails.length.toString());
//         log("product" + productDetails[0].ItemDescription.toString());
//         showItemList = false;
//         // for (int i = 0;
//         //     i < value.OrderDeatilsheaderData!.leadDeatilsQTLData!.length;
//         //     i++) {
//         //   selectedItemCode =
//         //       value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
//         //   selectedItemName =
//         //       value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
//         //   mycontroller[11].text = value
//         //       .leadDeatilheadsData!.leadDeatilsQTLData![i].Quantity
//         //       .toString();
//         //   mycontroller[10].text = value
//         //       .leadDeatilheadsData!.leadDeatilsQTLData![i].Price
//         //       .toString();
//         //        storecode= value
//         //       .leadDeatilheadsData!.leadDeatilsQTLData![i].LocCode
//         //       .toString();
//         //       deliveryfrom=value
//         //       .leadDeatilheadsData!.leadDeatilsQTLData![i].deliveryFrom
//         //       .toString();

//         // total=value.leadDeatilsQTHData!.DocTotal!;
//         // }

//         // leadDeatilsQTHData = value.leadDeatilsQTHData;
//         // leadDeatilsQTLData = value.leadDeatilsQTHData!.leadDeatilsQTLData!;
//         // leadLoadingdialog = false;
//         // leadForwarddialog = false;
//         // updateFollowUpDialog = false;
//         // viewDetailsdialog = true;
//         notifyListeners();
//       } else if (value.stcode! >= 400 && value.stcode! <= 490) {
//         // forwardSuccessMsg = 'Something wemt wrong..!!';
//         // leadLoadingdialog = false;
//         notifyListeners();
//       } else {
//         // forwardSuccessMsg = 'Something wemt wrong..!!';
//         // leadLoadingdialog = false;
//         notifyListeners();
//       }
//     });
//     customerapicLoading = false;
//     datafromlead.clear();
//     // productDetails.clear();
//     notifyListeners();
  }

  mapValues3() async {
    // getdataFromDb();
    // getEnqRefferes();
    // await getLeveofType();
    // await callLeadCheckApi();
    // getCustomerTag();
    // await stateApicallfromDB();
    // await callpaymodeApi();
    // for (int i = 0; i < customerTagTypeData.length; i++) {
    //   if (customerTagTypeData[i].Name == dataenq[10]) {
    //     isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
    //     notifyListeners();
    //   }
    //   log("isSelectedCsTag::" + dataenq[6].toString());
    //   notifyListeners();
    // }
    // // log("ANBY::"+dataenq[7].toString());
    // mycontroller[0].text =
    //     dataenq[0] == null || dataenq[0] == 'null' || dataenq[0].isEmpty
    //         ? ''
    //         : dataenq[0];
    // mycontroller[16].text =
    //     dataenq[1] == null || dataenq[1] == 'null' || dataenq[1].isEmpty
    //         ? ''
    //         : dataenq[1];
    // mycontroller[2].text =
    //     dataenq[2] == null || dataenq[2] == 'null' || dataenq[2].isEmpty
    //         ? ''
    //         : dataenq[2];
    // mycontroller[3].text =
    //     dataenq[3] == null || dataenq[3] == 'null' || dataenq[3].isEmpty
    //         ? ''
    //         : dataenq[3];
    // mycontroller[4].text =
    //     dataenq[4] == null || dataenq[4] == 'null' || dataenq[4].isEmpty
    //         ? ''
    //         : dataenq[4];
    // mycontroller[5].text =
    //     dataenq[5] == null || dataenq[5] == 'null' || dataenq[5].isEmpty
    //         ? ''
    //         : dataenq[5];
    // mycontroller[7].text =
    //     dataenq[7] == null || dataenq[7] == 'null' || dataenq[7].isEmpty
    //         ? ''
    //         : dataenq[7];
    // mycontroller[18].text =
    //     dataenq[9] == null || dataenq[9] == 'null' || dataenq[9].isEmpty
    //         ? ''
    //         : dataenq[9];
    // mycontroller[6].text =
    //     dataenq[11] == null || dataenq[11] == 'null' || dataenq[11].isEmpty
    //         ? ''
    //         : dataenq[11];
    // mycontroller[1].text =
    //     dataenq[12] == null || dataenq[12] == 'null' || dataenq[12].isEmpty
    //         ? ''
    //         : dataenq[12];
    // mycontroller[17].text =
    //     dataenq[13] == null || dataenq[13] == 'null' || dataenq[13].isEmpty
    //         ? ''
    //         : dataenq[13];

    // enqID = int.parse(dataenq[6]);
    // basetype = 1;

    // customerapicLoading = false;
    // dataenq.clear();

    // notifyListeners();
    // log("enq: ${enqID}");
    // log("isSelectedCsTag: ${isSelectedCsTag}");
  }

  // callEnqPageSB(
  //     BuildContext context, List<CheckEnqDetailsData> checkEnqDetailsData) {
  //   if (ConstantValues.sapUserType == 'Manager') {
  //     gotoMrgPage(context);
  //   } else {
  //     gotoUserPage(context);
  //   }
  // }

  // gotoUserPage(BuildContext context) {
  //   EnquiryUserContoller.isAlreadyenqOpen = true;
  //   EnquiryUserContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
  //   EnquiryUserContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
  //   customerapicLoading = false;
  //   exceptionOnApiCall = '';
  //   mycontroller[0].clear();
  //   Navigator.pop(context);
  //   Get.toNamed(ConstantRoutes.enquiriesUser);
  //   notifyListeners();
  // }

  int? reyear;
  int? remonth;
  int? reday;
  int? rehours;
  int? reminutes;
  // gotoMrgPage(BuildContext context) {
  //   EnquiryMangerContoller.isAlreadyenqOpen = true;
  //   EnquiryMangerContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
  //   EnquiryMangerContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
  //   customerapicLoading = false;
  //   exceptionOnApiCall = '';
  //   mycontroller[0].clear();
  //   Navigator.pop(context);
  //   Get.toNamed(ConstantRoutes.enquiriesManager);
  //   notifyListeners();
  // }

  // callEnqPageNSB(
  //     BuildContext context, List<CheckEnqDetailsData> checkEnqDetailsData) {
  //   EnquiryUserContoller.isAlreadyenqOpen = true;
  //   EnquiryUserContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
  //   EnquiryUserContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
  //   customerapicLoading = false;
  //   exceptionOnApiCall = '';
  //   mycontroller[0].clear();
  //   Navigator.pop(context);
  //   Get.toNamed(ConstantRoutes.enquiriesUser);
  //   notifyListeners();
  // }
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
  clearAllData() {
    log("step1");
     leveofdata.clear();
    ordertypedata.clear();
    valueChosedStatus=null;
    valueChosedCusType=null;
    valueChosedCusType=null;
    mycontroller[27].clear();
    mycontroller[28].clear();
    mycontroller[29].clear();
    mycontroller[30].clear();

    reyear = null;
    reminderOn = false;
    remonth = null;
    reday = null;
    rehours = null;
    reminutes = null;
    isTextFieldEnabled = true;
    iscomeforupdate = false;
    String statecode = '';
    String countrycode = '';
    String statename = '';
    statebool = false;
    statebool2 = false;
    isText1Correct = false;
    isText1Correct2 = false;
    isAnother == true;
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
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[20].clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();
    mycontroller[24].clear();
    mycontroller[25].clear();
    mycontroller[31].clear();

   
    value3 = false;
    isSelectedpaymentTermsList = '';
    isSelectedpaymentTermsCode = '';
    isSelectedenquirytype = '';
    isSelectedAge = '';
    isSelectedcomeas = '';
    isSelectedGender = '';
    isSelectedAdvertisement = '';
    isSelectedenquiryReffers = '';
    isSelectedCusTag = '';
    isSelectedCusTagcode = "";
    CusTag = null;
    customerapicalled = false;
    oldcutomer = false;
    customerapicLoading = false;
    // productDetails.clear();
    exceptionOnApiCall = '';
   
    showItemList = true;
    isSelectedCusTag = '';
    // isComeFromEnq = false;s
    isloadingBtn = false;
    // autoIsselectTag = false;
    enqID = null;
    basetype = null;
    log("step2");

    // resetListSelection();
    log("step3");

    notifyListeners();
  }

  String apiFDate = '';
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
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}.${date.millisecond.toString().padLeft(3, '0')}Z";
      print("delivery date" + apiFDate);
      reyear = date.year;
      remonth = date.month;
      reday = date.day;
      mycontroller[13].text = chooseddate;
      notifyListeners();
    });
  }

  String apiNdate = '';
  void showPaymentDate(BuildContext context) {
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
      apiNdate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}.${date.millisecond.toString().padLeft(3, '0')}Z";
      print(apiNdate);

      mycontroller[31].text = chooseddate;
      notifyListeners();
    });
  }

  //lead check list Api
//   List<OrderCheckData> leadcheckdatas = [];
//   List<OrderCheckData> get getleadcheckdatas => leadcheckdatas;
//   String LeadCheckDataExcep = '';
//   String get getLeadCheckDataExcep => LeadCheckDataExcep;

//   callLeadCheckApi() {
//     GetOrderCheckListApi.getData('${ConstantValues.slpcode}').then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.Ordercheckdata != null) {
//           leadcheckdatas = value.Ordercheckdata!;
//           log("ininin");
// //           for(int i=0;i<=value.leadcheckdata!.length;i++){
// // leadcheckdatas[0].linenum=  int.parse(value.leadcheckdata![i].toString());
// // log("linenummmm:"+leadcheckdatas[0].linenum.toString());
// // log("linenummmm:"+value.leadcheckdata![i].toString());

// //           }
//         } else if (value.Ordercheckdata == null) {
//           LeadCheckDataExcep = 'Lead check data not found..!!';
//         }
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         LeadCheckDataExcep = 'Some thing went wrong..!!';
//       } else if (value.stcode == 500) {
//         LeadCheckDataExcep =
//             '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
//       }
//     });
//   }

  // LeadcheckListClicked(bool? v, int i) {
  //   leadcheckdatas[i].ischecked = v;
  //   notifyListeners();
  // }

  // resetListSelection() {
  //   for (int i = 0; i < leadcheckdatas.length; i++) {
  //     leadcheckdatas[i].ischecked = false;
  //   }
  // }

  int docnum = 0;
  bool iscomeforupdate = false;

//save all values tp server

  saveToServer(BuildContext context) async {
    // await callcustomerapi();
    log("Step----------1");
  
    String date = config.currentDateOnly();
    PatchExCus patch = new PatchExCus();
    patch.CardCode = mycontroller[0].text;
    patch.CardName = mycontroller[16].text;
    //patch.CardType =  mycontroller[2].text;
    patch.U_Address1 =
        mycontroller[2].text == null || mycontroller[2].text.isEmpty
            ? null
            : mycontroller[2].text;
    patch.U_Address2 =
        mycontroller[3].text == null || mycontroller[3].text.isEmpty
            ? null
            : mycontroller[3].text;
    patch.area = mycontroller[17].text == null || mycontroller[17].text.isEmpty
        ? null
        : mycontroller[17].text;
    patch.U_ShipAddress1 =
        mycontroller[19].text == null || mycontroller[19].text.isEmpty
            ? null
            : mycontroller[19].text;
    patch.U_ShipAddress2 =
        mycontroller[20].text == null || mycontroller[20].text.isEmpty
            ? null
            : mycontroller[20].text;
    patch.U_Shiparea =
        mycontroller[21].text == null || mycontroller[21].text.isEmpty
            ? null
            : mycontroller[21].text;
    patch.altermobileNo =
        mycontroller[6].text == null || mycontroller[6].text.isEmpty
            ? null
            : mycontroller[6].text;
    patch.cantactName =
        mycontroller[1].text == null || mycontroller[1].text.isEmpty
            ? null
            : mycontroller[1].text;
    patch.gst = mycontroller[25].text == null || mycontroller[25].text.isEmpty
        ? null
        : mycontroller[25].text;
    patch.U_ShipCity =
        mycontroller[22].text == null || mycontroller[22].text.isEmpty
            ? null
            : mycontroller[22].text;
    patch.U_ShipState = statecode2;
    patch.U_ShipPincode =
        mycontroller[23].text == null || mycontroller[23].text.isEmpty
            ? null
            : mycontroller[23].text;
    patch.U_Pincode =
        mycontroller[4].text == null || mycontroller[4].text.isEmpty
            ? null
            : mycontroller[4].text;
    patch.U_City = mycontroller[5].text == null || mycontroller[5].text.isEmpty
        ? null
        : mycontroller[5].text;
    patch.U_State = statecode;
    patch.U_Country = countrycode;
    patch.U_ShipCountry = countrycode2;
    patch.levelof=valueChosedStatus==null ||valueChosedStatus!.isEmpty?null:valueChosedStatus;
        patch.ordertype=valueChosedCusType==null ||valueChosedCusType!.isEmpty?null:valueChosedCusType;

    // patch.gst=
    //patch.U_Country =  mycontroller[6].text;
    patch.U_EMail = mycontroller[7].text == null || mycontroller[7].text.isEmpty
        ? null
        : mycontroller[7].text;
    patch.U_Type = isSelectedCusTagcode;

    PostOrder? postLead = new PostOrder();
    postLead.updateDate = config.currentDate();
    postLead.updateid = int.parse(ConstantValues.UserId.toString());
    postLead.slpCode = ConstantValues.slpcode;
    patch.docent = ordocentry == null ? null : ordocentry;
    patch.ordernum = ordernum == null ? null : ordernum;
    postLead.docEntry = 0; //
    postLead.docnum = docnum + 1; //
    postLead.docstatus = "open"; //
    // postLead.doctotal = double.parse(getTotalOrderAmount());
    // postLead.DocType = "dDocument_Items"; //
    postLead.CardCode = mycontroller[0].text; //
    postLead.CardName = mycontroller[16].text; //
    postLead.DocDate = config.currentDate(); //
    postLead.deliveryDate = apiFDate;
    postLead.paymentDate = apiNdate;
    patch.enqid = enqID == null ? 0 : enqID;
    patch.enqtype = basetype == null ? -1 : basetype;
    // List<DocumentLines> productDetails2 = [];
    // for (int i = 0; i < productDetails.length; i++) {
    //   productDetails[i].linenum = i + 1;
    //   notifyListeners();
    // }
    // productDetails2 = productDetails;
    // // postLead.U_sk_planofpurchase = apiNdate;
    // postLead.docLine = productDetails2;
    // postLead.slpCode = ConstantValues.slpcode; //enqID
    postLead.enqID = enqID;
//
    postLead.U_sk_leadId = "";

    postLead.paymentTerms = isSelectedpaymentTermsCode;
    postLead.poReference = mycontroller[14].text;
    postLead.notes = mycontroller[15].text;
    // postLead.deliveryDate = mycontroller[13].text;

//
    if (iscomeforupdate == true) {
      isloadingBtn = true;
      notifyListeners();
      callupdateApi(context, postLead, patch);
    }
    //
    else {
      
        isloadingBtn = true;
        notifyListeners();
        callLeadSavePostApi(context, postLead, patch);
      
    }
  }

  //call save lead api
  late AccountsPostModal successRes;
  AccountsPostModal get getsuccessRes => successRes;

  callupdateApi(
      BuildContext context, PostOrder postLead, PatchExCus? patch) async {
   

    await AccountsUpdateApi.getData(ConstantValues.sapUserType, postLead, patch!)
        .then((value) {
      log("ANBUUU stcode " + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        successRes = value;
         callAlertDialog(context,'${value.exception}');
        // OrderSuccessPageState.getsuccessRes = value;
//         for(int i=0;i<paymode.length;i++){
//         if(paymode[i].CODE ==value.orderSavePostheader!.orderMasterdata![0].PaymentTerms){
// OrderSuccessPageState.paymode = paymode[i].description.toString();
//         }

//        } 
        // Get.toNamed(ConstantRoutes.a);?
        iscomeforupdate = false;

        // log("docno : " + successRes.DocNo.toString());
        notifyListeners();
        // callCheckListApi(context, value.DocEntry!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
            context, "${value.message}..!!${value.exception}..!!");
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context,
            "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
      }
    });
    //
    // if (errorFiles.isNotEmpty) {
    //   showLeadDeatilsDialog(context, errorFiles);
    // }
  }

  bool reminderOn = false;
  setReminderOnMethod(bool val, String? title) {
    reminderOn = val;
    if (reminderOn == true) {
      // addgoogle(title);
      notifyListeners();
    }
    notifyListeners();
  }

  // addgoogle(String? title) {
  //   Config config2 = Config();
  //   String newdate = config2.currentTmeonly();
  //   log("newdate::" + newdate.toString());
  //   rehours = int.parse(newdate.split(':')[0]);
  //   reminutes = int.parse(newdate.split(':')[1]);
  //   tz.TZDateTime? tzChosenDate;
  //   final DateTime chosenDate =
  //       DateTime(reyear!, remonth!, reday!, rehours!, reminutes!);
  //   final tz.Location indian = tz.getLocation('Asia/Kolkata');
  //   tzChosenDate = tz.TZDateTime.from(chosenDate, indian);
  //   config2.addEventToCalendar(tzChosenDate!, "$title", "Order");
  // }

  callLeadSavePostApi(
      BuildContext context, PostOrder postLead, PatchExCus? patch) async {
   
   
    notifyListeners();

    await AccountspostApi.getData(ConstantValues.sapUserType, postLead, patch!)
        .then((value) {
      log("ANBUUU stcode " + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        successRes = value;
        callAlertDialog(context,'${value.message}..!!${value.exception}');
//         OrderSuccessPageState.getsuccessRes = value;
//        for(int i=0;i<paymode.length;i++){
//         if(paymode[i].CODE ==value.orderSavePostheader!.orderMasterdata![0].PaymentTerms){
// OrderSuccessPageState.paymode = paymode[i].description.toString();
//         }

//        } 
        
       

        // log("docno : " + successRes.DocNo.toString());
        notifyListeners();
        // callCheckListApi(context, value.DocEntry!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        log("aaaa"+value.message.toString());
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
            context, "${value.message}..!!${value.exception}..");
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context,
            "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
      }
    });
    //
    // if (errorFiles.isNotEmpty) {
    //   showLeadDeatilsDialog(context, errorFiles);
    // }
  }

  // call save apis
callAlertDialog(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {
      clearAllData();
      Get.offAllNamed(ConstantRoutes.dashboard);
    });
  }
  bool isloadingBtn = false;
  bool get getisloadingBtn => isloadingBtn;
  // callNewCus(
  //     BuildContext context, PatchExCus? patch, PostOrder? postLead2) async {
  //   await OrderNewCustCretApi.getData(
  //           ConstantValues.sapUserType, patch!, postLead2!)
  //       .then((value) {
  //     log("Old customer " + value.stcode!.toString());
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       callLeadSavePostApi(context, postLead2, patch);
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(context, value.exception!);
  //       // config.msgDialog(
  //       //     context, "Some thing wrong..!!", value.error!.message!.value!);
  //     } else if (value.stcode! >= 500) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(
  //         context,
  //         "${value.stcode!}..!!Network Issue..\nTry again Later..!!",
  //       );
  //       // config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
  //     }
  //   });
  // }

//   fortest() {
//     for (int i = 0; i <= leadcheckdatas.length; i++) {
//       leadcheckdatas[i].linenum = i + 1;
//       log("linenummmm:" + leadcheckdatas[i].linenum.toString());
// // log("linenummmm:"+value.leadcheckdata![i].toString());
//     }
//   }

  //
  int docnum1 = 0;
//   callCheckListApi(BuildContext context, int docEntry) {
//     //  LeadCheckPostApi.printData(leadcheckdatas, docEntry);
//     String date = config.currentDateOnly();
//     for (int i = 0; i < leadcheckdatas.length; i++) {
//       int line = i + 1;
//       leadcheckdatas[i].linenum = line;
//       log("linenummmm:" + leadcheckdatas[i].linenum.toString());
// // log("linenummmm:"+value.leadcheckdata![i].toString());
//     }
//     OrderCheckPostApi.getData(
//             ConstantValues.sapUserType, leadcheckdatas, docEntry, docnum1)
//         .then((value) {
//       if (value >= 200 && value <= 210) {
//         OrderFollowupApiData leadFollowupApiData = new OrderFollowupApiData();
//         leadFollowupApiData.date = date;
//         leadFollowupApiData.nextFollowUp = apiFDate;
//         leadFollowupApiData.name = isSelectedenquiryReffers;
//         leadFollowupApiData.code = isSelectedrefcode;
//         callFollowupLead(context, leadFollowupApiData, docEntry);
//         //  isloadingBtn = false;
//         //  notifyListeners();
//         //  Get.toNamed(ConstantRoutes.successLead);

//         //  config.msgDialog(  --old
//         //  context, "Success..!!", "Lead Successfully created..!!");
//       } else if (value >= 400 && value <= 410) {
//         isloadingBtn = false;
//         notifyListeners();
//         showLeadDeatilsDialog(
//           context,
//           "Some thing wrong..!!",
//         );
//         // config.msgDialog(context, "Some thing wrong..!!","Try agin..!!");
//       } else if (value >= 500) {
//         isloadingBtn = false;
//         notifyListeners();
//         showLeadDeatilsDialog(
//           context,
//           "${value}..!!Network Issue..\nTry again Later..!!",
//         );
//         //config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
//       }
//     });
//   }

  bool remswitch = true;
  switchremainder(bool val) {
    remswitch = val;
    notifyListeners();
  }

  // Followup Lead

  // callFollowupLead(
  //   BuildContext context,
  //   OrderFollowupApiData leadFollowupApiData,
  //   int docEntry,
  // ) {
  //   //fs
  //   OrderFollowupApi.getData(
  //           ConstantValues.slpcode, leadFollowupApiData, docEntry)
  //       .then((value) {
  //     if (value >= 200 && value <= 210) {
  //       isloadingBtn = false;
  //       isComeFromEnq = false;
  //       enqID = null;
  //       notifyListeners();
  //       Get.toNamed(ConstantRoutes.successLead);
  //       //  Future.delayed(Duration(seconds: 2),(){
  //       //  // Navigator.pop(context);
  //       //   Get.offAllNamed(ConstantRoutes.leadstab);
  //       //  });

  //       //  config.msgDialog(  --old
  //       //  context, "Success..!!", "Lead Successfully created..!!");
  //     } else if (value >= 400 && value <= 410) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(
  //         context,
  //         "Some thing wrong..!!",
  //       );
  //       //config.msgDialog(context, "Some thing wrong..!!","Try agin..!!");
  //     } else if (value >= 500) {
  //       isloadingBtn = false;
  //       notifyListeners();
  //       showLeadDeatilsDialog(
  //         context,
  //         "${value}..!!Network Issue..\nTry again Later..!!",
  //       );
  //       //config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
  //     }
  //   });
  // }

  stateontap2(int i) {
    log("AAAA::" + i.toString());
    statebool2 = false;
    mycontroller[24].text = filterstateData[i].stateName.toString();
    statecode2 = filterstateData[i].statecode.toString();
    statename2 = filterstateData[i].stateName.toString();
    countrycode2 = filterstateData[i].countrycode.toString();
    log("statecode::" + statecode2.toString());
    log("statecode::" + countrycode2.toString());
    notifyListeners();
  }

  stateontap(int i) {
    log("AAAA::" + i.toString());
    statebool = false;
    mycontroller[18].text = filterstateData[i].stateName.toString();
    statecode = filterstateData[i].statecode.toString();
    statename = filterstateData[i].stateName.toString();
    countrycode = filterstateData[i].countrycode.toString();
    log("statecode::" + statecode.toString());
    log("statecode::" + countrycode.toString());
    notifyListeners();
  }
  //for success page

  //next btns

  firstPageNextBtn(BuildContext context) {
    int passed = 0;
    // log("pageChanged: ${pageChanged}");
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

    if (formkey[0].currentState!.validate()) {
      
       if(isSelectedCusTagcode.isEmpty){
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
      // if (mycontroller[18].text.isNotEmpty ) {

      //     methidstate(mycontroller[18].text);
      //     notifyListeners();

      // }
    else  if (mycontroller[18].text.isEmpty ||
          statecode.isEmpty && countrycode.isEmpty) {
        isText1Correct = true;
        notifyListeners();
      }
      // else  if (mycontroller[24].text.isNotEmpty) {

      //       methidstate2(mycontroller[24].text);
      //       notifyListeners();

      //   }
      else if (mycontroller[24].text.isEmpty ||
          statecode2.isEmpty && countrycode2.isEmpty) {
        isText1Correct2 = true;
        notifyListeners();
      } else {
        if (passed == 0) {
          saveToServer(context);
          // resetValidate();
        }
      }
    }
    notifyListeners();
  }

  // seconPageBtnClicked() {
  //   if (productDetails.length > 0) {
  //     pageController.animateToPage(++pageChanged,
  //         duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
  //   } else {
  //     Get.snackbar("Field Empty", "Choose products..!!",
  //         backgroundColor: Colors.red);
  //   }
  // }

  thirPageBtnClicked(BuildContext context) {
    int passed = 0;
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

  showBottomSheetInsert2(BuildContext context, int i) {
    final theme = Theme.of(context);
    selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    mycontroller[27].text = allProductDetails[i].sp == null
        ? "0"
        : allProductDetails[i].sp.toString();
    mycontroller[28].text = allProductDetails[i].slpPrice == null
        ? "0"
        : allProductDetails[i].slpPrice.toString();
    mycontroller[29].text = allProductDetails[i].storeStock == null
        ? "0"
        : allProductDetails[i].storeStock.toString();
    mycontroller[30].text = allProductDetails[i].whsStock == null
        ? "0"
        : allProductDetails[i].whsStock.toString();

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
                      SizedBox(
                        child: TextFormField(
                          enabled: true,
                          controller: mycontroller[27],
                          readOnly: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: theme.primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            alignLabelWithHint: true,
                            hintText: "",
                            labelText: "SP",
                            labelStyle: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor),

                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),

                            // border: OutlineInputBorder(

                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(10),
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: TextFormField(
                          // enabled: tr,
                          controller: mycontroller[28],
                          readOnly: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: theme.primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignLabelWithHint: true,
                            hintText: "",
                            labelText: "Cost",
                            labelStyle: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Fixed Price",
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              ":",
                              style: theme.textTheme.bodyText1?.copyWith(),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              "${allProductDetails[i].isFixedPrice}",
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
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
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              ":",
                              style: theme.textTheme.bodyText1?.copyWith(),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              "${allProductDetails[i].allowOrderBelowCost}",
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: theme.primaryColor,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: TextFormField(
                          // enabled: isTextFieldEnabled,
                          controller: mycontroller[29],
                          readOnly: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: theme.primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignLabelWithHint: true,
                            hintText: "",
                            labelText: "Store Stock",
                            labelStyle: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: TextFormField(
                          enabled: true,
                          controller: mycontroller[30],
                          readOnly: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: theme.primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignLabelWithHint: true,
                            hintText: "",
                            labelText: "Whs Stock",
                            labelStyle: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Allow Negative Stock",
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              ":",
                              style: theme.textTheme.bodyText1?.copyWith(),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              "${allProductDetails[i].allowNegativeStock}",
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: Colors.green[700],
                              ),
                            ),
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

  List<bool> isselected = [true, false];
  void showBottomSheet3(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Show SnackBar using the root Scaffold context
                  ScaffoldMessengerState().showSnackBar(
                    SnackBar(
                      content: Text(
                          'This is a SnackBar in front of the BottomSheet'),
                    ),
                  );
                },
                child: Text('Show Snackbar in Front of BottomSheet'),
              ),
              // Other content for the BottomSheet
            ],
          ),
        );
      },
    );
  }

  

  
  bool? fileValidation = false;

  List<String> filelink = [];
  List<String> fileException = [];
  List images = [
    "assets/pdfimg.png",
    "assets/txt.png",
    "assets/xls.png",
    "assets/img.jpg"
  ];

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

  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than Five Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  // selectattachment() async {
  //   List<File> filesz = [];
  //   log(files.length.toString());

  //   result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //   notifyListeners();

  //   if (result != null) {
  //     if (filedata.isEmpty) {
  //       files.clear();
  //       filesz.clear();
  //       filedata.clear();
  //       notifyListeners();
  //     }

  //     log("filedata::" + filedata.length.toString());

  //     filesz = result!.paths.map((path) => File(path!)).toList();

  //     // if (filesz.length != 0) {
  //     int remainingSlots = 5 - files.length;
  //     if (filesz.length <= remainingSlots) {
  //       for (int i = 0; i < filesz.length; i++) {
  //         // createAString();

  //         // showtoast();
  //         files.add(filesz[i]);
  //         log("Files Lenght :::::" + files.length.toString());
  //         List<int> intdata = filesz[i].readAsBytesSync();
  //         filedata.add(FilesData(
  //             fileBytes: base64Encode(intdata), fileName: filesz[i].path));

  //         //New
  //         // XFile? photoCompressedFile =await testCompressAndGetFile(filesz[i],filesz[i].path);
  //         // await FileStorage.writeCounter('${photoCompressedFile!.name}_1', photoCompressedFile);
  //         //

  //         notifyListeners();
  //         log("filedata222::" + filedata.length.toString());
  //         // return null;
  //       }
  //     } else {
  //       showtoast();
  //     }

  //     notifyListeners();
  //   }

  //   notifyListeners();
  // }

  // Future<XFile?> testCompressAndGetFile(File file, String targetPath) async {
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: 88,
  //     rotate: 180,
  //   );

  //   print(file.lengthSync());

  //   return result;
  // }

  // Future imagetoBinary(ImageSource source) async {
  //   List<File> filesz = [];
  //   await LocationTrack.checkcamlocation();
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image == null) return;
  //   // files.add(File());
  //   if (filedata.isEmpty) {
  //     filedata.clear();
  //     filesz.clear();
  //   }
  //   filesz.add(File(image.path));

  //   notifyListeners();
  //   log("filesz lenghthhhhh::::::" + filedata.length.toString());
  //   if (files.length <= 4) {
  //     for (int i = 0; i < filesz.length; i++) {
  //       files.add(filesz[i]);
  //       List<int> intdata = filesz[i].readAsBytesSync();
  //       String fileName = filesz[i].path.split('/').last;
  //       String fileBytes = base64Encode(intdata);
  //       Directory tempDir = await getTemporaryDirectory();
  //       String tempPath = tempDir.path;
  //       String fullPath = '${tempDir.path}/$fileName';
  //       filedata.add(
  //           FilesData(fileBytes: base64Encode(intdata), fileName: fullPath));
  //       notifyListeners();
  //     }
  //     // log("filesz lenghthhhhh::::::" + filedata.length.toString());

  //     // return null;
  //   } else {
  //     showtoast();
  //   }
  //   log("camera fileslength" + files.length.toString());
  //   log("camera filesdatalength" + filedata.length.toString());
  //   // showtoast();

  //   notifyListeners();
  // }

  // Future<XFile?> compressImage(File file) async {
  //   final filePath = file.absolute.path;
  //   final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
  //   final splitted = filePath.substring(0, (lastIndex));
  //   final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

  //   if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
  //     final compressedImage = await FlutterImageCompress.compressAndGetFile(
  //         filePath, outPath,
  //         minWidth: 1000,
  //         minHeight: 1000,
  //         quality: 50,
  //         format: CompressFormat.png);
  //     return compressedImage;
  //   } else {
  //     final compressedImage = await FlutterImageCompress.compressAndGetFile(
  //       filePath,
  //       outPath,
  //       minWidth: 1000,
  //       minHeight: 1000,
  //       quality: 50,
  //     );
  //     return compressedImage;
  //   }
  // }

  bool value3 = false;

  converttoShipping(bool value) {
    log("value:::" + value.toString());
    if (value == true) {
      mycontroller[19].text = mycontroller[2].text.toString();
      mycontroller[20].text = mycontroller[3].text.toString();
      mycontroller[21].text = mycontroller[17].text.toString();
      mycontroller[22].text = mycontroller[5].text.toString();
      mycontroller[23].text = mycontroller[4].text.toString();
      mycontroller[24].text = mycontroller[18].text.toString();
      notifyListeners();
    } else {
      mycontroller[19].text = "";
      mycontroller[20].text = "";
      mycontroller[21].text = "";
      mycontroller[22].text = "";
      mycontroller[23].text = "";
      mycontroller[24].text = "";
      notifyListeners();
    }
  }

  // getTotalOrderAmount() {
  //   double? LineTotal = 0.00;
  //   for (int i = 0; i < productDetails.length; i++) {
  //     LineTotal = LineTotal! + productDetails[i].LineTotal!;
  //   }
  //   return LineTotal!.toStringAsFixed(2);
  // }

  getExiCustomerData(String Customer, String CustomerCode) async {
    for (int i = 0; i < customerList.length; i++) {
      if (Customer == customerList[i].cardname &&
          CustomerCode == customerList[i].cardcode) {
        mycontroller[16].text = customerList[i].cardname.toString();
        mycontroller[0].text = customerList[i].mobile.toString();
        mycontroller[1].text = customerList[i].cantactName.toString();
        mycontroller[2].text = customerList[i].address1.toString();
        mycontroller[3].text = customerList[i].address2.toString();
        mycontroller[17].text = customerList[i].area.toString();
        mycontroller[5].text = customerList[i].city.toString();
        mycontroller[4].text = customerList[i].zipcode.toString();
        mycontroller[18].text = customerList[i].state.toString();
        mycontroller[6].text = customerList[i].alterMobileno.toString();
        mycontroller[7].text = customerList[i].email.toString();
        mycontroller[25].text = customerList[i].gst.toString();
        final Database db = (await DBHelper.getInstance())!;
        await DBOperation.getCusTagDataDetails(
                db, customerList[i].tag.toString().toUpperCase())
            .then((value) {
          isSelectedCusTag = value[0].Name.toString();
          CusTag = value[0].Name.toString();
          isSelectedCusTagcode = value[0].Code.toString();
        });

        // autoIsselectTag = true;

        notifyListeners();
      }
    }
    notifyListeners();
  }

  clearbool() {
    customerbool = false;
    areabool = false;
    citybool = false;
    pincodebool = false;

    notifyListeners();
  }

//
  filterListcustomer(String v) {
    if (v.isNotEmpty) {
      filterCustomerList = customerList
          .where((e) => e.cardname!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      // filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListArea(String v) {
    if (v.isNotEmpty) {
      filterCustomerList = customerList
          .where((e) => e.area!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerList = customerList;
      notifyListeners();
    }
  }

  filterListCity(String v) {
    if (v.isNotEmpty) {
      filterCustomerList = customerList
          .where((e) => e.city!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerList = customerList;
      notifyListeners();
    }
  }

  filterListPincode(String v) {
    if (v.isNotEmpty) {
      filterCustomerList = customerList
          .where((e) => e.zipcode!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerList = customerList;
      notifyListeners();
    }
  }

  filterListState(String v) {
    if (v.isNotEmpty) {
      filterCustomerList = customerList
          .where((e) => e.state!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerList = customerList;
      notifyListeners();
    }
  }



//   init(BuildContext context)async{
//     clearAll();
// await getCusTagType();
//     // determinePosition(context);
//     getEnqRefferes();
//   }
//   String? isSelectcstag='';
//   // iscateSeleted(int index) {
//   //    for (int i = 0; i < cusTagList.length; i++) {
//   //     if(cusTagList[i].Name == cusTagList[index].Name){
//   //       mycontroller3[6].text=cusTagList[i].Name.toString();
//   //       isSelectcstag='';

//   //     }
//   //    }
//   //   // mycontroller[7].text = select;
    
//   //   notifyListeners();
//   // }
//   List<CustomerTagTypeData> cusTagList = [];
//   List<CustomerTagTypeData> get getCusTagList => cusTagList;
//   getCusTagType() async {
//     final Database db = (await DBHelper.getInstance())!;

//     cusTagList = await DBOperation.getCusTagData(db);
//     notifyListeners();
//   }

//   //bool exception = false;f
//   bool billadressbool = false;
//   bool shipaddressbool = false;
//   bool officeaddress = false;
//   bool custInfobool = false;
//   bool latilongbool = false;
//   bool billingCheckbox = false;
//   bool delivAddCheckbox = false;

//   // bool spaddressbool = true;
//   bool isselect = false;
//   String? EnqRefer;
//   List<TextEditingController> mycontroller =
//       List.generate(30, (i) => TextEditingController());
//   // List<TextEditingController> mycontroller1 =
//   //     List.generate(20, (i) => TextEditingController());
//   // List<TextEditingController> mycontroller2 =
//   //     List.generate(15, (i) => TextEditingController());
//   // List<TextEditingController> mycontroller3 =
//   //     List.generate(15, (i) => TextEditingController());
//   ScrollController scrollController = ScrollController();
//   FocusNode focusNode2 = FocusNode();
  
//   bool isTextFieldEnabled = true;
//   bool customerbool = false;
//   bool areabool = false;
//   bool citybool = false;
//   bool pincodebool = false;
//   bool statebool = false;
//   bool statebool2 = false;
//   filterListcustomer(String v) {
//     if (v.isNotEmpty) {
//       filterCustomerList = customerList
//           .where((e) => e.cardname!.toLowerCase().contains(v.toLowerCase())
//               // ||
//               // e.name!.toLowerCase().contains(v.toLowerCase())
//               )
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       // filterexistCusDataList = existCusDataList;
//       notifyListeners();
//     }
//   }

//   filterListArea(String v) {
//     if (v.isNotEmpty) {
//       filterCustomerList = customerList
//           .where((e) => e.area!.toLowerCase().contains(v.toLowerCase())
//               // ||
//               // e.name!.toLowerCase().contains(v.toLowerCase())
//               )
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       filterCustomerList = customerList;
//       notifyListeners();
//     }
//   }

//   filterListCity(String v) {
//     if (v.isNotEmpty) {
//       filterCustomerList = customerList
//           .where((e) => e.city!.toLowerCase().contains(v.toLowerCase())
//               // ||
//               // e.name!.toLowerCase().contains(v.toLowerCase())
//               )
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       filterCustomerList = customerList;
//       notifyListeners();
//     }
//   }

//   filterListPincode(String v) {
//     if (v.isNotEmpty) {
//       filterCustomerList = customerList
//           .where((e) => e.zipcode!.toLowerCase().contains(v.toLowerCase())
//               // ||
//               // e.name!.toLowerCase().contains(v.toLowerCase())
//               )
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       filterCustomerList = customerList;
//       notifyListeners();
//     }
//   }

//   filterListState(String v) {
//     if (v.isNotEmpty) {
//       filterCustomerList = customerList
//           .where((e) => e.state!.toLowerCase().contains(v.toLowerCase())
//               // ||
//               // e.name!.toLowerCase().contains(v.toLowerCase())
//               )
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       filterCustomerList = customerList;
//       notifyListeners();
//     }
//   }
// }
//   List<CustomerData> customerList = [];
//   List<CustomerData> get getCustomerList => customerList;
//   List<CustomerData> filterCustomerList = [];
//   List<CustomerData> get getfilterCustomerList => filterCustomerList;
//   getExiCustomerData(String Customer, String CustomerCode) async {
//     // for (int i = 0; i < customerList.length; i++) {
//     //   if (Customer == customerList[i].cardname &&
//     //       CustomerCode == customerList[i].cardcode) {
//     //     // mycontroller[16].text = customerList[i].cardname.toString();
//     //     // mycontroller[0].text = customerList[i].mobile.toString();
//     //     // mycontroller[1].text = customerList[i].cantactName.toString();
//     //     // mycontroller[2].text = customerList[i].address1.toString();
//     //     // mycontroller[3].text = customerList[i].address2.toString();
//     //     // mycontroller[17].text = customerList[i].area.toString();
//     //     // mycontroller[5].text = customerList[i].city.toString();
//     //     // mycontroller[4].text = customerList[i].zipcode.toString();
//     //     // mycontroller[18].text = customerList[i].state.toString();
//     //     // mycontroller[6].text = customerList[i].alterMobileno.toString();
//     //     // mycontroller[7].text = customerList[i].email.toString();
//     //     // mycontroller[25].text = customerList[i].gst.toString();
//     //     // final Database db = (await DBHelper.getInstance())!;
//     //     // await DBOperation.getCusTagDataDetails(
//     //     //         db, customerList[i].tag.toString().toUpperCase())
//     //     //     .then((value) {
//     //     //   isSelectedCusTag = value[0].Name.toString();
//     //     //   CusTag = value[0].Name.toString();
//     //     //   isSelectedCusTagcode = value[0].Code.toString();
//     //     // });

//     //     // autoIsselectTag = true;

//     //     // notifyListeners();
//     //   // }
//     // }
//     // notifyListeners();
//   }
//    bool value3 = false;
// clearnum() {
//     value3 = false;
//     mycontroller[19].clear();
//     mycontroller[20].clear();
//     mycontroller[21].clear();
//     mycontroller[22].clear();
//     mycontroller[23].clear();
//     mycontroller[24].clear();
//     mycontroller[16].clear();
//     mycontroller[1].clear();
//     mycontroller[25].clear();
//     mycontroller[18].clear();
//     mycontroller[2].clear();
//     mycontroller[7].clear();
//     mycontroller[4].clear();
//     mycontroller[5].clear();
//     mycontroller[6].clear();
//     mycontroller[17].clear();
//     mycontroller[3].clear();
//     isSelectedCusTagcode = '';
//     customerapicLoading = false;
//     notifyListeners();
//   }

//   String statecode = '';
//   String countrycode = '';
//   String statename = '';
//   bool isText1Correct = false;
//   String statecode2 = '';
//   String countrycode2 = '';
//   String statename2 = '';
//   bool isText1Correct2 = false;

//   methidstate2(String name) {
//     statecode2 = '';
//     statename2 = '';
//     countrycode2 = '';

//     log("ANBU");
//     for (int i = 0; i < filterstateData.length; i++) {
//       if (filterstateData[i].stateName.toString().toLowerCase() ==
//           name.toString().toLowerCase()) {
//         statecode2 = filterstateData[i].statecode.toString();
//         statename2 = filterstateData[i].stateName.toString();
//         countrycode2 = filterstateData[i].countrycode.toString();
//         isText1Correct2 = false;

//         log("statecode22:::" + statecode2.toString());
//       }
//     }
//     //  notifyListeners();
//   }

//   methidstate(String name, BuildContext context) {
//     statecode = '';
//     statename = '';
//     countrycode = '';

//     log("ANBU");
//     for (int i = 0; i < filterstateData.length; i++) {
//       if (filterstateData[i].stateName.toString().toLowerCase() ==
//           name.toString().toLowerCase()) {
//         statecode = filterstateData[i].statecode.toString();
//         statename = filterstateData[i].stateName.toString();
//         countrycode = filterstateData[i].countrycode.toString();
//         isText1Correct = false;
// // FocusScope.of(context).unfocus();
//         log("22222state:::" + statecode.toString());
//       }
//     }
//     //  notifyListeners();
//   }

//   List<stateHeaderData> stateData = [];
//   List<stateHeaderData> filterstateData = [];
//   stateApicallfromDB() async {
//     stateData.clear();
//     filterstateData.clear();

//     final Database db = (await DBHelper.getInstance())!;
//     stateData = await DBOperation.getstateData(db);
//     filterstateData = stateData;
//     log("filterstateData length::" + filterstateData.length.toString());
//     notifyListeners();
//   }

//   filterListState2(String v) {
//     if (v.isNotEmpty) {
//       filterstateData = stateData
//           .where((e) => e.stateName!.toLowerCase().contains(v.toLowerCase())
//               // ||
//               // e.name!.toLowerCase().contains(v.toLowerCase())
//               )
//           .toList();
//       notifyListeners();
//     } else if (v.isEmpty) {
//       filterstateData = stateData;
//       notifyListeners();
//     }
//   }
//   List<GlobalKey<FormState>> formkey =
//       new List.generate(3, (i) => new GlobalKey<FormState>(debugLabel: "Lead"));
//   List<EnqRefferesData> enqReffList = [];
//   List<EnqRefferesData> get getenqReffList => enqReffList;
//   String isSelectedenquiryReffers = '';
//   String get getisSelectedenquiryReffers => isSelectedenquiryReffers;
//   getEnqRefferes() async {
//     final Database db = (await DBHelper.getInstance())!;
//     enqReffList = await DBOperation.getEnqRefferes(db);
//     print("payment term lenghth::" + enqReffList.length.toString());
//     notifyListeners();
//   }

//   customerDropDown() {
//     custInfobool = !custInfobool;
//     notifyListeners();
//   }

//   billAddCheckboxmethod(bool val) {
//     billingCheckbox = val;
//     if (val == true) {
//       mycontroller2[0].text = mycontroller1[0].text.toString();
//       mycontroller2[1].text = mycontroller1[1].text.toString();
//       mycontroller2[2].text = mycontroller1[2].text.toString();
//       mycontroller2[3].text = mycontroller1[3].text.toString();
//       mycontroller2[4].text = mycontroller1[4].text.toString();
//       mycontroller2[5].text = mycontroller1[5].text.toString();
//       mycontroller2[6].text = mycontroller1[6].text.toString();
//     } else {
//       mycontroller2[0].text = "";
//       mycontroller2[1].text = "";
//       mycontroller2[2].text = "";
//       mycontroller2[3].text = "";
//       mycontroller2[4].text = "";
//       mycontroller2[5].text = "";
//       mycontroller2[6].text = "";
//     }
//     notifyListeners();
//   }FocusNode focusNode1 = FocusNode();
//   FocusNode focusNode3 = FocusNode();

//   ontapvalid(BuildContext context) {
//     methidstate(mycontroller[18].text, context);
//     FocusScope.of(context).requestFocus(focusNode1);
//     statebool = false;
//     notifyListeners();
//   }

//   ontapvalid2(BuildContext context) {
//     methidstate2(mycontroller[24].text);
//     FocusScope.of(context).requestFocus(focusNode3);
//     statebool = false;
//     notifyListeners();
//   }

//   clearAll() {
   
//     log("step1");
    
//     valueChosedStatus=null;
//     valueChosedCusType=null;
//     valueChosedCusType=null;
//     mycontroller[27].clear();
//     mycontroller[28].clear();
//     mycontroller[29].clear();
//     mycontroller[30].clear();
//  customermodeldata=null;

//     paymode.clear();
//     reyear = null;
//     reminderOn = false;
//     remonth = null;
//     reday = null;
//     rehours = null;
//     reminutes = null;
//     isTextFieldEnabled = true;
//     iscomeforupdate = false;
//     String statecode = '';
//     String countrycode = '';
//     String statename = '';
//     statebool = false;
//     statebool2 = false;
//     isText1Correct = false;
//     isText1Correct2 = false;
//     isAnother == true;
//     mycontroller[0].clear();
//     mycontroller[1].clear();
//     mycontroller[2].clear();
//     mycontroller[3].clear();
//     mycontroller[4].clear();
//     mycontroller[5].clear();
//     mycontroller[6].clear();
//     mycontroller[7].clear();
//     mycontroller[8].clear();
//     mycontroller[9].clear();
//     mycontroller[10].clear();
//     mycontroller[11].clear();
//     mycontroller[12].clear();
//     mycontroller[13].clear();
//     mycontroller[14].clear();
//     mycontroller[15].clear();
//     mycontroller[16].clear();
//     mycontroller[17].clear();
//     mycontroller[18].clear();
//     mycontroller[19].clear();
//     mycontroller[20].clear();
//     mycontroller[21].clear();
//     mycontroller[22].clear();
//     mycontroller[23].clear();
//     mycontroller[24].clear();
//     mycontroller[25].clear();
//     mycontroller[31].clear();

//     files.clear();
//     filedata.clear();
//     value3 = false;
//     isSelectedpaymentTermsList = '';
//     isSelectedpaymentTermsCode = '';
//     isSelectedenquirytype = '';
//     isSelectedAge = '';
//     isSelectedcomeas = '';
//     isSelectedGender = '';
//     isSelectedAdvertisement = '';
//     isSelectedenquiryReffers = '';
//     isSelectedCusTag = '';
//     isSelectedCusTagcode = "";
//     CusTag = null;
//     customerapicalled = false;
//     oldcutomer = false;
//     customerapicLoading = false;
//     productDetails.clear();
//     exceptionOnApiCall = '';
//     pageChanged = 0;
//     showItemList = true;
//     isSelectedCusTag = '';
//     // isComeFromEnq = false;s
//     isloadingBtn = false;
//     // autoIsselectTag = false;
//     enqID = null;
//     basetype = null;
//     log("step2");

//     resetListSelection();
//     log("step3");

//     notifyListeners();
  
//   }

//   deliAddCheckboxmethod(bool val) {
//     delivAddCheckbox = val;
//     if (val == true) {
//       mycontroller3[0].text = mycontroller2[0].text.toString();
//       mycontroller3[1].text = mycontroller2[1].text.toString();
//       mycontroller3[2].text = mycontroller2[2].text.toString();
//       mycontroller3[3].text = mycontroller2[3].text.toString();
//       mycontroller3[4].text = mycontroller2[4].text.toString();
//       mycontroller3[5].text = mycontroller2[5].text.toString();
//       mycontroller3[6].text = mycontroller2[6].text.toString();
//     } else {
//       mycontroller3[0].text = "";
//       mycontroller3[1].text = "";
//       mycontroller3[2].text = "";
//       mycontroller3[3].text = "";
//       mycontroller3[4].text = "";
//       mycontroller3[5].text = "";
//       mycontroller3[6].text = "";
//     }
//     notifyListeners();
//   }

//   OfficeDropDown() {
//     officeaddress = !officeaddress;
//     notifyListeners();
//   }

//   billingAddDropDown() {
//     billadressbool = !billadressbool;
//     notifyListeners();
//   }

//   ShipAddDropDown() {
//     shipaddressbool = !shipaddressbool;
//     notifyListeners();
//   }

//   radio(bool val) {
//     // latilongbools
//     if (val == true) {
//       mycontroller1[6].text = latitude.toString();
//       mycontroller1[7].text = langitude.toString();
//       notifyListeners();
//     } else {
//       mycontroller1[6].text = "";
//       mycontroller1[7].text = "";
//       notifyListeners();
//     }
//   }

//   selectEnqReffers(String selected, String refercode) {
//     isSelectedenquiryReffers = selected;
//     EnqRefer = refercode;
//     notifyListeners();
//   }

//   validate2(BuildContext context) {
//     int count = 0;
//     int custcount = 0;
//     int addcount = 0;

//     String? billadd = "";
//     String? offadd = "";
//     String? shipadd = "";

//     billadressbool = false;
//     shipaddressbool = false;
//     officeaddress = false;
//     custInfobool = false;
//     if (formkey[0].currentState!.validate()) {
//     } else {
//       custcount = 1;
//       notifyListeners();
//     }

//     if (formkey[3].currentState!.validate()) {
//     } else if (formkey[1].currentState!.validate()) {
//     } else if (formkey[2].currentState!.validate()) {
//     } else {
//       addcount = 1;
//       notifyListeners();
//     }

//     if (custcount == 0 && addcount == 0) {
//       //    billadressbool = false;
//       // shipaddressbool = false;
//       // officeaddress = false;
//       // custInfobool = false;
//       showDialog<dynamic>(
//           context: context,
//           builder: (_) {
//             return SuccessDialogPG(
//               heading: 'Response',
//               msg: 'Customer Successfully Registered..!!',
//             );
//           });
//     } else if (custcount != 0 || addcount != 0) {
//       showDialog<dynamic>(
//           context: context,
//           builder: (_) {
//             return SuccessDialogPG(
//               heading: 'Response',
//               msg: 'Please Fill Mandatory fields..!!',
//             );
//           });
//       // formkey[0].currentState!.validate();
//       // formkey[1].currentState!.validate();
//       // formkey[2].currentState!.validate();
//       // formkey[3].currentState!.validate();
//     }

//     notifyListeners();
//   }

//   validate(BuildContext context) {
//     int count = 0;
//     int custcount = 0;
//     int addcount = 0;

//     String? billadd = "";
//     String? offadd = "";
//     String? shipadd = "";

//     billadressbool = false;
//     shipaddressbool = false;
//     officeaddress = false;
//     custInfobool = false;
//     if (formkey[0].currentState!.validate()) {
//     } else {
//       custcount = 1;
//       notifyListeners();
//     }

//     // if (formkey[1].currentState!.validate() ||
//     //     formkey[2].currentState!.validate() ||
//     //     formkey[3].currentState!.validate()) {
//     if (mycontroller1[0].text.isNotEmpty ||
//         mycontroller1[1].text.isNotEmpty ||
//         mycontroller1[2].text.isNotEmpty ||
//         mycontroller1[3].text.isNotEmpty ||
//         mycontroller1[4].text.isNotEmpty ||
//         mycontroller1[5].text.isNotEmpty ||
//         mycontroller1[6].text.isNotEmpty ||
//         mycontroller1[7].text.isNotEmpty ||
//         mycontroller1[8].text.isNotEmpty) {
//       if (formkey[1].currentState!.validate()) {
//       } else {
//         count++;
//         notifyListeners();
//       }
//     } else
//     //
//     if (mycontroller2[0].text.isNotEmpty ||
//         mycontroller2[1].text.isNotEmpty ||
//         mycontroller2[2].text.isNotEmpty ||
//         mycontroller2[3].text.isNotEmpty ||
//         mycontroller2[4].text.isNotEmpty ||
//         mycontroller2[5].text.isNotEmpty ||
//         mycontroller2[6].text.isNotEmpty) {
//       if (formkey[2].currentState!.validate()) {
//       } else {
//         count++;
//         notifyListeners();
//       }
//     } else
//     //
//     if (mycontroller3[0].text.isNotEmpty ||
//         mycontroller3[1].text.isNotEmpty ||
//         mycontroller3[2].text.isNotEmpty ||
//         mycontroller3[3].text.isNotEmpty ||
//         mycontroller3[4].text.isNotEmpty ||
//         mycontroller3[5].text.isNotEmpty ||
//         mycontroller3[6].text.isNotEmpty) {
//       if (formkey[3].currentState!.validate()) {
//       } else {
//         count++;
//         notifyListeners();
//       }
//     } else {
//       addcount = 1;
//       formkey[1].currentState!.validate();
//       formkey[2].currentState!.validate();
//       formkey[3].currentState!.validate();
//       notifyListeners();
//     }
//     if (custcount == 0 && count == 0 && addcount == 0) {
//       showDialog<dynamic>(
//           context: context,
//           builder: (_) {
//             return SuccessDialogPG(
//               heading: 'Response',
//               msg: 'Customer Successfully Registered..!!',
//             );
//           });
//     } else if (custcount != 0 || count != 0 || addcount != 0) {
//       showDialog<dynamic>(
//           context: context,
//           builder: (_) {
//             return SuccessDialogPG(
//               heading: 'Response',
//               msg: 'Please Fill Mandatory fields..!!',
//             );
//           });
//     }
//     // else if (custcount != 0) {
//     //   showDialog<dynamic>(
//     //       context: context,
//     //       builder: (_) {
//     //         return SuccessDialogPG(
//     //           heading: 'Response',
//     //           msg: 'Please Fill Customer Info Mandatory fields..!!',
//     //         );
//     //       });
//     // } else if (count != 0) {
//     //   showDialog<dynamic>(
//     //       context: context,
//     //       builder: (_) {
//     //         return SuccessDialogPG(
//     //           heading: 'Response',
//     //           msg: 'Please Fill Address Details..!!',
//     //         );
//     //       });
//     // } else if (addcount == 3 && custcount != 0) {
//     //   showDialog<dynamic>(
//     //       context: context,
//     //       builder: (_) {
//     //         return SuccessDialogPG(
//     //           heading: 'Response',
//     //           msg: 'Please Fill Minimum One Address Details..!!',
//     //         );
//     //       });
//     // }
//     // } else {
//     //   if (custcount == 0) {
//     //     showDialog<dynamic>(
//     //         context: context,
//     //         builder: (_) {
//     //           return SuccessDialogPG(
//     //             heading: 'Response',
//     //             msg: 'Please Enter Minimum One Address..!!',
//     //           );
//     //         });
//     //   }
//     // }
//     //else if (mycontroller1.isEmpty &&
//     //     mycontroller2.isEmpty &&
//     //     mycontroller3.isEmpty) {
//     //   showDialog<dynamic>(
//     //       context: context,
//     //       builder: (_) {
//     //         return SuccessDialogPG(
//     //           heading: 'Response',
//     //           msg: 'Please Enter Addresss..!!',
//     //         );
//     //       });
//     // }
//     // formkey[1].currentState!.validate();
//     // formkey[2].currentState!.validate();
//     // formkey[3].currentState!.validate();
//     // formkey[4].currentState!.validate();
//     notifyListeners();
//   }

//   String latitude = '';
//   String langitude = '';
//   String? url;
//   String? longi;
//   String? lati;
//   Future<void> determinePosition(BuildContext context) async {
//     bool? serviceEnabled;
//     LocationPermission permission;
//     try {
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (serviceEnabled == false) {
//         try {
//           await Geolocator.getCurrentPosition();
//           permission = await Geolocator.checkPermission();
//           if (permission == LocationPermission.denied) {
//             permission = await Geolocator.requestPermission();
//             if (permission == LocationPermission.denied) {
//               //return Future.error('Location permissions are denied');
//             }
//           }

//           if (permission == LocationPermission.deniedForever) {}
//           var pos = await Geolocator.getCurrentPosition();
//           print('lattitude: ' + pos.latitude.toString());
//           latitude = pos.latitude.toString();
//           langitude = pos.longitude.toString();
//           longi = langitude;
//           lati = latitude;

//           // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

//           var lat = double.parse(latitude);
//           var long = double.parse(langitude);
//           // await AddressMasterApi.getData(lat.toString(), long.toString())
//           //     .then((value) {
//           //   log("value.stcode::" + value.stcode.toString());
//           //   if (200 >= value.stcode! && 210 <= value.stcode!) {
//           //     adrress = value.address2;
//           //     log("adress::" + adrress.toString());
//           //     notifyListeners();
//           //   } else {
//           //     print("error:api");
//           //   }
//           // });
//           // var placemarks =
//           //     await placemarkFromCoordinates(lat, long);

//           // adrress = placemarks[0].street.toString() +
//           //       ' ' +
//           //       placemarks[0].thoroughfare.toString() +
//           //       ' ' +
//           //       placemarks[0].locality.toString();
//           //    final coordinates = new Coordinates(lat, long);
//           // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//           // var first = addresses.first;
//           // print("AAAAAAAAAAAAA:::${first.featureName} : ${first.addressLine}");
//           // adrress=first.addressLine;
//           notifyListeners();
//         } catch (e) {
//           const snackBar = SnackBar(
//               duration: Duration(seconds: 1),
//               backgroundColor: Colors.red,
//               content: Text('Please turn on the Location!!..'));
//           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           Future.delayed(
//             const Duration(seconds: 2),
//             () => Get.back<dynamic>(),
//           );
//         }
//         notifyListeners();
//       } else if (serviceEnabled == true) {
//         var pos = await Geolocator.getCurrentPosition();
//         print('lattitude: ' + pos.latitude.toString());
//         latitude = pos.latitude.toString();
//         langitude = pos.longitude.toString();
//         longi = langitude;
//         lati = latitude;

//         url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

//         var lat = double.parse(latitude);
//         var long = double.parse(langitude);
//         // await AddressMasterApi.getData(lat.toString(), long.toString())
//         //     .then((value) {
//         //   log("value.stcode::" + value.stcode.toString());
//         //   if (value.stcode! >= 200 && value.stcode! <= 210) {
//         //     adrress = value.address2;
//         //     log("adress::" + adrress.toString());
//         //     notifyListeners();
//         //   } else {
//         //     print("error:api");
//         //   }
//         // });
//         // var placemarks = await placemarkFromCoordinates(lat, long);
//         //   adrress = placemarks[0].street.toString() +
//         //       ' ' +
//         //       placemarks[0].thoroughfare.toString() +
//         //       ' ' +
//         //       placemarks[0].locality.toString();
//         //  final coordinates = new Coordinates(lat, long);
//         // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//         // var first = addresses.first;
//         //         adrress=first.addressLine;

//         // print("${first.featureName} : ${first.addressLine}");
//         notifyListeners();
//       }
//       notifyListeners();
//     } catch (e) {
//       final snackBar =
//           SnackBar(backgroundColor: Colors.red, content: Text('$e'));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       // Future.delayed(
//       //     const Duration(seconds: 2),
//       //     () => Get.back<dynamic>(),
//       //   );
//     }
//     notifyListeners();
//   }
}
