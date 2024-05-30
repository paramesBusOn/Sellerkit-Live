// ignore_for_file: prefer_const_constructors, prefer_is_empty, unnecessary_new, unnecessary_string_interpolations, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sellerkit/Constant/GetFilePath.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/OrderTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/levelofinterestModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/paymodemodel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/couponModel.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/couponApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/paymentmode.dart';
import 'package:sellerkit/Services/PostQueryApi/QuotatationApi/QuotesQTHApi.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/warningorder.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
// import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/GetOrderDeatilsQTH.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/updateorderApi.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/ItemMasertDBModel.dart';
import '../../Models/AddEnqModel/AddEnqModel.dart';
import '../../Models/CustomerMasterModel/CustomerMasterModel.dart';
import '../../Models/NewVisitModel/NewVisitModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CheckEnqCusDetailsModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import '../../Models/PostQueryModel/OrdersCheckListModel/GetOrderCheckListModel.dart';
import '../../Pages/OrderBooking/Screens/OrderSuccessPage.dart';
import '../../Pages/OrderBooking/Widgets/OrderWarningDialog.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqCutomerDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Services/PostQueryApi/OrdersApi/AttachmentFileLinkApi.dart';
import '../../Services/PostQueryApi/OrdersApi/OrderCheckListApi.dart';
import '../../Services/PostQueryApi/OrdersApi/OrderCheckPostApi.dart';
import '../../Services/PostQueryApi/OrdersApi/OrderFollowupApi.dart';
import '../../Services/PostQueryApi/OrdersApi/SaveOrderApi.dart';
import '../../Services/ServiceLayerApi/CreatNewCus/OrderCreateNewCustApi.dart';
import '../../Widgets/AlertDilog.dart';
import '../EnquiryController/EnquiryMngController.dart';
import '../EnquiryController/EnquiryUserContoller.dart';
import 'TabOrderController.dart';

class OrderNewController extends ChangeNotifier {
  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
  init() async {
    clearAllData();
    getdataFromDb();
    getEnqRefferes();
     await stateApicallfromDB();
   await getLeveofType();
    await callLeadCheckApi();
   
    await callpaymodeApi();
    getCustomerTag();
    // getCustomerListFromDB();
  }

  List<PaymodeModalData> paymode = [];
  callpaymodeApi() async {
    paymode.clear();
    notifyListeners();
    await PaymodeApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.paymode != null) {
          paymode = value.paymode!;

          notifyListeners();
        } else if (value.paymode == null) {
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
customerdetData? customermodeldata;
callcustomerapi()async{
  await customerDetailApi.getData().then((value) {
    if(value.stcode! >= 200 && value.stcode! <= 210){
customermodeldata=value.leadcheckdata;
// log("customermodeldata::"+customermodeldata!.storeLogoUrl.toString());
    }
  });

}

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
    getdataFromDb();
    getEnqRefferes();
     getLeveofType();
    callLeadCheckApi();
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
      new List.generate(6, (i) => new GlobalKey<FormState>(debugLabel: "Lead"));
  List<TextEditingController> mycontroller =
      List.generate(40, (i) => TextEditingController());

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
  double? quantity;
  double? taxvalue;
 
  double total = 0.00;
List<Custype> custype=[
  Custype(name: "Single"),
   Custype(name: "Bulk"),
    Custype(name: "Chain Order")
 
  ];
  double? sporder =0.00;
  double? slppriceorder=0.00;
  double? storestockorder=0.00;
  double? whsestockorder=0.00;
  bool? isfixedpriceorder=false;
  bool? allownegativestockorder=false;
  bool? alloworderbelowcostorder=false;
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

  List<PaymentTermsData> paymentTermsList = [
    PaymentTermsData(Name: "Cash", Code: "1"),
    PaymentTermsData(Name: "Card", Code: "2"),
    PaymentTermsData(Name: "Cheque", Code: "3"),
    PaymentTermsData(Name: "Finance", Code: "4"),
    PaymentTermsData(Name: "Wallet", Code: "5"),
    PaymentTermsData(Name: "Transfer", Code: "6"),
    PaymentTermsData(Name: "COD", Code: "7"),
  ];
  List<PaymentTermsData> get getpaymentTermsList => paymentTermsList;

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
    // log("AN11:" + isSelectedenquiryReffers.toString());

    // log("AN22:" + EnqRefer.toString());

    // log("AN33:" + isSelectedrefcode.toString());
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
    // log("getCustomerListFromDB length::" +
    //     filterCustomerList.length.toString());
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
  // checkscannedcode(String code){
  //    log("code:::::"+code.toString());
     

  // }
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
  addProductDetails(BuildContext context) {
    // log("sellect" + selectedItemCode.toString());
    // log("sellect" + selectedItemName.toString());
    // log("sellect" + quantity.toString());
    // log("sellect" + productDetails.length.toString());

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
        productDetails.add(DocumentLines(
            id: 0,
            docEntry: 0,
            linenum: 0,
            ItemCode: selectedItemCode,
            ItemDescription: selectedItemName,
            Quantity: quantity,
            LineTotal: total,
            Price: unitPrice,
            TaxCode: taxvalue,
            TaxLiable: "tNO",
            storecode:  ConstantValues.Storecode ,
            deliveryfrom: isselected[0] == true ? "store" : "Whse",
            sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            complementary: assignvalue,
            couponcode: mycontroller[36].text ==null || mycontroller[36].text.isEmpty?
   null:mycontroller[36].text,
            ));
         showItemList = false;
        mycontroller[12].clear();
        Navigator.pop(context);
        
        isUpdateClicked = false;
        // showComplementry(context);
        
        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].deliveryfrom.toString());
       
        notifyListeners();
      }
    }
  }

  addfinalproduct(BuildContext context){
   productDetails.add(DocumentLines(
            id: 0,
            docEntry: 0,
            linenum: 0,
            ItemCode: selectedItemCode,
            ItemDescription: selectedItemName,
            Quantity: quantity,
            LineTotal: total,
            Price: unitPrice,
            TaxCode: taxvalue,
            TaxLiable: "tNO",
            storecode:  ConstantValues.Storecode ,
            deliveryfrom: isselected[0] == true ? "store" : "Whse",
            sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            complementary: assignvalue
            ));
             showItemList = false;
        // mycontroller[12].clear();
      
        
        isUpdateClicked = false;
            Navigator.pop(context);
           
            notifyListeners(); 
           
  }
showComplementry(BuildContext context){
  final theme = Theme.of(context);
  showModalBottomSheet(
    isDismissible :false,
    context: context, 
    builder: (context)=>
    StatefulBuilder(builder: (context,st){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complementry Items",
              style: theme.textTheme.bodyText1!.copyWith(
                color: theme.primaryColor
              ),
            ),
            // if(){

            // }else{
              
            // }
           iscomplement == false?Container(): Container(
              child: Text("* Select Complementary",style:TextStyle(color:Colors.red)),
            ),
          Container(
            height: Screens.padingHeight(context)*0.3,
            width: Screens.width(context),
            child:SingleChildScrollView(
              child: ListBody(
                                        children:allProductDetails.take(10)
                                       . map((item )
                                         => CheckboxListTile(
                                          value:selectedassignto.contains(item.itemCode) ,
                                          title: Text(item.itemCode.toString()),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          st((){
 itemselectassignto(item.itemCode.toString(),ischecked!);
                                         
                                          })
                                           ,
                                    
                                         )
                                         ).toList()
                                      ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(onPressed: (){
              if(assignvalue==null || assignvalue!.isEmpty){
                st((){
             
            iscomplement=true;
            });
              }
            st((){
              addfinalproduct(context);
            });
            }, child: Text("save")),
          )
        ],),
      );

    })
    );

}

splitcomplement(String products){


  List<String> productList = products.split(',').map((item) => item.trim()).toList();
return ListView.builder(
  shrinkWrap : true,
  physics: NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('* ${productList[index]}', style: TextStyle(fontSize: 15)),
            SizedBox(height: 5,)
          ],
        );
          
        
      },
    );

}
bool iscomplement=false;
String? assignvalue;
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

List<String> selectedassignto=[];
  updateProductDetails(BuildContext context, int i) {
    if (formkey[1].currentState!.validate()) {
      productDetails[i].Quantity = quantity;
      productDetails[i].Price = unitPrice;
      productDetails[i].LineTotal = total;
      showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
    }
  }

  List<GetCustomerData>? customerdetails;
  resetItems(int i) {
    unitPrice = 0.00;
    quantity = 0;
    total = 0.00;
    mycontroller[10].text = allProductDetails[i].sp!.toStringAsFixed(2);
    //.clear();
    mycontroller[11].clear();
    mycontroller[36].clear();
    assignvalue = null;
    iscomplement=false;
    selectedassignto.clear();
    getcoupondata.clear();
    couponload=false;
    isappliedcoupon=false;
    notifyListeners();
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
            customerdetails = value.itemdata!.customerdetails;
            mapValues(value.itemdata!.customerdetails![0]);
            oldcutomer = true;
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
  //             alertDialogOpenLeadOREnq2(context, "enquiry");
  //           }
            //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            //             value.itemdata!.orderdetails != null) {
            //                log("Anbuenq");
            //           orderdetails = value.itemdata!.orderdetails;
            //           alertDialogOpenLeadOREnq(context,"Orders");
            //         }
             if (value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
              // log("Anbulead");
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
                }else if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
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

              alertDialogOpenLeadOREnq2(context, "Lead");
             } else if(enquirydetails!.isNotEmpty){
  AssignedToDialogUserState.LookingFor =
                  enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                  enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                  enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  enquirydetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq2(context, "enquiry");
             }else if(orderdetails!.isNotEmpty){
AssignedToDialogUserState.LookingFor =
                  orderdetails![0].DocType;
              AssignedToDialogUserState.Store =
                  orderdetails![0].Store;
              AssignedToDialogUserState.handledby =
                  orderdetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  orderdetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq2(context, "Order");
             }
             
            } 
            // else if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //       for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
                

            //   }
            //   log("Anbuenq");
            //   // enquirydetails = value.itemdata!.enquirydetails;
            
            // }
            // else if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //       for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
                

            //   }
            //   log("Anbuenq");
            //   // orderdetails = value.itemdata!.enquirydetails;
              
            // }
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

  List<CheckEnqDetailsData> checkEnqDetailsData = [];
  callLeadPageSB(
    BuildContext context,
  ) {
    OrderTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
    OrderTabController.isSameBranch = true;
    Navigator.pop(context);
    Get.offAllNamed(ConstantRoutes.leadstab);
    notifyListeners();
  }

  static String typeOfLeadOrEnq = '';
  static String branchOfLeadOrEnq = '';

  callLeadPageNSB(BuildContext context) {
    OrderTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
    OrderTabController.isSameBranch = false;
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

  void alertDialogOpenLeadOREnq(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return OrderWarningDialog();
        }).then((value) {});
  }

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
   clearwarning() {
    value3 = false;
    mycontroller[19].clear();
    mycontroller[20].clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();
    mycontroller[24].clear();
    mycontroller[16].clear();
    mycontroller[1].clear();
    mycontroller[0].clear();
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

        // log("statecode22:::" + statecode2.toString());
      }
    }
    //  notifyListeners();
  }

  methidstate(String name, BuildContext context) {
    statecode = '';
    statename = '';
    countrycode = '';

    // log("ANBU");
    for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].stateName.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        statecode = filterstateData[i].statecode.toString();
        statename = filterstateData[i].stateName.toString();
        countrycode = filterstateData[i].countrycode.toString();
        isText1Correct = false;
// FocusScope.of(context).unfocus();
        // log("22222state:::" + statecode.toString());
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
    // log("filterstateData length::" + filterstateData.length.toString());
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
//          
    customerapicLoading = false;
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == itemdata.customerGroup) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }
static List<String> datafromAcc = [];
  static List<String> datafrommodify = [];
  static List<String> datafromquotes = [];
  static List<String> datafromlead = [];
  static List<String> datafromsiteout = [];
  static List<String> datafromfollow = [];
  static List<String> datafromopenlead = [];
  static String iscomfromSiteOutMobile = '';
  checkComeFromEnq(BuildContext context) async {
    // log("ANBUUUU::");
    clearAllData();
    // customerapicLoading = true;
    // notifyListeners();
    //  getdataFromDb();
    // getEnqRefferes();
    // await callLeadCheckApi();
    // await stateApicallfromDB();
    // getCustomerTag();
    if (datafromfollow.length > 0) {
      print("datatatatata: .....");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfromFollowup(context);
      notifyListeners();
    }
    if (datafromAcc.length > 0) {
      print("datatatatata: .....");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfromAccounts(context);
      notifyListeners();
    }
    if (datafromopenlead.length > 0) {
      print("datatatatata: .....");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfromopenlead(context);
      notifyListeners();
    }
    if (dataenq.length > 0) {
       clearAllData();
      print("datatatatata: .....");
      customerapicLoading = true;
      mapValues3();
    }
    notifyListeners();
    if (datafromlead.length > 0) {
      // log("ANBUORDER");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfromlead(context);
      notifyListeners();
    }

    if (datafrommodify.length > 0) {
      // log("ANBUORDER");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfrommodify(context);
      notifyListeners();
    }
    if (datafromquotes.length > 0) {
      // log("ANBUORDER");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfromQuotes(context);
      notifyListeners();
    }

    if (datafromsiteout.length > 0) {
      // log("ANBUORDER");
      clearAllData();
      customerapicLoading = true;
      mapvaluessiteout();
      notifyListeners();
    }

    if (iscomfromSiteOutMobile.isNotEmpty) {}
    getdataFromDb();
    getEnqRefferes();
    await stateApicallfromDB();
    await getLeveofType();
    callLeadCheckApi();
    getCustomerTag();
    
    await callpaymodeApi();
    // getCustomerListFromDB();
    notifyListeners();
  }

  mapvaluessiteout() async {
    getdataFromDb();
    getEnqRefferes();
    await stateApicallfromDB();
    await callLeadCheckApi();
    getCustomerTag();
    await getLeveofType();
    
    await callpaymodeApi();
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
            datafromsiteout[12] == "null" ||datafromsiteout[12] == "0"||
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
String? GetleadItemCode;
  mapvaluesfromopenlead(BuildContext context) async {
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();
    
    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await getCustomerTag();
    await callpaymodeApi();
    // getCustomerListFromDB();
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafromopenlead[9]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
    String? storecode;
    String? deliveryfrom;
    // log("datafromlead" + datafromopenlead[9].toString());
    mycontroller[0].text = datafromopenlead[0];
    mycontroller[16].text = datafromopenlead[1];
    // mycontroller[1].text = datafromlead[1];
    mycontroller[2].text = datafromopenlead[2] == null ||
            datafromopenlead[2] == "null" ||
            datafromopenlead[2].isEmpty
        ? ""
        : datafromopenlead[2];
    mycontroller[3].text = datafromopenlead[3] == null ||
            datafromopenlead[3] == "null" ||
            datafromopenlead[3].isEmpty
        ? ""
        : datafromopenlead[3];
    mycontroller[4].text = datafromopenlead[4] == null ||
            datafromopenlead[4] == "null" ||datafromopenlead[4] == "0"||
            datafromopenlead[4].isEmpty
        ? ""
        : datafromopenlead[4];
    mycontroller[5].text = datafromopenlead[5] == null ||
            datafromopenlead[5] == "null" ||
            datafromopenlead[5].isEmpty
        ? ""
        : datafromopenlead[5];
    // mycontroller[5].text = datafromlead[6];//city
    mycontroller[18].text = datafromopenlead[8] == null ||
            datafromopenlead[8] == "null" ||
            datafromopenlead[8].isEmpty
        ? ""
        : datafromopenlead[8]; //pin
    mycontroller[7].text = datafromopenlead[7] == null ||
            datafromopenlead[7] == "null" ||
            datafromopenlead[7].isEmpty
        ? ""
        : datafromfollow[7]; //sta
    mycontroller[17].text = datafromopenlead[10] == null ||
            datafromopenlead[10] == "null" ||
            datafromopenlead[10].isEmpty
        ? ""
        : datafromopenlead[10];
    enqID = int.parse(datafromopenlead[6]);
    basetype = 2;

    // enqID = int.parse(datafromlead[6]);

    // ItemCode: selectedItemCode,
    //     ItemDescription: selectedItemName,
    //     Quantity: quantity,
    //     LineTotal: total,
    //     Price: unitPrice,

    await GetLeadQTHApi.getData(datafromopenlead[6]).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        for (int ik = 0;
            ik < value.leadDeatilheadsData!.leadDeatilsQTLData!.length;
            ik++) {
               GetleadItemCode =
              value.leadDeatilheadsData!.leadDeatilsQTLData![ik].ItemCode;
              mycontroller[11].text = value
              .leadDeatilheadsData!.leadDeatilsQTLData![ik].Quantity
              .toString();
          mycontroller[10].text = value
              .leadDeatilheadsData!.leadDeatilsQTLData![ik].Price
              .toString();
              // log("selectedItemCode::"+selectedItemCode.toString());
              for (int i=0;i<allProductDetails.length;i++){
                if(allProductDetails[i].itemCode ==GetleadItemCode){
          //          selectedItemCode =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
          // selectedItemName =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
                  selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    taxvalue=double.parse(allProductDetails[i].taxRate.toString());
 sporder= allProductDetails[i].sp == null
        ? 0.0
        : double.parse(allProductDetails[i].sp.toString());
            slppriceorder= allProductDetails[i].slpPrice == null
        ? 0.0
        : double.parse(allProductDetails[i].slpPrice.toString());
            storestockorder= allProductDetails[i].storeStock == null
        ? 0.0
        : double.parse(allProductDetails[i].storeStock.toString());
            whsestockorder=allProductDetails[i].whsStock == null
        ? 0.0
        : double.parse(allProductDetails[i].whsStock.toString()) ;
            isfixedpriceorder= allProductDetails[i].isFixedPrice;
            allownegativestockorder=allProductDetails[i].allowNegativeStock;
            alloworderbelowcostorder= allProductDetails[i].allowOrderBelowCost;
        
         
              // taxvalue=double.parse(value.leadDeatilheadsData!.leadDeatilsQTLData![i]..toString());
          
            //    sp: value
            //   .leadDeatilheadsData!.leadDeatilsQTLData![i],
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
          storecode = ConstantValues.Storecode;
          // value
          // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
          deliveryfrom = "store";
          // value
          // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
          // total=value.leadDeatilsQTHData!.DocTotal!;
          unitPrice = double.parse(mycontroller[10].text);
          quantity = double.parse(mycontroller[11].text);
          total = unitPrice! * quantity!;

          productDetails.add(DocumentLines(
              id: 0,
              docEntry: 0,
              linenum: 0,
              ItemCode: selectedItemCode,
              ItemDescription: selectedItemName,
              Quantity: quantity,
              LineTotal: total,
              Price: unitPrice,
              TaxCode:taxvalue,
              TaxLiable: "tNO",
              storecode: storecode,
              deliveryfrom: deliveryfrom,
               sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            //    sp: sporder,
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
              
              ));
                }

              }
              
        }
        notifyListeners();

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());
        showItemList = false;
        // leadDeatilsQTHData = value.leadDeatilsQTHData;
        // leadDeatilsQTLData = value.leadDeatilsQTHData!.leadDeatilsQTLData!;
        // leadLoadingdialog = false;
        // leadForwarddialog = false;
        // updateFollowUpDialog = false;
        // viewDetailsdialog = true;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      } else {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      }
    });
    customerapicLoading = false;
    datafromopenlead.clear();
    notifyListeners();
  }
mapvaluesfromAccounts(BuildContext context) async {
  // log("datafromAcc[11]::"+datafromAcc[11].toString());
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();
    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await getCustomerTag();
    
    await callpaymodeApi();
    // getCustomerListFromDB();
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafromAcc[8]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
    String? storecode;
    String? deliveryfrom;
    // log("datafromlead" + datafromAcc[9].toString());
    mycontroller[0].text = datafromAcc[0];
    mycontroller[16].text = datafromAcc[1];
    mycontroller[1].text=datafromAcc[9] == null ||
            datafromAcc[9] == "null" ||
            datafromAcc[9].isEmpty
        ? ""
        : datafromAcc[9];
         mycontroller[6].text = datafromAcc[6] == null ||
            datafromAcc[6] == "null" ||
            datafromAcc[6].isEmpty
        ? ""
        : datafromAcc[6]; 
         mycontroller[7].text = datafromAcc[7] == null ||
            datafromAcc[7] == "null" ||
            datafromAcc[7].isEmpty
        ? ""
        : datafromAcc[7]; 
         mycontroller[25].text = datafromAcc[18] == null ||
            datafromAcc[18] == "null" ||
            datafromAcc[18].isEmpty
        ? ""
        : datafromAcc[18]; 
    mycontroller[2].text = datafromAcc[2] == null ||
            datafromAcc[2] == "null" ||
            datafromAcc[2].isEmpty
        ? ""
        : datafromAcc[2];
    mycontroller[3].text = datafromAcc[3] == null ||
            datafromAcc[3] == "null" ||
            datafromAcc[3].isEmpty
        ? ""
        : datafromAcc[3];
        mycontroller[17].text = datafromAcc[10] == null ||
            datafromAcc[10] == "null" ||
            datafromAcc[10].isEmpty
        ? ""
        : datafromAcc[10];
         mycontroller[5].text = datafromAcc[5] == null ||
            datafromAcc[5] == "null" ||
            datafromAcc[5].isEmpty
        ? ""
        : datafromAcc[5];
    mycontroller[4].text = datafromAcc[4] == null ||
            datafromAcc[4] == "null" || datafromAcc[4] == "0"||
            datafromAcc[4].isEmpty
        ? ""
        : datafromAcc[4];
   
    // mycontroller[5].text = datafromlead[6];//city

//     if( datafromAcc[11] != null ||
//              datafromAcc[11] != "null" ||
//              datafromAcc[11].isNotEmpty){
// for(int i=0;i<filterstateData.length ;i++){
//         if(filterstateData[i].statecode == datafromAcc[11]){
// mycontroller[18].text = filterstateData[i].stateName.toString();

        
      //   }

      // }  
      //       }else{
      //      mycontroller[18].text ='';  
      //       }
    mycontroller[18].text = datafromAcc[11] == null ||
            datafromAcc[11] == "null" ||
            datafromAcc[11].isEmpty
        ? ""
        : datafromAcc[11];
        mycontroller[19].text = datafromAcc[12] == null ||
            datafromAcc[12] == "null" ||
            datafromAcc[12].isEmpty
        ? ""
        : datafromAcc[12];
        mycontroller[20].text = datafromAcc[13] == null ||
            datafromAcc[13] == "null" ||
            datafromAcc[13].isEmpty
        ? ""
        : datafromAcc[13];
        mycontroller[21].text = datafromAcc[14] == null ||
            datafromAcc[14] == "null" ||
            datafromAcc[14].isEmpty
        ? ""
        : datafromAcc[14];
        mycontroller[22].text = datafromAcc[15] == null ||
            datafromAcc[15] == "null" ||
            datafromAcc[15].isEmpty
        ? ""
        : datafromAcc[15];
        mycontroller[23].text = datafromAcc[16] == null ||
            datafromAcc[16] == "null" ||
            datafromAcc[16].isEmpty
        ? ""
        : datafromAcc[16];
// if(datafromAcc[17] != null ||
//             datafromAcc[17] != "null" ||
//             datafromAcc[17].isNotEmpty){
// for(int i=0;i<filterstateData.length ;i++){
//         if(filterstateData[i].statecode ==datafromAcc[17]){
mycontroller[24].text = datafromAcc[17] == null ||
            datafromAcc[17] == "null" ||
            datafromAcc[17].isEmpty?"":datafromAcc[17];

        
      //   }

      // }  
      //       }else{
      //       mycontroller[24].text ='';  
      //       }
      
        
         //pin
   //sta
    
    // enqID = int.parse(datafromfollow[6]);
    // basetype = 2;

    // enqID = int.parse(datafromlead[6]);

    // ItemCode: selectedItemCode,
    //     ItemDescription: selectedItemName,
    //     Quantity: quantity,
    //     LineTotal: total,
    //     Price: unitPrice,

    
    customerapicLoading = false;
    datafromAcc.clear();
    notifyListeners();
  }
  mapvaluesfromFollowup(BuildContext context) async {
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();
    
    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await getCustomerTag();
    await callpaymodeApi();
    // getCustomerListFromDB();
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafromfollow[9]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
    String? storecode;
    String? deliveryfrom;
    // log("datafromlead" + datafromfollow[9].toString());
    mycontroller[0].text = datafromfollow[0];
    mycontroller[16].text = datafromfollow[1];
    // mycontroller[1].text = datafromlead[1];
    mycontroller[2].text = datafromfollow[2] == null ||
            datafromfollow[2] == "null" ||
            datafromfollow[2].isEmpty
        ? ""
        : datafromfollow[2];
    mycontroller[3].text = datafromfollow[3] == null ||
            datafromfollow[3] == "null" ||
            datafromfollow[3].isEmpty
        ? ""
        : datafromfollow[3];
    mycontroller[4].text = datafromfollow[4] == null ||
            datafromfollow[4] == "null" || datafromfollow[4] == "0"||
            datafromfollow[4].isEmpty
        ? ""
        : datafromfollow[4];
    mycontroller[5].text = datafromfollow[5] == null ||
            datafromfollow[5] == "null" ||
            datafromfollow[5].isEmpty
        ? ""
        : datafromfollow[5];
    // mycontroller[5].text = datafromlead[6];//city
    mycontroller[18].text = datafromfollow[8] == null ||
            datafromfollow[8] == "null" ||
            datafromfollow[8].isEmpty
        ? ""
        : datafromfollow[8]; //pin
    mycontroller[7].text = datafromfollow[7] == null ||
            datafromfollow[7] == "null" ||
            datafromfollow[7].isEmpty
        ? ""
        : datafromfollow[7]; //sta
    mycontroller[17].text = datafromfollow[10] == null ||
            datafromfollow[10] == "null" ||
            datafromfollow[10].isEmpty
        ? ""
        : datafromfollow[10];
    enqID = int.parse(datafromfollow[6]);
    basetype = 2;

    // enqID = int.parse(datafromlead[6]);

    // ItemCode: selectedItemCode,
    //     ItemDescription: selectedItemName,
    //     Quantity: quantity,
    //     LineTotal: total,
    //     Price: unitPrice,

    await GetLeadQTHApi.getData(datafromfollow[6]).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        for (int ik = 0;
            ik < value.leadDeatilheadsData!.leadDeatilsQTLData!.length;
            ik++) {

              GetleadItemCode =
              value.leadDeatilheadsData!.leadDeatilsQTLData![ik].ItemCode;
              mycontroller[11].text = value
              .leadDeatilheadsData!.leadDeatilsQTLData![ik].Quantity
              .toString();
          mycontroller[10].text = value
              .leadDeatilheadsData!.leadDeatilsQTLData![ik].Price
              .toString();
              // log("selectedItemCode::"+selectedItemCode.toString());
              for (int i=0;i<allProductDetails.length;i++){
                if(allProductDetails[i].itemCode ==GetleadItemCode){
          //          selectedItemCode =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
          // selectedItemName =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
                  selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    taxvalue=double.parse(allProductDetails[i].taxRate.toString());
 sporder= allProductDetails[i].sp == null
        ? 0.0
        : double.parse(allProductDetails[i].sp.toString());
            slppriceorder= allProductDetails[i].slpPrice == null
        ? 0.0
        : double.parse(allProductDetails[i].slpPrice.toString());
            storestockorder= allProductDetails[i].storeStock == null
        ? 0.0
        : double.parse(allProductDetails[i].storeStock.toString());
            whsestockorder=allProductDetails[i].whsStock == null
        ? 0.0
        : double.parse(allProductDetails[i].whsStock.toString()) ;
            isfixedpriceorder= allProductDetails[i].isFixedPrice;
            allownegativestockorder=allProductDetails[i].allowNegativeStock;
            alloworderbelowcostorder= allProductDetails[i].allowOrderBelowCost;
        
         
              // taxvalue=double.parse(value.leadDeatilheadsData!.leadDeatilsQTLData![i]..toString());
          
            //    sp: value
            //   .leadDeatilheadsData!.leadDeatilsQTLData![i],
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
          storecode = ConstantValues.Storecode;
          // value
          // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
          deliveryfrom = "store";
          // value
          // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
          // total=value.leadDeatilsQTHData!.DocTotal!;
          unitPrice = double.parse(mycontroller[10].text);
          quantity = double.parse(mycontroller[11].text);
          total = unitPrice! * quantity!;

          productDetails.add(DocumentLines(
              id: 0,
              docEntry: 0,
              linenum: 0,
              ItemCode: selectedItemCode,
              ItemDescription: selectedItemName,
              Quantity: quantity,
              LineTotal: total,
              Price: unitPrice,
              TaxCode:taxvalue,
              TaxLiable: "tNO",
              storecode: storecode,
              deliveryfrom: deliveryfrom,
               sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            //    sp: sporder,
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
              
              ));
                }

              }
        }
        notifyListeners();

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());
        showItemList = false;
        // leadDeatilsQTHData = value.leadDeatilsQTHData;
        // leadDeatilsQTLData = value.leadDeatilsQTHData!.leadDeatilsQTLData!;
        // leadLoadingdialog = false;
        // leadForwarddialog = false;
        // updateFollowUpDialog = false;
        // viewDetailsdialog = true;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      } else {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      }
    });
    customerapicLoading = false;
    datafromfollow.clear();
  }

  int? ordernum;

  int? ordocentry;

  mapvaluesfrommodify(BuildContext context) async {
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();
    
    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await getCustomerTag();
    await callpaymodeApi();
    value3 == true;
    notifyListeners();
    iscomeforupdate = true;
    notifyListeners();
    // log("iscomeforupdate::::" + iscomeforupdate.toString());
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafrommodify[20]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
    // getCustomerListFromDB();
//  for (int i = 0; i < customerTagTypeData.length; i++) {
//       if (customerTagTypeData[i].Name ==  datafromlead[9]) {

//         isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
//         notifyListeners();
//       }
//       // log("isSelectedCsTag::" + dataenq[2].toString());
//       notifyListeners();
//     }
    // log("datafromlead" + datafromlead[5].toString());
    DocDateold=datafrommodify[22];
    mycontroller[0].text = datafrommodify[1];
    mycontroller[16].text = datafrommodify[2];
    // mycontroller[1].text = datafromlead[1];
    mycontroller[2].text = datafrommodify[6] == null ||
            datafrommodify[6] == "null" ||
            datafrommodify[6].isEmpty
        ? ""
        : datafrommodify[6];
    mycontroller[3].text = datafrommodify[7] == null ||
            datafrommodify[7] == "null" ||
            datafrommodify[7].isEmpty
        ? ""
        : datafrommodify[7];
    mycontroller[4].text = datafrommodify[10] == null ||
            datafrommodify[10] == "null" ||datafrommodify[10] == "0"||
            datafrommodify[10].isEmpty
        ? ""
        : datafrommodify[10];
    mycontroller[5].text = datafrommodify[9] == null ||
            datafrommodify[9] == "null" ||
            datafrommodify[9].isEmpty
        ? ""
        : datafrommodify[9];
    // mycontroller[5].text = datafrommodify[6];//city
    mycontroller[18].text = datafrommodify[11] == null ||
            datafrommodify[11] == "null" ||
            datafrommodify[11].isEmpty
        ? ""
        : datafrommodify[11]; //pin
    mycontroller[7].text = datafrommodify[4] == null ||
            datafrommodify[4] == "null" ||
            datafrommodify[4].isEmpty
        ? ""
        : datafrommodify[4]; //sta
    mycontroller[17].text = datafrommodify[8] == null ||
            datafrommodify[8] == "null" ||
            datafrommodify[8].isEmpty
        ? ""
        : datafrommodify[8];
    mycontroller[1].text = datafrommodify[5] == null ||
            datafrommodify[5] == "null" ||
            datafrommodify[5].isEmpty
        ? ""
        : datafrommodify[5];
    mycontroller[6].text = datafrommodify[3] == null ||
            datafrommodify[3] == "null" ||
            datafrommodify[3].isEmpty
        ? ""
        : datafrommodify[3];
    mycontroller[19].text = datafrommodify[12] == null ||
            datafrommodify[12] == "null" ||
            datafrommodify[12].isEmpty
        ? ""
        : datafrommodify[12];
    mycontroller[20].text = datafrommodify[13] == null ||
            datafrommodify[13] == "null" ||
            datafrommodify[13].isEmpty
        ? ""
        : datafrommodify[13];
    mycontroller[21].text = datafrommodify[14] == null ||
            datafrommodify[14] == "null" ||
            datafrommodify[14].isEmpty
        ? ""
        : datafrommodify[14];
    mycontroller[22].text = datafrommodify[15] == null ||
            datafrommodify[15] == "null" ||
            datafrommodify[15].isEmpty
        ? ""
        : datafrommodify[15];
    mycontroller[23].text = datafrommodify[16] == null ||
            datafrommodify[16] == "null"||datafrommodify[16] == "0" ||
            datafrommodify[16].isEmpty
        ? ""
        : datafrommodify[16];
    mycontroller[24].text = datafrommodify[17] == null ||
            datafrommodify[17] == "null" ||
            datafrommodify[17].isEmpty
        ? ""
        : datafrommodify[17];
    mycontroller[25].text = datafrommodify[19] == null ||
            datafrommodify[19] == "null" ||
            datafrommodify[19].isEmpty
        ? ""
        : datafrommodify[19];
         if(datafrommodify[21] !=null ||datafrommodify[21] != "null"||datafrommodify[21].isNotEmpty) {
for(int i=0;i<ordertypedata.length;i++){
          if(ordertypedata[i].Name==datafrommodify[21]){
valueChosedCusType=ordertypedata[i].Code;
          }
        }
       }
    ordocentry = int.parse(datafrommodify[0]);
    ordernum = int.parse(datafrommodify[18]);
    notifyListeners();
    String? storecode;
    String? deliveryfrom;
    
    await GetOrderQTHApi.getData(datafrommodify[0]).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        for (int ik = 0;
            ik < value.OrderDeatilsheaderData!.OrderDeatilsQTLData!.length;
            ik++) {

 
             
               GetleadItemCode =
              value.OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].ItemCode;
            
              mycontroller[11].text = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].Quantity
              .toString();
          mycontroller[10].text = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].Price
              .toString();
          storecode = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].LocCode
              .toString();
          deliveryfrom = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].deliveryFrom
              .toString();
              // log("selectedItemCode::"+selectedItemCode.toString());
              for (int i=0;i<allProductDetails.length;i++){
                if(allProductDetails[i].itemCode ==GetleadItemCode){
          //          selectedItemCode =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
          // selectedItemName =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
                  selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    taxvalue=double.parse(allProductDetails[i].taxRate.toString());
 sporder= allProductDetails[i].sp == null
        ? 0.0
        : double.parse(allProductDetails[i].sp.toString());
            slppriceorder= allProductDetails[i].slpPrice == null
        ? 0.0
        : double.parse(allProductDetails[i].slpPrice.toString());
            storestockorder= allProductDetails[i].storeStock == null
        ? 0.0
        : double.parse(allProductDetails[i].storeStock.toString());
            whsestockorder=allProductDetails[i].whsStock == null
        ? 0.0
        : double.parse(allProductDetails[i].whsStock.toString()) ;
            isfixedpriceorder= allProductDetails[i].isFixedPrice;
            allownegativestockorder=allProductDetails[i].allowNegativeStock;
            alloworderbelowcostorder= allProductDetails[i].allowOrderBelowCost;
        
         
            
          unitPrice = double.parse(mycontroller[10].text);
          quantity = double.parse(mycontroller[11].text);
          total = unitPrice! * quantity!;

          productDetails.add(DocumentLines(
              id: 0,
              docEntry: 0,
              linenum: 0,
              ItemCode: selectedItemCode,
              ItemDescription: selectedItemName,
              Quantity: quantity,
              LineTotal: total,
              Price: unitPrice,
              TaxCode:taxvalue,
              TaxLiable: "tNO",
              storecode: storecode,
              deliveryfrom: deliveryfrom,
               sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            //    sp: sporder,
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
              
              ));
                }

              }
          //       sporder= value
          //     .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].Info_SP;
          //   slppriceorder= value
          //     .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].Cost;
          //   storestockorder= value
          //     .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].StoreStock;
          //   whsestockorder=value
          //     .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].WhseStock ;
          //   isfixedpriceorder= value
          //     .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].isFixedPrice;
          //   allownegativestockorder=value
          //     .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].AllowNegativestock;
          //   alloworderbelowcostorder= value
          //     .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].AllowOrderBelowCost;
        
         
          // selectedItemName =
          //     value.OrderDeatilsheaderData!.OrderDeatilsQTLData![i].ItemName;
          
          
          
          //       // total=value.leadDeatilsQTHData!.DocTotal!;
          // unitPrice = double.parse(mycontroller[10].text);
          // quantity = double.parse(mycontroller[11].text);
          // total = unitPrice! * quantity!;

          // productDetails.add(DocumentLines(
          //     id: 0,
          //     docEntry: 0,
          //     linenum: 0,
          //     ItemCode: selectedItemCode,
          //     ItemDescription: selectedItemName,
          //     Quantity: quantity,
          //     LineTotal: total,
          //     Price: unitPrice,
          //     TaxCode: 0.0,
          //     TaxLiable: "tNO",
          //     storecode: storecode,
          //     deliveryfrom: deliveryfrom,
          //     sp: sporder,
          //   slpprice: slppriceorder,
          //   storestock: storestockorder,
          //   whsestock:whsestockorder ,
          //   isfixedprice: isfixedpriceorder,
          //   allownegativestock:allownegativestockorder ,
          //   alloworderbelowcost: alloworderbelowcostorder,
          //     ));
        }
        notifyListeners();

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());
        showItemList = false;

        // leadDeatilsQTHData = value.leadDeatilsQTHData;
        // leadDeatilsQTLData = value.leadDeatilsQTHData!.leadDeatilsQTLData!;
        // leadLoadingdialog = false;
        // leadForwarddialog = false;
        // updateFollowUpDialog = false;
        // viewDetailsdialog = true;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      } else {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      }
    });
    customerapicLoading = false;
    datafrommodify.clear();
    // productDetails.clear();
    notifyListeners();
  }

  mapvaluesfromQuotes(BuildContext context) async {
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();
    
    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await getCustomerTag();
    await callpaymodeApi();
    // getCustomerListFromDB();
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafromquotes[20]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
    // log("datafromleadsss" + datafromquotes[21].toString());
    mycontroller[0].text = datafromquotes[1];
    mycontroller[16].text = datafromquotes[2];
    // mycontroller[1].text = datafromlead[1];
    mycontroller[2].text = datafromquotes[6] == null ||
            datafromquotes[6] == "null" ||
            datafromquotes[6].isEmpty
        ? ""
        : datafromquotes[6];
    mycontroller[3].text = datafromquotes[7] == null ||
            datafromquotes[7] == "null" ||
            datafromquotes[7].isEmpty
        ? ""
        : datafromquotes[7];
    mycontroller[4].text = datafromquotes[10] == null ||
            datafromquotes[10] == "null" ||datafromquotes[10] == "0"||
            datafromquotes[10].isEmpty
        ? ""
        : datafromquotes[10];
    mycontroller[5].text = datafromquotes[9] == null ||
            datafromquotes[9] == "null" ||
            datafromquotes[9].isEmpty
        ? ""
        : datafromquotes[9];
    // mycontroller[5].text = datafromquotes[6];//city
    mycontroller[18].text = datafromquotes[11] == null ||
            datafromquotes[11] == "null" ||
            datafromquotes[11].isEmpty
        ? ""
        : datafromquotes[11]; //pin
    mycontroller[7].text = datafromquotes[4] == null ||
            datafromquotes[4] == "null" ||
            datafromquotes[4].isEmpty
        ? ""
        : datafromquotes[4]; //sta
    mycontroller[17].text = datafromquotes[8] == null ||
            datafromquotes[8] == "null" ||
            datafromquotes[8].isEmpty
        ? ""
        : datafromquotes[8];
    mycontroller[1].text = datafromquotes[5] == null ||
            datafromquotes[5] == "null" ||
            datafromquotes[5].isEmpty
        ? ""
        : datafromquotes[5];
    mycontroller[6].text = datafromquotes[3] == null ||
            datafromquotes[3] == "null" ||
            datafromquotes[3].isEmpty
        ? ""
        : datafromquotes[3];
    mycontroller[19].text = datafromquotes[12] == null ||
            datafromquotes[12] == "null" ||
            datafromquotes[12].isEmpty
        ? ""
        : datafromquotes[12];
    mycontroller[20].text = datafromquotes[13] == null ||
            datafromquotes[13] == "null" ||
            datafromquotes[13].isEmpty
        ? ""
        : datafromquotes[13];
    mycontroller[21].text = datafromquotes[14] == null ||
            datafromquotes[14] == "null" ||
            datafromquotes[14].isEmpty
        ? ""
        : datafromquotes[14];
    mycontroller[22].text = datafromquotes[15] == null ||
            datafromquotes[15] == "null" ||
            datafromquotes[15].isEmpty
        ? ""
        : datafromquotes[15];
    mycontroller[23].text = datafromquotes[16] == null ||
            datafromquotes[16] == "null"||datafromquotes[16] == "0" ||
            datafromquotes[16].isEmpty
        ? ""
        : datafromquotes[16];
    mycontroller[24].text = datafromquotes[17] == null ||
            datafromquotes[17] == "null" ||
            datafromquotes[17].isEmpty
        ? ""
        : datafromquotes[17];
        mycontroller[25].text=datafromquotes[19] == null ||
            datafromquotes[19] == "null" ||
            datafromquotes[19].isEmpty
        ? ""
        : datafromquotes[19];
          if(datafromquotes[21] !=null ||datafromquotes[21] != "null"||datafromquotes[21].isNotEmpty) {
for(int i=0;i<ordertypedata.length;i++){
          if(ordertypedata[i].Name==datafromquotes[21]){
valueChosedCusType=ordertypedata[i].Code;
          }
        }
       }
    enqID = int.parse(datafromquotes[0]);
    basetype = 3;
    // log("datafromlead[6]::" + datafromlead[6].toString());

    String? storecode;
    String? deliveryfrom;
    await GetQuotesQTHApi.getData(datafromquotes[0]).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        for (int ik = 0;
            ik < value.QuotesDeatilsheaderData!.OrderDeatilsQTLData!.length;
            ik++) {
  
 GetleadItemCode =
            value.QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].ItemCode;
            
              mycontroller[11].text = value
              .QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].Quantity
              .toString();
          mycontroller[10].text = value
              .QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].Price
              .toString();
           storecode = ConstantValues.Storecode;
          // value
          // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
          deliveryfrom = "store";
              // log("selectedItemCode::"+selectedItemCode.toString());
              for (int i=0;i<allProductDetails.length;i++){
                if(allProductDetails[i].itemCode ==GetleadItemCode){
          //          selectedItemCode =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
          // selectedItemName =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
                  selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    taxvalue=double.parse(allProductDetails[i].taxRate.toString());
 sporder= allProductDetails[i].sp == null
        ? 0.0
        : double.parse(allProductDetails[i].sp.toString());
            slppriceorder= allProductDetails[i].slpPrice == null
        ? 0.0
        : double.parse(allProductDetails[i].slpPrice.toString());
            storestockorder= allProductDetails[i].storeStock == null
        ? 0.0
        : double.parse(allProductDetails[i].storeStock.toString());
            whsestockorder=allProductDetails[i].whsStock == null
        ? 0.0
        : double.parse(allProductDetails[i].whsStock.toString()) ;
            isfixedpriceorder= allProductDetails[i].isFixedPrice;
            allownegativestockorder=allProductDetails[i].allowNegativeStock;
            alloworderbelowcostorder= allProductDetails[i].allowOrderBelowCost;
        
         
            
          unitPrice = double.parse(mycontroller[10].text);
          quantity = double.parse(mycontroller[11].text);
          total = unitPrice! * quantity!;

          productDetails.add(DocumentLines(
              id: 0,
              docEntry: 0,
              linenum: 0,
              ItemCode: selectedItemCode,
              ItemDescription: selectedItemName,
              Quantity: quantity,
              LineTotal: total,
              Price: unitPrice,
              TaxCode:taxvalue,
              TaxLiable: "tNO",
              storecode: storecode,
              deliveryfrom: deliveryfrom,
               sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            //    sp: sporder,
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
              
              ));
                }

              }

          //      sporder= value
          //     .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].Info_SP;
          //   slppriceorder= value
          //     .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].Cost;
          //   storestockorder= value
          //     .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].StoreStock;
          //   whsestockorder=value
          //     .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].WhseStock ;
          //   isfixedpriceorder= value
          //     .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].isFixedPrice;
          //   allownegativestockorder=value
          //     .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].AllowNegativestock;
          //   alloworderbelowcostorder= value
          //     .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].AllowOrderBelowCost;
        


        
         
          // // value
          // // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
          // // total=value.leadDeatilsQTHData!.DocTotal!;
          // notifyListeners();
          // unitPrice = double.parse(mycontroller[10].text);
          // quantity = double.parse(mycontroller[11].text);
          // total = unitPrice! * quantity!;
          // productDetails.add(DocumentLines(
          //     id: 0,
          //     docEntry: 0,
          //     linenum: 0,
          //     ItemCode: selectedItemCode,
          //     ItemDescription: selectedItemName,
          //     Quantity: quantity,
          //     LineTotal: total,
          //     Price: unitPrice,
          //     TaxCode: 0.0,
          //     TaxLiable: "tNO",
          //     storecode: storecode,
          //     deliveryfrom: deliveryfrom,
          //       sp: sporder,
          //   slpprice: slppriceorder,
          //   storestock: storestockorder,
          //   whsestock:whsestockorder ,
          //   isfixedprice: isfixedpriceorder,
          //   allownegativestock:allownegativestockorder ,
          //   alloworderbelowcost: alloworderbelowcostorder,
              
          //     ));
        }

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());
        showItemList = false;
        
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      } else {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      }
    });
    customerapicLoading = false;
    datafromquotes.clear();
    // productDetails.clear();
    notifyListeners();
  }

  mapvaluesfromlead(BuildContext context) async {
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();
    
    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await getCustomerTag();
    await callpaymodeApi();
    // getCustomerListFromDB();
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafromlead[9]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
    // log("datafromlead" + datafromlead[5].toString());
    mycontroller[0].text = datafromlead[0];
    mycontroller[16].text = datafromlead[1];
    // mycontroller[1].text = datafromlead[1];
    mycontroller[2].text = datafromlead[2] == null ||
            datafromlead[2] == "null" ||
            datafromlead[2].isEmpty
        ? ""
        : datafromlead[2];
    mycontroller[3].text = datafromlead[3] == null ||
            datafromlead[3] == "null" ||
            datafromlead[3].isEmpty
        ? ""
        : datafromlead[3];
    mycontroller[4].text = datafromlead[4] == null ||
            datafromlead[4] == "null" ||datafromlead[4] == "0"||
            datafromlead[4].isEmpty
        ? ""
        : datafromlead[4];
    mycontroller[5].text = datafromlead[5] == null ||
            datafromlead[5] == "null" ||
            datafromlead[5].isEmpty
        ? ""
        : datafromlead[5];
    // mycontroller[5].text = datafromlead[6];//city
    mycontroller[18].text = datafromlead[8] == null ||
            datafromlead[8] == "null" ||
            datafromlead[8].isEmpty
        ? ""
        : datafromlead[8]; //pin
    mycontroller[7].text = datafromlead[7] == null ||
            datafromlead[7] == "null" ||
            datafromlead[7].isEmpty
        ? ""
        : datafromlead[7]; //sta
    mycontroller[17].text = datafromlead[10] == null ||
            datafromlead[10] == "null" ||
            datafromlead[10].isEmpty
        ? ""
        : datafromlead[10];
        // log("datafromlead[11] !=null::"+datafromlead[11].toString());
        if(datafromlead[11] !=null ||datafromlead[11] != "null"||datafromlead[11].isNotEmpty) {
for(int i=0;i<ordertypedata.length;i++){
          if(ordertypedata[i].Name==datafromlead[11]){
valueChosedCusType=ordertypedata[i].Code;
          }
        }
       }
    enqID = int.parse(datafromlead[6]);
    basetype = 2;
    // log("datafromlead[6]::" + datafromlead[6].toString());

    String? storecode;
    String? deliveryfrom;
    await GetLeadQTHApi.getData(datafromlead[6]).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        for (int ik = 0;
            ik < value.leadDeatilheadsData!.leadDeatilsQTLData!.length;
            ik++) {
               GetleadItemCode =
              value.leadDeatilheadsData!.leadDeatilsQTLData![ik].ItemCode;
              mycontroller[11].text = value
              .leadDeatilheadsData!.leadDeatilsQTLData![ik].Quantity
              .toString();
          mycontroller[10].text = value
              .leadDeatilheadsData!.leadDeatilsQTLData![ik].Price
              .toString();
              // log("selectedItemCode::"+GetleadItemCode.toString());
              for (int i=0;i<allProductDetails.length;i++){
                if(allProductDetails[i].itemCode ==GetleadItemCode){
          //          selectedItemCode =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
          // selectedItemName =
          //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
                  selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    taxvalue=double.parse(allProductDetails[i].taxRate.toString());
 sporder= allProductDetails[i].sp == null
        ? 0.0
        : double.parse(allProductDetails[i].sp.toString());
            slppriceorder= allProductDetails[i].slpPrice == null
        ? 0.0
        : double.parse(allProductDetails[i].slpPrice.toString());
            storestockorder= allProductDetails[i].storeStock == null
        ? 0.0
        : double.parse(allProductDetails[i].storeStock.toString());
            whsestockorder=allProductDetails[i].whsStock == null
        ? 0.0
        : double.parse(allProductDetails[i].whsStock.toString()) ;
            isfixedpriceorder= allProductDetails[i].isFixedPrice;
            allownegativestockorder=allProductDetails[i].allowNegativeStock;
            alloworderbelowcostorder= allProductDetails[i].allowOrderBelowCost;
        
         
              // taxvalue=double.parse(value.leadDeatilheadsData!.leadDeatilsQTLData![i]..toString());
          
            //    sp: value
            //   .leadDeatilheadsData!.leadDeatilsQTLData![i],
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
          storecode = ConstantValues.Storecode;
          // value
          // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
          deliveryfrom = "store";
          // value
          // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
          // total=value.leadDeatilsQTHData!.DocTotal!;
          unitPrice = double.parse(mycontroller[10].text);
          quantity = double.parse(mycontroller[11].text);
          total = unitPrice! * quantity!;

          productDetails.add(DocumentLines(
              id: 0,
              docEntry: 0,
              linenum: 0,
              ItemCode: selectedItemCode,
              ItemDescription: selectedItemName,
              Quantity: quantity,
              LineTotal: total,
              Price: unitPrice,
              TaxCode:taxvalue,
              TaxLiable: "tNO",
              storecode: storecode,
              deliveryfrom: deliveryfrom,
               sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            //    sp: sporder,
            // slpprice: slppriceorder,
            // storestock: storestockorder,
            // whsestock:whsestockorder ,
            // isfixedprice: isfixedpriceorder,
            // allownegativestock:allownegativestockorder ,
            // alloworderbelowcost: alloworderbelowcostorder,
              
              ));
                }

              }
        }

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());
        showItemList = false;
        // for (int i = 0;
        //     i < value.OrderDeatilsheaderData!.leadDeatilsQTLData!.length;
        //     i++) {
        //   selectedItemCode =
        //       value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
        //   selectedItemName =
        //       value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
        //   mycontroller[11].text = value
        //       .leadDeatilheadsData!.leadDeatilsQTLData![i].Quantity
        //       .toString();
        //   mycontroller[10].text = value
        //       .leadDeatilheadsData!.leadDeatilsQTLData![i].Price
        //       .toString();
        //        storecode= value
        //       .leadDeatilheadsData!.leadDeatilsQTLData![i].LocCode
        //       .toString();
        //       deliveryfrom=value
        //       .leadDeatilheadsData!.leadDeatilsQTLData![i].deliveryFrom
        //       .toString();

        // total=value.leadDeatilsQTHData!.DocTotal!;
        // }

        // leadDeatilsQTHData = value.leadDeatilsQTHData;
        // leadDeatilsQTLData = value.leadDeatilsQTHData!.leadDeatilsQTLData!;
        // leadLoadingdialog = false;
        // leadForwarddialog = false;
        // updateFollowUpDialog = false;
        // viewDetailsdialog = true;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      } else {
        // forwardSuccessMsg = 'Something wemt wrong..!!';
        // leadLoadingdialog = false;
        notifyListeners();
      }
    });
    customerapicLoading = false;
    datafromlead.clear();
    // productDetails.clear();
    notifyListeners();
  }

  mapValues3() async {
    getdataFromDb();
    getEnqRefferes();
    
    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    getCustomerTag();
    await callpaymodeApi();
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == dataenq[10]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[6].toString());
      notifyListeners();
    }
    // log("ANBY::"+dataenq[7].toString());
    mycontroller[0].text =
        dataenq[0] == null || dataenq[0] == 'null' || dataenq[0].isEmpty
            ? ''
            : dataenq[0];
    mycontroller[16].text =
        dataenq[1] == null || dataenq[1] == 'null' || dataenq[1].isEmpty
            ? ''
            : dataenq[1];
    mycontroller[2].text =
        dataenq[2] == null || dataenq[2] == 'null' || dataenq[2].isEmpty
            ? ''
            : dataenq[2];
    mycontroller[3].text =
        dataenq[3] == null || dataenq[3] == 'null' || dataenq[3].isEmpty
            ? ''
            : dataenq[3];
    mycontroller[4].text =
        dataenq[4] == null || dataenq[4] == 'null' ||dataenq[4] == '0'|| dataenq[4].isEmpty
            ? ''
            : dataenq[4];
    mycontroller[5].text =
        dataenq[5] == null || dataenq[5] == 'null' || dataenq[5].isEmpty
            ? ''
            : dataenq[5];
    mycontroller[7].text =
        dataenq[7] == null || dataenq[7] == 'null' || dataenq[7].isEmpty
            ? ''
            : dataenq[7];
    mycontroller[18].text =
        dataenq[9] == null || dataenq[9] == 'null' || dataenq[9].isEmpty
            ? ''
            : dataenq[9];
    mycontroller[6].text =
        dataenq[11] == null || dataenq[11] == 'null' || dataenq[11].isEmpty
            ? ''
            : dataenq[11];
    mycontroller[1].text =
        dataenq[12] == null || dataenq[12] == 'null' || dataenq[12].isEmpty
            ? ''
            : dataenq[12];
    mycontroller[17].text =
        dataenq[13] == null || dataenq[13] == 'null' || dataenq[13].isEmpty
            ? ''
            : dataenq[13];
 if(dataenq[14] !=null ||dataenq[14] != "null"||dataenq[14].isNotEmpty) {
for(int i=0;i<ordertypedata.length;i++){
          if(ordertypedata[i].Name==dataenq[14]){
valueChosedCusType=ordertypedata[i].Code;
          }
        }
       }
    enqID = int.parse(dataenq[6]);
    basetype = 1;

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

  int? reyear;
  int? remonth;
  int? reday;
  int? rehours;
  int? reminutes;
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
String? valueChosedStatus;
String? valueChosedCusType;
String? valueChosedrefcode;
choosedType(String? val){
  valueChosedCusType=val;
  notifyListeners();

}

choosedrefer(String? val){
  valueChosedrefcode=val;
  notifyListeners();

}
choosedStatus(String? val){
  valueChosedStatus=val;
notifyListeners();
}
  clearAllData() {
    log("step1");
    mycontroller[36].clear();
    getcoupondata.clear();
    couponload=false;
    isappliedcoupon=false;
    paymentTerm=false;
     assignvalue = null;
    iscomplement=false;
    selectedassignto.clear();
     leveofdata.clear();
     enquirydetails.clear();
     leaddetails.clear();
     orderdetails.clear();
    ordertypedata.clear();
    valueChosedStatus=null;
    valueChosedCusType=null;
    valueChosedCusType=null;
    mycontroller[27].clear();
    mycontroller[28].clear();
    mycontroller[29].clear();
    mycontroller[30].clear();
 customermodeldata=null;
DocDateold='';
    paymode.clear();
    reyear = null;
    reminderOn = false;
    remonth = null;
    reday = null;
    rehours = null;
    reminutes = null;
    isTextFieldEnabled = true;
    iscomeforupdate = false;
     statecode = '';
     countrycode = '';
     statename = '';
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

    files.clear();
    filedata.clear();
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
    productDetails.clear();
    exceptionOnApiCall = '';
    pageChanged = 0;
    showItemList = true;
    isSelectedCusTag = '';
    // isComeFromEnq = false;s
    isloadingBtn = false;
    // autoIsselectTag = false;
    enqID = null;
    basetype = null;
    // log("step2");

    resetListSelection();
    // log("step3");

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
  List<OrderCheckData> leadcheckdatas = [];
  List<OrderCheckData> get getleadcheckdatas => leadcheckdatas;
  String LeadCheckDataExcep = '';
  String get getLeadCheckDataExcep => LeadCheckDataExcep;

  callLeadCheckApi() {
    GetOrderCheckListApi.getData('${ConstantValues.slpcode}').then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.Ordercheckdata != null) {
          leadcheckdatas = value.Ordercheckdata!;
          // log("ininin");
//           for(int i=0;i<=value.leadcheckdata!.length;i++){
// leadcheckdatas[0].linenum=  int.parse(value.leadcheckdata![i].toString());
// log("linenummmm:"+leadcheckdatas[0].linenum.toString());
// log("linenummmm:"+value.leadcheckdata![i].toString());

//           }
        } else if (value.Ordercheckdata == null) {
          LeadCheckDataExcep = 'Lead check data not found..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      } else if (value.stcode == 500) {
        LeadCheckDataExcep =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
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
  bool iscomeforupdate = false;
String? DocDateold='';
//save all values tp server

  saveToServer(BuildContext context) async {
    await callcustomerapi();
    log("Step----------1");
    // await GetCutomerDetailsApi.getData(
    //         mycontroller[0].text, "${ConstantValues.slpcode}")
    //     .then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     // log("Old customer Data::"+oldcutomer.toString());
    //     if (value.itemdata != null) {
    //       log("Old customer Data::true");
    //       //  itemdata = value.itemdata!;
    //       // mapValues(value.itemdata!);
    //       oldcutomer = true;
    //       notifyListeners();
    //     } else if (value.itemdata == null) {
    //       log("Old customer Data::false");

    //       oldcutomer = false;
    //       customerapicLoading = false;
    //       notifyListeners();
    //     }
    //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
    //     customerapicLoading = false;
    //     exceptionOnApiCall = 'Some thing went wrong..!!';
    //     print("Eeeeeeeeeeee");
    //     notifyListeners();
    //   } else if (value.stcode == 500) {
    //     customerapicLoading = false;
    //     exceptionOnApiCall = 'Some thing went wrong..!!';
    //     print("Eeeeeeeeeeee");
    //     notifyListeners();
    //   }
    //   //  print("olddd cusss : "+oldcutomer.toString());
    // });
    // await callApi()
    // log("Step----------2");

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
   patch. couponcode=mycontroller[36].text ==null || mycontroller[36].text.isEmpty?
   null:mycontroller[36].text;
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
    postLead.doctotal =double.parse (getTotalOrderAmount().toString().replaceAll(",", ""));
    // postLead.DocType = "dDocument_Items"; //
    postLead.CardCode = mycontroller[0].text; //
    postLead.CardName = mycontroller[16].text; //
    postLead.DocDate = config.currentDate(); //
    postLead.deliveryDate = apiFDate;
    postLead.paymentDate = apiNdate;
    postLead.DocDateold=DocDateold!.isEmpty?config.currentDate():DocDateold;
    patch.enqid = enqID == null ? 0 : enqID;
    patch.enqtype = basetype == null ? -1 : basetype;
    List<DocumentLines> productDetails2 = [];
    for (int i = 0; i < productDetails.length; i++) {
      productDetails[i].linenum = i + 1;
      notifyListeners();
    }
    productDetails2 = productDetails;
    // postLead.U_sk_planofpurchase = apiNdate;
    postLead.docLine = productDetails2;
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
      if (isComeFromEnq == true) {
        oldcutomer = true;
      }
      // log("Start Post" + oldcutomer.toString());
      if (oldcutomer == true) {
        isloadingBtn = true;
        notifyListeners();
        callLeadSavePostApi(context, postLead, patch);
      } else if (oldcutomer == false) {
        isloadingBtn = true;
        notifyListeners();
        callLeadSavePostApi(context, postLead, patch);
      }
    }
  }

DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.ordertab);
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
    
            child: Text("This User is assigned to multiple stores. Creating new order is not possible",
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
                 Get.offAllNamed(ConstantRoutes.ordertab);
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


  //call save lead api
  late OrderSavePostModal successRes;
  OrderSavePostModal get getsuccessRes => successRes;

  callupdateApi(
      BuildContext context, PostOrder postLead, PatchExCus? patch) async {
    List<String> filename = [];
    List<String>? fileError = [];

    if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          // log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              // log("message");
              postLead.attachmenturl1 = value;
            } else if (i == 1) {
              // log("message");
              postLead.attachmenturl2 = value;
            } else if (i == 2) {
              postLead.attachmenturl3 = value;
            } else if (i == 3) {
              postLead.attachmenturl4 = value;
            } else if (i == 4) {
              postLead.attachmenturl5 = value;
            }
          }
        });
      }
    }
    // log("filename:::${filename.length}");

    // postLead.attachmenturl1 = filename.isEmpty == null
    //     ? ""
    //     : filename[0].toString().isEmpty
    //         ? ""
    //         : filename[0].toString();
    // postLead.attachmenturl2 = filename.isEmpty
    //     ? ""
    //     : filename[1].toString().isEmpty
    //         ? ""
    //         : filename[1].toString();
    // postLead.attachmenturl3 = filename.isEmpty
    //     ? ""
    //     : filename[2].toString().isEmpty
    //         ? ""
    //         : filename[2].toString();
    // postLead.attachmenturl4 = filename.isEmpty
    //     ? ""
    //     : filename[3].toString().isEmpty
    //         ? ""
    //         : filename[3].toString();
    // postLead.attachmenturl5 = filename.isEmpty
    //     ? ""
    //     : filename[4].toString().isEmpty
    //         ? ""
    //         : filename[4].toString();
    String errorFiles = "";
    if (fileError != null) {
      for (int i = 0; i < fileError.length; i++) {
        errorFiles += errorFiles + "/";
      }
    }
    notifyListeners();

    await OrderupdateApi.getData(ConstantValues.sapUserType, postLead, patch!)
        .then((value) {
      // log("ANBUUU stcode " + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        successRes = value;
        OrderSuccessPageState.getsuccessRes = value;
        for(int i=0;i<paymode.length;i++){
        if(paymode[i].CODE ==value.orderSavePostheader!.orderMasterdata![0].PaymentTerms){
OrderSuccessPageState.paymode = paymode[i].description.toString();
        }

       } 
        Get.toNamed(ConstantRoutes.successorder);
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
      addgoogle(title);
      notifyListeners();
    }
    notifyListeners();
  }

  addgoogle(String? title) {
    Config config2 = Config();
    String newdate = config2.currentTmeonly();
    // log("newdate::" + newdate.toString());
    rehours = int.parse(newdate.split(':')[0]);
    reminutes = int.parse(newdate.split(':')[1]);
    tz.TZDateTime? tzChosenDate;
    final DateTime chosenDate =
        DateTime(reyear!, remonth!, reday!, rehours!, reminutes!);
    final tz.Location indian = tz.getLocation('Asia/Kolkata');
    tzChosenDate = tz.TZDateTime.from(chosenDate, indian);
    config2.addEventToCalendar(tzChosenDate!, "$title", "Order");
  }

  callLeadSavePostApi(
      BuildContext context, PostOrder postLead, PatchExCus? patch) async {
    List<String> filename = [];
    List<String>? fileError = [];
    // log("savetoserver2222::" + filedata.length.toString());

    if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
        // log("savetoserverNames::" + filedata[i].fileName.toString());
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          // log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              // log("message");
              postLead.attachmenturl1 = value;
            } else if (i == 1) {
              // log("message");
              postLead.attachmenturl2 = value;
            } else if (i == 2) {
              postLead.attachmenturl3 = value;
            } else if (i == 3) {
              postLead.attachmenturl4 = value;
            } else if (i == 4) {
              postLead.attachmenturl5 = value;
            }
          }
        });
      }
    }
    // log("filename:::${filename.length}");

    // postLead.attachmenturl1 = filename.isEmpty == null
    //     ? ""
    //     : filename[0].toString().isEmpty
    //         ? ""
    //         : filename[0].toString();
    // postLead.attachmenturl2 = filename.isEmpty
    //     ? ""
    //     : filename[1].toString().isEmpty
    //         ? ""
    //         : filename[1].toString();
    // postLead.attachmenturl3 = filename.isEmpty
    //     ? ""
    //     : filename[2].toString().isEmpty
    //         ? ""
    //         : filename[2].toString();
    // postLead.attachmenturl4 = filename.isEmpty
    //     ? ""
    //     : filename[3].toString().isEmpty
    //         ? ""
    //         : filename[3].toString();
    // postLead.attachmenturl5 = filename.isEmpty
    //     ? ""
    //     : filename[4].toString().isEmpty
    //         ? ""
    //         : filename[4].toString();
    String errorFiles = "";
    if (fileError != null) {
      for (int i = 0; i < fileError.length; i++) {
        errorFiles += errorFiles + "/";
      }
    }
    notifyListeners();

    await OrderSavePostApi.getData(ConstantValues.sapUserType, postLead, patch!)
        .then((value) {
      // log("ANBUUU stcode " + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        successRes = value;
        OrderSuccessPageState.getsuccessRes = value;
       for(int i=0;i<paymode.length;i++){
        if(paymode[i].CODE ==value.orderSavePostheader!.orderMasterdata![0].PaymentTerms){
OrderSuccessPageState.paymode = paymode[i].description.toString();
        }

       } 
        
        Get.toNamed(ConstantRoutes.successorder);

        // log("docno : " + successRes.DocNo.toString());
        notifyListeners();
        // callCheckListApi(context, value.DocEntry!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
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

  bool isloadingBtn = false;
  bool get getisloadingBtn => isloadingBtn;
  callNewCus(
      BuildContext context, PatchExCus? patch, PostOrder? postLead2) async {
    await OrderNewCustCretApi.getData(
            ConstantValues.sapUserType, patch!, postLead2!)
        .then((value) {
      // log("Old customer " + value.stcode!.toString());
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        callLeadSavePostApi(context, postLead2, patch);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, value.exception!);
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

  fortest() {
    for (int i = 0; i <= leadcheckdatas.length; i++) {
      leadcheckdatas[i].linenum = i + 1;
      // log("linenummmm:" + leadcheckdatas[i].linenum.toString());
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
      // log("linenummmm:" + leadcheckdatas[i].linenum.toString());
// log("linenummmm:"+value.leadcheckdata![i].toString());
    }
    OrderCheckPostApi.getData(
            ConstantValues.sapUserType, leadcheckdatas, docEntry, docnum1)
        .then((value) {
      if (value >= 200 && value <= 210) {
        OrderFollowupApiData leadFollowupApiData = new OrderFollowupApiData();
        leadFollowupApiData.date = date;
        leadFollowupApiData.nextFollowUp = apiFDate;
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
          "${value}..!!Network Issue..\nTry again Later..!!",
        );
        //config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
      }
    });
  }

  bool remswitch = true;
  switchremainder(bool val) {
    remswitch = val;
    notifyListeners();
  }

  // Followup Lead

  callFollowupLead(
    BuildContext context,
    OrderFollowupApiData leadFollowupApiData,
    int docEntry,
  ) {
    //fs
    OrderFollowupApi.getData(
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
          "Some thing wrong..!!",
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

  stateontap2(int i) {
    // log("AAAA::" + i.toString());
    statebool2 = false;
    mycontroller[24].text = filterstateData[i].stateName.toString();
    statecode2 = filterstateData[i].statecode.toString();
    statename2 = filterstateData[i].stateName.toString();
    countrycode2 = filterstateData[i].countrycode.toString();
    // log("statecode::" + statecode2.toString());
    // log("statecode::" + countrycode2.toString());
    notifyListeners();
  }

  stateontap(int i) {
    // log("AAAA::" + i.toString());
    statebool = false;
    mycontroller[18].text = filterstateData[i].stateName.toString();
    statecode = filterstateData[i].statecode.toString();
    statename = filterstateData[i].stateName.toString();
    countrycode = filterstateData[i].countrycode.toString();
    // log("statecode::" + statecode.toString());
    // log("statecode::" + countrycode.toString());
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
        showtoastcustomergroup();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Enter Customer Group..!!'),
        //     backgroundColor: Colors.red,
        //     elevation: 10,
        //     behavior: SnackBarBehavior.floating,
        //     margin: EdgeInsets.all(5),
        //     dismissDirection: DismissDirection.up,
        //   ),
        // ); 
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
bool paymentTerm=false;
  thirPageBtnClicked(BuildContext context) {
    int passed = 0;
    if (formkey[1].currentState!.validate()) {
    
    if(isSelectedpaymentTermsCode ==null ||isSelectedpaymentTermsCode.isEmpty){
paymentTerm=true;
      notifyListeners();
    }else{
      paymentTerm=false;
      notifyListeners();
       if (passed == 0) {
        // LeadSavePostApi.printData(postLead);
        saveToServer(context);
      }
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

   showBottomSheetInsert2forEdit(BuildContext context, int i) {
    final theme = Theme.of(context);
    selectedItemName = productDetails[i].ItemDescription.toString();
    selectedItemCode = productDetails[i].ItemCode.toString();
    mycontroller[27].text = productDetails[i].sp == null
        ? "0"
        : productDetails[i].sp.toString();
    mycontroller[28].text = productDetails[i].slpprice == null
        ? "0"
        : productDetails[i].slpprice.toString();
    mycontroller[29].text = productDetails[i].storestock == null
        ? "0"
        : productDetails[i].storestock.toString();
    mycontroller[30].text = productDetails[i].whsestock == null
        ? "0"
        : productDetails[i].whsestock.toString();

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
                        child: Text(productDetails[i].ItemCode.toString(),
                            style: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor)),
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text(productDetails[i].ItemDescription.toString(),
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
                              "${productDetails[i].isfixedprice}",
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
                              "${productDetails[i].alloworderbelowcost}",
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
                              "${productDetails[i].allownegativestock}",
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

  showBottomSheetInsert(
    BuildContext context,
    int i,
  ) {
    final theme = Theme.of(context);
    selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    taxvalue=double.parse(allProductDetails[i].taxRate.toString());
    log("taxvalue::"+taxvalue.toString());
    sporder=allProductDetails[i].sp == null
        ? 0.0
        : double.parse(allProductDetails[i].sp.toString());
    slppriceorder=allProductDetails[i].slpPrice == null
        ? 0.0
        : double.parse(allProductDetails[i].slpPrice.toString());
    storestockorder=allProductDetails[i].storeStock == null
        ? 0.0
        : double.parse(allProductDetails[i].storeStock.toString());
    whsestockorder=allProductDetails[i].whsStock == null
        ? 0.0
        : double.parse(allProductDetails[i].whsStock.toString());
    isfixedpriceorder=allProductDetails[i].isFixedPrice;
    allownegativestockorder=allProductDetails[i].allowNegativeStock;
    alloworderbelowcostorder=allProductDetails[i].allowOrderBelowCost;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, st) {
        return  couponload ==true?
        Container(
          height:Screens.padingHeight(context)*0.3,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ):
        
        
         Container(
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
                                width: Screens.width(context) * 0.8,
                                //  color: Colors.amber,
                                child: Text(
                                    allProductDetails[i].itemCode.toString(),
                                    style: theme.textTheme.bodyText1
                                        ?.copyWith(color: theme.primaryColor)),
                              ),
                              Container(
                                width: Screens.width(context) * 0.8,
                                // color: Colors.red,
                                child: Text(
                                    allProductDetails[i].itemName.toString(),
                                    style: theme.textTheme.bodyText1
                                        ?.copyWith() //color: theme.primaryColor
                                    ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              mycontroller[27].clear();
                              mycontroller[28].clear();
                              mycontroller[29].clear();
                              mycontroller[30].clear();

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
                                  quantity =
                                      double.parse(mycontroller[11].text);
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
                          readOnly:
                       isappliedcoupon ==true?true:  
                        allProductDetails[i].isFixedPrice ==false 
                           ?false:
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
                                  quantity =
                                      double.parse(mycontroller[11].text);
                                  total = unitPrice! * quantity!;
                                  print(total);
                                }
                              }
                            });
                          },
                          readOnly: isappliedcoupon ==true && getcoupondata.isNotEmpty?true:false,
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
                        height: 5,
                      ),
                      // Container(
                      //             height: Screens.padingHeight(context) * 0.06,
                      //             width: Screens.width(context),
                      //             child: DropdownButtonFormField(
                      //               decoration: InputDecoration(
                      //                 // hintText: 'Email',
                      //                 labelText: 'Select refercode',
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
                      //  SizedBox(
                      //   height: 5,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                     getcoupondata.isEmpty?Container():     Container(
                      width: Screens.width(context)*0.5,
                        alignment: Alignment.centerLeft,
                            child: TextFormField(
                              controller: mycontroller[36],
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                                 labelText: 'Couponcode',
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                             enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        //  when the TextFormField in unfocused
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        //  when the TextFormField in focused
                                      ),
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                              ),
                            ),
                           
                          ),
                           SizedBox(
                        height: 5,
                      ),
                       
                               
                          InkWell(
                            onTap: ()async{
                              if(mycontroller[11].text.isEmpty){
                                st((){
showtoastforcoupon("Enter QUANTITY");
                                });
                          
                              }else{
                                st((){
//  callcouponApi();

 
 st((){
  getcoupondata.clear();
couponload=true;
 });
  
  notifyListeners();
 couponmodel coupondata= couponmodel();
 coupondata.customerCode=mycontroller[0].text;
 coupondata.itemCode=selectedItemCode;
 coupondata.storeCode=ConstantValues.Storecode;
 coupondata.qty =int.parse(mycontroller[11].text);
 coupondata.totalBillValue=double.parse(mycontroller[10].text);
 coupondata.requestedBy_UserCode=ConstantValues.Usercode;

 CouponApi.getData(coupondata).then((value) {
 if (value.stcode! >= 200 && value.stcode! <= 210) {
        

        if (value.CouponModaldatageader!.Ordercheckdata != null && value.CouponModaldatageader!.Ordercheckdata!.isNotEmpty) {
          log("not null");
          st((){
 getcoupondata = value.CouponModaldatageader!.Ordercheckdata!;
  log("getcoupondata::"+getcoupondata.length.toString());
   mycontroller[36].text= getcoupondata[0].CouponCode.toString();
  mycontroller[10].text =getcoupondata[0].RP!.toStringAsFixed(2);
  mycontroller[11].text=getcoupondata[0].Quantity!.toStringAsFixed(0);
   unitPrice =
                                      double.parse(mycontroller[10].text);
                                  quantity =
                                      double.parse(mycontroller[11].text);
                                  total = unitPrice! * quantity!;
  //  total = double.parse(mycontroller[10].text!) * double.parse(mycontroller[11].text!);
notifyListeners();
isappliedcoupon=true;

notifyListeners();
couponload=false;
 });
 
          // mapcoupon(value.CouponModaldatageader!.Ordercheckdata!);
notifyListeners();
          // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
        } else if (value.CouponModaldatageader!.Ordercheckdata == null||value.CouponModaldatageader!.Ordercheckdata!.isEmpty) {
          log("Order data null");
          st((){
 couponload=false;
          
          showtoastforcoupon("There is no couponcode for this customer");
          });
         
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        st((){
 couponload=false;
         showtoastforcoupon('${value.message}..!!${value.exception}....!!');
          });
       
        
        notifyListeners();
      } else  {
        st((){ couponload=false;
        
         showtoastforcoupon('${value.stcode!}..!!Network Issue..\nTry again Later..!!');
    
          });
         
     notifyListeners();
      }
      notifyListeners();
});
                                });
                          
                              }
                              
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Apply Coupon Code",
                              style: theme.textTheme.bodyText1!.copyWith(
                                color:theme.primaryColor,
                                decoration: TextDecoration.underline
                              ),
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
                            child: Text("Delivery From",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: theme.primaryColor)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: Screens.padingHeight(context) * 0.04,
                            // width:Screens.width(context)*0.20 ,
                            // padding:  EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: theme.primaryColor)),
                            child: ToggleButtons(
                              selectedColor: Colors.white,
                              color: theme.primaryColor,
                              fillColor: theme.primaryColor,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Store"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("WareHouse"),
                                )
                              ],
                              onPressed: (int newindex) {
                                st(
                                  () {
                                    for (int index = 0;
                                        index < isselected.length;
                                        index++) {
                                      if (index == newindex) {
                                        isselected[index] = true;
                                        notifyListeners();
                                      } else {
                                        isselected[index] = false;
                                        notifyListeners();
                                      }
                                    }
                                  },
                                );
                              },
                              isSelected: isselected,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 5,
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
                                    //                             ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text('Quantity Not equal to 0..!!'),
                                    //     backgroundColor: Colors.red,
                                    //     elevation: 10,
                                    //     behavior: SnackBarBehavior.floating,

                                    //     margin: EdgeInsets.only(

                                    //       // bottom: Screens.bodyheight(context)-60
                                    //     ),
                                    //     dismissDirection: DismissDirection.down,
                                    //   ),
                                    // );
                                    if (int.parse(mycontroller[11].text) > 0) {
                                      mycontroller[12].clear();
                                      addProductDetails(context);
                                    } else {
                                      showtoastproduct();
                                    }
                                  },
                                  child: Text("ok"))
                              : ElevatedButton(
                                  onPressed: () {
                                    if (int.parse(mycontroller[11].text) > 0) {
                                      updateProductDetails(context, i);
                                    } else {
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
List<GetAllcouponData> getcoupondata=[];
bool? couponload=false;
bool? isappliedcoupon=false;
void showtoastforcoupon(String? msg) {
    Fluttertoast.showToast(
        msg: "${msg}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
callcouponApi()async{
 
}

mapcoupon(List<GetAllcouponData> getcoupondata){
  
notifyListeners();
}
   showBottomSheetInsertforedit(
    BuildContext context,
    int i,
  ) {
    final theme = Theme.of(context);
    selectedItemName = productDetails[i].ItemDescription.toString();
    selectedItemCode = productDetails[i].ItemCode.toString();
    taxvalue=double.parse(productDetails[i].TaxCode.toString());
    sporder=productDetails[i].sp == null
        ? 0.0
        : double.parse(productDetails[i].sp.toString());
    slppriceorder=productDetails[i].slpprice == null
        ? 0.0
        : double.parse(productDetails[i].slpprice.toString());
    storestockorder=productDetails[i].storestock == null
        ? 0.0
        : double.parse(productDetails[i].storestock.toString());
    whsestockorder=productDetails[i].whsestock == null
        ? 0.0
        : double.parse(productDetails[i].whsestock.toString());
    isfixedpriceorder=productDetails[i].isfixedprice;
    allownegativestockorder=productDetails[i].allownegativestock;
    alloworderbelowcostorder=productDetails[i].alloworderbelowcost;
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
                                width: Screens.width(context) * 0.8,
                                //  color: Colors.amber,
                                child: Text(
                                    productDetails[i].ItemCode.toString(),
                                    style: theme.textTheme.bodyText1
                                        ?.copyWith(color: theme.primaryColor)),
                              ),
                              Container(
                                width: Screens.width(context) * 0.8,
                                // color: Colors.red,
                                child: Text(
                                    productDetails[i].ItemDescription.toString(),
                                    style: theme.textTheme.bodyText1
                                        ?.copyWith() //color: theme.primaryColor
                                    ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              mycontroller[27].clear();
                              mycontroller[28].clear();
                              mycontroller[29].clear();
                              mycontroller[30].clear();

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
                                  quantity =
                                      double.parse(mycontroller[11].text);
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
                          readOnly:
                          productDetails[i].isfixedprice ==false ?false:
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
                                  quantity =
                                      double.parse(mycontroller[11].text);
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
                      Row(
                        children: [
                          Container(
                            child: Text("Delivery From",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: theme.primaryColor)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: Screens.padingHeight(context) * 0.04,
                            // width:Screens.width(context)*0.20 ,
                            // padding:  EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: theme.primaryColor)),
                            child: ToggleButtons(
                              selectedColor: Colors.white,
                              color: theme.primaryColor,
                              fillColor: theme.primaryColor,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Store"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("WareHouse"),
                                )
                              ],
                              onPressed: (int newindex) {
                                st(
                                  () {
                                    for (int index = 0;
                                        index < isselected.length;
                                        index++) {
                                      if (index == newindex) {
                                        isselected[index] = true;
                                        notifyListeners();
                                      } else {
                                        isselected[index] = false;
                                        notifyListeners();
                                      }
                                    }
                                  },
                                );
                              },
                              isSelected: isselected,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 5,
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
                                    //                             ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text('Quantity Not equal to 0..!!'),
                                    //     backgroundColor: Colors.red,
                                    //     elevation: 10,
                                    //     behavior: SnackBarBehavior.floating,

                                    //     margin: EdgeInsets.only(

                                    //       // bottom: Screens.bodyheight(context)-60
                                    //     ),
                                    //     dismissDirection: DismissDirection.down,
                                    //   ),
                                    // );
                                    if (int.parse(mycontroller[11].text)>0) {
                                      mycontroller[12].clear();
                                      addProductDetails(context);
                                    } else {
                                      showtoastproduct();
                                    }
                                  },
                                  child: Text("ok"))
                              : ElevatedButton(
                                  onPressed: () {
                                    if (int.parse(mycontroller[11].text)>0) {
                                      updateProductDetails(context, i);
                                    } else {
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

  List<ExistingCusData> existCusDataList = [];
  List<ExistingCusData> get getexistCusDataList => existCusDataList;
  List<ExistingCusData> filterexistCusDataList = [];
  List<customerTags> cusReffList = [];
  List<customerTags> get getcusReffList => cusReffList;

  FilePickerResult? result;
  //  filesz = [];
  List<File> files = [];
  bool? fileValidation = false;

  List<FilesData> filedata = [];
  List<String> filelink = [];
  List<String> fileException = [];
  List images = [
    "assets/PDFimg.png",
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
  void showtoastcustomergroup() {
    Fluttertoast.showToast(
        msg: "Enter Customer Group..!!",
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

  selectattachment() async {
    List<File> filesz = [];
    // log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
      if (filedata.isEmpty) {
        files.clear();
        filesz.clear();
        filedata.clear();
        notifyListeners();
      }

      // log("filedata::" + filedata.length.toString());

      filesz = result!.paths.map((path) => File(path!)).toList();

      // if (filesz.length != 0) {
      int remainingSlots = 5 - files.length;
      if (filesz.length <= remainingSlots) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

          // showtoast();
          files.add(filesz[i]);
          // log("Files Lenght :::::" + files.length.toString());
          List<int> intdata = filesz[i].readAsBytesSync();
          filedata.add(FilesData(
              fileBytes: base64Encode(intdata), fileName: filesz[i].path));

          //New
          // XFile? photoCompressedFile =await testCompressAndGetFile(filesz[i],filesz[i].path);
          // await FileStorage.writeCounter('${photoCompressedFile!.name}_1', photoCompressedFile);
          //

          notifyListeners();
          // log("filedata222::" + filedata.length.toString());
          // return null;
        }
      } else {
        showtoast();
      }

      notifyListeners();
    }

    notifyListeners();
  }

  Future<XFile?> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());

    return result;
  }

  Future imagetoBinary(ImageSource source) async {
    List<File> filesz = [];
    await LocationTrack.checkcamlocation();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // files.add(File());
    if (filedata.isEmpty) {
      filedata.clear();
      filesz.clear();
    }
    filesz.add(File(image.path));

    notifyListeners();
    // log("filesz lenghthhhhh::::::" + filedata.length.toString());
    if (files.length <= 4) {
      for (int i = 0; i < filesz.length; i++) {
        files.add(filesz[i]);
        List<int> intdata = filesz[i].readAsBytesSync();
        String fileName = filesz[i].path.split('/').last;
        String fileBytes = base64Encode(intdata);
        String tempPath='';
        if(Platform.isAndroid){
//  Directory tempDir =  await getTemporaryDirectory();
  
//         log("tempDir::"+tempDir.toString());
         tempPath = (await getExternalStorageDirectory())!.path;
          // String? imagesaver = '$tempPath/$fileName'; 
    
       
 
        }else if(Platform.isIOS){
 tempPath = (await getApplicationDocumentsDirectory())!.path;
        }
       
        String fullPath = '$tempPath/$fileName'; 
        await filesz[i].copy(fullPath);
         File(fullPath).writeAsBytesSync(intdata);
  final result = await ImageGallerySaver.saveFile(fullPath,isReturnPathOfIOS: true);
    
        // log("fullPath::"+fullPath.toString());
         if(Platform.isAndroid){
filedata.add(FilesData(
            fileBytes: base64Encode(intdata),
            fileName: fullPath
            // files[i].path.split('/').last
            ));
             }else{
              filedata.add(FilesData(
            fileBytes: base64Encode(intdata),
            fileName: image.path
            // files[i].path.split('/').last
            ));
             }
        // filedata.add(
        //     FilesData(fileBytes: base64Encode(intdata), fileName: fullPath));
        notifyListeners();
      }
      // log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
      showtoast();
    }
    // log("camera fileslength" + files.length.toString());
    // log("camera filesdatalength" + filedata.length.toString());
    // showtoast();

    notifyListeners();
  }

  Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  bool value3 = false;

  converttoShipping(bool value) {
    // log("value:::" + value.toString());
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

  getTotalOrderAmount() {
    double? taxpercentage ;
    double? LineTotal = 0.00;
    for (int i = 0; i < productDetails.length; i++) {
      // log("LineTotal::"+productDetails.length.toString());
       taxpercentage=productDetails[i].TaxCode;
      LineTotal = LineTotal! + (productDetails[i].LineTotal!/(1+taxpercentage!/100));
        // log("LineTotal5555::"+LineTotal.toString());
    }
    return config.slpitCurrency22(LineTotal!.toString()) ;
  }
  getTotalTaxAmount() {
    double? taxtotal = 0.00;
    double? taxpercentage ;
    for (int i = 0; i < productDetails.length; i++) {
      taxpercentage=productDetails[i].TaxCode;
      // log("productDetails[i].LineTotal:::"+productDetails[i].LineTotal!.toString());
      // log("taxpercentage:::"+taxpercentage.toString());
      
      taxtotal = taxtotal! +(taxpercentage! * (productDetails[i].LineTotal!/(1+taxpercentage!/100)))/100;
  //  log("taxtotal:::"+taxtotal.toString());
    }
    return config.slpitCurrency22(taxtotal!.toString()) ;
  }
  getTotalGrossAmount() {
    double? LineTotal = double.parse(getTotalOrderAmount().toString().replaceAll(",", ""));
    double? taxTotal = double.parse(getTotalTaxAmount().toString().replaceAll(",", ""));
    // for (int i = 0; i < productDetails.length; i++) {
      LineTotal = LineTotal! + taxTotal;
    // }
    return config.slpitCurrency22(LineTotal!.toString()) ;
  }


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
      filterexistCusDataList = existCusDataList;
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
}

class customerTags {
  String? tagname;

  String? tagid;
  // String shipCity;
  // String shipstate;
  // String shipPincode;
  // String shipCountry;
  customerTags({
    this.tagid,
    this.tagname,

    // required this.shipCity,
    //required this.shipAddress,

    // required this.shipCountry,
    // required this.shipPincode,
    // required this.shipstate
  });
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

class FilesData {
  String fileBytes;
  String fileName;
  // String filepath;

  FilesData({
    required this.fileBytes,
    required this.fileName,
  });
}

class PaymentTermsData {
  String? Name;
  String? Code;

  PaymentTermsData({required this.Name, required this.Code});
}
class Custype{
  String? name;
  Custype({
    required this.name

  });
}
class complementary{
  String? itemName;
  String? ItemCode;
  double? SP;
  double? offer;
  double? Percentage;
  double? qty;

complementary({
  required this.itemName,
  required this.ItemCode,
  required this.Percentage,
  required this.SP,
  required this.offer,
  required this.qty

});
}