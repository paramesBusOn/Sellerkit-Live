// ignore_for_file: prefer_const_constructors, prefer_is_empty, unnecessary_new, unnecessary_string_interpolations, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sellerkit/Constant/get_filepath.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/OrderTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/levelofinterestModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/paymodemodel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/couponModel.dart';
import 'package:sellerkit/Models/ordergiftModel/LiknkedItemsModel.dart';
import 'package:sellerkit/Models/ordergiftModel/ParticularpricelistModel.dart';
import 'package:sellerkit/Models/ordergiftModel/orderbundleModel.dart';
import 'package:sellerkit/Models/ordergiftModel/ordergiftModel.dart';
import 'package:sellerkit/Models/ordergiftModel/orderpricecheckModel.dart';
import 'package:sellerkit/Models/ordergiftModel/valuebasedgiftModel.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/paymenttermdialog.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/shorefdialog.dart';
import 'package:sellerkit/Services/OrdergiftApi/linkeditemsApi.dart';
import 'package:sellerkit/Services/OrdergiftApi/orderbundleApi.dart';
import 'package:sellerkit/Services/OrdergiftApi/ordergiftapi.dart';
import 'package:sellerkit/Services/OrdergiftApi/orderpricecheckApi.dart';
import 'package:sellerkit/Services/OrdergiftApi/pricelistparticularApi.dart';
import 'package:sellerkit/Services/OrdergiftApi/valuebasedgiftApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/couponApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/paymentmode.dart';
import 'package:sellerkit/Services/PostQueryApi/QuotatationApi/QuotesQTHApi.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';
import 'package:sellerkit/Services/refrealpartnerApi/refpartnerApi.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/location_track.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/DBHelper/db_helper.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/warningorder.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
// import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/GetOrderDeatilsQTH.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/updateorderApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';
import '../../DBHelper/db_operation.dart';
import '../../DBModel/itemmasertdb_model.dart';
import '../../Models/AddEnqModel/addenq_model.dart';
import '../../Models/CustomerMasterModel/customermaster_model.dart';
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
import '../EnquiryController/enquiryuser_contoller.dart';
import 'taborder_controller.dart';

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
    await callrefparnerApi();
    await callpaymodeApi();
    getCustomerTag();
    // getCustomerListFromDB();
  }

  iscateSeleted(
    String name,
    String code,
    BuildContext context,
  ) {
    selectedapartcode = code.toString();
    mycontroller[48].text = name.toString();
    selectedapartname = name.toString();
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

  List<refdetModalData> refpartdata = [];
  List<refdetModalData> filterrefpartdata = [];
  String selectedapartcode = '';
  String selectedapartname = '';
  callrefparnerApi() async {
    refpartdata.clear();
    filterrefpartdata.clear();
    await refpartnerApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata!.itemdata != null &&
            value.itemdata!.itemdata!.isNotEmpty) {
          refpartdata = value.itemdata!.itemdata!;
          filterrefpartdata = refpartdata;
          log("refpartdata:::" + refpartdata.length.toString());
          log("filterrefpartdata:::" + filterrefpartdata.length.toString());
          notifyListeners();
        } else if (value.itemdata!.itemdata == null ||
            value.itemdata!.itemdata!.isEmpty) {
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
 List<PaymodeModalData> duplicatepaymode = [];
  List<PaymodeModalData> paymode = [];
  List<paymenttermdata> postpaymentdata = [];
  List<PaymodeModalist> paymodeModallist = [];
  List<PaymodeModalist> valueDroplist = [];
  callpaymodeApi() async {
    duplicatepaymode.clear();
   
    paymodeModallist.clear();
    notifyListeners();
    await PaymodeApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.paymode != null) {
          duplicatepaymode = value.paymode!.paymodeModalData!;
          paymodeModallist = value.paymode!.paymodeModallist!;
          log("paymode:::" + paymode.length.toString());
mappaymode(duplicatepaymode);
          log("paymodeModallist:::" + paymodeModallist.length.toString());
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
mappaymode(List<PaymodeModalData> duplicatepaymode){
   paymode.clear();
  for(int i=0;i<duplicatepaymode.length;i++){
    if(duplicatepaymode[i]. Applicable_SO ==true){
 paymode.add(PaymodeModalData(
      Applicable_CE:duplicatepaymode[i]. Applicable_CE, 
      Applicable_SO:duplicatepaymode[i]. Applicable_SO, 
    Attach:duplicatepaymode[i]. Attach, 
    Code:duplicatepaymode[i]. Code, 
    CreatedBy:duplicatepaymode[i]. CreatedBy, 
    CreatedDatetime:duplicatepaymode[i]. CreatedDatetime, 
    ListVal: duplicatepaymode[i].ListVal, 
    ModeName:duplicatepaymode[i]. ModeName, 
    Ref1:duplicatepaymode[i]. Ref1, 
    Ref2:duplicatepaymode[i]. Ref2, 
    SortOrder:duplicatepaymode[i]. SortOrder, 
    Status:duplicatepaymode[i]. Status, 
    TransDate:duplicatepaymode[i]. TransDate, 
    isselected: duplicatepaymode[i].isselected
    ));
    }
   
  }
notifyListeners();
}
  List<LevelofData> leveofdata = [];
  List<OrderTypeData> ordertypedata = [];
  getLeveofType() async {
    leveofdata.clear();
    ordertypedata.clear();
    Particularprice.clear();
    final Database db = (await DBHelper.getInstance())!;

    leveofdata = await DBOperation.getlevelofData(db);
    ordertypedata = await DBOperation.getordertypeData(db);
    Particularprice = await DBOperation.getparticularprice(db);
    notifyListeners();
  }

  customerdetData? customermodeldata;
  callcustomerapi() async {
    await customerDetailApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        customermodeldata = value.leadcheckdata;
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
    callrefparnerApi();
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
  getpaymenttot2(int index) {
    double amount = 0.0;
    double? pendingamount;
    // double payTermTotal = double.parse(paytermtotal!
    //                                 .toStringAsFixed(2));
    double fullpayment2 = double.parse(fullpayment!.toStringAsFixed(2));

    for (int i = 0; i < postpaymentdata.length; i++) {
      amount = amount + postpaymentdata[i].amount!;
      log("paytermtotal:::" + paytermtotal.toString());
    }
    pendingamount = amount - postpaymentdata[index].amount!;
    log("pendingamount::" + pendingamount.toString());
    final pendingfullcash = fullpayment2 - pendingamount;
    log("pendingfullcash::" + pendingfullcash.toString());
    return pendingfullcash;
  }

  validateupdate(int index, PaymodeModalData paymode, BuildContext context) {
    if (formkey[5].currentState!.validate()) {
      payloading = true;
      notifyListeners();
      updatepayterm(index, paymode, context);
      notifyListeners();
    }
  }

  updatepayterm(
      int index, PaymodeModalData paymode, BuildContext context) async {
    log("payindhhh::" + postpaymentdata.length.toString());
    log("payindex::" + payindex.toString());
    double parsedValue = double.parse(mycontroller[46].text.toString());
    double fullpayment2 = double.parse(fullpayment!.toStringAsFixed(2));
//  if(parsedValue <= fullpayment2){
    postpaymentdata.removeAt(index);

//  }
    getTotalaoyAmount();

    List<String> filename2 = [];
    List<String>? fileError2 = [];
    String? attachment;
    attachment = '';
    if (filedata2 != null || filedata2.isNotEmpty) {
      for (int i = 0; i < filedata2.length; i++) {
        // log("savetoserverNames::" + filedata[i].fileName.toString());
        await OrderAttachmentApiApi.getData(
          filedata2[i].fileName,
        ).then((value) {
          // log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError2.add(filedata2[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              // log("message");
              attachment = value;
            }
          }
        });
      }
    }

    postpaymentdata.add(paymenttermdata(
        paymodcode: paymode.Code,
        paymodename: paymode.ModeName,
        ref1: mycontroller[43].text == null ||
                mycontroller[43].text == '' ||
                mycontroller[43].text.isEmpty
            ? null
            : mycontroller[43].text,
        ref2: mycontroller[44].text == null ||
                mycontroller[44].text == '' ||
                mycontroller[44].text.isEmpty
            ? null
            : mycontroller[44].text,
        listtype:
            selecteditem == null || selecteditem!.isEmpty ? null : selecteditem,
        dateref: chequedate == null || chequedate == '' || chequedate.isEmpty
            ? null
            : chequedate,
        attachment1:
            attachment == null || attachment == '' || attachment!.isEmpty
                ? null
                : attachment,
        amount: mycontroller[46].text == null ||
                mycontroller[46].text == '' ||
                mycontroller[46].text.isEmpty
            ? 0.0
            : double.parse(mycontroller[46].text)));

    //  postpaymentdata[index] .    paymodcode= paymode.Code;
    //     postpaymentdata[index] .  paymodename= paymode.ModeName;
    //     postpaymentdata[index] .  ref1= mycontroller[43].text == null ||
    //               mycontroller[43].text == '' ||
    //               mycontroller[43].text.isEmpty
    //           ? null
    //           : mycontroller[43].text;
    //     postpaymentdata[index] .  ref2= mycontroller[44].text == null ||
    //               mycontroller[44].text == '' ||
    //               mycontroller[44].text.isEmpty
    //           ? null
    //           : mycontroller[44].text;
    //    postpaymentdata[index] .   listtype=selecteditem == null || selecteditem!.isEmpty
    //           ? null
    //           : selecteditem;
    //    postpaymentdata[index] .   dateref=mycontroller[45].text == null ||
    //               mycontroller[45].text == '' ||
    //               mycontroller[45].text.isEmpty
    //           ? null
    //           : mycontroller[45].text;
    //    postpaymentdata[index] .   attachment1=
    //           attachment == null || attachment == '' || attachment!.isEmpty
    //               ? null
    //               : attachment;
    //   postpaymentdata[index] .    amount= mycontroller[46].text == null ||
    //               mycontroller[46].text == '' ||
    //               mycontroller[46].text.isEmpty
    //           ? 0.0
    //           : double.parse(mycontroller[46].text);
    //            notifyListeners();
    //             paymode.isselected = !paymode.isselected!;
    paymode.amount = mycontroller[46].text;
    paytermtotal = double.parse(paytermtotal!.toStringAsFixed(2)) -
        double.parse(mycontroller[46].text);
    //  getTotalaoyAmount();
    // isSelectedpaymentTermsCode=paymode.Code.toString();
    payloading = false;

    notifyListeners();
    Navigator.pop(context);
  }

  bool? payloading = false;
  validatepayterm(PaymodeModalData paymode, BuildContext context) async {
    if (formkey[5].currentState!.validate()) {
      payloading = true;
      notifyListeners();
      //  Future.delayed(Duration(seconds: 3),(){});
      List<String> filename2 = [];
      List<String>? fileError2 = [];
      String? attachment;
      attachment = '';
      if (filedata2 != null || filedata2.isNotEmpty) {
        for (int i = 0; i < filedata2.length; i++) {
          // log("savetoserverNames::" + filedata[i].fileName.toString());
          await OrderAttachmentApiApi.getData(
            filedata2[i].fileName,
          ).then((value) {
            // log("OrderAttachmentApiApi::" + value.toString());
            if (value == 'No Data Found..!!') {
              fileError2.add(filedata2[i].fileName);
              // filename.add("");
            } else {
              // filename.add(value);
              if (i == 0) {
                // log("message");
                attachment = value;
              }
            }
          });
        }
      }

      postpaymentdata.add(paymenttermdata(
          paymodcode: paymode.Code,
          paymodename: paymode.ModeName,
          ref1: mycontroller[43].text == null ||
                  mycontroller[43].text == '' ||
                  mycontroller[43].text.isEmpty
              ? null
              : mycontroller[43].text,
          ref2: mycontroller[44].text == null ||
                  mycontroller[44].text == '' ||
                  mycontroller[44].text.isEmpty
              ? null
              : mycontroller[44].text,
          listtype: selecteditem == null || selecteditem!.isEmpty
              ? null
              : selecteditem,
          dateref: chequedate == null || chequedate == '' || chequedate.isEmpty
              ? null
              : chequedate,
          attachment1:
              attachment == null || attachment == '' || attachment!.isEmpty
                  ? null
                  : attachment,
          amount: mycontroller[46].text == null ||
                  mycontroller[46].text == '' ||
                  mycontroller[46].text.isEmpty
              ? 0.0
              : double.parse(mycontroller[46].text)));
      paymode.isselected = !paymode.isselected!;
      paymode.amount = mycontroller[46].text;
      paytermtotal = double.parse(paytermtotal!.toStringAsFixed(2)) -
          double.parse(mycontroller[46].text);
      // getTotalaoyAmount();
      // isSelectedpaymentTermsCode=paymode.Code.toString();
      payloading = false;

      notifyListeners();
      Navigator.pop(context);
      log("paymode!.isselected::" + paymode.isselected.toString());
      log("paymode!.isselected::" + postpaymentdata.length.toString());
    }
  }

  deletepaymode2() {
    for (int i = 0; i < paymode.length; i++) {
      paymode[i].isselected = false;
      paymode[i].amount = '';
    }
  }

  deletepaymode(paymenttermdata paymentdata, int index) {
    // log("postpaymentdata[index].paymodename::"+postpaymentdata[index].paymodename.toString());
    for (int i = 0; i < paymode.length; i++) {
      if (paymode[i].ModeName == paymentdata.paymodename) {
        paymode[i].isselected = !paymode[i].isselected!;
        paymode[i].amount = '';
        //  postpaymentdata.removeAt(index);
        notifyListeners();
      }
    }
  }

  List<GlobalKey<FormState>> formkey =
      new List.generate(6, (i) => new GlobalKey<FormState>(debugLabel: "Lead"));
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
 List<DocumentLines2> valuebaseproductDetails = [];
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
  int? offeridval;
  String? itemtypemodify;
  int? bundleidmodify;

  double total = 0.00;
  List<Custype> custype = [
    Custype(name: "Single"),
    Custype(name: "Bulk"),
    Custype(name: "Chain Order")
  ];
  double? sporder = 0.00;
  double? slppriceorder = 0.00;
  double? storestockorder = 0.00;
  double? whsestockorder = 0.00;
  bool? isfixedpriceorder = false;
  bool? allownegativestockorder = false;
  bool? alloworderbelowcostorder = false;
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

  String chequedate = '';
  void showchequeDate(BuildContext context) {
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
      chequedate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";
      print(chequedate);
      mycontroller[45].text = chooseddate;
      notifyListeners();
    });
  }

  String? selecteditem;
  String? selectedpaycode;
  onselectdrop(String val) {
    selecteditem = val;
    for (int i = 0; i < valueDroplist.length; i++) {
      if (valueDroplist[i].ListName.toString() == val)
        selectedpaycode = valueDroplist[i].ListCode;
      break;
    }
    notifyListeners();
  }

  dropdownvalue(int ind) {
    valueDroplist.clear();
    log("value::" + ind.toString());
    for (int i = 0; i < paymodeModallist.length; i++) {
      if (paymodeModallist[i].Code == paymode[ind].Code) {
        valueDroplist.add(PaymodeModalist(
            Code: paymodeModallist[i].Code,
            ListCode: paymodeModallist[i].ListCode,
            ListName: paymodeModallist[i].ListName,
            Status: paymodeModallist[i].Status));
      }
      log("valueDroplist::" + valueDroplist.length.toString());
      notifyListeners();
    }
  }

  int? payindex;
  bool? payupdate = false;
  selectpaymentTerms(String selected, String refercode, String code,
      BuildContext context, PaymodeModalData paymode, int index) {
    payindex = null;
    payupdate = false;

    notifyListeners();
    isSelectedpaymentTermsList = selected;
    PaymentTerms = refercode;
    clearpaydata();
    isSelectedpaymentTermsCode = code;

    dropdownvalue(index);
    if (postpaymentdata.isNotEmpty) {
      for (int i = 0; i < postpaymentdata.length; i++) {
        if (postpaymentdata[i].paymodename == paymode.ModeName) {
          mycontroller[43].text = postpaymentdata[i].ref1 == null ||
                  postpaymentdata[i].ref1!.isEmpty
              ? ''
              : postpaymentdata[i].ref1.toString();
          mycontroller[44].text = postpaymentdata[i].ref2 == null ||
                  postpaymentdata[i].ref2!.isEmpty
              ? ''
              : postpaymentdata[i].ref2.toString();
          //   mycontroller[45].text=postpaymentdata[i].dateref ==null||postpaymentdata[i].dateref!.isEmpty?
          // '':postpaymentdata[i].dateref.toString();
          mycontroller[46].text = postpaymentdata[i].amount == null
              ? ''
              : postpaymentdata[i].amount!.toStringAsFixed(2);
          selecteditem = postpaymentdata[i].listtype == null ||
                  postpaymentdata[i].listtype!.isEmpty
              ? ''
              : postpaymentdata[i].listtype.toString();
          payindex = i;
          payupdate = true;
          log("payupdate=true;");
          notifyListeners();
        }
      }
    }
    getTotalaoyAmount();
    notifyListeners();
    log("AN11:" + PaymentTerms.toString());
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return paytermdialog(paymode: paymode);
        });
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

  scannerreset() {
    itemAlreadyscanned = false;
    indexscanning = null;
    notifyListeners();
  }

  int? indexscanning;
  bool itemAlreadyscanned = false;
  String? Scancode;
  scanneddataget(BuildContext context) {
    // log("code:::::"+code.toString());

    notifyListeners();

    // Get.back();
// Navigator.pop(context);
    notifyListeners();
    for (int ij = 0; ij < allProductDetails.length; ij++) {
      if (allProductDetails[ij].partCode == Scancode) {
        itemAlreadyscanned = true;
        indexscanning = ij;
        notifyListeners();
        break;
      }
    }
    if (itemAlreadyscanned == true) {
      resetItems(indexscanning!);
      showBottomSheetInsert(context, indexscanning!);
      notifyListeners();
    } else {
      showtoastforscanning();
      notifyListeners();
    }

//  checkscannedcode(code);
    notifyListeners();
  }
  // checkscannedcode(String code){
  //    log("code:::::"+code.toString());

  // }
  List<ItemMasterDBModel> bundleallProductDetails = [];
  getdataFromDb() async {
    final Database db = (await DBHelper.getInstance())!;
    allProductDetails = await DBOperation.getAllProducts(db);
    await mapvaluesbundledb(allProductDetails);
    filterProductDetails = allProductDetails;
    // log("allProductDetails::"+allProductDetails[1].imageUrl1!.toString());
    notifyListeners();
  }

  mapvaluesbundledb(List<ItemMasterDBModel> allProductDetails) async {
    bundleallProductDetails.clear();
    notifyListeners();
    for (int i = 0; i < allProductDetails.length; i++) {
      if (allProductDetails[i].Isbundle == true) {
        bundleallProductDetails.add(ItemMasterDBModel(
            refreshedRecordDate: allProductDetails[i].refreshedRecordDate,
            id: allProductDetails[i].id,
            itemCode: allProductDetails[i].itemCode,
            brand: allProductDetails[i].brand,
            division: allProductDetails[i].division,
            category: allProductDetails[i].category,
            itemName: allProductDetails[i].itemName,
            segment: allProductDetails[i].segment,
            isselected: allProductDetails[i].isselected,
            favorite: allProductDetails[i].favorite,
            mgrPrice: allProductDetails[i].mgrPrice,
            slpPrice: allProductDetails[i].slpPrice,
            storeStock: allProductDetails[i].storeStock,
            whsStock: allProductDetails[i].whsStock,
            allowNegativeStock: allProductDetails[i].allowNegativeStock,
            allowOrderBelowCost: allProductDetails[i].allowOrderBelowCost,
            brandCode: allProductDetails[i].brandCode,
            catalogueUrl1: allProductDetails[i].catalogueUrl1,
            catalogueUrl2: allProductDetails[i].catalogueUrl2,
            clasification: allProductDetails[i].clasification,
            color: allProductDetails[i].color,
            eol: allProductDetails[i].eol,
            fast: allProductDetails[i].fast,
            imageUrl1: allProductDetails[i].imageUrl1,
            imageUrl2: allProductDetails[i].imageUrl2,
            isFixedPrice: allProductDetails[i].isFixedPrice,
            itemDescription: allProductDetails[i].itemDescription,
            itemGroup: allProductDetails[i].itemGroup,
            modelNo: allProductDetails[i].modelNo,
            movingType: allProductDetails[i].movingType,
            partCode: allProductDetails[i].partCode,
            priceStockId: allProductDetails[i].priceStockId,
            serialNumber: allProductDetails[i].serialNumber,
            sizeCapacity: allProductDetails[i].sizeCapacity,
            skucode: allProductDetails[i].skucode,
            slow: allProductDetails[i].slow,
            sp: allProductDetails[i].sp,
            specification: allProductDetails[i].specification,
            ssp1: allProductDetails[i].ssp1,
            ssp1Inc: allProductDetails[i].ssp1Inc,
            ssp2: allProductDetails[i].ssp2,
            ssp2Inc: allProductDetails[i].ssp2Inc,
            ssp3: allProductDetails[i].ssp3,
            ssp3Inc: allProductDetails[i].ssp3Inc,
            ssp4: allProductDetails[i].ssp4,
            ssp4Inc: allProductDetails[i].ssp4Inc,
            ssp5: allProductDetails[i].ssp5,
            ssp5Inc: allProductDetails[i].ssp5Inc,
            status: allProductDetails[i].status,
            storeCode: allProductDetails[i].storeCode,
            taxRate: allProductDetails[i].taxRate,
            textNote: allProductDetails[i].textNote,
            uoM: allProductDetails[i].uoM,
            validTill: allProductDetails[i].validTill,
            veryFast: allProductDetails[i].veryFast,
            verySlow: allProductDetails[i].verySlow,
            whseCode: allProductDetails[i].whseCode,
            calcType: allProductDetails[i].calcType,
            payOn: allProductDetails[i].payOn,
            storeAgeSlab1: allProductDetails[i].storeAgeSlab1,
            storeAgeSlab2: allProductDetails[i].storeAgeSlab2,
            storeAgeSlab3: allProductDetails[i].storeAgeSlab3,
            storeAgeSlab4: allProductDetails[i].storeAgeSlab4,
            storeAgeSlab5: allProductDetails[i].storeAgeSlab5,
            whsAgeSlab1: allProductDetails[i].whsAgeSlab1,
            whsAgeSlab2: allProductDetails[i].whsAgeSlab2,
            whsAgeSlab3: allProductDetails[i].whsAgeSlab3,
            whsAgeSlab4: allProductDetails[i].whsAgeSlab4,
            whsAgeSlab5: allProductDetails[i].whsAgeSlab5,
            Isbundle: allProductDetails[i].Isbundle));
      }
    }
    notifyListeners();
    await mapvaluesdb(allProductDetails);
    notifyListeners();
  }

  mapvaluesdb(List<ItemMasterDBModel> allProductDetails) async {
    for (int i = allProductDetails.length - 1; i >= 0; i--) {
      if (allProductDetails[i].Isbundle == true) {
        log("allProductDetailsbundle::" +
            allProductDetails[i].itemCode.toString());
        allProductDetails.removeAt(i);
      }
    }
    notifyListeners();
    await addbundledb();
    notifyListeners();
  }

  addbundledb() async {
    if (bundleallProductDetails.isNotEmpty) {
      for (int i = 0; i < bundleallProductDetails.length; i++) {
        allProductDetails.add(ItemMasterDBModel(
            refreshedRecordDate: allProductDetails[i].refreshedRecordDate,
            id: bundleallProductDetails[i].id,
            itemCode: bundleallProductDetails[i].itemCode,
            brand: bundleallProductDetails[i].brand,
            division: bundleallProductDetails[i].division,
            category: bundleallProductDetails[i].category,
            itemName: bundleallProductDetails[i].itemName,
            segment: bundleallProductDetails[i].segment,
            isselected: bundleallProductDetails[i].isselected,
            favorite: bundleallProductDetails[i].favorite,
            mgrPrice: bundleallProductDetails[i].mgrPrice,
            slpPrice: bundleallProductDetails[i].slpPrice,
            storeStock: bundleallProductDetails[i].storeStock,
            whsStock: bundleallProductDetails[i].whsStock,
            allowNegativeStock: bundleallProductDetails[i].allowNegativeStock,
            allowOrderBelowCost: bundleallProductDetails[i].allowOrderBelowCost,
            brandCode: bundleallProductDetails[i].brandCode,
            catalogueUrl1: bundleallProductDetails[i].catalogueUrl1,
            catalogueUrl2: bundleallProductDetails[i].catalogueUrl2,
            clasification: bundleallProductDetails[i].clasification,
            color: bundleallProductDetails[i].color,
            eol: bundleallProductDetails[i].eol,
            fast: bundleallProductDetails[i].fast,
            imageUrl1: bundleallProductDetails[i].imageUrl1,
            imageUrl2: bundleallProductDetails[i].imageUrl2,
            isFixedPrice: bundleallProductDetails[i].isFixedPrice,
            itemDescription: bundleallProductDetails[i].itemDescription,
            itemGroup: bundleallProductDetails[i].itemGroup,
            modelNo: bundleallProductDetails[i].modelNo,
            movingType: bundleallProductDetails[i].movingType,
            partCode: bundleallProductDetails[i].partCode,
            priceStockId: bundleallProductDetails[i].priceStockId,
            serialNumber: bundleallProductDetails[i].serialNumber,
            sizeCapacity: bundleallProductDetails[i].sizeCapacity,
            skucode: bundleallProductDetails[i].skucode,
            slow: bundleallProductDetails[i].slow,
            sp: bundleallProductDetails[i].sp,
            specification: bundleallProductDetails[i].specification,
            ssp1: bundleallProductDetails[i].ssp1,
            ssp1Inc: bundleallProductDetails[i].ssp1Inc,
            ssp2: bundleallProductDetails[i].ssp2,
            ssp2Inc: bundleallProductDetails[i].ssp2Inc,
            ssp3: bundleallProductDetails[i].ssp3,
            ssp3Inc: bundleallProductDetails[i].ssp3Inc,
            ssp4: bundleallProductDetails[i].ssp4,
            ssp4Inc: bundleallProductDetails[i].ssp4Inc,
            ssp5: bundleallProductDetails[i].ssp5,
            ssp5Inc: bundleallProductDetails[i].ssp5Inc,
            status: bundleallProductDetails[i].status,
            storeCode: bundleallProductDetails[i].storeCode,
            taxRate: bundleallProductDetails[i].taxRate,
            textNote: bundleallProductDetails[i].textNote,
            uoM: bundleallProductDetails[i].uoM,
            validTill: bundleallProductDetails[i].validTill,
            veryFast: bundleallProductDetails[i].veryFast,
            verySlow: bundleallProductDetails[i].verySlow,
            whseCode: bundleallProductDetails[i].whseCode,
            calcType: bundleallProductDetails[i].calcType,
            payOn: bundleallProductDetails[i].payOn,
            storeAgeSlab1: bundleallProductDetails[i].storeAgeSlab1,
            storeAgeSlab2: bundleallProductDetails[i].storeAgeSlab2,
            storeAgeSlab3: bundleallProductDetails[i].storeAgeSlab3,
            storeAgeSlab4: bundleallProductDetails[i].storeAgeSlab4,
            storeAgeSlab5: bundleallProductDetails[i].storeAgeSlab5,
            whsAgeSlab1: bundleallProductDetails[i].whsAgeSlab1,
            whsAgeSlab2: bundleallProductDetails[i].whsAgeSlab2,
            whsAgeSlab3: bundleallProductDetails[i].whsAgeSlab3,
            whsAgeSlab4: bundleallProductDetails[i].whsAgeSlab4,
            whsAgeSlab5: bundleallProductDetails[i].whsAgeSlab5,
            Isbundle: bundleallProductDetails[i].Isbundle));
      }
    }
    notifyListeners();
  }

  changeVisible() {
    allProductDetails = filterProductDetails;
    log("allProductDetails::" + allProductDetails[1].imageUrl1!.toString());
    showItemList = !showItemList;
    notifyListeners();
  }

  changeVisible2() {
    allProductDetails = filterProductDetails;

// isselected = [true, false];

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

  showpopdialogunitprice(
      BuildContext context, String headtext, String childtext) async {
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setst) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text("Are you sure?"),
          // content: Text("Do you want to exit?"),
          content: Container(
            width: Screens.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            // fontSize: 12,
                            ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )), //Radius.circular(6)
                      ),
                      child: Text("Alert", style: TextStyle(fontSize: 15))),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                Container(
                    padding: EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: Divider(
                      color: Colors.grey,
                    )),
                Container(
                    alignment: Alignment.center,
                    // width: Screens.width(context)*0.5,
                    // padding: EdgeInsets.only(left:20),
                    //Entered Amount is less than SP
                    child: Text(
                      "$headtext",
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                childtext == ''
                    ? Container()
                    : Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(left:20),
                        //To proceed with order creation...get price approval
                        child:
                            Text("$childtext", style: TextStyle(fontSize: 15))),
                Container(
                    padding: EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: Divider(color: Colors.grey)),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: theme.primaryColor,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(0),
                        )),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        //  exit(0);
                        // setst(() {
                        //   if (ispopupshown == true) {
                        //     ispopupallow = true;
                        //     notifyListeners();
                        //   } else if (ispopupshown2 == true) {
                        //     ispopupallow2 = true;
                        //     notifyListeners();
                        //   } else if (ispopupshown3 == true) {
                        //     ispopupallow3 = true;
                        //     notifyListeners();
                        //   } else if (ispopupshown4 == true) {
                        //     ispopupallow4 = true;
                        //     notifyListeners();
                        //   }

                        //   Navigator.pop(context);
                        // });
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () => Navigator.of(context).pop(false),
          //     child: Text("No"),
          //   ),
          //   TextButton(
          //       onPressed: () {
          //         exit(0);
          //       },
          //       child: Text("yes"))
          // ],
        );
      }),
    );
  }

  showpopdialogbundle(BuildContext context, int? bundleId) async {
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setst) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text("Are you sure?"),
          // content: Text("Do you want to exit?"),
          content: Container(
            width: Screens.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            // fontSize: 12,
                            ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )), //Radius.circular(6)
                      ),
                      child: Text("Alert", style: TextStyle(fontSize: 15))),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                Container(
                    padding: EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: Divider(
                      color: Colors.grey,
                    )),
                Container(
                    alignment: Alignment.center,
                    // width: Screens.width(context)*0.5,
                    // padding: EdgeInsets.only(left:20),
                    child: Text(
                      "Removing this item will also remove the other items in the bundle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                Container(
                    alignment: Alignment.center,
                    // padding: EdgeInsets.only(left:20),
                    child: Text("Do you want to continue?",
                        style: TextStyle(fontSize: 15))),
                Container(
                    padding: EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: Divider(color: Colors.grey)),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.47,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: theme.primaryColor,
                            textStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                            )),
                          ),
                          onPressed: () {
                            //  exit(0);
                            setst(() {
                              clearbundle(bundleId, context);
                            });
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Container(
                      width: Screens.width(context) * 0.47,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: theme.primaryColor,
                            textStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10),
                            )),
                          ),
                          onPressed: () {
                            setst(() {
                              Navigator.pop(context);
                            });
                            // context.read<EnquiryUserContoller>().checkDialogCon();
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () => Navigator.of(context).pop(false),
          //     child: Text("No"),
          //   ),
          //   TextButton(
          //       onPressed: () {
          //         exit(0);
          //       },
          //       child: Text("yes"))
          // ],
        );
      }),
    );
  }

  String? taxRate;
  String? taxCode;
// int linenum=0;
  showpopdialog(BuildContext context, String? Textheading) async {
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setst) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text("Are you sure?"),
          // content: Text("Do you want to exit?"),
          content: Container(
            width: Screens.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            // fontSize: 12,
                            ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )), //Radius.circular(6)
                      ),
                      child: Text("Alert", style: TextStyle(fontSize: 15))),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                Container(
                    padding: EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: Divider(
                      color: Colors.grey,
                    )),
                Container(
                    alignment: Alignment.center,
                    // width: Screens.width(context)*0.5,
                    // padding: EdgeInsets.only(left:20),
                    child: Text(
                      "$Textheading",
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                Container(
                    alignment: Alignment.center,
                    // padding: EdgeInsets.only(left:20),
                    child: Text("Do you want to continue?",
                        style: TextStyle(fontSize: 15))),
                Container(
                    padding: EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: Divider(color: Colors.grey)),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.47,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: theme.primaryColor,
                            textStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                            )),
                          ),
                          onPressed: () {
                            //  exit(0);
                            setst(() {
                              if (ispopupshown == true) {
                                ispopupallow = true;
                                notifyListeners();
                              } else if (ispopupshown2 == true) {
                                ispopupallow2 = true;
                                notifyListeners();
                              } else if (ispopupshown3 == true) {
                                ispopupallow3 = true;
                                notifyListeners();
                              } else if (ispopupshown4 == true) {
                                ispopupallow4 = true;
                                notifyListeners();
                              }

                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Container(
                      width: Screens.width(context) * 0.47,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: theme.primaryColor,
                            textStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10),
                            )),
                          ),
                          onPressed: () {
                            setst(() {
                              if (ispopupshown == true) {
                                ispopupallow = false;
                                notifyListeners();
                              } else if (ispopupshown2 == true) {
                                ispopupallow2 = false;
                                notifyListeners();
                              } else if (ispopupshown3 == true) {
                                ispopupallow3 = false;
                                notifyListeners();
                              } else if (ispopupshown4 == true) {
                                ispopupallow4 = false;
                                notifyListeners();
                              }

                              Navigator.pop(context);
                            });
                            // context.read<EnquiryUserContoller>().checkDialogCon();
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () => Navigator.of(context).pop(false),
          //     child: Text("No"),
          //   ),
          //   TextButton(
          //       onPressed: () {
          //         exit(0);
          //       },
          //       child: Text("yes"))
          // ],
        );
      }),
    );
  }

  bool ispopupshown = false;
  bool ispopupshown2 = false;
  bool ispopupshown3 = false;
  bool ispopupshown4 = false;
  bool ispopupallow = false;
  bool ispopupallow2 = false;
  bool ispopupallow3 = false;
  bool ispopupallow4 = false;
  bool ispopupfinal1 = false;
  bool ispopupfinal2 = false;
  bool ispopupfinal3 = false;
  bool ispopupfinal4 = false;
  List<giftoffers> finalgiftlist = [];
//  List<giftoffers> tempGiftList = [];
  List<giftoffers> modifyfinalgiftlist = [];

  deepCopyGiftList(List<giftoffers> originalList) {
    return originalList
        .map((gift) => giftoffers(
            itemtype: gift.itemtype,
            GiftQty: gift.GiftQty,
            OfferSetup_Id: gift.OfferSetup_Id,
            ItemCode: gift.ItemCode,
            Attach_Qty: gift.Attach_Qty,
            BasicPrice: gift.BasicPrice,
            ItemName: gift.ItemName,
            MRP: gift.MRP,
            Price: gift.Price,
            SP: gift.SP,
            TaxAmt_PerUnit: gift.TaxAmt_PerUnit,
            TaxRate: gift.TaxRate,
            quantity: gift.quantity))
        .toList();
  }

  deepCopyGiftList2(List<giftoffers> originalList) {
    return originalList
        .map((gift) => giftoffers(
            itemtype: gift.itemtype,
            GiftQty: gift.GiftQty,
            OfferSetup_Id: gift.OfferSetup_Id,
            ItemCode: gift.ItemCode,
            Attach_Qty: gift.Attach_Qty,
            BasicPrice: gift.BasicPrice,
            ItemName: gift.ItemName,
            MRP: gift.MRP,
            Price: gift.Price,
            SP: gift.SP,
            TaxAmt_PerUnit: gift.TaxAmt_PerUnit,
            TaxRate: gift.TaxRate,
            quantity: gift.quantity))
        .toList();
  }

  List<OrderPricecheckData> orderpricecheckData = [];
  bool pricecheckloading = false;
  String? pricecheckerror = '';
  callPricecheckApi(
    String? itemcode,
    int? quantity,
    double? unitprice,
    String? couponcode,
    BuildContext context,
    ThemeData theme,
    int i,
    bool addproduct,
    ItemMasterDBModel updateallProductDetails,
  ) async {
    orderpricecheckData.clear();
    pricecheckloading = true;
    pricecheckerror = '';
    await OrderPricecheckApi.getData(itemcode, quantity, unitprice, couponcode)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("Step 3" + value.Ordercheckdatageader.toString());

        if (value.itemdata!.childdata != null &&
            value.itemdata!.childdata!.isNotEmpty) {
          log("not null");

          orderpricecheckData = value.itemdata!.childdata!;
          if (orderpricecheckData[0].validity == 'valid') {
            if (ConstantValues.ordergiftlogic!.toLowerCase() == 'y') {
              callgiftApi(
                  itemcode.toString(),
                  int.parse(mycontroller[11].text),
                  double.parse(mycontroller[10].text),
                  context,
                  i,
                  theme,
                  addproduct,
                  allProductDetails[i]);
            } else {
              if (addproduct == true) {
                mycontroller[12].clear();
                addProductDetails(context, allProductDetails[i], false, null);
                notifyListeners();
              } else if (addproduct == false) {
                updateProductDetails(context, i, updateallProductDetails);
                notifyListeners();
              }
            }
          } else {
            showpopdialogunitprice(
                context,
                "Price cannot be deviated from your allowed Limit. Required Special Pricing Approval to Proceed..!!",
                '');
            notifyListeners();
          }
          // showgiftitems(context, i, theme, addproduct, updateallProductDetails);
          pricecheckloading = false;
          pricecheckerror = '';
          notifyListeners();
        } else if (value.itemdata!.childdata == null ||
            value.itemdata!.childdata!.isEmpty) {
          log("Order data null");
          pricecheckloading = false;
          pricecheckerror = 'No data in CheckPriceValidity..!!';
          showpopdialogunitprice(context, "$pricecheckerror", '');
          // gifterror = 'No data..!!';
          // if (addproduct == true) {
          //   mycontroller[12].clear();
          //   addProductDetails(context, allProductDetails[i]);
          //   notifyListeners();
          // } else if (addproduct == false) {
          //   updateProductDetails(context, i, updateallProductDetails);
          // }
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        pricecheckloading = false;
        pricecheckerror = '${value.message}..!!${value.exception}....!!';
        showpopdialogunitprice(context, "$pricecheckerror", '');
        // if (addproduct == true) {
        //   mycontroller[12].clear();
        //   addProductDetails(context, allProductDetails[i]);
        //   notifyListeners();
        // } else if (addproduct == false) {
        //   updateProductDetails(context, i, updateallProductDetails);
        // }

        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          pricecheckloading = false;
          pricecheckerror =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          showpopdialogunitprice(context, "$pricecheckerror", '');
          // if (addproduct == true) {
          //   mycontroller[12].clear();
          //   addProductDetails(context, allProductDetails[i]);
          //   notifyListeners();
          // } else if (addproduct == false) {
          //   updateProductDetails(context, i, updateallProductDetails);
          // }

          notifyListeners();
        } else {
          pricecheckloading = false;
          pricecheckerror =
              '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
          showpopdialogunitprice(context, "$pricecheckerror", '');
          // if (addproduct == true) {
          //   mycontroller[12].clear();
          //   addProductDetails(context, allProductDetails[i]);
          //   notifyListeners();
          // } else if (addproduct == false) {
          //   updateProductDetails(context, i, updateallProductDetails);
          // }

          notifyListeners();
        }

        notifyListeners();
      }
    });
  }

  List<Bundleheadlist> Bundleheaddetails = [];
  List<BundleItemlist> BundleItemdetails = [];
  List<Bundlestorelist> Bundlestoredetails = [];
  bool isBundleloading = false;
  String? Bundleerror = '';
  callbundleApi(BuildContext context, int? id, bool addproduct, int i,
      ItemMasterDBModel updateallProductDetails) async {
    Bundleheaddetails.clear();
    BundleItemdetails.clear();
    Bundlestoredetails.clear();
    isBundleloading = true;
    Bundleerror = '';
    await OrderbundleApi.getData(id).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("Step 3" + value.Ordercheckdatageader.toString());

        if (value.itemdata!.BundleItemdetails != null &&
            value.itemdata!.BundleItemdetails!.isNotEmpty) {
          log("not null");
          Bundleheaddetails = value.itemdata!.Bundleheaddetails!;
          BundleItemdetails = value.itemdata!.BundleItemdetails!;
          Bundlestoredetails = value.itemdata!.Bundlestoredetails!;
          isBundleloading = false;
          Bundleerror = '';
          if (addproduct == true) {
            mycontroller[12].clear();
            log("id::" + id.toString());
            addProductDetails(context, allProductDetails[i], true, id);
            notifyListeners();
          } else if (addproduct == false) {
            updateProductDetails(context, i, updateallProductDetails);
          }
          notifyListeners();
        } else if (value.itemdata!.BundleItemdetails == null ||
            value.itemdata!.BundleItemdetails!.isEmpty) {
          log("Order data null");
          isBundleloading = false;
          Bundleerror = 'No data in Bundle..!!';
          showpopdialogunitprice(context, "$Bundleerror", '');
          // if (addproduct == true) {
          //   mycontroller[12].clear();
          //   addProductDetails(context, allProductDetails[i]);
          //   notifyListeners();
          // } else if (addproduct == false) {
          //   updateProductDetails(context, i, updateallProductDetails);
          // }
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isBundleloading = false;
        Bundleerror = '${value.message}..!!${value.exception}....!!';
        showpopdialogunitprice(context, "$Bundleerror", '');
        // if (addproduct == true) {
        //   mycontroller[12].clear();
        //   addProductDetails(context, allProductDetails[i]);
        //   notifyListeners();
        // } else if (addproduct == false) {
        //   updateProductDetails(context, i, updateallProductDetails);
        // }

        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isBundleloading = false;
          Bundleerror =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          showpopdialogunitprice(context, "$Bundleerror", '');
          // if (addproduct == true) {
          //   mycontroller[12].clear();
          //   addProductDetails(context, allProductDetails[i]);
          //   notifyListeners();
          // } else if (addproduct == false) {
          //   updateProductDetails(context, i, updateallProductDetails);
          // }

          notifyListeners();
        } else {
          isBundleloading = false;
          Bundleerror =
              '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
          // if (addproduct == true) {
          //   mycontroller[12].clear();
          //   addProductDetails(context, allProductDetails[i]);
          //   notifyListeners();
          // } else if (addproduct == false) {
          //   updateProductDetails(context, i, updateallProductDetails);
          // }

          notifyListeners();
        }

        notifyListeners();
      }
    });
  }

  List<LinkeditemsData> linkedItemsdata = [];
  List<LinkeditemsData> linkedItemsdatacheck = [];
  bool LinkedItemsloading = false;
  String? LinkedItemserror = '';
  int? Linked;
  resetrelateditems() {
    Linked = null;
    linkedItemsdata.clear();
    LinkedItemsloading = true;
    LinkedItemserror = '';
    notifyListeners();
  }

  onselectlinked(BuildContext context, int? linkindex) {
// linkedItemsdata[linkindex!].linkedItemcode
    changeVisible2();
    bool isboolchecked = false;
    int? index;
    isboolchecked = false;
    for (int i = 0; i < allProductDetails.length; i++) {
      if (allProductDetails[i].itemCode ==
          linkedItemsdata[linkindex!].linkedItemcode) {
        isboolchecked = true;
        index = i;
        break;
      }
    }
    if (isboolchecked) {
      Navigator.pop(context);
      resetItems(index!);
      showBottomSheetInsert(context, index!);
      notifyListeners();
    } else {
      Navigator.pop(context);
      showtoastforscanning();
      notifyListeners();
    }
  }

  bool finallinkload = false;
  calllinkedheader(int index) async {
    log("productDetails[index].ItemCode::"+productDetails[index].ItemCode.toString());
    finallinkload = true;
    await calllinkedApi(productDetails[index].ItemCode.toString());
    notifyListeners();
    if (productDetails[index].giftitems !=null&& productDetails[index].giftitems!.isNotEmpty) {
      for (int i = 0; i < productDetails[index].giftitems!.length; i++) {
        await calllinkedApi(
            productDetails[index].giftitems![i].ItemCode.toString());
      }
      finallinkload = false;
      notifyListeners();
    }
    finallinkload = false;
    notifyListeners();
  }

  calllinkedApi22(
    String? itemcode,
  ) async {
    // linkedItemsdata.clear();
    // linkedItemsdatacheck=[];
    // LinkedItemsloading = true;
    // LinkedItemserror = '';
    await LinkeditemsApi.getData(
      itemcode,
    ).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("Step 3" + value.Ordercheckdatageader.toString());

        if (value.itemdata!.childdata != null &&
            value.itemdata!.childdata!.isNotEmpty) {
          log("not null");

          linkedItemsdatacheck = value.itemdata!.childdata!;

          // LinkedItemsloading = false;
          // LinkedItemserror = '';
          notifyListeners();
        } else if (value.itemdata!.childdata == null ||
            value.itemdata!.childdata!.isEmpty) {
          log("Order data null");
          // LinkedItemsloading = false;
          // LinkedItemserror = 'No related Items for this selected item..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // LinkedItemsloading = false;
        // LinkedItemserror = '${value.message}..!!${value.exception}....!!';

        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          // LinkedItemsloading = false;
          // LinkedItemserror =
          //     '${value.stcode!}..!!Network Issue..\nTry again Later..!!';

          notifyListeners();
        } else {
          // LinkedItemsloading = false;
          // LinkedItemserror =
          //     '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';

          notifyListeners();
        }

        notifyListeners();
      }
    });
  }

  calllinkedApi(
    String? itemcode,
  ) async {
    // linkedItemsdata.clear();
    LinkedItemsloading = true;
    LinkedItemserror = '';
    await LinkeditemsApi.getData(
      itemcode,
    ).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("Step 3" + value.Ordercheckdatageader.toString());

        if (value.itemdata!.childdata != null &&
            value.itemdata!.childdata!.isNotEmpty) {
          log("not null");

          linkedItemsdata = value.itemdata!.childdata!;

          LinkedItemsloading = false;
          LinkedItemserror = '';
          notifyListeners();
        } else if (value.itemdata!.childdata == null ||
            value.itemdata!.childdata!.isEmpty) {
          log("Order data null");
          LinkedItemsloading = false;
          LinkedItemserror = 'No related Items..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        LinkedItemsloading = false;
        LinkedItemserror = '${value.message}..!!${value.exception}....!!';

        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          LinkedItemsloading = false;
          LinkedItemserror =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';

          notifyListeners();
        } else {
          LinkedItemsloading = false;
          LinkedItemserror =
              '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';

          notifyListeners();
        }

        notifyListeners();
      }
    });
  }

  List<ParticularpriceData> Particularprice = [];

  List<OrdergiftData> ordergiftData = [];
  bool isgiftloading = false;
  String? gifterror = '';
  callgiftApi(
      String? itemcode,
      int? quantity,
      double? unitprice,
      BuildContext context,
      int i,
      ThemeData theme,
      bool addproduct,
      ItemMasterDBModel updateallProductDetails) async {
    ordergiftData.clear();
    isgiftloading = true;
    await OrdergiftDetailsApi.getData(itemcode, quantity, unitprice)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("Step 3" + value.Ordercheckdatageader.toString());

        if (value.itemdata!.childdata != null &&
            value.itemdata!.childdata!.isNotEmpty) {
          log("not null");

          ordergiftData = value.itemdata!.childdata!;
          showgiftitems(context, i, theme, addproduct, updateallProductDetails);
          isgiftloading = false;
          gifterror = '';
          notifyListeners();
        } else if (value.itemdata!.childdata == null ||
            value.itemdata!.childdata!.isEmpty) {
          log("Order data null");
          isgiftloading = false;
          gifterror = 'No data..!!';
          if (addproduct == true) {
            mycontroller[12].clear();
            addProductDetails(context, allProductDetails[i], false, null);
            notifyListeners();
          } else if (addproduct == false) {
            updateProductDetails(context, i, updateallProductDetails);
          }
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isgiftloading = false;
        gifterror = '${value.message}..!!${value.exception}....!!';
        if (addproduct == true) {
          mycontroller[12].clear();
          addProductDetails(context, allProductDetails[i], false, null);
          notifyListeners();
        } else if (addproduct == false) {
          updateProductDetails(context, i, updateallProductDetails);
        }

        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          isgiftloading = false;
          gifterror =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          if (addproduct == true) {
            mycontroller[12].clear();
            addProductDetails(context, allProductDetails[i], false, null);
            notifyListeners();
          } else if (addproduct == false) {
            updateProductDetails(context, i, updateallProductDetails);
          }

          notifyListeners();
        } else {
          isgiftloading = false;
          gifterror =
              '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
          if (addproduct == true) {
            mycontroller[12].clear();
            addProductDetails(context, allProductDetails[i], false, null);
            notifyListeners();
          } else if (addproduct == false) {
            updateProductDetails(context, i, updateallProductDetails);
          }

          notifyListeners();
        }

        notifyListeners();
      }
    });
  }

  getlinetotalgift(int index) {
    double linetotalgift = 0.00;
    double finallinetotal = 0.00;
    if (productDetails[index].giftitems != null &&
        productDetails[index].giftitems!.isNotEmpty) {
      for (int ij = 0; ij < productDetails[index].giftitems!.length; ij++) {
        linetotalgift = linetotalgift +
            (productDetails[index].giftitems![ij].quantity! *
                productDetails[index].giftitems![ij].Price!);
      }
    }
    linetotalgift = linetotalgift + getProduct[index].LineTotal!;
    return linetotalgift.toString();
  }

  clearbundle(int? bundleid, BuildContext context) async {
    log("bundleiddelete" + productDetails.length.toString());
    for (int i = productDetails.length - 1; i >= 0; i--) {
      log("bundleiddelete" +
          productDetails[i].ItemCode.toString() +
          "::sss" +
          productDetails[i].bundleId.toString());
      if (productDetails[i].bundleId == bundleid) {
        productDetails.removeAt(i);
      }
      notifyListeners();
    }
    notifyListeners();
    Navigator.pop(context);
  }

  addProductDetails(
      BuildContext context,
      ItemMasterDBModel addallProductDetails,
      bool isbundle,
      int? bundleid) async {
    log("sellect" + addallProductDetails.mgrPrice.toString());
    log("sellect" + addallProductDetails.slpPrice.toString());
    log("unitPrice" + unitPrice.toString());
    log("sellect" + productDetails.length.toString());
    // changeVisible2();
    if (formkey[1].currentState!.validate()) {
      deletevaluebased();
      finalgiftlist.clear();
      for (int i = 0; i < ordergiftData.length; i++) {
        if (int.parse(ordergiftData[i].quantity.toString()) > 0) {
          finalgiftlist.add(giftoffers(
              itemtype: "G",
              GiftQty: ordergiftData[i].GiftQty,
              OfferSetup_Id: ordergiftData[i].OfferSetup_Id,
              ItemCode: ordergiftData[i].ItemCode,
              Attach_Qty: ordergiftData[i].Attach_Qty,
              BasicPrice: ordergiftData[i].BasicPrice,
              ItemName: ordergiftData[i].ItemName,
              MRP: ordergiftData[i].MRP,
              Price: ordergiftData[i].Price,
              SP: ordergiftData[i].SP,
              TaxAmt_PerUnit: ordergiftData[i].TaxAmt_PerUnit,
              TaxRate: ordergiftData[i].TaxRate,
              quantity: ordergiftData[i].quantity));
          notifyListeners();
        }
      }
      ispopupshown = false;
      ispopupshown2 = false;
      ispopupshown3 = false;
      ispopupshown4 = false;
      ispopupallow = false;
      ispopupallow2 = false;
      ispopupallow3 = false;
      ispopupallow4 = false;
      ispopupfinal1 = false;
      ispopupfinal2 = false;
      ispopupfinal3 = false;
      ispopupfinal4 = false;
      notifyListeners();
      if (unitPrice! > addallProductDetails.mgrPrice!) {
        ispopupshown = true;
        ispopupshown2 = false;
        ispopupshown3 = false;
        ispopupshown4 = false;
        ispopupfinal1 = true;
        notifyListeners();
        await showpopdialog(context, "Entered price is greater than MRP");
      }
      if (unitPrice! < addallProductDetails.slpPrice!) {
        ispopupshown = false;

        ispopupshown3 = false;
        ispopupshown4 = false;
        ispopupshown2 = true;
        ispopupfinal2 = true;
        notifyListeners();
        await showpopdialog(context, "Entered price is less than Cost");
      }
      if (isselected[0] == true) {
        if (quantity! > addallProductDetails.storeStock!) {
          ispopupshown = false;
          ispopupshown2 = false;
          ispopupshown4 = false;
          ispopupshown3 = true;
          ispopupfinal3 = true;
          notifyListeners();
          await showpopdialog(
              context, "Entered quantity is greater than Storestock");
        }
      } else {
        if (quantity! > addallProductDetails.whsStock!) {
          ispopupshown4 = true;
          ispopupshown = false;
          ispopupshown2 = false;
          ispopupshown3 = false;
          ispopupfinal4 = true;
          notifyListeners();
          await showpopdialog(
              context, "Entered quantity is greater than Whsestock");
        }
      }
      if (ispopupfinal1 == false &&
          ispopupfinal2 == false &&
          ispopupfinal3 == false &&
          ispopupfinal4 == false) {
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
        } else {
          log("finalgiftlist::" + finalgiftlist.length.toString());
          for (int iy = 0; iy < finalgiftlist.length; iy++) {
            await calllinkedApi22(finalgiftlist[iy].ItemCode);
          }
          var giftListCopy = deepCopyGiftList(finalgiftlist);

          if (isbundle == true) {
            log("bundleid::" + bundleid.toString());
            for (int ib = 0; ib < BundleItemdetails.length; ib++) {
              await calllinkedApi22(BundleItemdetails[ib].ItemCode);
              for (int ij = 0; ij < allProductDetails.length; ij++) {
                // log("allProductDetails[ij].itemCode::" +
                //     allProductDetails[ij].itemCode.toString());

                // log("selectedItemCode::" + selectedItemCode.toString());
                if (allProductDetails[ij].itemCode ==
                    BundleItemdetails[ib].ItemCode) {
                  taxvalue =
                      double.parse(allProductDetails[ij].taxRate.toString());
                  slppriceorder = allProductDetails[ij].slpPrice == null
                      ? 0.0
                      : double.parse(allProductDetails[ij].slpPrice.toString());
                  storestockorder = allProductDetails[ij].storeStock == null
                      ? 0.0
                      : double.parse(
                          allProductDetails[ij].storeStock.toString());
                  whsestockorder = allProductDetails[ij].whsStock == null
                      ? 0.0
                      : double.parse(allProductDetails[ij].whsStock.toString());
                  isfixedpriceorder = allProductDetails[ij].isFixedPrice;
                  allownegativestockorder =
                      allProductDetails[ij].allowNegativeStock;
                  alloworderbelowcostorder =
                      allProductDetails[ij].allowOrderBelowCost;
                  break;
                }
              }
              productDetails.add(DocumentLines(
                  bundleId: bundleid,
                  itemtype: 'B',
                  OfferSetup_Id: null,
                  id: 0,
                  docEntry: 0,
                  linenum: 0,
                  ItemCode: BundleItemdetails[ib].ItemCode,
                  ItemDescription: BundleItemdetails[ib].ItemName,
                  Quantity: BundleItemdetails[ib].Quantity,
                  LineTotal: BundleItemdetails[ib].LineTotal,
                  Price: BundleItemdetails[ib].Price,
                  TaxCode: taxvalue,
                  TaxLiable: "tNO",
                  linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                  storecode: ConstantValues.Storecode,
                  deliveryfrom: isselected[0] == true ? "store" : "Whse",
                  sp: sporder,
                  slpprice: slppriceorder,
                  storestock: storestockorder,
                  whsestock: whsestockorder,
                  isfixedprice: isfixedpriceorder,
                  allownegativestock: allownegativestockorder,
                  alloworderbelowcost: alloworderbelowcostorder,
                  complementary: assignvalue,
                  couponcode: mycontroller[36].text == null ||
                          mycontroller[36].text.isEmpty
                      ? null
                      : mycontroller[36].text,
                  partcode:
                      selectedapartcode == null || selectedapartcode.isEmpty
                          ? null
                          : selectedapartcode,
                  partname:
                      selectedapartname == null || selectedapartname.isEmpty
                          ? null
                          : selectedapartname,
                  giftitems: giftListCopy));
            }
          } else if (isbundle == false) {
            await calllinkedApi22(selectedItemCode);

            productDetails.add(DocumentLines(
                bundleId: null,
                itemtype: 'R',
                OfferSetup_Id: null,
                id: 0,
                docEntry: 0,
                linenum: 0,
                linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                ItemCode: selectedItemCode,
                ItemDescription: selectedItemName,
                Quantity: quantity,
                LineTotal: total,
                Price: unitPrice,
                TaxCode: taxvalue,
                TaxLiable: "tNO",
                storecode: ConstantValues.Storecode,
                deliveryfrom: isselected[0] == true ? "store" : "Whse",
                sp: sporder,
                slpprice: slppriceorder,
                storestock: storestockorder,
                whsestock: whsestockorder,
                isfixedprice: isfixedpriceorder,
                allownegativestock: allownegativestockorder,
                alloworderbelowcost: alloworderbelowcostorder,
                complementary: assignvalue,
                couponcode: mycontroller[36].text == null ||
                        mycontroller[36].text.isEmpty
                    ? null
                    : mycontroller[36].text,
                partcode: selectedapartcode == null || selectedapartcode.isEmpty
                    ? null
                    : selectedapartcode,
                partname: selectedapartname == null || selectedapartname.isEmpty
                    ? null
                    : selectedapartname,
                giftitems: giftListCopy));
          }

          showItemList = false;
          mycontroller[12].clear();
          Navigator.pop(context);

          isUpdateClicked = false;
          postpaymentdata.clear();
          deletepaymode2();
          notifyListeners();
        }
      } else {
        log("ispopupallow3::" + ispopupallow3.toString());
        if (ispopupfinal1 == true && ispopupallow == false) {
          log("error occured in popupshown1");
        } else if (ispopupfinal2 == true && ispopupallow2 == false) {
          log("error occured in popupshown2");
        } else if (ispopupfinal3 == true && ispopupallow3 == false) {
          log("error occured in popupshown3");
        } else if (ispopupfinal4 == true && ispopupallow4 == false) {
          log("error occured in popupshown4");
        } else {
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
          } else {
            var giftListCopy = deepCopyGiftList(finalgiftlist);
            if (isbundle == true) {
              log("bundleid::" + bundleid.toString());
              for (int ib = 0; ib < BundleItemdetails.length; ib++) {
                await calllinkedApi22(BundleItemdetails[ib].ItemCode);
                for (int ij = 0; ij < allProductDetails.length; ij++) {
                  // log("allProductDetails[ij].itemCode::" +
                  //     allProductDetails[ij].itemCode.toString());

                  // log("selectedItemCode::" + selectedItemCode.toString());
                  if (allProductDetails[ij].itemCode ==
                      BundleItemdetails[ib].ItemCode) {
                    taxvalue =
                        double.parse(allProductDetails[ij].taxRate.toString());
                    slppriceorder = allProductDetails[ij].slpPrice == null
                        ? 0.0
                        : double.parse(
                            allProductDetails[ij].slpPrice.toString());
                    storestockorder = allProductDetails[ij].storeStock == null
                        ? 0.0
                        : double.parse(
                            allProductDetails[ij].storeStock.toString());
                    whsestockorder = allProductDetails[ij].whsStock == null
                        ? 0.0
                        : double.parse(
                            allProductDetails[ij].whsStock.toString());
                    isfixedpriceorder = allProductDetails[ij].isFixedPrice;
                    allownegativestockorder =
                        allProductDetails[ij].allowNegativeStock;
                    alloworderbelowcostorder =
                        allProductDetails[ij].allowOrderBelowCost;
                    break;
                  }
                }
                productDetails.add(DocumentLines(
                    bundleId: bundleid,
                    itemtype: 'B',
                    OfferSetup_Id: null,
                    id: 0,
                    docEntry: 0,
                    linenum: 0,
                    ItemCode: BundleItemdetails[ib].ItemCode,
                    ItemDescription: BundleItemdetails[ib].ItemName,
                    Quantity: BundleItemdetails[ib].Quantity,
                    LineTotal: BundleItemdetails[ib].LineTotal,
                    Price: BundleItemdetails[ib].Price,
                    linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                    TaxCode: taxvalue,
                    TaxLiable: "tNO",
                    storecode: ConstantValues.Storecode,
                    deliveryfrom: isselected[0] == true ? "store" : "Whse",
                    sp: sporder,
                    slpprice: slppriceorder,
                    storestock: storestockorder,
                    whsestock: whsestockorder,
                    isfixedprice: isfixedpriceorder,
                    allownegativestock: allownegativestockorder,
                    alloworderbelowcost: alloworderbelowcostorder,
                    complementary: assignvalue,
                    couponcode: mycontroller[36].text == null ||
                            mycontroller[36].text.isEmpty
                        ? null
                        : mycontroller[36].text,
                    partcode:
                        selectedapartcode == null || selectedapartcode.isEmpty
                            ? null
                            : selectedapartcode,
                    partname:
                        selectedapartname == null || selectedapartname.isEmpty
                            ? null
                            : selectedapartname,
                    giftitems: giftListCopy));
              }
            } else if (isbundle == false) {
              await calllinkedApi22(selectedItemCode);
              productDetails.add(DocumentLines(
                  bundleId: null,
                  itemtype: 'R',
                  OfferSetup_Id: null,
                  id: 0,
                  docEntry: 0,
                  linenum: 0,
                  linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                  ItemCode: selectedItemCode,
                  ItemDescription: selectedItemName,
                  Quantity: quantity,
                  LineTotal: total,
                  Price: unitPrice,
                  TaxCode: taxvalue,
                  TaxLiable: "tNO",
                  storecode: ConstantValues.Storecode,
                  deliveryfrom: isselected[0] == true ? "store" : "Whse",
                  sp: sporder,
                  slpprice: slppriceorder,
                  storestock: storestockorder,
                  whsestock: whsestockorder,
                  isfixedprice: isfixedpriceorder,
                  allownegativestock: allownegativestockorder,
                  alloworderbelowcost: alloworderbelowcostorder,
                  complementary: assignvalue,
                  couponcode: mycontroller[36].text == null ||
                          mycontroller[36].text.isEmpty
                      ? null
                      : mycontroller[36].text,
                  partcode:
                      selectedapartcode == null || selectedapartcode.isEmpty
                          ? null
                          : selectedapartcode,
                  partname:
                      selectedapartname == null || selectedapartname.isEmpty
                          ? null
                          : selectedapartname,
                  giftitems: giftListCopy));
            }

            showItemList = false;
            mycontroller[12].clear();
            Navigator.pop(context);
            postpaymentdata.clear();
            deletepaymode2();
            isUpdateClicked = false;

            notifyListeners();
          }
        }
      }
    }
    // for(int i=0;i<productDetails.length;i++){
    //   log("hhhhh::"+productDetails[i].giftitems![0].name.toString());
    // }
  }

  addfinalproduct(BuildContext context) {
    productDetails.add(DocumentLines(
        bundleId: null,
        itemtype: 'R',
        OfferSetup_Id: null,
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
        storecode: ConstantValues.Storecode,
        deliveryfrom: isselected[0] == true ? "store" : "Whse",
        sp: sporder,
        slpprice: slppriceorder,
        storestock: storestockorder,
        whsestock: whsestockorder,
        isfixedprice: isfixedpriceorder,
        allownegativestock: allownegativestockorder,
        alloworderbelowcost: alloworderbelowcostorder,
        complementary: assignvalue));
    showItemList = false;
    // mycontroller[12].clear();

    isUpdateClicked = false;
    Navigator.pop(context);

    notifyListeners();
  }

  showComplementry(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, st) {
              return Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Complementry Items",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.primaryColor),
                    ),
                    // if(){

                    // }else{

                    // }
                    iscomplement == false
                        ? Container()
                        : Container(
                            child: Text("* Select Complementary",
                                style: TextStyle(color: Colors.red)),
                          ),
                    Container(
                      height: Screens.padingHeight(context) * 0.3,
                      width: Screens.width(context),
                      child: SingleChildScrollView(
                        child: ListBody(
                            children: allProductDetails
                                .take(10)
                                .map((item) => CheckboxListTile(
                                      value: selectedassignto
                                          .contains(item.itemCode),
                                      title: Text(item.itemCode.toString()),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (ischecked) => st(() {
                                        itemselectassignto(
                                            item.itemCode.toString(),
                                            ischecked!);
                                      }),
                                    ))
                                .toList()),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            if (assignvalue == null || assignvalue!.isEmpty) {
                              st(() {
                                iscomplement = true;
                              });
                            }
                            st(() {
                              addfinalproduct(context);
                            });
                          },
                          child: Text("save")),
                    )
                  ],
                ),
              );
            }));
  }

  splitcomplement(String products) {
    List<String> productList =
        products.split(',').map((item) => item.trim()).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('* ${productList[index]}', style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 5,
            )
          ],
        );
      },
    );
  }

  bool iscomplement = false;
  String? assignvalue;
  itemselectassignto(String itemvalue, bool isselected) {
    assignvalue = '';
    if (isselected) {
      selectedassignto.add(itemvalue);
    } else {
      selectedassignto.remove(itemvalue);
    }
    assignvalue = selectedassignto.join(', ');
    log("selectedassignto::" + selectedassignto.toString());
    log("assignvalue::" + assignvalue.toString());
    notifyListeners();
  }

  List<String> selectedassignto = [];
  updateProductDetails(
      BuildContext context, int i, ItemMasterDBModel allProductDetails) async {
    if (formkey[1].currentState!.validate()) {
     
      finalgiftlist.clear();
      for (int i = 0; i < ordergiftData.length; i++) {
        if (int.parse(ordergiftData[i].quantity.toString()) > 0) {
          finalgiftlist.add(giftoffers(
              itemtype: 'G',
              GiftQty: ordergiftData[i].GiftQty,
              OfferSetup_Id: ordergiftData[i].OfferSetup_Id,
              ItemCode: ordergiftData[i].ItemCode,
              Attach_Qty: ordergiftData[i].Attach_Qty,
              BasicPrice: ordergiftData[i].BasicPrice,
              ItemName: ordergiftData[i].ItemName,
              MRP: ordergiftData[i].MRP,
              Price: ordergiftData[i].Price,
              SP: ordergiftData[i].SP,
              TaxAmt_PerUnit: ordergiftData[i].TaxAmt_PerUnit,
              TaxRate: ordergiftData[i].TaxRate,
              quantity: ordergiftData[i].quantity));
          notifyListeners();
        }
      }
      ispopupshown = false;
      ispopupshown2 = false;
      ispopupshown3 = false;
      ispopupshown4 = false;
      ispopupallow = false;
      ispopupallow2 = false;
      ispopupallow3 = false;
      ispopupallow4 = false;
      ispopupfinal1 = false;
      ispopupfinal2 = false;
      ispopupfinal3 = false;
      ispopupfinal4 = false;
      notifyListeners();
      if (unitPrice! > allProductDetails.mgrPrice!) {
        ispopupshown = true;
        ispopupshown2 = false;
        ispopupshown3 = false;
        ispopupshown4 = false;
        ispopupfinal1 = true;
        notifyListeners();
        await showpopdialog(context, "Entered price is greater than MRP");
      }
      if (unitPrice! < allProductDetails.slpPrice!) {
        ispopupshown2 = true;
        ispopupshown = false;
        ispopupshown3 = false;
        ispopupshown4 = false;
        ispopupfinal2 = true;
        notifyListeners();
        await showpopdialog(context, "Entered price is less than Cost");
      }
      if (isselected[0] == true) {
        if (quantity! > allProductDetails.storeStock!) {
          ispopupshown3 = true;
          ispopupshown = false;
          ispopupshown2 = false;
          ispopupshown4 = false;
          ispopupfinal3 = true;
          notifyListeners();
          await showpopdialog(
              context, "Entered quantity is greater than Storestock");
        }
      } else {
        if (quantity! > allProductDetails.whsStock!) {
          ispopupshown4 = true;
          ispopupshown = false;
          ispopupshown2 = false;
          ispopupshown3 = false;
          ispopupfinal4 = true;
          notifyListeners();
          await showpopdialog(
              context, "Entered quantity is greater than Whsestock");
        }
      }

      if (ispopupfinal1 == false &&
          ispopupfinal2 == false &&
          ispopupfinal3 == false &&
          ispopupfinal4 == false) {
        var giftListCopy = deepCopyGiftList(finalgiftlist);
        productDetails[i].Quantity = quantity;
        productDetails[i].Price = unitPrice;
        productDetails[i].LineTotal = total;
        productDetails[i].partcode =
            selectedapartcode == null || selectedapartcode.isEmpty
                ? productDetails[i].partcode
                : selectedapartcode;
        productDetails[i].partname =
            selectedapartname == null || selectedapartname.isEmpty
                ? productDetails[i].partname
                : selectedapartname;
        productDetails[i].couponcode =
            mycontroller[36].text == null || mycontroller[36].text.isEmpty
                ? productDetails[i].couponcode
                : mycontroller[36].text;
        productDetails[i].giftitems = giftListCopy;
        productDetails[i].deliveryfrom =
            isselected[0] == true ? "store" : "Whse";
        showItemList = false;
         deletevaluebased();
        Navigator.pop(context);
        postpaymentdata.clear();
        deletepaymode2();
        isUpdateClicked = false;
        notifyListeners();
      } else {
        log("ispopupallow3::" + ispopupallow3.toString());
        if (ispopupfinal1 == true && ispopupallow == false) {
          log("error occured in popupshown1");
        } else if (ispopupfinal2 == true && ispopupallow2 == false) {
          log("error occured in popupshown2");
        } else if (ispopupfinal3 == true && ispopupallow3 == false) {
          log("error occured in popupshown3");
        } else if (ispopupfinal4 == true && ispopupallow4 == false) {
          log("error occured in popupshown4");
        } else {
          var giftListCopy = deepCopyGiftList(finalgiftlist);
          productDetails[i].Quantity = quantity;
          productDetails[i].Price = unitPrice;
          productDetails[i].LineTotal = total;
          productDetails[i].partcode =
              selectedapartcode == null || selectedapartcode.isEmpty
                  ? productDetails[i].partcode
                  : selectedapartcode;
          productDetails[i].partname =
              selectedapartname == null || selectedapartname.isEmpty
                  ? productDetails[i].partname
                  : selectedapartname;
          productDetails[i].couponcode =
              mycontroller[36].text == null || mycontroller[36].text.isEmpty
                  ? productDetails[i].couponcode
                  : mycontroller[36].text;
          showItemList = false;
          productDetails[i].giftitems = giftListCopy;
          productDetails[i].deliveryfrom =
              isselected[0] == true ? "store" : "Whse";
               deletevaluebased();
          Navigator.pop(context);
          postpaymentdata.clear();
          deletepaymode2();
          isUpdateClicked = false;
          notifyListeners();
        }
      }
    }
  }

  List<GetCustomerData>? customerdetails;
  resetItems(int i) {
    linkedItemsdatacheck.clear();
    Bundleheaddetails.clear();
    BundleItemdetails.clear();
    Bundlestoredetails.clear();
    isBundleloading = false;
    Bundleerror = '';
    isselected = [true, false];
    orderpricecheckData.clear();
    ordergiftData.clear();
    isgiftloading = false;
    gifterror = '';
    unitPrice = 0.00;
    quantity = 0;
    total = 0.00;
    mycontroller[10].text = allProductDetails[i].sp!.toStringAsFixed(2);
    //.clear();

    mycontroller[11].clear();
    if (allProductDetails[i].Isbundle == true) {
      mycontroller[11].text = '1';
    }
    mycontroller[36].clear();
    mycontroller[48].clear();
    selectedapartcode = '';
    selectedapartname = '';
    assignvalue = null;
    iscomplement = false;
    selectedassignto.clear();
    getcoupondata.clear();
    couponload = false;
    ispopupshown = false;
    ispopupshown2 = false;
    ispopupshown3 = false;
    ispopupshown4 = false;
    ispopupallow = false;
    ispopupallow2 = false;
    ispopupallow3 = false;
    ispopupallow4 = false;
    ispopupfinal1 = false;
    ispopupfinal2 = false;
    ispopupfinal3 = false;
    ispopupfinal4 = false;

    isappliedcoupon = false;
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
  List<GetenquiryData> enquirydetails = [];
  List<GetenquiryData> leaddetails = [];
  List<GetenquiryData> quotationdetails = [];
  List<GetenquiryData> orderdetails = [];
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
            if (value.itemdata!.enquirydetails != null &&
                value.itemdata!.enquirydetails!.isNotEmpty) {
              // log("Anbulead");
              for (int i = 0; i < value.itemdata!.enquirydetails!.length; i++) {
                if (value.itemdata!.enquirydetails![i].DocType == "Lead") {
                  leaddetails!.add(GetenquiryData(
                      DocType: value.itemdata!.enquirydetails![i].DocType,
                      AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo,
                      BusinessValue:
                          value.itemdata!.enquirydetails![i].BusinessValue,
                      CurrentStatus:
                          value.itemdata!.enquirydetails![i].CurrentStatus,
                      DocDate: value.itemdata!.enquirydetails![i].DocDate,
                      DocNum: value.itemdata!.enquirydetails![i].DocNum,
                      Status: value.itemdata!.enquirydetails![i].Status,
                      Store: value.itemdata!.enquirydetails![i].Store));
                } else if (value.itemdata!.enquirydetails![i].DocType ==
                    "Enquiry") {
                  enquirydetails!.add(GetenquiryData(
                      DocType: value.itemdata!.enquirydetails![i].DocType,
                      AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo,
                      BusinessValue:
                          value.itemdata!.enquirydetails![i].BusinessValue,
                      CurrentStatus:
                          value.itemdata!.enquirydetails![i].CurrentStatus,
                      DocDate: value.itemdata!.enquirydetails![i].DocDate,
                      DocNum: value.itemdata!.enquirydetails![i].DocNum,
                      Status: value.itemdata!.enquirydetails![i].Status,
                      Store: value.itemdata!.enquirydetails![i].Store));
                } else if (value.itemdata!.enquirydetails![i].DocType ==
                    "Order") {
                  orderdetails!.add(GetenquiryData(
                      DocType: value.itemdata!.enquirydetails![i].DocType,
                      AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo,
                      BusinessValue:
                          value.itemdata!.enquirydetails![i].BusinessValue,
                      CurrentStatus:
                          value.itemdata!.enquirydetails![i].CurrentStatus,
                      DocDate: value.itemdata!.enquirydetails![i].DocDate,
                      DocNum: value.itemdata!.enquirydetails![i].DocNum,
                      Status: value.itemdata!.enquirydetails![i].Status,
                      Store: value.itemdata!.enquirydetails![i].Store));
                }
              }
              if (leaddetails!.isNotEmpty) {
                AssignedToDialogUserState.LookingFor = leaddetails![0].DocType;
                AssignedToDialogUserState.Store = leaddetails![0].Store;
                AssignedToDialogUserState.handledby =
                    leaddetails![0].AssignedTo;
                AssignedToDialogUserState.currentstatus =
                    leaddetails![0].CurrentStatus;

                alertDialogOpenLeadOREnq2(context, "Lead");
              } else if (enquirydetails!.isNotEmpty) {
                AssignedToDialogUserState.LookingFor =
                    enquirydetails![0].DocType;
                AssignedToDialogUserState.Store = enquirydetails![0].Store;
                AssignedToDialogUserState.handledby =
                    enquirydetails![0].AssignedTo;
                AssignedToDialogUserState.currentstatus =
                    enquirydetails![0].CurrentStatus;

                alertDialogOpenLeadOREnq2(context, "enquiry");
              } else if (orderdetails!.isNotEmpty) {
                AssignedToDialogUserState.LookingFor = orderdetails![0].DocType;
                AssignedToDialogUserState.Store = orderdetails![0].Store;
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
            itemdata.Pincode == 'null' ||
            itemdata.Pincode == '0'
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

  static List<String> datafromsp = [];
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
    if (datafromsp.length > 0) {
      // log("ANBUORDER");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfromSp(context);
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
    await callrefparnerApi();
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
    await callrefparnerApi();
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
            datafromsiteout[12] == "null" ||
            datafromsiteout[12] == "0" ||
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
    await callrefparnerApi();
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
            datafromopenlead[4] == "null" ||
            datafromopenlead[4] == "0" ||
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
        : datafromopenlead[7]; //sta
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

    await GetLeadQTHApi.getData(datafromopenlead[6]).then((value) async {
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
          for (int i = 0; i < allProductDetails.length; i++) {
            if (allProductDetails[i].itemCode == GetleadItemCode) {
              //          selectedItemCode =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
              // selectedItemName =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
              selectedItemName = allProductDetails[i].itemName.toString();
              selectedItemCode = allProductDetails[i].itemCode.toString();
              taxvalue = double.parse(allProductDetails[i].taxRate.toString());
              sporder = allProductDetails[i].sp == null
                  ? 0.0
                  : double.parse(allProductDetails[i].sp.toString());
              slppriceorder = allProductDetails[i].slpPrice == null
                  ? 0.0
                  : double.parse(allProductDetails[i].slpPrice.toString());
              storestockorder = allProductDetails[i].storeStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].storeStock.toString());
              whsestockorder = allProductDetails[i].whsStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].whsStock.toString());
              isfixedpriceorder = allProductDetails[i].isFixedPrice;
              allownegativestockorder = allProductDetails[i].allowNegativeStock;
              alloworderbelowcostorder =
                  allProductDetails[i].allowOrderBelowCost;

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
              if (ConstantValues.unitpricelogic!.toLowerCase() == 'y') {
                orderpricecheckData.clear();
                pricecheckloading = true;
                pricecheckerror = '';

                await OrderPricecheckApi.getData(
                        selectedItemCode, quantity!.toInt()!, unitPrice, '')
                    .then((value) async {
                  if (value.stcode! >= 200 && value.stcode! <= 210) {
                    // log("Step 3" + value.Ordercheckdatageader.toString());

                    if (value.itemdata!.childdata != null &&
                        value.itemdata!.childdata!.isNotEmpty) {
                      log("not null");

                      orderpricecheckData = value.itemdata!.childdata!;
                      if (orderpricecheckData[0].validity == 'valid') {
                        await calllinkedApi22(selectedItemCode);

                        productDetails.add(DocumentLines(
                            bundleId: null,
                            itemtype: "R",
                            OfferSetup_Id: null,
                            id: 0,
                            docEntry: 0,
                            linenum: 0,
                            linkeditems:
                                linkedItemsdatacheck.length > 0 ? true : false,
                            ItemCode: selectedItemCode,
                            ItemDescription: selectedItemName,
                            Quantity: quantity,
                            LineTotal: total,
                            Price: unitPrice,
                            TaxCode: taxvalue,
                            TaxLiable: "tNO",
                            storecode: storecode,
                            deliveryfrom: deliveryfrom,
                            sp: sporder,
                            slpprice: slppriceorder,
                            storestock: storestockorder,
                            whsestock: whsestockorder,
                            isfixedprice: isfixedpriceorder,
                            allownegativestock: allownegativestockorder,
                            alloworderbelowcost: alloworderbelowcostorder,
                            // partcode: selectedapartcode == null || selectedapartcode.isEmpty
                            // ? null
                            // : selectedapartcode,
                            giftitems: []
                            //    sp: sporder,
                            // slpprice: slppriceorder,
                            // storestock: storestockorder,
                            // whsestock:whsestockorder ,
                            // isfixedprice: isfixedpriceorder,
                            // allownegativestock:allownegativestockorder ,
                            // alloworderbelowcost: alloworderbelowcostorder,
                            ));
                        showItemList = false;
                      } else {
                        // showpopdialogunitprice(
                        //     context,
                        //     "Price cannot be deviated from your allowed Limit. Required Special Pricing Approval to Proceed..!!",
                        //     '');
                        notifyListeners();
                      }
                      // showgiftitems(context, i, theme, addproduct, updateallProductDetails);
                      pricecheckloading = false;
                      pricecheckerror = '';
                      notifyListeners();
                    } else if (value.itemdata!.childdata == null ||
                        value.itemdata!.childdata!.isEmpty) {
                      log("Order data null");
                      pricecheckloading = false;
                      pricecheckerror = 'No data in CheckPriceValidity..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // gifterror = 'No data..!!';
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }
                    }
                  } else if (value.stcode! >= 400 && value.stcode! <= 410) {
                    pricecheckloading = false;
                    pricecheckerror =
                        '${value.message}..!!${value.exception}....!!';
                    showpopdialogunitprice(context, "$pricecheckerror", '');
                    // if (addproduct == true) {
                    //   mycontroller[12].clear();
                    //   addProductDetails(context, allProductDetails[i]);
                    //   notifyListeners();
                    // } else if (addproduct == false) {
                    //   updateProductDetails(context, i, updateallProductDetails);
                    // }

                    notifyListeners();
                  } else {
                    if (value.exception!.contains("Network is unreachable")) {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    } else {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    }

                    notifyListeners();
                  }
                });
              } else {
                await calllinkedApi22(selectedItemCode);
                productDetails.add(DocumentLines(
                    bundleId: null,
                    itemtype: "R",
                    OfferSetup_Id: null,
                    id: 0,
                    docEntry: 0,
                    linenum: 0,
                    linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                    ItemCode: selectedItemCode,
                    ItemDescription: selectedItemName,
                    Quantity: quantity,
                    LineTotal: total,
                    Price: unitPrice,
                    TaxCode: taxvalue,
                    TaxLiable: "tNO",
                    storecode: storecode,
                    deliveryfrom: deliveryfrom,
                    sp: sporder,
                    slpprice: slppriceorder,
                    storestock: storestockorder,
                    whsestock: whsestockorder,
                    isfixedprice: isfixedpriceorder,
                    allownegativestock: allownegativestockorder,
                    alloworderbelowcost: alloworderbelowcostorder,
                    giftitems: []
                    //    sp: sporder,
                    // slpprice: slppriceorder,
                    // storestock: storestockorder,
                    // whsestock:whsestockorder ,
                    // isfixedprice: isfixedpriceorder,
                    // allownegativestock:allownegativestockorder ,
                    // alloworderbelowcost: alloworderbelowcostorder,
                    ));
                showItemList = false;
              }

              // productDetails.add(DocumentLines(
              //     bundleId: null,
              //     itemtype: 'R',
              //     OfferSetup_Id: null,
              //     id: 0,
              //     docEntry: 0,
              //     linenum: 0,
              //     ItemCode: selectedItemCode,
              //     ItemDescription: selectedItemName,
              //     Quantity: quantity,
              //     LineTotal: total,
              //     Price: unitPrice,
              //     TaxCode: taxvalue,
              //     TaxLiable: "tNO",
              //     storecode: storecode,
              //     deliveryfrom: deliveryfrom,
              //     sp: sporder,
              //     slpprice: slppriceorder,
              //     storestock: storestockorder,
              //     whsestock: whsestockorder,
              //     isfixedprice: isfixedpriceorder,
              //     allownegativestock: allownegativestockorder,
              //     alloworderbelowcost: alloworderbelowcostorder,
              //     giftitems: []
              //     //    sp: sporder,
              //     // slpprice: slppriceorder,
              //     // storestock: storestockorder,
              //     // whsestock:whsestockorder ,
              //     // isfixedprice: isfixedpriceorder,
              //     // allownegativestock:allownegativestockorder ,
              //     // alloworderbelowcost: alloworderbelowcostorder,
              //     ));
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
    await callrefparnerApi();
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
    mycontroller[1].text = datafromAcc[9] == null ||
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
            datafromAcc[4] == "null" ||
            datafromAcc[4] == "0" ||
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
            datafromAcc[17].isEmpty
        ? ""
        : datafromAcc[17];

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
    await callrefparnerApi();
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
            datafromfollow[4] == "null" ||
            datafromfollow[4] == "0" ||
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

    await GetLeadQTHApi.getData(datafromfollow[6]).then((value) async {
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
          for (int i = 0; i < allProductDetails.length; i++) {
            if (allProductDetails[i].itemCode == GetleadItemCode) {
              //          selectedItemCode =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
              // selectedItemName =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
              selectedItemName = allProductDetails[i].itemName.toString();
              selectedItemCode = allProductDetails[i].itemCode.toString();
              taxvalue = double.parse(allProductDetails[i].taxRate.toString());
              sporder = allProductDetails[i].sp == null
                  ? 0.0
                  : double.parse(allProductDetails[i].sp.toString());
              slppriceorder = allProductDetails[i].slpPrice == null
                  ? 0.0
                  : double.parse(allProductDetails[i].slpPrice.toString());
              storestockorder = allProductDetails[i].storeStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].storeStock.toString());
              whsestockorder = allProductDetails[i].whsStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].whsStock.toString());
              isfixedpriceorder = allProductDetails[i].isFixedPrice;
              allownegativestockorder = allProductDetails[i].allowNegativeStock;
              alloworderbelowcostorder =
                  allProductDetails[i].allowOrderBelowCost;

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
              if (ConstantValues.unitpricelogic!.toLowerCase() == 'y') {
                orderpricecheckData.clear();
                pricecheckloading = true;
                pricecheckerror = '';

                await OrderPricecheckApi.getData(
                        selectedItemCode, quantity!.toInt()!, unitPrice, '')
                    .then((value) async {
                  if (value.stcode! >= 200 && value.stcode! <= 210) {
                    // log("Step 3" + value.Ordercheckdatageader.toString());

                    if (value.itemdata!.childdata != null &&
                        value.itemdata!.childdata!.isNotEmpty) {
                      log("not null");

                      orderpricecheckData = value.itemdata!.childdata!;
                      if (orderpricecheckData[0].validity == 'valid') {
                        await calllinkedApi22(selectedItemCode);

                        productDetails.add(DocumentLines(
                            bundleId: null,
                            itemtype: "R",
                            OfferSetup_Id: null,
                            id: 0,
                            docEntry: 0,
                            linenum: 0,
                            linkeditems:
                                linkedItemsdatacheck.length > 0 ? true : false,
                            ItemCode: selectedItemCode,
                            ItemDescription: selectedItemName,
                            Quantity: quantity,
                            LineTotal: total,
                            Price: unitPrice,
                            TaxCode: taxvalue,
                            TaxLiable: "tNO",
                            storecode: storecode,
                            deliveryfrom: deliveryfrom,
                            sp: sporder,
                            slpprice: slppriceorder,
                            storestock: storestockorder,
                            whsestock: whsestockorder,
                            isfixedprice: isfixedpriceorder,
                            allownegativestock: allownegativestockorder,
                            alloworderbelowcost: alloworderbelowcostorder,
                            // partcode: selectedapartcode == null || selectedapartcode.isEmpty
                            // ? null
                            // : selectedapartcode,
                            giftitems: []
                            //    sp: sporder,
                            // slpprice: slppriceorder,
                            // storestock: storestockorder,
                            // whsestock:whsestockorder ,
                            // isfixedprice: isfixedpriceorder,
                            // allownegativestock:allownegativestockorder ,
                            // alloworderbelowcost: alloworderbelowcostorder,
                            ));
                        showItemList = false;
                      } else {
                        // showpopdialogunitprice(
                        //     context,
                        //     "Price cannot be deviated from your allowed Limit. Required Special Pricing Approval to Proceed..!!",
                        //     '');
                        notifyListeners();
                      }
                      // showgiftitems(context, i, theme, addproduct, updateallProductDetails);
                      pricecheckloading = false;
                      pricecheckerror = '';
                      notifyListeners();
                    } else if (value.itemdata!.childdata == null ||
                        value.itemdata!.childdata!.isEmpty) {
                      log("Order data null");
                      pricecheckloading = false;
                      pricecheckerror = 'No data in CheckPriceValidity..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // gifterror = 'No data..!!';
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }
                    }
                  } else if (value.stcode! >= 400 && value.stcode! <= 410) {
                    pricecheckloading = false;
                    pricecheckerror =
                        '${value.message}..!!${value.exception}....!!';
                    showpopdialogunitprice(context, "$pricecheckerror", '');
                    // if (addproduct == true) {
                    //   mycontroller[12].clear();
                    //   addProductDetails(context, allProductDetails[i]);
                    //   notifyListeners();
                    // } else if (addproduct == false) {
                    //   updateProductDetails(context, i, updateallProductDetails);
                    // }

                    notifyListeners();
                  } else {
                    if (value.exception!.contains("Network is unreachable")) {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    } else {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    }

                    notifyListeners();
                  }
                });
              } else {
                await calllinkedApi22(selectedItemCode);
                productDetails.add(DocumentLines(
                    bundleId: null,
                    itemtype: "R",
                    OfferSetup_Id: null,
                    id: 0,
                    docEntry: 0,
                    linenum: 0,
                    linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                    ItemCode: selectedItemCode,
                    ItemDescription: selectedItemName,
                    Quantity: quantity,
                    LineTotal: total,
                    Price: unitPrice,
                    TaxCode: taxvalue,
                    TaxLiable: "tNO",
                    storecode: storecode,
                    deliveryfrom: deliveryfrom,
                    sp: sporder,
                    slpprice: slppriceorder,
                    storestock: storestockorder,
                    whsestock: whsestockorder,
                    isfixedprice: isfixedpriceorder,
                    allownegativestock: allownegativestockorder,
                    alloworderbelowcost: alloworderbelowcostorder,
                    giftitems: []
                    //    sp: sporder,
                    // slpprice: slppriceorder,
                    // storestock: storestockorder,
                    // whsestock:whsestockorder ,
                    // isfixedprice: isfixedpriceorder,
                    // allownegativestock:allownegativestockorder ,
                    // alloworderbelowcost: alloworderbelowcostorder,
                    ));
                showItemList = false;
              }
              // productDetails.add(DocumentLines(
              //     bundleId: null,
              //     itemtype: 'R',
              //     OfferSetup_Id: null,
              //     id: 0,
              //     docEntry: 0,
              //     linenum: 0,
              //     ItemCode: selectedItemCode,
              //     ItemDescription: selectedItemName,
              //     Quantity: quantity,
              //     LineTotal: total,
              //     Price: unitPrice,
              //     TaxCode: taxvalue,
              //     TaxLiable: "tNO",
              //     storecode: storecode,
              //     deliveryfrom: deliveryfrom,
              //     sp: sporder,
              //     slpprice: slppriceorder,
              //     storestock: storestockorder,
              //     whsestock: whsestockorder,
              //     isfixedprice: isfixedpriceorder,
              //     allownegativestock: allownegativestockorder,
              //     alloworderbelowcost: alloworderbelowcostorder,
              //     giftitems: []
              //     //    sp: sporder,
              //     // slpprice: slppriceorder,
              //     // storestock: storestockorder,
              //     // whsestock:whsestockorder ,
              //     // isfixedprice: isfixedpriceorder,
              //     // allownegativestock:allownegativestockorder ,
              //     // alloworderbelowcost: alloworderbelowcostorder,
              //     ));
            }
          }
        }
        notifyListeners();

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());
        // showItemList = false;
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
    await callrefparnerApi();
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
    DocDateold = datafrommodify[22];
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
            datafrommodify[10] == "null" ||
            datafrommodify[10] == "0" ||
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
            datafrommodify[16] == "null" ||
            datafrommodify[16] == "0" ||
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
    if (datafrommodify[21] != null ||
        datafrommodify[21] != "null" ||
        datafrommodify[21].isNotEmpty) {
      for (int i = 0; i < ordertypedata.length; i++) {
        if (ordertypedata[i].Name == datafrommodify[21]) {
          valueChosedCusType = ordertypedata[i].Code;
        }
      }
    }
    ordocentry = int.parse(datafrommodify[0]);
    ordernum = int.parse(datafrommodify[18]);
    notifyListeners();
    String? storecode;
    String? deliveryfrom;
    modifyfinalgiftlist.clear();
    await GetOrderQTHApi.getData(datafrommodify[0]).then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        for (int ik = 0;
            ik < value.OrderDeatilsheaderData!.OrderDeatilsQTLData!.length;
            ik++) {
          linkedItemsdatacheck.clear();
          GetleadItemCode =
              value.OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].ItemCode;

          offeridval =
              value.OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].OfferId;
          itemtypemodify =
              value.OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].ItemType;
          bundleidmodify =
              value.OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].BundleId;

          mycontroller[11].text = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].Quantity
              .toString();
          mycontroller[10].text = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].Price
              .toString();
              mycontroller[36].text =value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].CouponCode
              .toString();
          storecode = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].LocCode
              .toString();
          deliveryfrom = value
              .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].deliveryFrom
              .toString();

          if (
             itemtypemodify!.toLowerCase() == 'v' ||
            itemtypemodify!.toLowerCase() == 'p' ||
              itemtypemodify!.toLowerCase() == 'b' ||
              itemtypemodify!.toLowerCase() == 'r' ||
              itemtypemodify == null ||
              itemtypemodify == '') {
            for (int i = 0; i < allProductDetails.length; i++) {
              if (allProductDetails[i].itemCode == GetleadItemCode) {
                selectedItemName = allProductDetails[i].itemName.toString();
                selectedItemCode = allProductDetails[i].itemCode.toString();
                taxvalue =
                    double.parse(allProductDetails[i].taxRate.toString());
                sporder = allProductDetails[i].sp == null
                    ? 0.0
                    : double.parse(allProductDetails[i].sp.toString());
                slppriceorder = allProductDetails[i].slpPrice == null
                    ? 0.0
                    : double.parse(allProductDetails[i].slpPrice.toString());
                storestockorder = allProductDetails[i].storeStock == null
                    ? 0.0
                    : double.parse(allProductDetails[i].storeStock.toString());
                whsestockorder = allProductDetails[i].whsStock == null
                    ? 0.0
                    : double.parse(allProductDetails[i].whsStock.toString());
                isfixedpriceorder = allProductDetails[i].isFixedPrice;
                allownegativestockorder =
                    allProductDetails[i].allowNegativeStock;
                alloworderbelowcostorder =
                    allProductDetails[i].allowOrderBelowCost;

                unitPrice = double.parse(mycontroller[10].text);
                quantity = double.parse(mycontroller[11].text);
                total = unitPrice! * quantity!;
                await calllinkedApi22(selectedItemCode);
                productDetails.add(DocumentLines(
                    bundleId: bundleidmodify == 0 ? null : bundleidmodify,
                    itemtype: itemtypemodify,
                    OfferSetup_Id: offeridval,
                    id: 0,
                    docEntry: 0,
                    linenum: 0,
                    linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                    ItemCode: selectedItemCode,
                    ItemDescription: selectedItemName,
                     couponcode:   mycontroller[36].text.isEmpty?null:mycontroller[36].text,
                    Quantity: quantity,
                    LineTotal: total,
                    Price: unitPrice,
                    TaxCode: taxvalue,
                    TaxLiable: "tNO",
                    storecode: storecode,
                    deliveryfrom: deliveryfrom,
                    sp: sporder,
                    slpprice: slppriceorder,
                    storestock: storestockorder,
                    whsestock: whsestockorder,
                    isfixedprice: isfixedpriceorder,
                    allownegativestock: allownegativestockorder,
                    alloworderbelowcost: alloworderbelowcostorder,
                    giftitems: []));
              }
            }
          } else if (itemtypemodify!.toLowerCase() == 'g') {
            modifyfinalgiftlist.add(giftoffers(
                itemtype: itemtypemodify,
                GiftQty: null,
                OfferSetup_Id: offeridval,
                ItemCode: value
                    .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].ItemCode,
                Attach_Qty: null,
                BasicPrice: value
                    .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].BasePrice,
                ItemName: value
                    .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].ItemName,
                MRP: value.OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].MRP,
                Price: value
                    .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].Price,
                SP: value
                    .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].Info_SP,
                TaxAmt_PerUnit: null,
                TaxRate: value
                    .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].TaxCode,
                quantity: value
                    .OrderDeatilsheaderData!.OrderDeatilsQTLData![ik].Quantity!
                    .toInt()));
          }
          log("modifyfinalgiftlist::" + modifyfinalgiftlist.length.toString());
        }
        if (modifyfinalgiftlist.isNotEmpty) {
          for (int iu = 0; iu < productDetails.length; iu++) {
            // tempGiftList.clear();
            List<giftoffers> tempGiftList = [];
            log("productDetailsfinalgiftlist::" +
                productDetails[iu].itemtype.toString());
            log("productDetailsfinalgiftlist::" +
                productDetails[iu].ItemCode.toString());
            for (int ih = 0; ih < modifyfinalgiftlist.length; ih++) {
              if (productDetails[iu].itemtype!.toLowerCase() == 'p' &&
                  productDetails[iu].OfferSetup_Id ==
                      modifyfinalgiftlist[ih].OfferSetup_Id) {
                tempGiftList.add(giftoffers(
                    itemtype: modifyfinalgiftlist[ih].itemtype,
                    GiftQty: modifyfinalgiftlist[ih].GiftQty,
                    OfferSetup_Id: modifyfinalgiftlist[ih].OfferSetup_Id,
                    ItemCode: modifyfinalgiftlist[ih].ItemCode,
                    Attach_Qty: modifyfinalgiftlist[ih].Attach_Qty,
                    BasicPrice: modifyfinalgiftlist[ih].BasicPrice,
                    ItemName: modifyfinalgiftlist[ih].ItemName,
                    MRP: modifyfinalgiftlist[ih].MRP,
                    Price: modifyfinalgiftlist[ih].Price,
                    SP: modifyfinalgiftlist[ih].SP,
                    TaxAmt_PerUnit: modifyfinalgiftlist[ih].TaxAmt_PerUnit,
                    TaxRate: modifyfinalgiftlist[ih].TaxRate,
                    quantity: modifyfinalgiftlist[ih].quantity));
                log("finalgiftlist::" + finalgiftlist.length.toString());
              }
            }
            if (tempGiftList.isNotEmpty) {
              for (int iq = 0; iq < tempGiftList.length; iq++) {
                await calllinkedApi22(tempGiftList[iq].ItemCode);
                notifyListeners();
              }
              productDetails[iu].linkeditems =
                  linkedItemsdatacheck.length > 0 ? true : false;
              productDetails[iu].giftitems = tempGiftList;
            }
            log("productDetails[iu].giftitems::" +
                productDetails[iu].giftitems!.length.toString());
          }
        }
        notifyListeners();

        showItemList = false;

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        notifyListeners();
      } else {
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
    await callrefparnerApi();
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
            datafromquotes[10] == "null" ||
            datafromquotes[10] == "0" ||
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
            datafromquotes[16] == "null" ||
            datafromquotes[16] == "0" ||
            datafromquotes[16].isEmpty
        ? ""
        : datafromquotes[16];
    mycontroller[24].text = datafromquotes[17] == null ||
            datafromquotes[17] == "null" ||
            datafromquotes[17].isEmpty
        ? ""
        : datafromquotes[17];
    mycontroller[25].text = datafromquotes[19] == null ||
            datafromquotes[19] == "null" ||
            datafromquotes[19].isEmpty
        ? ""
        : datafromquotes[19];
    if (datafromquotes[21] != null ||
        datafromquotes[21] != "null" ||
        datafromquotes[21].isNotEmpty) {
      for (int i = 0; i < ordertypedata.length; i++) {
        if (ordertypedata[i].Name == datafromquotes[21]) {
          valueChosedCusType = ordertypedata[i].Code;
        }
      }
    }
    enqID = int.parse(datafromquotes[0]);
    basetype = 3;
    // log("datafromlead[6]::" + datafromlead[6].toString());

    String? storecode;
    String? deliveryfrom;
    await GetQuotesQTHApi.getData(datafromquotes[0]).then((value) async {
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
          for (int i = 0; i < allProductDetails.length; i++) {
            if (allProductDetails[i].itemCode == GetleadItemCode) {
              //          selectedItemCode =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
              // selectedItemName =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
              selectedItemName = allProductDetails[i].itemName.toString();
              selectedItemCode = allProductDetails[i].itemCode.toString();
              taxvalue = double.parse(allProductDetails[i].taxRate.toString());
              sporder = allProductDetails[i].sp == null
                  ? 0.0
                  : double.parse(allProductDetails[i].sp.toString());
              slppriceorder = allProductDetails[i].slpPrice == null
                  ? 0.0
                  : double.parse(allProductDetails[i].slpPrice.toString());
              storestockorder = allProductDetails[i].storeStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].storeStock.toString());
              whsestockorder = allProductDetails[i].whsStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].whsStock.toString());
              isfixedpriceorder = allProductDetails[i].isFixedPrice;
              allownegativestockorder = allProductDetails[i].allowNegativeStock;
              alloworderbelowcostorder =
                  allProductDetails[i].allowOrderBelowCost;

              unitPrice = double.parse(mycontroller[10].text);
              quantity = double.parse(mycontroller[11].text);
              total = unitPrice! * quantity!;

              if (ConstantValues.unitpricelogic!.toLowerCase() == 'y') {
                orderpricecheckData.clear();
                pricecheckloading = true;
                pricecheckerror = '';

                await OrderPricecheckApi.getData(
                        selectedItemCode, quantity!.toInt()!, unitPrice, '')
                    .then((value) async {
                  if (value.stcode! >= 200 && value.stcode! <= 210) {
                    // log("Step 3" + value.Ordercheckdatageader.toString());

                    if (value.itemdata!.childdata != null &&
                        value.itemdata!.childdata!.isNotEmpty) {
                      log("not null");

                      orderpricecheckData = value.itemdata!.childdata!;
                      if (orderpricecheckData[0].validity == 'valid') {
                        await calllinkedApi22(selectedItemCode);

                        productDetails.add(DocumentLines(
                            bundleId: null,
                            itemtype: "R",
                            OfferSetup_Id: null,
                            id: 0,
                            docEntry: 0,
                            linenum: 0,
                            linkeditems:
                                linkedItemsdatacheck.length > 0 ? true : false,
                            ItemCode: selectedItemCode,
                            ItemDescription: selectedItemName,
                            Quantity: quantity,
                            LineTotal: total,
                            Price: unitPrice,
                            TaxCode: taxvalue,
                            TaxLiable: "tNO",
                            storecode: storecode,
                            deliveryfrom: deliveryfrom,
                            sp: sporder,
                            slpprice: slppriceorder,
                            storestock: storestockorder,
                            whsestock: whsestockorder,
                            isfixedprice: isfixedpriceorder,
                            allownegativestock: allownegativestockorder,
                            alloworderbelowcost: alloworderbelowcostorder,
                            // partcode: selectedapartcode == null || selectedapartcode.isEmpty
                            // ? null
                            // : selectedapartcode,
                            giftitems: []
                            //    sp: sporder,
                            // slpprice: slppriceorder,
                            // storestock: storestockorder,
                            // whsestock:whsestockorder ,
                            // isfixedprice: isfixedpriceorder,
                            // allownegativestock:allownegativestockorder ,
                            // alloworderbelowcost: alloworderbelowcostorder,
                            ));
                        showItemList = false;
                      } else {
                        // showpopdialogunitprice(
                        //     context,
                        //     "Price cannot be deviated from your allowed Limit. Required Special Pricing Approval to Proceed..!!",
                        //     '');
                        notifyListeners();
                      }
                      // showgiftitems(context, i, theme, addproduct, updateallProductDetails);
                      pricecheckloading = false;
                      pricecheckerror = '';
                      notifyListeners();
                    } else if (value.itemdata!.childdata == null ||
                        value.itemdata!.childdata!.isEmpty) {
                      log("Order data null");
                      pricecheckloading = false;
                      pricecheckerror = 'No data in CheckPriceValidity..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // gifterror = 'No data..!!';
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }
                    }
                  } else if (value.stcode! >= 400 && value.stcode! <= 410) {
                    pricecheckloading = false;
                    pricecheckerror =
                        '${value.message}..!!${value.exception}....!!';
                    showpopdialogunitprice(context, "$pricecheckerror", '');
                    // if (addproduct == true) {
                    //   mycontroller[12].clear();
                    //   addProductDetails(context, allProductDetails[i]);
                    //   notifyListeners();
                    // } else if (addproduct == false) {
                    //   updateProductDetails(context, i, updateallProductDetails);
                    // }

                    notifyListeners();
                  } else {
                    if (value.exception!.contains("Network is unreachable")) {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    } else {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    }

                    notifyListeners();
                  }
                });
              } else {
                await calllinkedApi22(selectedItemCode);
                productDetails.add(DocumentLines(
                    bundleId: null,
                    itemtype: "R",
                    OfferSetup_Id: null,
                    id: 0,
                    docEntry: 0,
                    linenum: 0,
                    linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                    ItemCode: selectedItemCode,
                    ItemDescription: selectedItemName,
                    Quantity: quantity,
                    LineTotal: total,
                    Price: unitPrice,
                    TaxCode: taxvalue,
                    TaxLiable: "tNO",
                    storecode: storecode,
                    deliveryfrom: deliveryfrom,
                    sp: sporder,
                    slpprice: slppriceorder,
                    storestock: storestockorder,
                    whsestock: whsestockorder,
                    isfixedprice: isfixedpriceorder,
                    allownegativestock: allownegativestockorder,
                    alloworderbelowcost: alloworderbelowcostorder,
                    giftitems: []
                    //    sp: sporder,
                    // slpprice: slppriceorder,
                    // storestock: storestockorder,
                    // whsestock:whsestockorder ,
                    // isfixedprice: isfixedpriceorder,
                    // allownegativestock:allownegativestockorder ,
                    // alloworderbelowcost: alloworderbelowcostorder,
                    ));
                showItemList = false;
              }
              // productDetails.add(DocumentLines(
              //     bundleId: null,
              //     itemtype: "R",
              //     OfferSetup_Id: null,
              //     id: 0,
              //     docEntry: 0,
              //     linenum: 0,
              //     ItemCode: selectedItemCode,
              //     ItemDescription: selectedItemName,
              //     Quantity: quantity,
              //     LineTotal: total,
              //     Price: unitPrice,
              //     TaxCode: taxvalue,
              //     TaxLiable: "tNO",
              //     storecode: storecode,
              //     deliveryfrom: deliveryfrom,
              //     sp: sporder,
              //     slpprice: slppriceorder,
              //     storestock: storestockorder,
              //     whsestock: whsestockorder,
              //     isfixedprice: isfixedpriceorder,
              //     allownegativestock: allownegativestockorder,
              //     alloworderbelowcost: alloworderbelowcostorder,
              //     giftitems: []
              //     //    sp: sporder,
              //     // slpprice: slppriceorder,
              //     // storestock: storestockorder,
              //     // whsestock:whsestockorder ,
              //     // isfixedprice: isfixedpriceorder,
              //     // allownegativestock:allownegativestockorder ,
              //     // alloworderbelowcost: alloworderbelowcostorder,
              //     ));
            }
          }
        }

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());
        // showItemList = false;

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

  mapvaluesfromSp(BuildContext context) async {
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();

    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await callrefparnerApi();
    await getCustomerTag();
    await callpaymodeApi();

// isselected=true;
    // log("datafromlead" + datafromlead[5].toString());
    mycontroller[0].text = datafromsp[1];
    mycontroller[16].text = datafromsp[2];
    await callApi(context);
    // mycontroller[1].text = datafromlead[1];

    // log("datafromlead[11] !=null::"+datafromlead[11].toString());

    enqID = null;
    basetype = null;

    String? storecode;
    String? deliveryfrom;
    // await GetLeadQTHApi.getData(datafromlead[6]).then((value) {
    // if (value.stcode! >= 200 && value.stcode! <= 210) {
    // for (int ik = 0;
    //     ik < value.leadDeatilheadsData!.leadDeatilsQTLData!.length;
    //     ik++) {
    GetleadItemCode = datafromsp[3];
    mycontroller[11].text = datafromsp[5];
    mycontroller[10].text = datafromsp[6];
    mycontroller[36].text = datafromsp[7];
    // log("selectedItemCode::"+GetleadItemCode.toString());
    for (int i = 0; i < allProductDetails.length; i++) {
      if (allProductDetails[i].itemCode == GetleadItemCode) {
        selectedItemName = allProductDetails[i].itemName.toString();
        selectedItemCode = allProductDetails[i].itemCode.toString();
        taxvalue = double.parse(allProductDetails[i].taxRate.toString());
        log("converttax::"+taxvalue.toString());
        sporder = allProductDetails[i].sp == null
            ? 0.0
            : double.parse(allProductDetails[i].sp.toString());
        slppriceorder = allProductDetails[i].slpPrice == null
            ? 0.0
            : double.parse(allProductDetails[i].slpPrice.toString());
        storestockorder = allProductDetails[i].storeStock == null
            ? 0.0
            : double.parse(allProductDetails[i].storeStock.toString());
        whsestockorder = allProductDetails[i].whsStock == null
            ? 0.0
            : double.parse(allProductDetails[i].whsStock.toString());
        isfixedpriceorder = allProductDetails[i].isFixedPrice;
        allownegativestockorder = allProductDetails[i].allowNegativeStock;
        alloworderbelowcostorder = allProductDetails[i].allowOrderBelowCost;

        storecode = ConstantValues.Storecode;

        deliveryfrom = "store";

        unitPrice = double.parse(mycontroller[10].text);
        quantity = double.parse(mycontroller[11].text);
        total = unitPrice! * quantity!;
        await calllinkedApi22(selectedItemCode);

        productDetails.add(DocumentLines(
            bundleId: null,
            itemtype: 'R',
            OfferSetup_Id: null,
            id: 0,
            docEntry: 0,
            linenum: 0,
            linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
            couponcode: mycontroller[36].text,
            ItemCode: selectedItemCode,
            ItemDescription: selectedItemName,
            Quantity: quantity,
            LineTotal: total,
            Price: unitPrice,
            TaxCode: taxvalue,
            TaxLiable: "tNO",
            storecode: storecode,
            deliveryfrom: deliveryfrom,
            sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock: whsestockorder,
            isfixedprice: isfixedpriceorder,
            allownegativestock: allownegativestockorder,
            alloworderbelowcost: alloworderbelowcostorder,
            giftitems: []));
      }
    }
    // }

    showItemList = false;

    notifyListeners();
    // } else if (value.stcode! >= 400 && value.stcode! <= 490) {

    //   notifyListeners();
    // } else {

    //   notifyListeners();
    // }
    // });
    customerapicLoading = false;
    datafromsp.clear();

    notifyListeners();
  }

  mapvaluesfromlead(BuildContext context) async {
    productDetails.clear();
    getdataFromDb();
    getEnqRefferes();

    await stateApicallfromDB();
    await getLeveofType();
    await callLeadCheckApi();
    await callrefparnerApi();
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
            datafromlead[4] == "null" ||
            datafromlead[4] == "0" ||
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
    if (datafromlead[11] != null ||
        datafromlead[11] != "null" ||
        datafromlead[11].isNotEmpty) {
      for (int i = 0; i < ordertypedata.length; i++) {
        if (ordertypedata[i].Name == datafromlead[11]) {
          valueChosedCusType = ordertypedata[i].Code;
        }
      }
    }
    enqID = int.parse(datafromlead[6]);
    basetype = 2;
    // log("datafromlead[6]::" + datafromlead[6].toString());

    String? storecode;
    String? deliveryfrom;
    await GetLeadQTHApi.getData(datafromlead[6]).then((value) async {
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
          for (int i = 0; i < allProductDetails.length; i++) {
            if (allProductDetails[i].itemCode == GetleadItemCode) {
              //          selectedItemCode =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
              // selectedItemName =
              //     value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
              selectedItemName = allProductDetails[i].itemName.toString();
              selectedItemCode = allProductDetails[i].itemCode.toString();
              taxvalue = double.parse(allProductDetails[i].taxRate.toString());
              sporder = allProductDetails[i].sp == null
                  ? 0.0
                  : double.parse(allProductDetails[i].sp.toString());
              slppriceorder = allProductDetails[i].slpPrice == null
                  ? 0.0
                  : double.parse(allProductDetails[i].slpPrice.toString());
              storestockorder = allProductDetails[i].storeStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].storeStock.toString());
              whsestockorder = allProductDetails[i].whsStock == null
                  ? 0.0
                  : double.parse(allProductDetails[i].whsStock.toString());
              isfixedpriceorder = allProductDetails[i].isFixedPrice;
              allownegativestockorder = allProductDetails[i].allowNegativeStock;
              alloworderbelowcostorder =
                  allProductDetails[i].allowOrderBelowCost;

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
              if (ConstantValues.unitpricelogic!.toLowerCase() == 'y') {
                orderpricecheckData.clear();
                pricecheckloading = true;
                pricecheckerror = '';

                await OrderPricecheckApi.getData(
                        selectedItemCode, quantity!.toInt()!, unitPrice, '')
                    .then((value) async {
                  if (value.stcode! >= 200 && value.stcode! <= 210) {
                    // log("Step 3" + value.Ordercheckdatageader.toString());

                    if (value.itemdata!.childdata != null &&
                        value.itemdata!.childdata!.isNotEmpty) {
                      log("not null");

                      orderpricecheckData = value.itemdata!.childdata!;
                      if (orderpricecheckData[0].validity == 'valid') {
                        await calllinkedApi22(selectedItemCode);

                        productDetails.add(DocumentLines(
                            bundleId: null,
                            itemtype: "R",
                            OfferSetup_Id: null,
                            id: 0,
                            docEntry: 0,
                            linenum: 0,
                            linkeditems:
                                linkedItemsdatacheck.length > 0 ? true : false,
                            ItemCode: selectedItemCode,
                            ItemDescription: selectedItemName,
                            Quantity: quantity,
                            LineTotal: total,
                            Price: unitPrice,
                            TaxCode: taxvalue,
                            TaxLiable: "tNO",
                            storecode: storecode,
                            deliveryfrom: deliveryfrom,
                            sp: sporder,
                            slpprice: slppriceorder,
                            storestock: storestockorder,
                            whsestock: whsestockorder,
                            isfixedprice: isfixedpriceorder,
                            allownegativestock: allownegativestockorder,
                            alloworderbelowcost: alloworderbelowcostorder,
                            // partcode: selectedapartcode == null || selectedapartcode.isEmpty
                            // ? null
                            // : selectedapartcode,
                            giftitems: []
                            //    sp: sporder,
                            // slpprice: slppriceorder,
                            // storestock: storestockorder,
                            // whsestock:whsestockorder ,
                            // isfixedprice: isfixedpriceorder,
                            // allownegativestock:allownegativestockorder ,
                            // alloworderbelowcost: alloworderbelowcostorder,
                            ));
                        showItemList = false;
                      } else {
                        // showpopdialogunitprice(
                        //     context,
                        //     "Price cannot be deviated from your allowed Limit. Required Special Pricing Approval to Proceed..!!",
                        //     '');
                        notifyListeners();
                      }
                      // showgiftitems(context, i, theme, addproduct, updateallProductDetails);
                      pricecheckloading = false;
                      pricecheckerror = '';
                      notifyListeners();
                    } else if (value.itemdata!.childdata == null ||
                        value.itemdata!.childdata!.isEmpty) {
                      log("Order data null");
                      pricecheckloading = false;
                      pricecheckerror = 'No data in CheckPriceValidity..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // gifterror = 'No data..!!';
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }
                    }
                  } else if (value.stcode! >= 400 && value.stcode! <= 410) {
                    pricecheckloading = false;
                    pricecheckerror =
                        '${value.message}..!!${value.exception}....!!';
                    showpopdialogunitprice(context, "$pricecheckerror", '');
                    // if (addproduct == true) {
                    //   mycontroller[12].clear();
                    //   addProductDetails(context, allProductDetails[i]);
                    //   notifyListeners();
                    // } else if (addproduct == false) {
                    //   updateProductDetails(context, i, updateallProductDetails);
                    // }

                    notifyListeners();
                  } else {
                    if (value.exception!.contains("Network is unreachable")) {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    } else {
                      pricecheckloading = false;
                      pricecheckerror =
                          '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
                      showpopdialogunitprice(context, "$pricecheckerror", '');
                      // if (addproduct == true) {
                      //   mycontroller[12].clear();
                      //   addProductDetails(context, allProductDetails[i]);
                      //   notifyListeners();
                      // } else if (addproduct == false) {
                      //   updateProductDetails(context, i, updateallProductDetails);
                      // }

                      notifyListeners();
                    }

                    notifyListeners();
                  }
                });
              } else {
                await calllinkedApi22(selectedItemCode);
                productDetails.add(DocumentLines(
                    bundleId: null,
                    itemtype: "R",
                    OfferSetup_Id: null,
                    id: 0,
                    docEntry: 0,
                    linenum: 0,
                    linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                    ItemCode: selectedItemCode,
                    ItemDescription: selectedItemName,
                    Quantity: quantity,
                    LineTotal: total,
                    Price: unitPrice,
                    TaxCode: taxvalue,
                    TaxLiable: "tNO",
                    storecode: storecode,
                    deliveryfrom: deliveryfrom,
                    sp: sporder,
                    slpprice: slppriceorder,
                    storestock: storestockorder,
                    whsestock: whsestockorder,
                    isfixedprice: isfixedpriceorder,
                    allownegativestock: allownegativestockorder,
                    alloworderbelowcost: alloworderbelowcostorder,
                    giftitems: []
                    //    sp: sporder,
                    // slpprice: slppriceorder,
                    // storestock: storestockorder,
                    // whsestock:whsestockorder ,
                    // isfixedprice: isfixedpriceorder,
                    // allownegativestock:allownegativestockorder ,
                    // alloworderbelowcost: alloworderbelowcostorder,
                    ));
                showItemList = false;
              }
            }
          }
        }

        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].ItemDescription.toString());

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
    await callrefparnerApi();
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
    mycontroller[4].text = dataenq[4] == null ||
            dataenq[4] == 'null' ||
            dataenq[4] == '0' ||
            dataenq[4].isEmpty
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
    if (dataenq[14] != null ||
        dataenq[14] != "null" ||
        dataenq[14].isNotEmpty) {
      for (int i = 0; i < ordertypedata.length; i++) {
        if (ordertypedata[i].Name == dataenq[14]) {
          valueChosedCusType = ordertypedata[i].Code;
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
  choosedType(String? val) {
    valueChosedCusType = val;
    notifyListeners();
  }

  choosedrefer(String? val) {
    valueChosedrefcode = val;
    notifyListeners();
  }

  choosedStatus(String? val) {
    valueChosedStatus = val;
    notifyListeners();
  }

  clearAllData() {
    valuegiftitems.clear();
  valuebaseproductDetails =[];
  valueBasedisgiftloading=false;
  valueBasedgifterror='';
    Linked = null;
    log("step1");
    linkedItemsdatacheck.clear();
    finallinkload = false;
    linkedItemsdata.clear();
    LinkedItemsloading = false;
    LinkedItemserror = '';
    bundleallProductDetails.clear();
    Bundleheaddetails.clear();
    BundleItemdetails.clear();
    Bundlestoredetails.clear();
    isBundleloading = false;
    Bundleerror = '';
    isselected = [true, false];
    offeridval = null;
    itemtypemodify = '';
    bundleidmodify = null;
    ordergiftData.clear();
    isgiftloading = false;
    gifterror = '';
    postpaymentdata.clear();
    refpartdata.clear();
    ispopupshown = false;
    ispopupshown2 = false;
    ispopupshown3 = false;
    ispopupshown4 = false;
    ispopupallow = false;
    ispopupallow2 = false;
    ispopupallow3 = false;
    ispopupallow4 = false;
    ispopupfinal1 = false;
    ispopupfinal2 = false;
    ispopupfinal3 = false;
    ispopupfinal4 = false;
    mycontroller[46].clear();
    filterrefpartdata.clear();
    mycontroller[36].clear();
    getcoupondata.clear();
    couponload = false;
    isappliedcoupon = false;
    paymentTerm = false;
    assignvalue = null;
    iscomplement = false;
    selectedassignto.clear();
    leveofdata.clear();
    enquirydetails.clear();
    leaddetails.clear();
    orderdetails.clear();
    ordertypedata.clear();
    Particularprice.clear();
    valueChosedStatus = null;
    valueChosedCusType = null;
    valueChosedCusType = null;
    mycontroller[27].clear();
    mycontroller[28].clear();
    mycontroller[29].clear();
    mycontroller[30].clear();
    mycontroller[41].clear();
    customermodeldata = null;
    DocDateold = '';
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
    files2.clear();
    filedata2.clear();
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
  String? DocDateold = '';
//save all values tp server
deletevaluebased(){
   for (int i = productDetails.length - 1; i >= 0; i--){
    if (productDetails[i].itemtype!.toLowerCase() == 'v') {
        productDetails.removeAt(i);
        notifyListeners();
      } 
   }
}
  onbackthired() async {
    for (int i = productDetails.length - 1; i >= 0; i--) {
      log('productDetails[i].OfferSetup_Id::' +
          productDetails[i].OfferSetup_Id.toString());
      if (productDetails[i].itemtype!.toLowerCase() == 'g') {
        productDetails.removeAt(i);
        notifyListeners();
      } else {
        notifyListeners();
      }
      // log("aaajj::"+productDetails[i].giftitems!.length.toString());
    }
    log("productDetails::" + productDetails.length.toString());
    notifyListeners();
    // pageController
    //                               .animateToPage(
    //                                   --pageChanged,
    //                                   duration: Duration(milliseconds: 250),
    //                                   curve: Curves.bounceIn);
  }

  bool finalsaveload = false;
  saveToServer(BuildContext context) async {
    await callcustomerapi();
    log("Step----------1");

    for (int i = 0; i < productDetails.length; i++) {
      if (productDetails[i].itemtype!.toLowerCase() == 'g') {
        productDetails.removeAt(i);
        notifyListeners();
      }
    }
    for (int i = 0; i < productDetails.length; i++) {
      if (productDetails[i].giftitems != null &&
          productDetails[i].giftitems!.isNotEmpty) {
        for (int ik = 0; ik < productDetails[i].giftitems!.length; ik++) {
          productDetails[i].OfferSetup_Id =
              productDetails[i].giftitems![ik].OfferSetup_Id;
          productDetails[i].itemtype = 'P';
          productDetails.add(DocumentLines(
              bundleId: null,
              itemtype: productDetails[i].giftitems![ik].itemtype,
              OfferSetup_Id: productDetails[i].giftitems![ik].OfferSetup_Id,
              id: 0,
              docEntry: 0,
              linenum: 0,
              storecode: ConstantValues.Storecode,
              deliveryfrom: "store",
              ItemCode: productDetails[i].giftitems![ik].ItemCode,
              couponcode: null,
              partcode: null,
              ItemDescription: productDetails[i].giftitems![ik].ItemName,
              Quantity: productDetails[i].giftitems![ik].quantity!.toDouble(),
              LineTotal: productDetails[i].giftitems![ik].quantity!.toDouble() *
                  productDetails[i].giftitems![ik].Price!,
              Price: productDetails[i].giftitems![ik].Price!,
              TaxCode: productDetails[i].giftitems![ik].TaxRate));
        }
      }
    }

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
    patch.couponcode =
        mycontroller[36].text == null || mycontroller[36].text.isEmpty
            ? null
            : mycontroller[36].text;
    patch.U_ShipCountry = countrycode2;
    patch.levelof = valueChosedStatus == null || valueChosedStatus!.isEmpty
        ? null
        : valueChosedStatus;
    patch.ordertype = valueChosedCusType == null || valueChosedCusType!.isEmpty
        ? null
        : valueChosedCusType;

    // patch.gst=
    //patch.U_Country =  mycontroller[6].text;
    patch.U_EMail = mycontroller[7].text == null || mycontroller[7].text.isEmpty
        ? null
        : mycontroller[7].text;
    patch.U_Type = isSelectedCusTagcode;

    PostOrder? postLead = new PostOrder();
    postLead.paymentdata = postpaymentdata;
    postLead.updateDate = config.currentDate();
    postLead.updateid = int.parse(ConstantValues.UserId.toString());
    postLead.slpCode = ConstantValues.slpcode;
    patch.docent = ordocentry == null ? null : ordocentry;
    patch.ordernum = ordernum == null ? null : ordernum;
    postLead.docEntry = 0; //
    postLead.docnum = docnum + 1; //
    postLead.docstatus = "open"; //
    postLead.doctotal =
        double.parse(getTotalOrderAmount().toString().replaceAll(",", ""));
    // postLead.DocType = "dDocument_Items"; //
    postLead.CardCode = mycontroller[0].text; //
    postLead.CardName = mycontroller[16].text; //
    postLead.DocDate = config.currentDate(); //
    postLead.deliveryDate = apiFDate;
    postLead.paymentDate = apiNdate;
    postLead.DocDateold =
        DocDateold!.isEmpty ? config.currentDate() : DocDateold;
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
    log("postLead.paymentdata::" + postpaymentdata!.length.toString());
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

  restricteddialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
        // barrierDismissible: true,
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: onbackpress,
            child: AlertDialog(
              // insetPadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.06,
                    width: Screens.width(context),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ))),
                        child: Text(
                          "Alert",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.02,
                  ),
                  Container(
                    child: Text(
                      "This User is assigned to multiple stores. Creating new order is not possible",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.02,
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.06,
                    width: Screens.width(context),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed(ConstantRoutes.ordertab);
                          notifyListeners();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ))),
                        child: Text(
                          "ok",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white, fontSize: 18),
                        )),
                  ),
                ],
              )),
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
        OrderSuccessPageState.orderpayment =
            value.orderSavePostheader!.orderpaydata;
        for (int i = 0; i < paymode.length; i++) {
          if (paymode[i].Code ==
              value.orderSavePostheader!.orderMasterdata![0].PaymentTerms) {
            OrderSuccessPageState.paymode = paymode[i].ModeName.toString();
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
        // onbackthired();
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        // onbackthired();
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
        if (value.orderSavePostheader!.orderpaydata != null &&
            value.orderSavePostheader!.orderpaydata!.isNotEmpty) {
          log("value::" +
              value.orderSavePostheader!.documentdata![0].ItemCode.toString());
          OrderSuccessPageState.orderpayment =
              value.orderSavePostheader!.orderpaydata;
          log("value::" +
              value.orderSavePostheader!.orderpaydata![0].ModeName.toString());
          for (int i = 0; i < paymode.length; i++) {
            if (paymode[i].Code ==
                value.orderSavePostheader!.orderMasterdata![0].PaymentTerms) {
              OrderSuccessPageState.paymode = paymode[i].ModeName.toString();
            }
          }
        }

        Get.toNamed(ConstantRoutes.successorder);

        // log("docno : " + successRes.DocNo.toString());
        notifyListeners();
        // callCheckListApi(context, value.DocEntry!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        // onbackthired();
        showLeadDeatilsDialog(
            context, "${value.message}..!!${value.exception}..");
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        // onbackthired();
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
      if (isSelectedCusTagcode.isEmpty) {
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
      else if (mycontroller[18].text.isEmpty ||
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
  List<ValueBasedgiftData> valuegiftitems=[];
  bool valueBasedisgiftloading = false;
  String? valueBasedgifterror = '';
checkvaluebasedapi(ThemeData theme ,BuildContext context)async{
  valuegiftitems.clear();
  valuebaseproductDetails =[];
  valueBasedisgiftloading=true;
  valueBasedgifterror='';
  notifyListeners();
  for(int i=0;i<productDetails.length;i++){
valuebaseproductDetails.add(
  DocumentLines2(
    partcode:productDetails[i].partcode,
    couponcode:productDetails[i].couponcode,
    complementary:productDetails[i].complementary,
    alloworderbelowcost:productDetails[i].alloworderbelowcost,
    allownegativestock:productDetails[i].allownegativestock,
    isfixedprice:productDetails[i].isfixedprice,
    whsestock:productDetails[i].whsestock,
    storestock:productDetails[i].storestock,
    storecode:productDetails[i].storecode,
    deliveryfrom:productDetails[i].deliveryfrom,
    bundleId:productDetails[i].bundleId,
    OfferSetup_Id:productDetails[i].OfferSetup_Id,
    itemtype:productDetails[i].itemtype,
    linkeditems:productDetails[i].linkeditems,
    giftitems:productDetails[i].giftitems,
    id:productDetails[i].id, 
    docEntry: productDetails[i].docEntry, 
    linenum:productDetails[i]. linenum, 
    ItemCode: productDetails[i].ItemCode, 
    ItemDescription:productDetails[i]. ItemDescription, 
    Quantity:productDetails[i]. Quantity, 
    LineTotal:productDetails[i]. LineTotal, 
    Price:productDetails[i]. Price, 
    TaxCode:productDetails[i]. TaxCode
    )
    
  );
  }
  
  notifyListeners();
  log("valuebaseproductDetails::"+valuebaseproductDetails.length.toString());
  for (int i = 0; i < valuebaseproductDetails.length; i++) {
      if (valuebaseproductDetails[i].itemtype!.toLowerCase() == 'g') {
        valuebaseproductDetails.removeAt(i);
        notifyListeners();
      }
    }
    for (int i = 0; i < valuebaseproductDetails.length; i++) {
      if (valuebaseproductDetails[i].giftitems != null &&
          valuebaseproductDetails[i].giftitems!.isNotEmpty) {
        for (int ik = 0; ik < valuebaseproductDetails[i].giftitems!.length; ik++) {
          valuebaseproductDetails[i].OfferSetup_Id =
              valuebaseproductDetails[i].giftitems![ik].OfferSetup_Id;
          valuebaseproductDetails[i].itemtype = 'P';
          valuebaseproductDetails.add(DocumentLines2(
              bundleId: null,
              itemtype: valuebaseproductDetails[i].giftitems![ik].itemtype,
              OfferSetup_Id: valuebaseproductDetails[i].giftitems![ik].OfferSetup_Id,
              id: 0,
              docEntry: 0,
              linenum: 0,
              storecode: ConstantValues.Storecode,
              deliveryfrom: "store",
              ItemCode: valuebaseproductDetails[i].giftitems![ik].ItemCode,
              couponcode: null,
              partcode: null,
              ItemDescription: valuebaseproductDetails[i].giftitems![ik].ItemName,
              Quantity: valuebaseproductDetails[i].giftitems![ik].quantity!.toDouble(),
              LineTotal: valuebaseproductDetails[i].giftitems![ik].quantity!.toDouble() *
                  valuebaseproductDetails[i].giftitems![ik].Price!,
              Price: valuebaseproductDetails[i].giftitems![ik].Price!,
              TaxCode: valuebaseproductDetails[i].giftitems![ik].TaxRate));
        }
      }
    }
      // PostOrder? postLead = new PostOrder();
      // postLead.docLine =valuebaseproductDetails;
       await valuebasedgiftApi.getData(valuebaseproductDetails)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("Step 3" + value.Ordercheckdatageader.toString());

        if (value.itemdata!.childdata != null &&
            value.itemdata!.childdata!.isNotEmpty) {
          log("not null");
valuegiftitems=value.itemdata!.childdata!;
       valueBasedisgiftloading = false;
       valueBasedgifterror = '';
       valuebasegiftitems(theme ,context);
          notifyListeners();
        } else if (value.itemdata!.childdata == null ||
            value.itemdata!.childdata!.isEmpty) {
          log("Order data null");
          valueBasedisgiftloading = false;
          valueBasedgifterror = 'No data..!!';
           pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      getTotalaoyAmount();
          
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        valueBasedisgiftloading = false;
        valueBasedgifterror = '${value.message}..!!${value.exception}....!!';
         pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      getTotalaoyAmount();

        notifyListeners();
      } else {
        if (value.exception!.contains("Network is unreachable")) {
          valueBasedisgiftloading = false;
          valueBasedgifterror =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      getTotalaoyAmount();

          notifyListeners();
        } else {
          valueBasedisgiftloading = false;
          valueBasedgifterror =
              '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
           pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      getTotalaoyAmount();

          notifyListeners();
        }

        notifyListeners();
      }
    });
  // log("valuebaseproductDetails::"+valuebaseproductDetails.length.toString());

}
  seconPageBtnClicked(ThemeData theme,BuildContext context) {
    if (productDetails.length > 0) {
      bool isdatavisible=false;
      isdatavisible=false;
      for(int ik=0;ik<productDetails.length;ik++){
        if(productDetails[ik].itemtype!.toLowerCase() =='v'){
          isdatavisible=true;

         notifyListeners();
        }
      }
if(isdatavisible ==true){
 pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      getTotalaoyAmount();
      notifyListeners();
}else{
 checkvaluebasedapi(theme ,context);
 notifyListeners();
}
     
     
    } else {
      Get.snackbar("Field Empty", "Choose products..!!",
          backgroundColor: Colors.red);
    }
  }

  bool paymentTerm = false;
  thirPageBtnClicked(BuildContext context) {
    int passed = 0;
    if (formkey[1].currentState!.validate()) {
      isloadingBtn = true;
      notifyListeners();
      // if (isSelectedpaymentTermsCode == null ||
      //     isSelectedpaymentTermsCode.isEmpty) {
      //   paymentTerm = true;
      //   notifyListeners();
      // } else {
      //   paymentTerm = false;
      //   notifyListeners();
      if (passed == 0) {
        // LeadSavePostApi.printData(postLead);
        saveToServer(context);
      }
      // }
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
    mycontroller[41].text = allProductDetails[i].mgrPrice == null
        ? "0"
        : allProductDetails[i].mgrPrice.toString();
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
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: theme.primaryColor)),
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text(allProductDetails[i].itemName.toString(),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : createTable4(
                              theme,
                              i,
                            ),
                      if (ConstantValues.showallslab!.toLowerCase() == 'y') ...[
                        Container()
                      ] else ...[
                        if (Particularprice.length <= 5) ...[
                          createTableparticular(theme, i, context),
                        ] else if (Particularprice.length <= 10) ...[
                          createTableparticular(theme, i, context),
                          SizedBox(height: 5),
                          createTableparticular2(theme, i, context),
                        ] else if (Particularprice.length <= 15) ...[
                          createTableparticular(theme, i, context),
                          SizedBox(height: 5),
                          createTableparticular2(theme, i, context),
                          SizedBox(height: 5),
                          createTableparticular3(theme, i, context),
                        ] else ...[
                          Container(), // Fallback if none of the conditions are met
                        ],
                      ],

                      SizedBox(
                        height: 5,
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      //  SizedBox(
                      //       width: 15,
                      //     ),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : createTable(theme, i),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : SizedBox(
                              height: 5,
                            ),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : createTable2(theme, i),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Store Age Slab:",
                            style: theme.textTheme.bodyMedium
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
                            style: theme.textTheme.bodyMedium
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
                      //       labelStyle: theme.textTheme.bodyMedium
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
                      //       labelStyle: theme.textTheme.bodyMedium
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
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  child: Text(
                                    ":",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(),
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
                                    child: allProductDetails[i].isFixedPrice ==
                                            true
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                    // Text(
                                    //   "${allProductDetails[i].isFixedPrice}",
                                    //   style: theme.textTheme.bodyMedium?.copyWith(
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
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  child: Text(
                                    ":",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(),
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
                                    child: allProductDetails[i]
                                                .allowNegativeStock ==
                                            true
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                    //  Text(
                                    //   "${allProductDetails[i].allowNegativeStock}",
                                    //   style: theme.textTheme.bodyMedium?.copyWith(
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
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: theme.primaryColor),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              child: Text(
                                ":",
                                style: theme.textTheme.bodyMedium?.copyWith(),
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
                                child:
                                    allProductDetails[i].allowOrderBelowCost ==
                                            true
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                // Text(
                                //   "${allProductDetails[i].allowOrderBelowCost}",
                                //   style: theme.textTheme.bodyMedium?.copyWith(
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

  Widget createTableparticular(ThemeData theme, int ij, BuildContext context) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Particularprice.length > 0 && Particularprice[0] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[0].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[0].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[0].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :"${Particularprice[0].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            )
          : Container(),
      Particularprice.length > 1 && Particularprice[1] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[1].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[1].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[1].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[1].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 2 && Particularprice[2] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[2].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[2].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[2].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[2].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 3 && Particularprice[3] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[3].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[3].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[3].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[3].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 4 && Particularprice[4] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[4].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[4].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[4].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[4].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Particularprice.length > 0 && Particularprice[0].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[0].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[0].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[0].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[0].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[0].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[0].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[0]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[0]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[0]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[0].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[0].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[0].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 1 && Particularprice[1].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[1].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[1].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[1].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[1].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[1].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[1].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[1]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[1]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[1]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[1].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[1].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[1].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 2 && Particularprice[2].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[2].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[2].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[2].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[2].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[2].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[2].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[2]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[2]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[2]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[2].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[2].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[2].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 3 && Particularprice[3].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[3].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[3].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[3].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[3].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[3].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[3].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[3]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[3]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[3]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[3].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[3].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[3].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 4 && Particularprice[4].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[4].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[4].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[4].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[4].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[4].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[4].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[4]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[4]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[4]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[4].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[4].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[4].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
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

  Widget createTableparticular2(ThemeData theme, int ij, BuildContext context) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Particularprice.length > 5 && Particularprice[5] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[5].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[5].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[5].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[5].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            )
          : Container(),
      Particularprice.length > 6 && Particularprice[6] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[6].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[6].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[6].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[6].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 7 && Particularprice[7] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[7].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[7].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[7].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[7].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 8 && Particularprice[8] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[8].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[8].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[8].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[8].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 9 && Particularprice[9] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[9].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[9].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[9].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[9].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Particularprice.length > 5 && Particularprice[5].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[5].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[5].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[5].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[5].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[5].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[5].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[5]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[5]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[5]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[5].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[5].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[5].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 6 && Particularprice[6].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[6].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[6].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[6].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[6].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[6].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[6].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[6]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[6]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[6]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[6].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[6].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[6].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 7 && Particularprice[7].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[7].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[7].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[7].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[7].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[7].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[7].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[7]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[7]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[7]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[7].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[7].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[7].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 8 && Particularprice[8].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[8].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[8].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[8].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[8].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[8].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[8].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[8]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[8]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[8]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[8].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[8].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[8].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 9 && Particularprice[9].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[9].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[9].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[9].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[9].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[9].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[9].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[9]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[9]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[9]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(
                                                        allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[9].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[9].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[9].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
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

  Widget createTableparticular3(ThemeData theme, int ij, BuildContext context) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Particularprice.length > 10 && Particularprice[10] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[10].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[10].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[10].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[10].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            )
          : Container(),
      Particularprice.length > 11 && Particularprice[11] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                 Particularprice[11].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[11].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[11].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                 Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[11].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 12 && Particularprice[12] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                 Particularprice[12].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[12].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[12].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[12].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 13 && Particularprice[13] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                 Particularprice[13].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[13].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[13].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[13].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      Particularprice.length > 14 && Particularprice[14] != null
          ? Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                 Particularprice[14].PriceList!.toLowerCase() == 'mrp'?
                "${ConstantValues.configmrp}"
                :Particularprice[14].PriceList!.toLowerCase() == 'sp'?
                "${ConstantValues.configsp}"
                :Particularprice[14].PriceList!.toLowerCase() == 'cost'?
                "${ConstantValues.configcost}"
                :
                Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? "${ConstantValues.ssp1}"
                                : Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp2'
                                ? "${ConstantValues.ssp2}"
                                : Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp3'
                                ? "${ConstantValues.ssp3}"
                                : Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp4'
                                ? "${ConstantValues.ssp4}"
                                : Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp5'
                                ? "${ConstantValues.ssp5}"
                                :Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp1_inc'
                                ? "${ConstantValues.ssp1_Inc}"
                                :Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp2_inc'
                                ? "${ConstantValues.ssp2_Inc}"
                                :Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp3_inc'
                                ? "${ConstantValues.ssp3_Inc}"
                                :Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp4_inc'
                                ? "${ConstantValues.ssp4_Inc}"
                                :Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp5_inc'
                                ? "${ConstantValues.ssp5_Inc}"
                                :
                "${Particularprice[14].PriceList}",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Particularprice.length > 10 && Particularprice[10].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[10].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[10].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[10].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[10].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[10].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[10].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[10]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[10]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[10]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[10].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[10].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[10].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 11 && Particularprice[11].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[11].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[11].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[11].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[11].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[11].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[11].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[11]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[11]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[11]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[11].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[11].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[11].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 12 && Particularprice[12].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[12].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[12].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[12].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[12].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[12].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[12].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[12]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[12]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[12]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[12].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[12].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[12].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 13 && Particularprice[13].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[13].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[13].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[13].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[13].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[13].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[13].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[13]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[13]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[13]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[13].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[13].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[13].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
      Particularprice.length > 14 && Particularprice[14].PriceList != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Particularprice[14].PriceList!.toLowerCase() == 'mrp'
                    ? config.slpitCurrency22(
                        allProductDetails[ij].mgrPrice.toString())
                    : Particularprice[14].PriceList!.toLowerCase() == 'sp'
                        ? config.slpitCurrency22(
                            allProductDetails[ij].sp.toString())
                        : Particularprice[14].PriceList!.toLowerCase() == 'cost'
                            ? config.slpitCurrency22(
                                allProductDetails[ij].slpPrice.toString())
                            : Particularprice[14].PriceList!.toLowerCase() ==
                                    'ssp1'
                                ? config.slpitCurrency22(
                                    allProductDetails[ij].ssp1.toString())
                                : Particularprice[14].PriceList!.toLowerCase() ==
                                        'ssp2'
                                    ? config.slpitCurrency22(
                                        allProductDetails[ij].ssp2.toString())
                                    : Particularprice[14].PriceList!.toLowerCase() ==
                                            'ssp3'
                                        ? config.slpitCurrency22(allProductDetails[ij]
                                            .ssp3
                                            .toString())
                                        : Particularprice[14]
                                                    .PriceList!
                                                    .toLowerCase() ==
                                                'ssp4'
                                            ? config.slpitCurrency22(
                                                allProductDetails[ij]
                                                    .ssp4
                                                    .toString())
                                            : Particularprice[14]
                                                        .PriceList!
                                                        .toLowerCase() ==
                                                    'ssp5'
                                                ? config.slpitCurrency22(
                                                    allProductDetails[ij]
                                                        .ssp5
                                                        .toString())
                                                : Particularprice[14]
                                                            .PriceList!
                                                            .toLowerCase() ==
                                                        'ssp1_inc'
                                                    ? config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString())
                                                    : Particularprice[14].PriceList!.toLowerCase() == 'ssp2_inc'
                                                        ? config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString())
                                                        : Particularprice[14].PriceList!.toLowerCase() == 'ssp3_inc'
                                                            ? config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString())
                                                            : Particularprice[14].PriceList!.toLowerCase() == 'ssp4_inc'
                                                                ? config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString())
                                                                : '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            )
          : Container(),
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

  Widget createTable(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp1}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp2}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp3}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp4}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp5}",
          style: theme.textTheme.bodyMedium
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
          style: theme.textTheme.bodyMedium?.copyWith(
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
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp5.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Whs Stock",
          style: theme.textTheme.bodyMedium
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
          style: theme.textTheme.bodyMedium?.copyWith(
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
          style: theme.textTheme.bodyMedium?.copyWith(
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
          "MRP",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "SP",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      ConstantValues.showallslab!.toLowerCase() != 'y'
          ? Container()
          : Container(
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                "Cost",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
    ]));

    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].sp.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      ConstantValues.showallslab!.toLowerCase() != 'y'
          ? Container()
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                config
                    .slpitCurrency22(allProductDetails[ij].slpPrice.toString()),
                // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
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

  Widget createTable2(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp1_Inc}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp2_Inc}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp3_Inc}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp4_Inc}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp5_Inc}",
          style: theme.textTheme.bodyMedium
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
          style: theme.textTheme.bodyMedium?.copyWith(
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
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].ssp5Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
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

  Widget createTable5(ThemeData theme, int ij) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab1}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab2}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab3}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab4}",
          style: theme.textTheme.bodyMedium
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
          config
              .slpitCurrency22(allProductDetails[ij].storeAgeSlab1.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config
              .slpitCurrency22(allProductDetails[ij].storeAgeSlab2.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config
              .slpitCurrency22(allProductDetails[ij].storeAgeSlab3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config
              .slpitCurrency22(allProductDetails[ij].storeAgeSlab4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab2}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab3}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab4}",
          style: theme.textTheme.bodyMedium
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
          style: theme.textTheme.bodyMedium?.copyWith(
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
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].whsAgeSlab3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].whsAgeSlab4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
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

  showBottomSheetInsert2forEdit(BuildContext context, int i) {
    final theme = Theme.of(context);
    int? indexshow;
    selectedItemName = productDetails[i].ItemDescription.toString();
    selectedItemCode = productDetails[i].ItemCode.toString();
    for (int ij = 0; ij < allProductDetails.length; ij++) {
      if (allProductDetails[ij].itemCode == selectedItemCode) {
        indexshow = ij;
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
                        width: Screens.width(context) * 0.8,
                        child: Text(productDetails[i].ItemCode.toString(),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: theme.primaryColor)),
                      ),
                      Container(
                        width: Screens.width(context) * 0.7,
                        // color: Colors.red,
                        child: Text(
                            productDetails[i].ItemDescription.toString(),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : createTable4(theme, indexshow!),
                      if (ConstantValues.showallslab!.toLowerCase() == 'y') ...[
                        Container()
                      ] else ...[
                        if (Particularprice.length <= 5) ...[
                          createTableparticular(theme, indexshow!, context),
                        ] else if (Particularprice.length <= 10) ...[
                          createTableparticular(theme, indexshow!, context),
                          SizedBox(height: 5),
                          createTableparticular2(theme, indexshow!, context),
                        ] else if (Particularprice.length <= 15) ...[
                          createTableparticular(theme, indexshow!, context),
                          SizedBox(height: 5),
                          createTableparticular2(theme, indexshow!, context),
                          SizedBox(height: 5),
                          createTableparticular3(theme, indexshow!, context),
                        ] else ...[
                          Container(), // Fallback if none of the conditions are met
                        ],
                      ],
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
                      //       labelStyle: theme.textTheme.bodyMedium
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
                      //           labelStyle: theme.textTheme.bodyMedium
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
                      //           labelStyle: theme.textTheme.bodyMedium
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
                      ConstantValues.showallslab!.toLowerCase() == 'y'
                          ? Container()
                          : createTableparticular(theme, indexshow!, context),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : SizedBox(
                              height: 5,
                            ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      //  SizedBox(
                      //       width: 15,
                      //     ),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : createTable(theme, indexshow!),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : SizedBox(
                              height: 5,
                            ),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : createTable2(theme, indexshow!),
                      ConstantValues.showallslab!.toLowerCase() != 'y'
                          ? Container()
                          : SizedBox(
                              height: 5,
                            ),
                      Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Store Age Slab:",
                            style: theme.textTheme.bodyMedium
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
                            style: theme.textTheme.bodyMedium
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      createTable6(theme, indexshow),
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
                      //       labelStyle: theme.textTheme.bodyMedium
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
                      //       labelStyle: theme.textTheme.bodyMedium
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
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  child: Text(
                                    ":",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(),
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
                                    child: allProductDetails[indexshow]
                                                .isFixedPrice ==
                                            true
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Allow Negative Stock",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  child: Text(
                                    ":",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(),
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
                                    child: allProductDetails[indexshow]
                                                .allowNegativeStock ==
                                            true
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )),
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
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            child: Text(
                              ":",
                              style: theme.textTheme.bodyMedium?.copyWith(),
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
                              child: allProductDetails[indexshow]
                                          .allowOrderBelowCost ==
                                      true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )),
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
    taxvalue = double.parse(allProductDetails[i].taxRate.toString());
    log("taxvalue::" + taxvalue.toString());
    sporder = allProductDetails[i].sp == null
        ? 0.0
        : double.parse(allProductDetails[i].sp.toString());
    slppriceorder = allProductDetails[i].slpPrice == null
        ? 0.0
        : double.parse(allProductDetails[i].slpPrice.toString());
    storestockorder = allProductDetails[i].storeStock == null
        ? 0.0
        : double.parse(allProductDetails[i].storeStock.toString());
    whsestockorder = allProductDetails[i].whsStock == null
        ? 0.0
        : double.parse(allProductDetails[i].whsStock.toString());
    isfixedpriceorder = allProductDetails[i].isFixedPrice;
    allownegativestockorder = allProductDetails[i].allowNegativeStock;
    alloworderbelowcostorder = allProductDetails[i].allowOrderBelowCost;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, st) {
        return couponload == true
            ? Container(
                height: Screens.padingHeight(context) * 0.3,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                                        allProductDetails[i]
                                            .itemCode
                                            .toString(),
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontSize: 13,
                                                color: theme.primaryColor)),
                                  ),
                                  Container(
                                    width: Screens.width(context) * 0.8,
                                    // color: Colors.red,
                                    child: Text(
                                        allProductDetails[i]
                                            .itemName
                                            .toString(),
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                            fontSize:
                                                13) //color: theme.primaryColor
                                        ),
                                  ),
                                ],
                              ),
                              allProductDetails[i].Isbundle == true
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        mycontroller[27].clear();
                                        mycontroller[28].clear();
                                        mycontroller[29].clear();
                                        mycontroller[30].clear();
                                        mycontroller[41].clear();

                                        showBottomSheetInsert2(context, i);
                                        notifyListeners();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        //  padding: const EdgeInsets.only(right:10 ),
                                        width: Screens.width(context) * 0.05,
                                        height: Screens.padingHeight(context) *
                                            0.04,
                                        child: Center(
                                            child: Icon(Icons.more_vert,
                                                color: Colors.white)),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                              readOnly: isappliedcoupon == true
                                  ? true
                                  : allProductDetails[i].isFixedPrice == false
                                      ? false
                                      : true,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d*')),
                              ],
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                 isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
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
                            height: 10,
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
                              readOnly: isappliedcoupon == true &&
                                      getcoupondata.isNotEmpty
                                  ? true
                                  : false,
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                 isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: "Quantity",
                              ),
                            ),
                          ),
                          //  ),
                          // SizedBox(
                          //   height: 10,
                          // ),

                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                // width: 270,
                                // height: 40,
                                child: InkWell(
                                  onTap: () {
                                    showDialog<dynamic>(
                                        context: context,
                                        builder: (_) {
                                          return ShowSearchDialog();
                                        }).then((value) {
                                      mycontroller[47].clear();
                                      filterrefpartdata = refpartdata;
                                      notifyListeners();
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Referral Partner",
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                              color: theme.primaryColor,
                                              decoration:
                                                  TextDecoration.underline),
                                    ),
                                  ),
                                ),
                                // child: new TextFormField(
                                //   controller: mycontroller[48],

                                //   readOnly: true,
                                //   onTap: () {
                                //     showDialog<dynamic>(
                                //         context: context,
                                //         builder: (_) {
                                //           return ShowSearchDialog();
                                //         }).then((value) {
                                //       mycontroller[47].clear();
                                //       filterrefpartdata = refpartdata;
                                //       notifyListeners();
                                //       //  context
                                //       //   .read<
                                //       //       NewEnqController>()
                                //       //   .setcatagorydata();
                                //     });
                                //   },
                                //   // validator: (value) {
                                //   //   if (value!.isEmpty) {
                                //   //     return "ENTER QUANTITY";
                                //   //   }
                                //   //   return null;
                                //   // },

                                //   style: TextStyle(fontSize: 15),
                                //   decoration: InputDecoration(
                                //       contentPadding: EdgeInsets.symmetric(
                                //           vertical: 10, horizontal: 10),
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(10),
                                //         ),
                                //       ),
                                //       labelText: "referal partner",
                                //       suffixIcon: Icon(Icons.search)),
                                // ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (mycontroller[11].text.isEmpty) {
                                    st(() {
                                      showtoastforcoupon("Enter QUANTITY");
                                    });
                                  } else {
                                    st(() {
//  callcouponApi();

                                      st(() {
                                        getcoupondata.clear();
                                        couponload = true;
                                      });

                                      notifyListeners();
                                      couponmodel coupondata = couponmodel();
                                      coupondata.customerCode =
                                          mycontroller[0].text;
                                      coupondata.itemCode = selectedItemCode;
                                      coupondata.storeCode =
                                          ConstantValues.Storecode;
                                      coupondata.qty =
                                          int.parse(mycontroller[11].text);
                                      coupondata.totalBillValue =
                                          double.parse(mycontroller[10].text);
                                      coupondata.requestedBy_UserCode =
                                          ConstantValues.Usercode;

                                      CouponApi.getData(coupondata)
                                          .then((value) {
                                        if (value.stcode! >= 200 &&
                                            value.stcode! <= 210) {
                                          if (value.CouponModaldatageader!
                                                      .Ordercheckdata !=
                                                  null &&
                                              value.CouponModaldatageader!
                                                  .Ordercheckdata!.isNotEmpty) {
                                            log("not null");
                                            st(() {
                                              getcoupondata = value
                                                  .CouponModaldatageader!
                                                  .Ordercheckdata!;
                                              log("getcoupondata::" +
                                                  getcoupondata.length
                                                      .toString());
                                              mycontroller[36].text =
                                                  getcoupondata[0]
                                                      .CouponCode
                                                      .toString();
                                              mycontroller[10].text =
                                                  getcoupondata[0]
                                                      .RP!
                                                      .toStringAsFixed(2);
                                              mycontroller[11].text =
                                                  getcoupondata[0]
                                                      .Quantity!
                                                      .toStringAsFixed(0);
                                              unitPrice = double.parse(
                                                  mycontroller[10].text);
                                              quantity = double.parse(
                                                  mycontroller[11].text);
                                              total = unitPrice! * quantity!;
                                              //  total = double.parse(mycontroller[10].text!) * double.parse(mycontroller[11].text!);
                                              notifyListeners();
                                              isappliedcoupon = true;

                                              notifyListeners();
                                              couponload = false;
                                            });

                                            // mapcoupon(value.CouponModaldatageader!.Ordercheckdata!);
                                            notifyListeners();
                                            // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
                                          } else if (value
                                                      .CouponModaldatageader!
                                                      .Ordercheckdata ==
                                                  null ||
                                              value.CouponModaldatageader!
                                                  .Ordercheckdata!.isEmpty) {
                                            log("Order data null");
                                            st(() {
                                              couponload = false;

                                              showtoastforcoupon(
                                                  "There is no coupon code for this customer");
                                            });

                                            notifyListeners();
                                          }
                                        } else if (value.stcode! >= 400 &&
                                            value.stcode! <= 410) {
                                          st(() {
                                            couponload = false;
                                            showtoastforcoupon(
                                                '${value.message}..!!${value.exception}....!!');
                                          });

                                          notifyListeners();
                                        } else {
                                          st(() {
                                            couponload = false;

                                            showtoastforcoupon(
                                                '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
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
                                  child: Text(
                                    "Apply Coupon Code",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                        color: theme.primaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 7,
                          ),

                          Row(
                            children: [
                              Container(
                                child: Text("Delivery From",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: theme.primaryColor)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: Screens.padingHeight(context) * 0.04,
                                // width:Screens.width(context)*0.20 ,
                                padding: EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]
                                    // borderRadius: BorderRadius.circular(5),
                                    // boxShadow:[
                                    //   BoxShadow(
                                    //   color: Colors.white,
                                    //   spreadRadius: 1,
                                    //   blurRadius: 2,
                                    //   offset: Offset(0, 15)

                                    // )
                                    // ]
                                    // border:
                                    //     Border.all(color: theme.primaryColor)
                                    ),
                                child: ToggleButtons(
                                  selectedColor: Colors.white,
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  // borderColor: theme.primaryColor,
                                  fillColor: theme.primaryColor,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                          "Store (${allProductDetails[i].storeStock!.toStringAsFixed(0)})"),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                          "Warehouse (${allProductDetails[i].whsStock!.toStringAsFixed(0)})"),
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
                            height: 7,
                          ),
                          // getcoupondata.isEmpty
                          //     ? Container()
                          //     :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            InkWell(
                              onTap:(){
                                showDialog<dynamic>(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)
                                            ),
                                            content: Container(
                                               width: Screens.width(context)*0.5,
                                               child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                    SizedBox(
  height: Screens.padingHeight(context)*0.01,
),
                                                  Container(
                                                    child: Text("Enter Coupon Code",
                                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold,fontSize: 16) ,),
                                                  ),
                                                  SizedBox(
  height: Screens.padingHeight(context)*0.01,
),
                                                   Container(
                                width: Screens.width(context) * 0.65,
                                alignment: Alignment.centerLeft,
                               
                                
                                child: TextFormField(
                                  // textAlign :TextAlign.left,
                                  controller: mycontroller[36],
                                  onEditingComplete: () {
                                   
                                  },
                                  decoration: InputDecoration(
                                     isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical:8,
                                      horizontal: 10,
                                    ),
                                    labelText: 'Coupon Code',
                                    fillColor: Colors.grey[100],
                                    filled: true,
                              
                                    labelStyle: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor,),
                                         border:UnderlineInputBorder(
                                          borderSide :BorderSide(color: theme.primaryColor),
                                          // borderRadius: BorderRadius.circular(8)

                                         ) ,
                                        //  InputBorder.none,
                                         enabledBorder: UnderlineInputBorder(
                                          borderSide :BorderSide(color: theme.primaryColor),
                                          // borderRadius: BorderRadius.circular(8)

                                         ),
                                        //  InputBorder.none,
                                //          UnderlineInputBorder(
                                 
                                // ),
                                         focusedBorder: UnderlineInputBorder(
                                          borderSide :BorderSide(color: theme.primaryColor),
                                          // borderRadius: BorderRadius.circular(8)

                                         ),
                                  ),
                                ),
                              ),
SizedBox(
  height: Screens.padingHeight(context)*0.01,
),
ElevatedButton(onPressed: (){
   if (mycontroller[11].text.isEmpty) {
                                      st(() {
                                        showtoastforcoupon("Enter QUANTITY");
                                        
                                        Navigator.pop(context);
                                         mycontroller[36].clear();
                                      });
                                    } else {
                                      st(() {
                              //  callcouponApi();
                              
                                        st(() {
                                          getcoupondata.clear();
                                          couponload = true;
                                        });
                              
                                        notifyListeners();
                                        couponmodel coupondata = couponmodel();
                                        coupondata.customerCode =
                                            mycontroller[0].text;
                                        coupondata.itemCode = selectedItemCode;
                                        coupondata.storeCode =
                                            ConstantValues.Storecode;
                                        coupondata.qty =
                                            int.parse(mycontroller[11].text);
                                        coupondata.totalBillValue =
                                            double.parse(mycontroller[10].text);
                                        coupondata.requestedBy_UserCode =
                                            ConstantValues.Usercode;
                              
                                        CouponApi.getData(coupondata)
                                            .then((value) {
                                          if (value.stcode! >= 200 &&
                                              value.stcode! <= 210) {
                                            if (value.CouponModaldatageader!
                                                        .Ordercheckdata !=
                                                    null &&
                                                value
                                                    .CouponModaldatageader!
                                                    .Ordercheckdata!
                                                    .isNotEmpty) {
                                              log("not null");
                                              st(() {
                                                getcoupondata = value
                                                    .CouponModaldatageader!
                                                    .Ordercheckdata!;
                                                log("getcoupondata::" +
                                                    getcoupondata.length
                                                        .toString());
                                                if (mycontroller[36].text ==
                                                    getcoupondata[0]
                                                        .CouponCode) {
                                                  mycontroller[10].text =
                                                      getcoupondata[0]
                                                          .RP!
                                                          .toStringAsFixed(2);
                                                  mycontroller[11].text =
                                                      getcoupondata[0]
                                                          .Quantity!
                                                          .toStringAsFixed(0);
                                                  unitPrice = double.parse(
                                                      mycontroller[10].text);
                                                  quantity = double.parse(
                                                      mycontroller[11].text);
                                                  total =
                                                      unitPrice! * quantity!;
                                                        
                                                  //  total = double.parse(mycontroller[10].text!) * double.parse(mycontroller[11].text!);
                                                  notifyListeners();
                                                  isappliedcoupon = true;
                              
                                                  notifyListeners();
                                                  couponload = false;
                                                  Navigator.pop(context);
                                                } else {
                                                 st((){
                                                  couponload = false;
                                                  showtoastforcoupon(
                                                    "Entered coupon code is not valid");
                                                mycontroller[36].clear();
                                                Navigator.pop(context);
                                                });
                                                }
                                                // mycontroller[36].text =
                                                //     getcoupondata[0]
                                                //         .CouponCode
                                                //         .toString();
                                              });
                              
                                              // mapcoupon(value.CouponModaldatageader!.Ordercheckdata!);
                                              notifyListeners();
                                              // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
                                            } else if (value
                                                        .CouponModaldatageader!
                                                        .Ordercheckdata ==
                                                    null ||
                                                value.CouponModaldatageader!
                                                    .Ordercheckdata!.isEmpty) {
                                              log("Order data null");
                                              st(() {
                                                couponload = false;
                              
                                                showtoastforcoupon(
                                                    "Entered coupon code is not valid");
                                                    Navigator.pop(context);
                                                mycontroller[36].clear();
                                              });
                              
                                              notifyListeners();
                                            }
                                          } else if (value.stcode! >= 400 &&
                                              value.stcode! <= 410) {
                                            st(() {
                                              couponload = false;
                                              showtoastforcoupon(
                                                  '${value.message}..!!${value.exception}....!!');
                                                  Navigator.pop(context);
                                              mycontroller[36].clear();
                                            });
                              
                                            notifyListeners();
                                          } else {
                                            st(() {
                                              couponload = false;
                              
                                              showtoastforcoupon(
                                                  '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
                                                  Navigator.pop(context);
                                              mycontroller[36].clear();
                                            });
                              
                                            notifyListeners();
                                          }
                                          notifyListeners();
                                        });
                                      });
                                    }
}, child: Text("ok"))
                                                ],
                                               ),
                                            ),
                                          );
                                        }).then((value) => null);
                              },
                              child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Coupon Code  ",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.primaryColor,
                                                decoration:
                                                    TextDecoration.underline),
                                      ),
                                    ),
                            ),

                         mycontroller[36].text.isEmpty?Container():     Container(
                                width: Screens.width(context) * 0.40,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(8),
                                
                                decoration: BoxDecoration(
 color:Colors.grey[200],
 borderRadius: BorderRadius.circular(8)
                                ),
                               
                                child: Text(mycontroller[36].text)
                              //   TextFormField(
                              //     textAlign :TextAlign.left,
                              //     controller: mycontroller[36],
                              //     onEditingComplete: () {
                              //       if (mycontroller[11].text.isEmpty) {
                              //         st(() {
                              //           showtoastforcoupon("Enter QUANTITY");
                              //         });
                              //       } else {
                              //         st(() {
                              // //  callcouponApi();
                              
                              //           st(() {
                              //             getcoupondata.clear();
                              //             couponload = true;
                              //           });
                              
                              //           notifyListeners();
                              //           couponmodel coupondata = couponmodel();
                              //           coupondata.customerCode =
                              //               mycontroller[0].text;
                              //           coupondata.itemCode = selectedItemCode;
                              //           coupondata.storeCode =
                              //               ConstantValues.Storecode;
                              //           coupondata.qty =
                              //               int.parse(mycontroller[11].text);
                              //           coupondata.totalBillValue =
                              //               double.parse(mycontroller[10].text);
                              //           coupondata.requestedBy_UserCode =
                              //               ConstantValues.Usercode;
                              
                              //           CouponApi.getData(coupondata)
                              //               .then((value) {
                              //             if (value.stcode! >= 200 &&
                              //                 value.stcode! <= 210) {
                              //               if (value.CouponModaldatageader!
                              //                           .Ordercheckdata !=
                              //                       null &&
                              //                   value
                              //                       .CouponModaldatageader!
                              //                       .Ordercheckdata!
                              //                       .isNotEmpty) {
                              //                 log("not null");
                              //                 st(() {
                              //                   getcoupondata = value
                              //                       .CouponModaldatageader!
                              //                       .Ordercheckdata!;
                              //                   log("getcoupondata::" +
                              //                       getcoupondata.length
                              //                           .toString());
                              //                   if (mycontroller[36].text ==
                              //                       getcoupondata[0]
                              //                           .CouponCode) {
                              //                     mycontroller[10].text =
                              //                         getcoupondata[0]
                              //                             .RP!
                              //                             .toStringAsFixed(2);
                              //                     mycontroller[11].text =
                              //                         getcoupondata[0]
                              //                             .Quantity!
                              //                             .toStringAsFixed(0);
                              //                     unitPrice = double.parse(
                              //                         mycontroller[10].text);
                              //                     quantity = double.parse(
                              //                         mycontroller[11].text);
                              //                     total =
                              //                         unitPrice! * quantity!;
                              //                     //  total = double.parse(mycontroller[10].text!) * double.parse(mycontroller[11].text!);
                              //                     notifyListeners();
                              //                     isappliedcoupon = true;
                              
                              //                     notifyListeners();
                              //                     couponload = false;
                              //                   } else {
                              //                     showtoastforcoupon(
                              //                         "you entered coupon code is not valid");
                              //                     mycontroller[36].clear();
                              //                   }
                              //                   // mycontroller[36].text =
                              //                   //     getcoupondata[0]
                              //                   //         .CouponCode
                              //                   //         .toString();
                              //                 });
                              
                              //                 // mapcoupon(value.CouponModaldatageader!.Ordercheckdata!);
                              //                 notifyListeners();
                              //                 // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
                              //               } else if (value
                              //                           .CouponModaldatageader!
                              //                           .Ordercheckdata ==
                              //                       null ||
                              //                   value.CouponModaldatageader!
                              //                       .Ordercheckdata!.isEmpty) {
                              //                 log("Order data null");
                              //                 st(() {
                              //                   couponload = false;
                              
                              //                   showtoastforcoupon(
                              //                       "you entered coupon code is not valid");
                              //                   mycontroller[36].clear();
                              //                 });
                              
                              //                 notifyListeners();
                              //               }
                              //             } else if (value.stcode! >= 400 &&
                              //                 value.stcode! <= 410) {
                              //               st(() {
                              //                 couponload = false;
                              //                 showtoastforcoupon(
                              //                     '${value.message}..!!${value.exception}....!!');
                              //                 mycontroller[36].clear();
                              //               });
                              
                              //               notifyListeners();
                              //             } else {
                              //               st(() {
                              //                 couponload = false;
                              
                              //                 showtoastforcoupon(
                              //                     '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
                              //                 mycontroller[36].clear();
                              //               });
                              
                              //               notifyListeners();
                              //             }
                              //             notifyListeners();
                              //           });
                              //         });
                              //       }
                              //     },
                              //     decoration: InputDecoration(
                              //       isDense: true,
                              //       contentPadding: const EdgeInsets.symmetric(
                              //         vertical: 3,
                              //         horizontal: 0,
                              //       ),
                              //       labelText: 'Coupon Code',
                              //       // fillColor: Colors.grey[200],
                              //       // filled: true,
                              
                              //       labelStyle: theme.textTheme.bodyMedium!
                              //           .copyWith(color: theme.primaryColor,decoration:TextDecoration.underline),
                              //            border:InputBorder.none ,
                              //           //  InputBorder.none,
                              //            enabledBorder: InputBorder.none,
                              //   //          UnderlineInputBorder(
                                 
                              //   // ),
                              //            focusedBorder: InputBorder.none,
                              //   //          UnderlineInputBorder(
                                 
                              //   // ),
                                         
                              //       // enabledBorder: UnderlineInputBorder(
                              //       //   borderSide:
                              //       //       BorderSide(color: Colors.grey),
                              //       //   //  when the TextFormField in unfocused
                              //       // ),
                              //       // focusedBorder: UnderlineInputBorder(
                              //       //   borderSide:
                              //       //       BorderSide(color: Colors.grey),
                              //       //   //  when the TextFormField in focused
                              //       // ),
                              //       // border: UnderlineInputBorder(),
                              //       // // enabledBorder: UnderlineInputBorder(),
                              //       // // focusedBorder: UnderlineInputBorder(),
                              //       // errorBorder: UnderlineInputBorder(),
                              //       // focusedErrorBorder: UnderlineInputBorder(),
                              //     ),
                              //   ),
                            
                              ),
                            ],
                          ),
                          //  selectedapartcode !=null||selectedapartcode.isNotEmpty?   Align(
                          //         alignment: Alignment.bottomLeft,
                          //         child: Text("Refcode: $selectedapartcode")):Container(),
                          Align(
                              alignment: Alignment.bottomRight,
                              child:
                                  Text("Total: ${total.toStringAsFixed(2)}")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")),
                              isUpdateClicked == false
                                  ? ElevatedButton(
                                      onPressed: () {
                                        if (mycontroller[11].text.isNotEmpty &&
                                            int.parse(mycontroller[11].text) >
                                                0) {
                                          if (allProductDetails[i].Isbundle ==
                                              true) {
                                            log("hhh::" +
                                                allProductDetails[i]
                                                    .id
                                                    .toString());
                                            callbundleApi(
                                                context,
                                                allProductDetails[i].id!,
                                                true,
                                                i,
                                                allProductDetails[i]);
                                          } else {
                                            if (ConstantValues.unitpricelogic!
                                                    .toLowerCase() ==
                                                'y') {
                                              callPricecheckApi(
                                                  allProductDetails[i].itemCode,
                                                  int.parse(
                                                      mycontroller[11].text),
                                                  double.parse(
                                                      mycontroller[10].text),
                                                  mycontroller[36].text!.isEmpty
                                                      ? ''
                                                      : mycontroller[36].text,
                                                  context,
                                                  theme,
                                                  i,
                                                  true,
                                                  allProductDetails[i]);
                                            } else {
                                              if (ConstantValues.ordergiftlogic!
                                                      .toLowerCase() ==
                                                  'y') {
                                                callgiftApi(
                                                    allProductDetails[i]
                                                        .itemCode
                                                        .toString(),
                                                    int.parse(
                                                        mycontroller[11].text),
                                                    double.parse(
                                                        mycontroller[10].text),
                                                    context,
                                                    i,
                                                    theme,
                                                    true,
                                                    allProductDetails[i]);
                                              } else {
                                                mycontroller[12].clear();
                                                addProductDetails(
                                                    context,
                                                    allProductDetails[i],
                                                    false,
                                                    null);
                                              }
                                            }
                                          }
                                        } else {
                                          showtoastproduct();
                                        }
                                      },
                                      child: Text("Ok"))
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (mycontroller[11].text.isNotEmpty &&
                                            int.parse(mycontroller[11].text) >
                                                0) {
                                          updateProductDetails(
                                              context, i, allProductDetails[i]);
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

  List<giftitems> giftlist = [];
  giftitemsadd() {
    giftlist = [
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          offerprice: 10.00,
          name: "Vector 1",
          itemcode: "Vector itemcode",
          price: 100.00,
          quantity: "0",
          addproduct: false),
      giftitems(
          name: "Vector 2",
          itemcode: "Vector2 itemcode",
          price: 100.00,
          quantity: "0",
          offerprice: 10.00,
          addproduct: false)
    ];
  }

  checkeligible() {
    int? eligible = 0;
    eligible = 0;
    for (int i = 0; i < ordergiftData.length; i++) {
      if (ordergiftData[i].quantity! > 0) {
        eligible = eligible! + 1;
      }
    }
    return eligible;
  }
valuebasedcheckeligible2() {
    int? eligible = 0;
    eligible = 0;
    for (int i = 0; i < valuegiftitems.length; i++) {
      if (valuegiftitems[i].quantity! > 0) {
        eligible = eligible! + valuegiftitems[i].quantity!;
      }
    }
    log("eligibleeligible::" + eligible.toString());
    return eligible;
  }
  checkeligible2() {
    int? eligible = 0;
    eligible = 0;
    for (int i = 0; i < ordergiftData.length; i++) {
      if (ordergiftData[i].quantity! > 0) {
        eligible = eligible! + ordergiftData[i].quantity!;
      }
    }
    log("eligibleeligible::" + eligible.toString());
    return eligible;
  }

   valuebasegiftitems(ThemeData theme,BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) => StatefulBuilder(builder: (context, st) {
              return Container(
                decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Screens.width(context) * 0.7,
                          child: Text("Value Based Offers ",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        // ConstantValues.ordergiftskip!.toLowerCase() == 'y'
                        //     ? Container()
                        //     : 
                            GestureDetector(
                                onTap: () {
                                  st((){
                                     Navigator.pop(context);
 pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      getTotalaoyAmount();
     
                                  });
                                  
                                },
                                child: Container(
                                  // width: Screens.width(context)*0.7,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: theme.primaryColor))),
                                  child: Row(
                                    children: [
                                      Text("Skip",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: theme.primaryColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                      Icon(
                                        Icons.keyboard_double_arrow_right,
                                        color: theme.primaryColor,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      child: Text(
                          "Eligible Gifts : ${valuegiftitems != null && valuegiftitems.isNotEmpty ? valuegiftitems[0].GiftQty!.toStringAsFixed(0) : ""}",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 15)),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    // Container(
                    //   child: Text(
                    //       "Minimum eligible price : ${ordergiftData != null && ordergiftData.isNotEmpty ? "${ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp1' ? ConstantValues.ssp1 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp2' ? ConstantValues.ssp2 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp3' ? ConstantValues.ssp3 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp4' ? ConstantValues.ssp4 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp5' ? ConstantValues.ssp5 : ordergiftData[0].UptoPriceSlab!}" '-' "${ordergiftData[0].MinimumPrice!.toStringAsFixed(2)}" : ""}",
                    //       style: theme.textTheme.bodyMedium!.copyWith(
                    //           color: theme.primaryColor, fontSize: 15)),
                    // ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                        // height: Screens.padingHeight(context) * 0.3,
                        child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: Screens.padingHeight(context) * 0.5),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: valuegiftitems.length,
                          itemBuilder: (context, i) {
                            return Container(
                                child: Card(
                                    elevation: 5,
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius:
                                    //         BorderRadius.circular(10)),
                                    // color: Colors.grey[100],
                                    child: Container(
                                        width: Screens.width(context),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                            horizontal:
                                                Screens.width(context) * 0.02),
                                        //                                decoration: BoxDecoration(
                                        // border: Border(
                                        //     left: BorderSide(
                                        //         color: theme.primaryColor,
                                        //         width: Screens.width(context) * 0.05))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.6,
                                                        child: Text(
                                                            "${valuegiftitems[i].ItemCode}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              fontSize: 15,
                                                              // color:Colors.grey,
                                                              // fontWeight: FontWeight.bold
                                                            ))),
                                                    SizedBox(
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.6,
                                                        child: Text(
                                                            "${valuegiftitems[i].ItemName}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              fontSize: 15,
                                                              // fontWeight: FontWeight.bold,
                                                              // decoration: TextDecoration.lineThrough
                                                            ))),
                                                  ],
                                                ),
                                                Container(
                                                    child: Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                      GestureDetector(
                                                        onTap: valuegiftitems[i]
                                                                    .quantity ==
                                                                valuegiftitems[i]
                                                                    .MinQty
                                                            ? () {
                                                                //   st(() {
                                                                //     showtoastgift(
                                                                //         "Allowed Quantity for this product is ${ordergiftData[i].Attach_Qty}..!!");
                                                                //   });
                                                              }
                                                            : () {
                                                                st(() {
                                                                  int? qty = int.parse(valuegiftitems[
                                                                              i]
                                                                          .quantity
                                                                          .toString()) -
                                                                      1;
                                                                  valuegiftitems[
                                                                              i]
                                                                          .quantity =
                                                                      qty;
                                                                });
                                                              },
                                                        child: Container(
                                                          child: Icon(
                                                              Icons.remove,
                                                              color: theme
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                            "${valuegiftitems[i].quantity}",
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      GestureDetector(
                                                        onTap: valuegiftitems[i]
                                                                    .quantity ==
                                                                valuegiftitems[i]
                                                                    .MaxQty
                                                            ? () {
                                                                st(() {
                                                                  showtoastgift(
                                                                      "Allowed Quantity for this product is ${valuegiftitems[i].MaxQty}..!!");
                                                                });
                                                              }
                                                            : valuebasedcheckeligible2() >=
                                                                    valuegiftitems[
                                                                            0]
                                                                        .GiftQty
                                                                //         &&
                                                                // ordergiftData[i]
                                                                //         .quantity ==
                                                                //     0
                                                                ? () {
                                                                    st(() {
                                                                      showtoastgift(
                                                                          "Eligible gift quantity is ${valuegiftitems[0].GiftQty!.toStringAsFixed(0)}..!!");
                                                                    });
                                                                  }
                                                                : () {
                                                                    st(() {
                                                                      int? qty =
                                                                          int.parse(valuegiftitems[i].quantity.toString()) +
                                                                              1;
                                                                      valuegiftitems[
                                                                              i]
                                                                          .quantity = qty;
                                                                    });
                                                                  },
                                                        // valuegiftitems[i]
                                                        //             .quantity ==
                                                        //         valuegiftitems[i]
                                                        //             .MaxQty
                                                        //     ? () {
                                                        //         st(() {
                                                        //           showtoastgift(
                                                        //               "Maximun Quantity for this product is ${valuegiftitems[i].MaxQty}..!!");
                                                        //         });
                                                        //       }:
                                                        //     // : checkeligible2() >=
                                                        //     //         valuegiftitems[
                                                        //     //                 0]
                                                        //     //             .GiftQty
                                                        //     //     //         &&
                                                        //     //     // ordergiftData[i]
                                                        //     //     //         .quantity ==
                                                        //     //     //     0
                                                        //     //     ? () {
                                                        //     //         st(() {
                                                        //     //           showtoastgift(
                                                        //     //               "Eligible gift quantity is ${ordergiftData[0].GiftQty!.toStringAsFixed(0)}..!!");
                                                        //     //         });
                                                        //     //       }
                                                        //     //     :
                                                        //          () {
                                                        //             st(() {
                                                        //               int? qty =
                                                        //                   int.parse(valuegiftitems[i].quantity.toString()) +
                                                        //                       1;
                                                        //               valuegiftitems[
                                                        //                       i]
                                                        //                   .quantity = qty;
                                                        //             });
                                                        //           },
                                                        child: Container(
                                                          child: Icon(Icons.add,
                                                              color: theme
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                    ]))
                                              ],
                                            ),
                                           
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        child: Text("Price : ",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    // fontSize: 15,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // decoration: TextDecoration.lineThrough

                                                                    ))),
                                                    Container(
                                                        child: Text(
                                                            "${config.slpitCurrency22(valuegiftitems[i].Price.toString())}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    // fontWeight: FontWeight.bold,
                                                                   ))),
                                                  ],
                                                ),
                                                // Container(
                                                //     child: Text(
                                                //         "Offer Price : ${config.slpitCurrency22(ordergiftData[i].Price.toString())}",
                                                //         style: theme.textTheme
                                                //             .bodyMedium!
                                                //             .copyWith(
                                                //           fontSize: 15,
                                                //           // fontWeight: FontWeight.bold,
                                                //           // decoration: TextDecoration.lineThrough
                                                //         ))),
                                              ],
                                            ),
                                          ],
                                        ))));
                          }),
                    )),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      width: Screens.width(context),
                      // color: Colors.amber,
                      // alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () async{
                            if (valuebasedcheckeligible2() > valuegiftitems[0].GiftQty) {
                              st(() {
                                showtoastgift(
                                    "Eligible gift quantity is ${valuegiftitems[0].GiftQty!.toStringAsFixed(0)}..!!");
                              });
                            }else{
                              if (valuegiftitems[0].Allowpartialgift == 0){
   if(valuebasedcheckeligible2() == valuegiftitems[0].GiftQty){
 for(int ib =0;ib<valuegiftitems.length;ib++){
                              if(valuegiftitems[ib].quantity! >0){
                                for (int ij = 0; ij < allProductDetails.length; ij++) {
                
                if (allProductDetails[ij].itemCode ==
                    valuegiftitems[ib].ItemCode) {
                      linkedItemsdatacheck=[];
                       await calllinkedApi22( valuegiftitems[ib].ItemCode);
                  taxvalue =
                      double.parse(allProductDetails[ij].taxRate.toString());
                  slppriceorder = allProductDetails[ij].slpPrice == null
                      ? 0.0
                      : double.parse(allProductDetails[ij].slpPrice.toString());
                  storestockorder = allProductDetails[ij].storeStock == null
                      ? 0.0
                      : double.parse(
                          allProductDetails[ij].storeStock.toString());
                  whsestockorder = allProductDetails[ij].whsStock == null
                      ? 0.0
                      : double.parse(allProductDetails[ij].whsStock.toString());
                  isfixedpriceorder = allProductDetails[ij].isFixedPrice;
                  allownegativestockorder =
                      allProductDetails[ij].allowNegativeStock;
                  alloworderbelowcostorder =
                      allProductDetails[ij].allowOrderBelowCost;
                  break;
                }
              }
           productDetails.add(DocumentLines(
                  bundleId: null,
                  itemtype: 'V',
                  OfferSetup_Id: valuegiftitems[ib].OfferSetup_Id,
                  id: 0,
                  docEntry: 0,
                  linenum: 0,
                  ItemCode: valuegiftitems[ib].ItemCode,
                  ItemDescription: valuegiftitems[ib].ItemName,
                  Quantity: valuegiftitems[ib].quantity!.toDouble(),
                  LineTotal:valuegiftitems[ib].quantity!*valuegiftitems[ib].Price!,
                  Price: valuegiftitems[ib].Price,
                  TaxCode: taxvalue,
                  TaxLiable: "tNO",
                 slpprice: slppriceorder,
                  storestock: storestockorder,
                  whsestock: whsestockorder,
                  isfixedprice: isfixedpriceorder,
                  allownegativestock: allownegativestockorder,
                  alloworderbelowcost: alloworderbelowcostorder,
                  storecode: ConstantValues.Storecode,
                  deliveryfrom:  "store" ,
                  linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                  couponcode: null,
                  partcode:
                      null,
                  partname:
                      null,
                  ));
                    
                              }
                              // else{
                              //   st(() {
                              //                                     showtoastgift(
                              //                                         "All items quantity is 0..!!");
                              //                                   }); 
                              // }
                             

                            }
                  
                          Navigator.pop(context);
                              }else{
                                showtoastgift(
                                        "Eligible gift quantity is ${valuegiftitems[0].GiftQty!.toStringAsFixed(0)}..!!");
                                  
                              }
                              }else if(valuegiftitems[0].Allowpartialgift ==
                                  1) {
                                //  else
                                if (valuebasedcheckeligible2() <=
                                    valuegiftitems[0].GiftQty){
                                      for(int ib =0;ib<valuegiftitems.length;ib++){
                              if(valuegiftitems[ib].quantity! >0){
                                for (int ij = 0; ij < allProductDetails.length; ij++) {
                
                if (allProductDetails[ij].itemCode ==
                    valuegiftitems[ib].ItemCode) {
                      linkedItemsdatacheck=[];
                       await calllinkedApi22( valuegiftitems[ib].ItemCode);
                  taxvalue =
                      double.parse(allProductDetails[ij].taxRate.toString());
                  slppriceorder = allProductDetails[ij].slpPrice == null
                      ? 0.0
                      : double.parse(allProductDetails[ij].slpPrice.toString());
                  storestockorder = allProductDetails[ij].storeStock == null
                      ? 0.0
                      : double.parse(
                          allProductDetails[ij].storeStock.toString());
                  whsestockorder = allProductDetails[ij].whsStock == null
                      ? 0.0
                      : double.parse(allProductDetails[ij].whsStock.toString());
                  isfixedpriceorder = allProductDetails[ij].isFixedPrice;
                  allownegativestockorder =
                      allProductDetails[ij].allowNegativeStock;
                  alloworderbelowcostorder =
                      allProductDetails[ij].allowOrderBelowCost;
                  break;
                }
              }
           productDetails.add(DocumentLines(
                  bundleId: null,
                  itemtype: 'V',
                  OfferSetup_Id: valuegiftitems[ib].OfferSetup_Id,
                  id: 0,
                  docEntry: 0,
                  linenum: 0,
                  ItemCode: valuegiftitems[ib].ItemCode,
                  ItemDescription: valuegiftitems[ib].ItemName,
                  Quantity: valuegiftitems[ib].quantity!.toDouble(),
                  LineTotal:valuegiftitems[ib].quantity!*valuegiftitems[ib].Price!,
                  Price: valuegiftitems[ib].Price,
                  TaxCode: taxvalue,
                  TaxLiable: "tNO",
                 slpprice: slppriceorder,
                  storestock: storestockorder,
                  whsestock: whsestockorder,
                  isfixedprice: isfixedpriceorder,
                  allownegativestock: allownegativestockorder,
                  alloworderbelowcost: alloworderbelowcostorder,
                  storecode: ConstantValues.Storecode,
                  deliveryfrom:  "store" ,
                  linkeditems: linkedItemsdatacheck.length > 0 ? true : false,
                  couponcode: null,
                  partcode:
                      null,
                  partname:
                      null,
                  ));
                    
                              }
                              // else{
                              //   st(() {
                              //                                     showtoastgift(
                              //                                         "All items quantity is 0..!!");
                              //                                   }); 
                              // }
                             

                            }
                  
                          Navigator.pop(context);

                                    }}
                           
  
                            }
                         
                          },
                          child: Text("Attach offers")),
                    ),
                  ],
                ),
              );
            })).then((value) {});
  }

  showgiftitems(BuildContext context, int index, ThemeData theme,
      bool addproduct, ItemMasterDBModel updateallProductDetails) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) => StatefulBuilder(builder: (context, st) {
              return Container(
                decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Screens.width(context) * 0.7,
                          child: Text("Recommended offers ",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ConstantValues.ordergiftskip!.toLowerCase() == 'y'
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  st(() {
                                    if (addproduct == true) {
                                      mycontroller[12].clear();
                                      ordergiftData.clear();
                                      addProductDetails(
                                          context,
                                          allProductDetails[index],
                                          false,
                                          null);
                                      notifyListeners();
                                    } else if (addproduct == false) {
                                      ordergiftData.clear();
                                      updateProductDetails(context, index,
                                          updateallProductDetails);
                                    }
                                  });
                                },
                                child: Container(
                                  // width: Screens.width(context)*0.7,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: theme.primaryColor))),
                                  child: Row(
                                    children: [
                                      Text("Skip",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: theme.primaryColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                      Icon(
                                        Icons.keyboard_double_arrow_right,
                                        color: theme.primaryColor,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      child: Text(
                          "Eligible Gifts : ${ordergiftData != null && ordergiftData.isNotEmpty ? ordergiftData[0].GiftQty!.toStringAsFixed(0) : ""}",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 15)),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      child: Text(
                          "Minimum eligible price : ${ordergiftData != null && ordergiftData.isNotEmpty ? "${ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp1' ? ConstantValues.ssp1 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp2' ? ConstantValues.ssp2 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp3' ? ConstantValues.ssp3 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp4' ? ConstantValues.ssp4 : ordergiftData[0].UptoPriceSlab!.toLowerCase() == 'ssp5' ? ConstantValues.ssp5 : ordergiftData[0].UptoPriceSlab!}" '-' "${ordergiftData[0].MinimumPrice!.toStringAsFixed(2)}" : ""}",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 15)),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                        // height: Screens.padingHeight(context) * 0.3,
                        child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: Screens.padingHeight(context) * 0.5),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ordergiftData.length,
                          itemBuilder: (context, i) {
                            return Container(
                                child: Card(
                                    elevation: 5,
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius:
                                    //         BorderRadius.circular(10)),
                                    // color: Colors.grey[100],
                                    child: Container(
                                        width: Screens.width(context),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                            horizontal:
                                                Screens.width(context) * 0.02),
                                        //                                decoration: BoxDecoration(
                                        // border: Border(
                                        //     left: BorderSide(
                                        //         color: theme.primaryColor,
                                        //         width: Screens.width(context) * 0.05))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.6,
                                                        child: Text(
                                                            "${ordergiftData[i].ItemCode}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              fontSize: 15,
                                                              // color:Colors.grey,
                                                              // fontWeight: FontWeight.bold
                                                            ))),
                                                    SizedBox(
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.6,
                                                        child: Text(
                                                            "${ordergiftData[i].ItemName}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              fontSize: 15,
                                                              // fontWeight: FontWeight.bold,
                                                              // decoration: TextDecoration.lineThrough
                                                            ))),
                                                  ],
                                                ),
                                                Container(
                                                    child: Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                      GestureDetector(
                                                        onTap: ordergiftData[i]
                                                                    .quantity ==
                                                                ordergiftData[i]
                                                                    .MinQty
                                                            ? () {
                                                                //   st(() {
                                                                //     showtoastgift(
                                                                //         "Allowed Quantity for this product is ${ordergiftData[i].Attach_Qty}..!!");
                                                                //   });
                                                              }
                                                            : () {
                                                                st(() {
                                                                  int? qty = int.parse(ordergiftData[
                                                                              i]
                                                                          .quantity
                                                                          .toString()) -
                                                                      1;
                                                                  ordergiftData[
                                                                              i]
                                                                          .quantity =
                                                                      qty;
                                                                });
                                                              },
                                                        child: Container(
                                                          child: Icon(
                                                              Icons.remove,
                                                              color: theme
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                            "${ordergiftData[i].quantity}",
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                      ),
                                                      SizedBox(
                                                        width: Screens.width(
                                                                context) *
                                                            0.01,
                                                      ),
                                                      GestureDetector(
                                                        onTap: ordergiftData[i]
                                                                    .quantity ==
                                                                ordergiftData[i]
                                                                    .Attach_Qty
                                                            ? () {
                                                                st(() {
                                                                  showtoastgift(
                                                                      "Allowed Quantity for this product is ${ordergiftData[i].Attach_Qty}..!!");
                                                                });
                                                              }
                                                            : checkeligible2() >=
                                                                    ordergiftData[
                                                                            0]
                                                                        .GiftQty
                                                                //         &&
                                                                // ordergiftData[i]
                                                                //         .quantity ==
                                                                //     0
                                                                ? () {
                                                                    st(() {
                                                                      showtoastgift(
                                                                          "Eligible gift quantity is ${ordergiftData[0].GiftQty!.toStringAsFixed(0)}..!!");
                                                                    });
                                                                  }
                                                                : () {
                                                                    st(() {
                                                                      int? qty =
                                                                          int.parse(ordergiftData[i].quantity.toString()) +
                                                                              1;
                                                                      ordergiftData[
                                                                              i]
                                                                          .quantity = qty;
                                                                    });
                                                                  },
                                                        child: Container(
                                                          child: Icon(Icons.add,
                                                              color: theme
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                    ]))
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height: Screens
                                            //           .padingHeight(
                                            //               context) *
                                            //       0.01,
                                            // ),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   children: [

                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        child: Text("MRP : ",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    // fontSize: 15,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // decoration: TextDecoration.lineThrough

                                                                    ))),
                                                    Container(
                                                        child: Text(
                                                            "${config.slpitCurrency22(ordergiftData[i].MRP.toString())}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    // fontWeight: FontWeight.bold,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough))),
                                                  ],
                                                ),
                                                Container(
                                                    child: Text(
                                                        "Offer Price : ${config.slpitCurrency22(ordergiftData[i].Price.toString())}",
                                                        style: theme.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          fontSize: 15,
                                                          // fontWeight: FontWeight.bold,
                                                          // decoration: TextDecoration.lineThrough
                                                        ))),
                                              ],
                                            ),
                                          ],
                                        ))));
                          }),
                    )),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      width: Screens.width(context),
                      // color: Colors.amber,
                      // alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            if (checkeligible2() > ordergiftData[0].GiftQty) {
                              st(() {
                                showtoastgift(
                                    "Eligible gift quantity is ${ordergiftData[0].GiftQty!.toStringAsFixed(0)}..!!");
                              });
                            } else {
                              if (ordergiftData[0].allowpartialgift == 0) {
                                if (checkeligible2() ==
                                    ordergiftData[0].GiftQty) {
                                  bool isproceed3newgift = false;
                                  int? indexgift2;
                                  isproceed3newgift = false;
                                  indexgift2 = null;
                                  for (int ik = 0;
                                      ik < ordergiftData.length;
                                      ik++) {
                                    if (ordergiftData[ik].quantity! > 0) {
                                      if (ordergiftData[ik].quantity! <
                                          ordergiftData[ik].MinQty!) {
                                        isproceed3newgift = true;
                                        indexgift2 = ik;
                                        break;
                                      }
                                    }
                                  }
                                  if (isproceed3newgift == true) {
                                    showtoastgift(
                                        "${ordergiftData[indexgift2!].ItemCode} Minimum Quantity should be  ${ordergiftData[indexgift2!].MinQty}..!!");
                                  } else {
                                    if (addproduct == true) {
                                      mycontroller[12].clear();
                                      addProductDetails(
                                          context,
                                          allProductDetails[index],
                                          false,
                                          null);
                                      notifyListeners();
                                    } else if (addproduct == false) {
                                      updateProductDetails(context, index,
                                          updateallProductDetails);
                                    }
                                  }
                                } else {
                                  st(() {
                                    log("mandatory");
                                    showtoastgift(
                                        "Eligible gift quantity is ${ordergiftData[0].GiftQty!.toStringAsFixed(0)}..!!");
                                  });
                                }
                              } else if (ordergiftData[0].allowpartialgift ==
                                  1) {
                                //  else
                                if (checkeligible2() <=
                                    ordergiftData[0].GiftQty) {
                                  bool isproceed3new = false;
                                  int? indexgift;
                                  isproceed3new = false;
                                  indexgift = null;
                                  for (int ik = 0;
                                      ik < ordergiftData.length;
                                      ik++) {
                                    if (ordergiftData[ik].quantity! > 0) {
                                      if (ordergiftData[ik].quantity! <
                                          ordergiftData[ik].MinQty!) {
                                        isproceed3new = true;
                                        indexgift = ik;
                                        break;
                                      }
                                    }
                                  }
                                  if (isproceed3new == true) {
                                    showtoastgift(
                                        "${ordergiftData[indexgift!].ItemCode} Minimum Quantity should be  ${ordergiftData[indexgift!].MinQty}..!!");
                                  } else {
                                    if (addproduct == true) {
                                      mycontroller[12].clear();
                                      addProductDetails(
                                          context,
                                          allProductDetails[index],
                                          false,
                                          null);
                                      notifyListeners();
                                    } else if (addproduct == false) {
                                      updateProductDetails(context, index,
                                          updateallProductDetails);
                                    }
                                  }
                                }
                              }
                            }

                            // st(() {
                            //   bool isproceed = false;
                            //   int? indexgift;
                            //   isproceed = false;
                            //   indexgift = null;
                            //   for (int ij = 0;
                            //       ij < ordergiftData.length;
                            //       ij++) {
                            //     if (ordergiftData[ij].quantity! > 0) {
                            //       isproceed = true;
                            //     }
                            //   }
                            //   if (isproceed == true) {
                            //     if (addproduct == true) {
                            //       mycontroller[12].clear();
                            //       addProductDetails(
                            //           context, allProductDetails[index]);
                            //       notifyListeners();
                            //     } else if (addproduct == false) {
                            //       updateProductDetails(
                            //           context, index, updateallProductDetails);
                            //     }
                            //     // mycontroller[12].clear();
                            //     // addProductDetails(
                            //     //     context, allProductDetails[index]);
                            //   } else {
                            //     showtoastgift(
                            //         "gift Products Quantity should be greater than 0..!!");
                            //   }
                            // });
                          },
                          child: Text("Attach offers")),
                    ),
                  ],
                ),
              );
            })).then((value) => Navigator.pop(context));
  }

  List<GetAllcouponData> getcoupondata = [];
  bool? couponload = false;
  bool? isappliedcoupon = false;
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

  callcouponApi() async {}

  mapcoupon(List<GetAllcouponData> getcoupondata) {
    notifyListeners();
  }

  showBottomSheetInsertforedit(
    BuildContext context,
    int i,
  ) {
    int? indexupdate;
    final theme = Theme.of(context);

    selectedItemName = productDetails[i].ItemDescription.toString();
    selectedItemCode = productDetails[i].ItemCode.toString();
    taxvalue = double.parse(productDetails[i].TaxCode.toString());
    sporder = productDetails[i].sp == null
        ? 0.0
        : double.parse(productDetails[i].sp.toString());
    slppriceorder = productDetails[i].slpprice == null
        ? 0.0
        : double.parse(productDetails[i].slpprice.toString());
    storestockorder = productDetails[i].storestock == null
        ? 0.0
        : double.parse(productDetails[i].storestock.toString());
    whsestockorder = productDetails[i].whsestock == null
        ? 0.0
        : double.parse(productDetails[i].whsestock.toString());
    isfixedpriceorder = productDetails[i].isfixedprice;
    allownegativestockorder = productDetails[i].allownegativestock;
    alloworderbelowcostorder = productDetails[i].alloworderbelowcost;
    for (int ij = 0; ij < allProductDetails.length; ij++) {
      // log("allProductDetails[ij].itemCode::" +
      //     allProductDetails[ij].itemCode.toString());
      // log("selectedItemCode::" + selectedItemCode.toString());
      if (allProductDetails[ij].itemCode == selectedItemCode) {
        indexupdate = ij;
        break;
      }
    }
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
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 13,
                                        color: theme.primaryColor)),
                              ),
                              Container(
                                width: Screens.width(context) * 0.8,
                                // color: Colors.red,
                                child: Text(
                                    productDetails[i]
                                        .ItemDescription
                                        .toString(),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize:
                                            13) //color: theme.primaryColor
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
                              mycontroller[41].clear();

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
                              productDetails[i].itemtype!.toLowerCase() == 'b'
                                  ? true
                                  : (productDetails[i].couponcode != null &&
                                          productDetails[i].couponcode != '')
                                      ? true
                                      : productDetails[i].isfixedprice == false
                                          ? false
                                          : true,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          ],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                             isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
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
                          readOnly:
                              productDetails[i].itemtype!.toLowerCase() == 'b'
                                  ? true
                                  : (productDetails[i].couponcode != null &&
                                          productDetails[i].couponcode != '')
                                      ? true
                                      : false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                             isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "Quantity",
                          ),
                        ),
                      ),
                      //  ),

                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: InkWell(
                              onTap: () {
                                showDialog<dynamic>(
                                    context: context,
                                    builder: (_) {
                                      return ShowSearchDialog();
                                    }).then((value) {
                                  mycontroller[47].clear();
                                  filterrefpartdata = refpartdata;
                                  notifyListeners();
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Referral Partner",
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            // width: 270,
                            // height: 40,
                            // child: new TextFormField(
                            //   controller: mycontroller[48],

                            //   readOnly: true,
                            //   onTap: () {
                            //     showDialog<dynamic>(
                            //         context: context,
                            //         builder: (_) {
                            //           return ShowSearchDialog();
                            //         }).then((value) {
                            //       mycontroller[47].clear();
                            //       filterrefpartdata = refpartdata;
                            //       notifyListeners();
                            //       //  context
                            //       //   .read<
                            //       //       NewEnqController>()
                            //       //   .setcatagorydata();
                            //     });
                            //   },
                            //   // validator: (value) {
                            //   //   if (value!.isEmpty) {
                            //   //     return "ENTER QUANTITY";
                            //   //   }
                            //   //   return null;
                            //   // },

                            //   style: TextStyle(fontSize: 15),
                            //   decoration: InputDecoration(
                            //       contentPadding: EdgeInsets.symmetric(
                            //           vertical: 10, horizontal: 10),
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.all(
                            //           Radius.circular(10),
                            //         ),
                            //       ),
                            //       labelText: "referal partner",
                            //       suffixIcon: Icon(Icons.search)),
                            // ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          productDetails[i].itemtype!.toLowerCase() == 'b'
                              ? Container()
                              : InkWell(
                                  onTap: () async {
                                    if (mycontroller[11].text.isEmpty) {
                                      st(() {
                                        showtoastforcoupon("Enter QUANTITY");
                                      });
                                    } else {
                                      st(() {
//  callcouponApi();

                                        st(() {
                                          getcoupondata.clear();
                                          couponload = true;
                                        });

                                        notifyListeners();
                                        couponmodel coupondata = couponmodel();
                                        coupondata.customerCode =
                                            mycontroller[0].text;
                                        coupondata.itemCode = selectedItemCode;
                                        coupondata.storeCode =
                                            ConstantValues.Storecode;
                                        coupondata.qty =
                                            int.parse(mycontroller[11].text);
                                        coupondata.totalBillValue =
                                            double.parse(mycontroller[10].text);
                                        coupondata.requestedBy_UserCode =
                                            ConstantValues.Usercode;

                                        CouponApi.getData(coupondata)
                                            .then((value) {
                                          if (value.stcode! >= 200 &&
                                              value.stcode! <= 210) {
                                            if (value.CouponModaldatageader!
                                                        .Ordercheckdata !=
                                                    null &&
                                                value
                                                    .CouponModaldatageader!
                                                    .Ordercheckdata!
                                                    .isNotEmpty) {
                                              log("not null");
                                              st(() {
                                                getcoupondata = value
                                                    .CouponModaldatageader!
                                                    .Ordercheckdata!;
                                                log("getcoupondata::" +
                                                    getcoupondata.length
                                                        .toString());
                                                mycontroller[36].text =
                                                    getcoupondata[0]
                                                        .CouponCode
                                                        .toString();
                                                mycontroller[10].text =
                                                    getcoupondata[0]
                                                        .RP!
                                                        .toStringAsFixed(2);
                                                mycontroller[11].text =
                                                    getcoupondata[0]
                                                        .Quantity!
                                                        .toStringAsFixed(0);
                                                unitPrice = double.parse(
                                                    mycontroller[10].text);
                                                quantity = double.parse(
                                                    mycontroller[11].text);
                                                total = unitPrice! * quantity!;
                                                //  total = double.parse(mycontroller[10].text!) * double.parse(mycontroller[11].text!);
                                                notifyListeners();
                                                isappliedcoupon = true;

                                                notifyListeners();
                                                couponload = false;
                                              });

                                              // mapcoupon(value.CouponModaldatageader!.Ordercheckdata!);
                                              notifyListeners();
                                              // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
                                            } else if (value
                                                        .CouponModaldatageader!
                                                        .Ordercheckdata ==
                                                    null ||
                                                value.CouponModaldatageader!
                                                    .Ordercheckdata!.isEmpty) {
                                              log("Order data null");
                                              st(() {
                                                couponload = false;

                                                showtoastforcoupon(
                                                    "There is no coupon code for this customer");
                                              });

                                              notifyListeners();
                                            }
                                          } else if (value.stcode! >= 400 &&
                                              value.stcode! <= 410) {
                                            st(() {
                                              couponload = false;
                                              showtoastforcoupon(
                                                  '${value.message}..!!${value.exception}....!!');
                                            });

                                            notifyListeners();
                                          } else {
                                            st(() {
                                              couponload = false;

                                              showtoastforcoupon(
                                                  '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
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
                                    child: Text(
                                      "Apply Coupon Code",
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                              color: theme.primaryColor,
                                              decoration:
                                                  TextDecoration.underline),
                                    ),
                                  ),
                                ),
                        ],
                      ),

                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text("Delivery From",
                                style: theme.textTheme.bodyMedium
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
                                // border: Border.all(color: theme.primaryColor)
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: ToggleButtons(
                              selectedColor: Colors.white,
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              borderColor: theme.primaryColor,
                              fillColor: theme.primaryColor,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                      "Store (${indexupdate == null ? '' : allProductDetails[indexupdate!].storeStock!.toStringAsFixed(0)})"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                      "Warehouse (${indexupdate == null ? '' : allProductDetails[indexupdate!].whsStock!.toStringAsFixed(0)})"),
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
                      // getcoupondata.isEmpty
                      //     ? Container()
                      //     :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         InkWell(
                          onTap: (){
                            showDialog<dynamic>(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)
                                            ),
                                            content: Container(
                                               width: Screens.width(context)*0.5,
                                               padding: EdgeInsets.all(10),
                                               child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                   SizedBox(
  height: Screens.padingHeight(context)*0.01,
),
                                                  Container(
                                                    child: Text("Enter Coupon Code",
                                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold,fontSize: 16) ,),
                                                  ),
                                                  SizedBox(
  height: Screens.padingHeight(context)*0.01,
),
 Container(
                            width: Screens.width(context) * 0.65,
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              textAlign :TextAlign.left,
                              controller: mycontroller[36],
                              onEditingComplete: () {
                               
                              },
                              readOnly: (productDetails[i].couponcode != null &&
                                      productDetails[i].couponcode != '')
                                  ? true
                                  : false,
                              decoration: InputDecoration(
                               isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical:8,
                                      horizontal: 10,
                                    ),
                                    labelText: 'Coupon Code',
                                    fillColor: Colors.grey[100],
                                    filled: true,
                              
                                    labelStyle: theme.textTheme.bodyMedium!
                                        .copyWith(color: theme.primaryColor,),
                                         border:UnderlineInputBorder(
                                          borderSide :BorderSide(color: theme.primaryColor),
                                          // borderRadius: BorderRadius.circular(8)

                                         ) ,
                                        //  InputBorder.none,
                                         enabledBorder: UnderlineInputBorder(
                                          borderSide :BorderSide(color: theme.primaryColor),
                                          // borderRadius: BorderRadius.circular(8)

                                         ),
                                        //  InputBorder.none,
                                //          UnderlineInputBorder(
                                 
                                // ),
                                         focusedBorder: UnderlineInputBorder(
                                          borderSide :BorderSide(color: theme.primaryColor),
                                          // borderRadius: BorderRadius.circular(8)

                                         ),
                              ),
                            ),
                          ),
                                                  
SizedBox(
  height: Screens.padingHeight(context)*0.01,
),
Container(
  alignment: Alignment.center,
  child: ElevatedButton(onPressed:(productDetails[i].couponcode != null &&
                                        productDetails[i].couponcode != '')?(){}: (){
      if (mycontroller[11].text.isEmpty) {
                                    st(() {
                                      showtoastforcoupon("Enter QUANTITY");
                                    });
                                  } else {
                                    st(() {
  //  callcouponApi();
  
                                      st(() {
                                        getcoupondata.clear();
                                        couponload = true;
                                      });
  
                                      notifyListeners();
                                      couponmodel coupondata = couponmodel();
                                      coupondata.customerCode =
                                          mycontroller[0].text;
                                      coupondata.itemCode = selectedItemCode;
                                      coupondata.storeCode =
                                          ConstantValues.Storecode;
                                      coupondata.qty =
                                          int.parse(mycontroller[11].text);
                                      coupondata.totalBillValue =
                                          double.parse(mycontroller[10].text);
                                      coupondata.requestedBy_UserCode =
                                          ConstantValues.Usercode;
  
                                      CouponApi.getData(coupondata).then((value) {
                                        if (value.stcode! >= 200 &&
                                            value.stcode! <= 210) {
                                          if (value.CouponModaldatageader!
                                                      .Ordercheckdata !=
                                                  null &&
                                              value.CouponModaldatageader!
                                                  .Ordercheckdata!.isNotEmpty) {
                                            log("not null");
                                            st(() {
                                              getcoupondata = value
                                                  .CouponModaldatageader!
                                                  .Ordercheckdata!;
                                              log("getcoupondata::" +
                                                  getcoupondata.length
                                                      .toString());
                                              if (mycontroller[36].text ==
                                                  getcoupondata[0].CouponCode) {
                                                mycontroller[10].text =
                                                    getcoupondata[0]
                                                        .RP!
                                                        .toStringAsFixed(2);
                                                mycontroller[11].text =
                                                    getcoupondata[0]
                                                        .Quantity!
                                                        .toStringAsFixed(0);
                                                unitPrice = double.parse(
                                                    mycontroller[10].text);
                                                quantity = double.parse(
                                                    mycontroller[11].text);
                                                total = unitPrice! * quantity!;
                                                //  total = double.parse(mycontroller[10].text!) * double.parse(mycontroller[11].text!);
                                                notifyListeners();
                                                isappliedcoupon = true;
  
                                                notifyListeners();
                                                couponload = false;
                                                Navigator.pop(context);
                                              } else {
                                                st((){
                                                  couponload = false;
                                                  showtoastforcoupon(
                                                    "Entered coupon code is not valid");
                                                mycontroller[36].clear();
                                                Navigator.pop(context);
                                                });
                                                
                                              }
                                             
                                            });
  
                                            // mapcoupon(value.CouponModaldatageader!.Ordercheckdata!);
                                            notifyListeners();
                                            // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
                                          } else if (value.CouponModaldatageader!
                                                      .Ordercheckdata ==
                                                  null ||
                                              value.CouponModaldatageader!
                                                  .Ordercheckdata!.isEmpty) {
                                            log("Order data null");
                                            st(() {
                                              couponload = false;
  
                                              showtoastforcoupon(
                                                  "Entered coupon code is not valid");
                                                  Navigator.pop(context);
                                              mycontroller[36].clear();
                                            });
  
                                            notifyListeners();
                                          }
                                        } else if (value.stcode! >= 400 &&
                                            value.stcode! <= 410) {
                                          st(() {
                                            couponload = false;
                                            showtoastforcoupon(
                                                '${value.message}..!!${value.exception}....!!');
                                                Navigator.pop(context);
                                            mycontroller[36].clear();
                                          });
  
                                          notifyListeners();
                                        } else {
                                          st(() {
                                            couponload = false;
  
                                            showtoastforcoupon(
                                                '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
                                                Navigator.pop(context);
                                            mycontroller[36].clear();
                                          });
  
                                          notifyListeners();
                                        }
                                        notifyListeners();
                                      });
                                    });
                                  }
  }, child: Text("ok")),
)
                                                ],
                                               ),
                                            ),
                                          );
                                        }).then((value) => null);
                          },
                           child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Coupon Code  ",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: theme.primaryColor,
                                                  decoration:
                                                      TextDecoration.underline),
                                        ),
                                      ),
                         ),
                       mycontroller[36].text.isEmpty?Container():   Container(
                             width: Screens.width(context) * 0.40,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(8),
                                
                                decoration: BoxDecoration(
 color:Colors.grey[200],
 borderRadius: BorderRadius.circular(8)
                                ),
                               
                                child: Text(mycontroller[36].text)
//                              TextFormField(
//                               textAlign :TextAlign.left,
//                               controller: mycontroller[36],
//                               onEditingComplete: () {
//                                 if (mycontroller[11].text.isEmpty) {
//                                   st(() {
//                                     showtoastforcoupon("Enter QUANTITY");
//                                   });
//                                 } else {
//                                   st(() {
// //  callcouponApi();

//                                     st(() {
//                                       getcoupondata.clear();
//                                       couponload = true;
//                                     });

//                                     notifyListeners();
//                                     couponmodel coupondata = couponmodel();
//                                     coupondata.customerCode =
//                                         mycontroller[0].text;
//                                     coupondata.itemCode = selectedItemCode;
//                                     coupondata.storeCode =
//                                         ConstantValues.Storecode;
//                                     coupondata.qty =
//                                         int.parse(mycontroller[11].text);
//                                     coupondata.totalBillValue =
//                                         double.parse(mycontroller[10].text);
//                                     coupondata.requestedBy_UserCode =
//                                         ConstantValues.Usercode;

//                                     CouponApi.getData(coupondata).then((value) {
//                                       if (value.stcode! >= 200 &&
//                                           value.stcode! <= 210) {
//                                         if (value.CouponModaldatageader!
//                                                     .Ordercheckdata !=
//                                                 null &&
//                                             value.CouponModaldatageader!
//                                                 .Ordercheckdata!.isNotEmpty) {
//                                           log("not null");
//                                           st(() {
//                                             getcoupondata = value
//                                                 .CouponModaldatageader!
//                                                 .Ordercheckdata!;
//                                             log("getcoupondata::" +
//                                                 getcoupondata.length
//                                                     .toString());
//                                             if (mycontroller[36].text ==
//                                                 getcoupondata[0].CouponCode) {
//                                               mycontroller[10].text =
//                                                   getcoupondata[0]
//                                                       .RP!
//                                                       .toStringAsFixed(2);
//                                               mycontroller[11].text =
//                                                   getcoupondata[0]
//                                                       .Quantity!
//                                                       .toStringAsFixed(0);
//                                               unitPrice = double.parse(
//                                                   mycontroller[10].text);
//                                               quantity = double.parse(
//                                                   mycontroller[11].text);
//                                               total = unitPrice! * quantity!;
//                                               //  total = double.parse(mycontroller[10].text!) * double.parse(mycontroller[11].text!);
//                                               notifyListeners();
//                                               isappliedcoupon = true;

//                                               notifyListeners();
//                                               couponload = false;
//                                             } else {
//                                               showtoastforcoupon(
//                                                   "you entered coupon code is not valid");
//                                               mycontroller[36].clear();
//                                             }
//                                             // mycontroller[36].text =
//                                             //     getcoupondata[0]
//                                             //         .CouponCode
//                                             //         .toString();
//                                           });

//                                           // mapcoupon(value.CouponModaldatageader!.Ordercheckdata!);
//                                           notifyListeners();
//                                           // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
//                                         } else if (value.CouponModaldatageader!
//                                                     .Ordercheckdata ==
//                                                 null ||
//                                             value.CouponModaldatageader!
//                                                 .Ordercheckdata!.isEmpty) {
//                                           log("Order data null");
//                                           st(() {
//                                             couponload = false;

//                                             showtoastforcoupon(
//                                                 "you entered coupon code is not valid");
//                                             mycontroller[36].clear();
//                                           });

//                                           notifyListeners();
//                                         }
//                                       } else if (value.stcode! >= 400 &&
//                                           value.stcode! <= 410) {
//                                         st(() {
//                                           couponload = false;
//                                           showtoastforcoupon(
//                                               '${value.message}..!!${value.exception}....!!');
//                                           mycontroller[36].clear();
//                                         });

//                                         notifyListeners();
//                                       } else {
//                                         st(() {
//                                           couponload = false;

//                                           showtoastforcoupon(
//                                               '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
//                                           mycontroller[36].clear();
//                                         });

//                                         notifyListeners();
//                                       }
//                                       notifyListeners();
//                                     });
//                                   });
//                                 }
//                               },
//                               readOnly: (productDetails[i].couponcode != null &&
//                                       productDetails[i].couponcode != '')
//                                   ? true
//                                   : false,
//                               decoration: InputDecoration(
//                                isDense: true,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 1,
//                                       horizontal: 0,
//                                     ),
//                                     labelText: 'Coupon Code',
//                                     // fillColor: Colors.grey[200],
//                                     // filled: true,
                              
//                                     labelStyle: theme.textTheme.bodyMedium!
//                                         .copyWith(color: theme.primaryColor,decoration:TextDecoration.underline ),
//                                          border:  InputBorder.none,
//                                 //          UnderlineInputBorder(
                                 
                                
//                                 // ),
//                                         //  InputBorder.none,
//                                          enabledBorder:  InputBorder.none,
//                                 //          UnderlineInputBorder(
                                 
//                                 // ),
//                                          focusedBorder:  InputBorder.none,
//                                 //          UnderlineInputBorder(
                                 
//                                 // ),
//                               ),
//                             ),
                        
                          ),
                        ],
                      ),
                      // selectedapartcode !=null||selectedapartcode.isNotEmpty?   Align(
                      //     alignment: Alignment.bottomLeft,
                      //     child: Text("Refcode: $selectedapartcode")):Container(),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Total: ${total.toStringAsFixed(2)}")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          isUpdateClicked == false
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (mycontroller[11].text.isNotEmpty &&
                                        int.parse(mycontroller[11].text) > 0) {
                                      mycontroller[12].clear();
                                      addProductDetails(
                                          context,
                                          allProductDetails[indexupdate!],
                                          false,
                                          null);
                                    } else {
                                      showtoastproduct();
                                    }
                                  },
                                  child: Text("Ok"))
                              : ElevatedButton(
                                  onPressed: () {
                                    if (mycontroller[11].text.isNotEmpty &&
                                        int.parse(mycontroller[11].text) > 0) {
                                          
                                           unitPrice =
                                            double.parse(mycontroller[10].text);
                                        quantity =
                                            double.parse(mycontroller[11].text);
                                        total = unitPrice! * quantity!;
                                      if (productDetails[i]
                                              .itemtype!
                                              .toLowerCase() ==
                                          'b') {
                                       
                                        updateProductDetails(context, i,
                                            allProductDetails[indexupdate!]);
                                      } else {
                                        if (ConstantValues.unitpricelogic!
                                                .toLowerCase() ==
                                            'y') {
                                          callPricecheckApi(
                                              productDetails[i].ItemCode,
                                              int.parse(mycontroller[11].text),
                                              double.parse(
                                                  mycontroller[10].text),
                                              productDetails[i].couponcode ==
                                                          null ||
                                                      productDetails[i]
                                                          .couponcode!
                                                          .isEmpty
                                                  ? ''
                                                  : productDetails[i]
                                                      .couponcode,
                                              context,
                                              theme,
                                              i,
                                              false,
                                              allProductDetails[indexupdate!]);
                                        } else {
                                          if (ConstantValues.ordergiftlogic!
                                                  .toLowerCase() ==
                                              'y') {
                                            productDetails[i]
                                                .giftitems!
                                                .clear();
                                            callgiftApi(
                                                productDetails[i].ItemCode,
                                                int.parse(
                                                    mycontroller[11].text),
                                                double.parse(
                                                    mycontroller[10].text),
                                                context,
                                                i,
                                                theme,
                                                false,
                                                allProductDetails[
                                                    indexupdate!]);
                                          } else {
                                            updateProductDetails(
                                                context,
                                                i,
                                                allProductDetails[
                                                    indexupdate!]);
                                          }
                                        }
                                      }
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
  List<File> files2 = [];
  bool? fileValidation2 = false;

  List<FilesData> filedata2 = [];
  List<String> filelink = [];
  List<String> fileException = [];
  List images = [
    "assets/pdfimg.png",
    "assets/txt.png",
    "assets/xls.png",
    "assets/img.jpg"
  ];
  void showtoastgift(String? msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
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

  void showtoastpayattach() {
    Fluttertoast.showToast(
        msg: "More than one Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
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

  selectattachment2() async {
    List<File> filesz2 = [];
    // log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
      if (filedata2.isEmpty) {
        files2.clear();
        filesz2.clear();
        filedata2.clear();
        notifyListeners();
      }

      // log("filedata::" + filedata.length.toString());

      filesz2 = result!.paths.map((path) => File(path!)).toList();

      // if (filesz.length != 0) {
      int remainingSlots = 1 - files.length;
      if (filesz2.length <= remainingSlots) {
        for (int i = 0; i < filesz2.length; i++) {
          // createAString();

          // showtoast();
          files2.add(filesz2[i]);
          // log("Files Lenght :::::" + files.length.toString());
          List<int> intdata = filesz2[i].readAsBytesSync();
          filedata2.add(FilesData(
              fileBytes: base64Encode(intdata), fileName: filesz2[i].path));

          //New
          // XFile? photoCompressedFile =await testCompressAndGetFile(filesz[i],filesz[i].path);
          // await FileStorage.writeCounter('${photoCompressedFile!.name}_1', photoCompressedFile);
          //

          notifyListeners();
          // log("filedata222::" + filedata.length.toString());
          // return null;
        }
      } else {
        showtoastpayattach();
      }

      notifyListeners();
    }

    notifyListeners();
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

  Future imagetoBinary2(ImageSource source) async {
    List<File> filesz2 = [];
    await LocationTrack.checkcamlocation();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // files.add(File());
    if (filedata2.isEmpty) {
      filedata2.clear();
      filesz2.clear();
    }
    filesz2.add(File(image.path));

    notifyListeners();
    // log("filesz lenghthhhhh::::::" + filedata.length.toString());
    if (files2.length <= 1) {
      for (int i = 0; i < filesz2.length; i++) {
        files2.add(filesz2[i]);
        List<int> intdata = filesz2[i].readAsBytesSync();
        String fileName = filesz2[i].path.split('/').last;
        String fileBytes = base64Encode(intdata);
        String tempPath = '';
        if (Platform.isAndroid) {
//  Directory tempDir =  await getTemporaryDirectory();

//         log("tempDir::"+tempDir.toString());
          tempPath = (await getExternalStorageDirectory())!.path;
          // String? imagesaver = '$tempPath/$fileName';
        } else if (Platform.isIOS) {
          tempPath = (await getApplicationDocumentsDirectory())!.path;
        }

        String fullPath = '$tempPath/$fileName';
        await filesz2[i].copy(fullPath);
        File(fullPath).writeAsBytesSync(intdata);
        final result =
            await ImageGallerySaver.saveFile(fullPath, isReturnPathOfIOS: true);

        // log("fullPath::"+fullPath.toString());
        if (Platform.isAndroid) {
          filedata2.add(
              FilesData(fileBytes: base64Encode(intdata), fileName: fullPath
                  // files[i].path.split('/').last
                  ));
        } else {
          filedata2.add(
              FilesData(fileBytes: base64Encode(intdata), fileName: image.path
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
      showtoastpayattach();
    }
    // log("camera fileslength" + files.length.toString());
    // log("camera filesdatalength" + filedata.length.toString());
    // showtoast();

    notifyListeners();
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
        String tempPath = '';
        if (Platform.isAndroid) {
//  Directory tempDir =  await getTemporaryDirectory();

//         log("tempDir::"+tempDir.toString());
          tempPath = (await getExternalStorageDirectory())!.path;
          // String? imagesaver = '$tempPath/$fileName';
        } else if (Platform.isIOS) {
          tempPath = (await getApplicationDocumentsDirectory())!.path;
        }

        String fullPath = '$tempPath/$fileName';
        await filesz[i].copy(fullPath);
        File(fullPath).writeAsBytesSync(intdata);
        final result =
            await ImageGallerySaver.saveFile(fullPath, isReturnPathOfIOS: true);

        // log("fullPath::"+fullPath.toString());
        if (Platform.isAndroid) {
          filedata.add(
              FilesData(fileBytes: base64Encode(intdata), fileName: fullPath
                  // files[i].path.split('/').last
                  ));
        } else {
          filedata.add(
              FilesData(fileBytes: base64Encode(intdata), fileName: image.path
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
      methidstate2(mycontroller[24].text);

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
    double? taxpercentage;
    double? LineTotal = 0.00;
    double? LineTotalfinal = 0.00;
    for (int i = 0; i < productDetails.length; i++) {
      // log("LineTotal::"+productDetails.length.toString());
      if (productDetails[i].itemtype!.toLowerCase() != 'g') {
        taxpercentage = productDetails[i].TaxCode;
        // log("aaa"+"${productDetails[i].LineTotal! / (1 + taxpercentage! / 100)}");
        LineTotal = LineTotal! +
            (productDetails[i].LineTotal! / (1 + taxpercentage! / 100));
      }

      // log("LineTotal5555::" + LineTotal.toString());
    }
    LineTotal = LineTotal! + getTotalGiftLineAmount();
    log("LineTotalppp::" + LineTotal.toString());
    // LineTotalfinal= config.truncateToTwoDecimals(LineTotal);
    return LineTotal;
    // config.slpitCurrency22(LineTotal!.toString());
  }

  getTotalGiftTaxAmount(
      // int i
      ) {
    double? taxtotal = 0.00;
    double? gifttaxpercentage;
    for (int i = 0; i < productDetails.length; i++) {
      if (productDetails[i].giftitems != null &&
          productDetails[i].giftitems!.isNotEmpty) {
        for (int ij = 0; ij < productDetails[i].giftitems!.length; ij++) {
          gifttaxpercentage = productDetails[i].giftitems![ij].TaxRate;
          taxtotal = taxtotal! +
              (gifttaxpercentage! *
                      ((productDetails[i].giftitems![ij].Price! *
                              productDetails[i].giftitems![ij].quantity!) /
                          (1 + gifttaxpercentage! / 100))) /
                  100;
          log("gifttaxtotal:::" + taxtotal.toString());
        }
      }

      // log("productDetails[i].LineTotal:::"+productDetails[i].LineTotal!.toString());
      // log("taxpercentage:::"+taxpercentage.toString());

      //  log("taxtotal:::"+taxtotal.toString());
    }
    return taxtotal!;
  }

  getTotalGiftLineAmount() {
    double? LineTotal = 0.00;
    double? taxpercentage;
    for (int i = 0; i < productDetails.length; i++) {
      // log("productDetails[i].giftitems::" +
      //     productDetails[i].giftitems.toString());
      if (productDetails[i].giftitems != null &&
          productDetails[i].giftitems!.isNotEmpty) {
        for (int ij = 0; ij < productDetails[i].giftitems!.length; ij++) {
          taxpercentage = productDetails[i].giftitems![ij].TaxRate;
          LineTotal = LineTotal! +
              ((productDetails[i].giftitems![ij].Price! *
                      productDetails[i].giftitems![ij].quantity!) /
                  (1 + taxpercentage! / 100));
          // log("getTotalTaxAmountbefore:::" + LineTotal.toString());
          // LineTotal=taxtotal+getTotalGiftTaxAmount()??0.0;
          // log("getTotalgiftAmount:::" + LineTotal.toString());
        }
      }
    }
    return LineTotal!;
  }

  getTotalTaxAmount() {
    double? taxtotal = 0.00;
    double? taxtotalfinal = 0.00;
    double? taxpercentage;

    for (int i = 0; i < productDetails.length; i++) {
      // log(),
      log("product" +
          productDetails[i].ItemCode.toString() +
          "type" +
          productDetails[i].itemtype.toString());
      if (productDetails[i].itemtype!.toLowerCase() != 'g') {
        taxpercentage = productDetails[i].TaxCode;
        // log("productDetails[i].LineTotal:::" +
        //     productDetails[i].LineTotal!.toString());
        // log("taxpercentage:::" + taxpercentage.toString());

        taxtotal = taxtotal! +
            (taxpercentage! *
                    (productDetails[i].LineTotal! /
                        (1 + taxpercentage! / 100))) /
                100;
        // log("taxtotal:::" + taxtotal.toString());

        log("getTotalTaxAmount:::" + taxtotal.toString());
      }
    }
    taxtotal = taxtotal! + getTotalGiftTaxAmount() ?? 0.0;
  // taxtotalfinal= config.truncateToTwoDecimals(taxtotal);
    return taxtotal;
    // config.slpitCurrency22(taxtotal!.toString());
  }

  double? paytermtotal = 0.0;
  double? fullpayment = 0.0;
  String? payamounterror = '';
  clearpaydata() {
    mycontroller[43].clear();
    mycontroller[44].clear();
    mycontroller[45].clear();
    mycontroller[46].clear();
    payamounterror = '';
    selecteditem = null;
    files2.clear();
    filedata2.clear();
    notifyListeners();
    payloading = false;
  }
  // onchangedpayterm(String? value) {
  //   double payamount = double.parse(value.toString());
  //   if (payamount > paytermtotal!) {
  //     log("Amount Should be less than or equal to ${paytermtotal!.toStringAsFixed(2)}");

  //     payamounterror =
  //         "Amount Should be less than or equal to ${paytermtotal!.toStringAsFixed(2)}";
  //     notifyListeners();
  //   } else {
  //     payamounterror = '';
  //     paytermtotal =paytermtotal! - payamount;
  //   }
  //   notifyListeners();
  // }

  oncopy() {
    mycontroller[46].text = paytermtotal!.toStringAsFixed(2);
  }

  getTotalaoyAmount() {
    paytermtotal = 0.0;
    fullpayment = 0.0;

    double? LineTotal =
        double.parse(getTotalOrderAmount().toString().replaceAll(",", ""));
    double? taxTotal =
        double.parse(getTotalTaxAmount().toString().replaceAll(",", ""));
    // for (int i = 0; i < productDetails.length; i++) {
    LineTotal = LineTotal! + taxTotal;
    paytermtotal = paytermtotal! + LineTotal;
    fullpayment = fullpayment! + LineTotal;
    // log("paytermtotal2222:::" + paytermtotal.toString());
    if (postpaymentdata.isNotEmpty) {
      for (int i = 0; i < postpaymentdata.length; i++) {
        paytermtotal = double.parse(paytermtotal!.toStringAsFixed(2)) -
                postpaymentdata[i].amount! ??
            0.0;
        // log("paytermtotal:::" + paytermtotal.toString());
      }
    }

    // }
    return config.slpitCurrency22(LineTotal!.toString());
  }

  getroundoffdiff(){
    double? LineTotal =
        double.parse(getTotalOrderAmount().toString().replaceAll(",", ""));
        double? taxTotal =
        double.parse(getTotalTaxAmount().toString().replaceAll(",", ""));
        double? actualTotal =
        double.parse(getTotalGrossAmount().toString().replaceAll(",", ""));
         String? LineTotal3 =
        config.slpitCurrency22(LineTotal.toString());
        String? taxTotal3 =
        config.slpitCurrency22(taxTotal.toString());
         double? LineTotal2 =
        double.parse(LineTotal3.toString().replaceAll(",", ""));
        double? taxTotal2 =
        double.parse(taxTotal3.toString().replaceAll(",", ""));
LineTotal2 =LineTotal2 +taxTotal2;
        actualTotal =actualTotal -LineTotal2 ;
        return config.slpitCurrency22(actualTotal.toString());
  }

  getTotalGrossAmount() {
    // paytermtotal = 0.0;

    double? LineTotal =
        double.parse(getTotalOrderAmount().toString().replaceAll(",", ""));
    double? taxTotal =
        double.parse(getTotalTaxAmount().toString().replaceAll(",", ""));
    // for (int i = 0; i < productDetails.length; i++) {
    LineTotal = LineTotal! + taxTotal;
    // paytermtotal = paytermtotal! + LineTotal;
    // log("paytermtotal::" + paytermtotal.toString());
    // }
    return config.slpitCurrency22(LineTotal!.toString());
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

class Custype {
  String? name;
  Custype({required this.name});
}

class complementary {
  String? itemName;
  String? ItemCode;
  double? SP;
  double? offer;
  double? Percentage;
  double? qty;

  complementary(
      {required this.itemName,
      required this.ItemCode,
      required this.Percentage,
      required this.SP,
      required this.offer,
      required this.qty});
}

class giftitems {
  String? name;
  String? itemcode;
  double? price;
  String? quantity;
  bool? addproduct;
  double? offerprice;
  giftitems(
      {required this.offerprice,
      required this.name,
      required this.itemcode,
      required this.price,
      required this.quantity,
      required this.addproduct});
}
