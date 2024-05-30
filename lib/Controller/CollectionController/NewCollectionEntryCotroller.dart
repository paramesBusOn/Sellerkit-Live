// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_import, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sellerkit/Pages/Collection/widgets/CollectionSuccessPage.dart';
import 'package:sellerkit/Pages/Collection/widgets/warnningDialog.dart';
// import 'package:share/share.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/LocationTrack.dart';
import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/outstandingDBmodel.dart';
import '../../DBModel/outstandinglinechild.dart';
import '../../Models/OutStandingModel/outstandingmodel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import '../../Models/stateModel/stateModel.dart';
import '../../Services/CollectionApi/CollectionPostApi.dart';
import '../../Services/OutstandingApi/outstandingApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Services/PostQueryApi/OrdersApi/AttachmentFileLinkApi.dart';
import '../../Widgets/SucessDialagBox.dart';
import '../OutStandingController/OutStandingController.dart';

class NewCollectionContoller extends ChangeNotifier {
  Config config = Config();
  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
  List<CollectionLineData> productDetails = [];
  List<CollectionLineData> get getProduct => productDetails;

  List<CollectionCustomerData> allProductDetails = [];
  List<CollectionCustomerData> filterProductDetails = [];
  static List<String> comefromoutStanding = [];
  static List<String> comefromSiteOut = [];
   static List<String> comefromAcc = [];

  List<CollectionCustomerData> get getAllProductDetails => allProductDetails;
  bool showItemList = true;
  bool isUpdateClicked = false;
  List<GlobalKey<FormState>> formkey = new List.generate(
      3, (i) => new GlobalKey<FormState>(debugLabel: "Collection"));
  List<TextEditingController> mycontroller =
      List.generate(30, (i) => TextEditingController());
  changeVisible() {
    showItemList = !showItemList;
    notifyListeners();
  }

  static String? docNO;
  static String? title;
  List<String> paths = [];

  pdfMethod() async {
    final tempDir = await getTemporaryDirectory();
    print("direc: " + tempDir.path.toString() + '/$title-$docNO.pdf');
    paths.add('${tempDir.path}/$title-$docNO.pdf');
    await Share.shareFiles(paths);
    paths.clear();
  }

  init(BuildContext context) async {
    ClearDataAll();
    // getData();
    await GetAllOutstandingscall(context);
    await stateApicallfromDB();
    await getCustomerTag();
    
    //   print(showItemList);
    //   print(allProductDetails);
  }

  List<outstandingData> outstanddata = [];
  List<outstandingLine> outstandline = [];
  bool apiloading = false;
  String errormsg = '';
  GetAllOutstandingscall(BuildContext context) async {
    valueDBmodel.clear();
    outstanddata.clear();
    outstandline.clear();
    valueDBmodelchild.clear();
    apiloading = false;
    // outsatandingmodel outsatandingModel = await GetoutstandingApi.getData();
    await GetoutstandingApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.outstandhead!.outstanddata != null &&
            value.outstandhead!.outstanddata!.isNotEmpty &&
            value.outstandhead!.outstandline != null &&
            value.outstandhead!.outstandline!.isNotEmpty) {
          apiloading = true;
          notifyListeners();
          outstanddata = value.outstandhead!.outstanddata!;
          outstandline = value.outstandhead!.outstandline!;

          await tableinsert();
        } else {
          apiloading = true;
          errormsg = 'No Outstanding..!!';
          // showDialog<dynamic>(
          //     context: context,
          //     builder: (_) {
          //       return warningDialog(
          //         heading: 'Response',
          //         msg: '${value.message}..!!',
          //       );
          //     });
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // apiloading = true;
        // errormsg = '${value.message}..${value.exception}..!!';
        // showDialog<dynamic>(
        //     context: context,
        //     builder: (_) {
        //       return warningDialog(
        //         heading: 'Response',
        //         msg: '${errormsg}..!!',
        //       );
        //     });
        notifyListeners();
      } else if (value.stcode! == 500) {
        apiloading = true;
        errormsg = '${value.stcode}..!!Network Issue\nTry again Later..!!';
        showDialog<dynamic>(
            context: context,
            builder: (_) {
              return warningDialog(
                heading: 'Response',
                msg: '${errormsg}',
              );
            });

        notifyListeners();
      }
    });
  }

  tableinsert() async {
    final Database db = (await DBHelper.getInstance())!;
    // await DBOperation.truncareoutstandingmaste(db);
    // await DBOperation.truncareoutstandingline(db);
    await DBOperation.insertOutstandingMaster(outstanddata, db);
    await DBOperation.insertOutstandingchild(outstandline, db);

    notifyListeners();
    await getdbmodel();
    notifyListeners();
  }

  mapvaluefromOutstanding(BuildContext context) async {
    mycontroller[0].text = comefromoutStanding[0] == null ||
            comefromoutStanding[0] == 'null' ||
            comefromoutStanding[0].isEmpty
        ? ''
        : comefromoutStanding[0].toString(); //mobile
    mycontroller[1].text = comefromoutStanding[1] == null ||
            comefromoutStanding[1] == 'null' ||
            comefromoutStanding[1].isEmpty
        ? ''
        : comefromoutStanding[1].toString(); //customer
    mycontroller[2].text = comefromoutStanding[3] == null ||
            comefromoutStanding[3] == 'null' ||
            comefromoutStanding[3].isEmpty
        ? ''
        : comefromoutStanding[3].toString(); //cantact name
    mycontroller[3].text = comefromoutStanding[2] == null ||
            comefromoutStanding[2] == 'null' ||
            comefromoutStanding[2].isEmpty
        ? ''
        : comefromoutStanding[2].toString(); //alter mobile
    mycontroller[4].text = comefromoutStanding[4] == null ||
            comefromoutStanding[4] == 'null' ||
            comefromoutStanding[4].isEmpty
        ? ''
        : comefromoutStanding[4].toString(); //email
    mycontroller[5].text = comefromoutStanding[5] == null ||
            comefromoutStanding[5] == 'null' ||
            comefromoutStanding[5].isEmpty
        ? ''
        : comefromoutStanding[5].toString(); //gst
    mycontroller[7].text = comefromoutStanding[6] == null ||
            comefromoutStanding[6] == 'null' ||
            comefromoutStanding[6].isEmpty
        ? ''
        : comefromoutStanding[6].toString(); //bill add1
    mycontroller[8].text = comefromoutStanding[7] == null ||
            comefromoutStanding[7] == 'null' ||
            comefromoutStanding[7].isEmpty
        ? ''
        : comefromoutStanding[7].toString(); //bill add2
    mycontroller[9].text = comefromoutStanding[8] == null ||
            comefromoutStanding[8] == 'null' ||
            comefromoutStanding[8].isEmpty
        ? ''
        : comefromoutStanding[8].toString(); //area
    mycontroller[10].text = comefromoutStanding[9] == null ||
            comefromoutStanding[9] == 'null' ||
            comefromoutStanding[9].isEmpty
        ? ''
        : comefromoutStanding[9].toString(); //city
    mycontroller[11].text = comefromoutStanding[11] == null ||
            comefromoutStanding[11] == 'null' ||
            comefromoutStanding[11].isEmpty
        ? ''
        : comefromoutStanding[11].toString(); //pincode
    mycontroller[12].text = comefromoutStanding[12] == null ||
            comefromoutStanding[12] == 'null' ||
            comefromoutStanding[12].isEmpty
        ? ''
        : comefromoutStanding[12].toString(); //state
    // methidstate(comefromoutStanding[12].toString(), context);

    if (mycontroller[12].text != null ||
        mycontroller[12].text != 'null' ||
        mycontroller[12].text.isNotEmpty) {
      await stateloop(mycontroller[12].text);
    }
    comefromoutStanding.clear();
    notifyListeners();
  }

  stateloop(String state) {
    statecode = '';
    statename = '';
    countrycode = '';

    for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].stateName.toString().toLowerCase() ==
          state.toString().toLowerCase()) {
        statecode = filterstateData[i].statecode.toString();
        statename = filterstateData[i].stateName.toString();
        countrycode = filterstateData[i].countrycode.toString();
        isText1Correct = false;
        // FocusScope.of(context).unfocus();
      }
    }
  }
mapvaluefromAccounts(BuildContext context) async {
    // visitId = comefromSiteOut[0] == null ||
    //         comefromSiteOut[0] == 'null' ||
    //         comefromSiteOut[0].isEmpty
    //     ? 0
    //     : int.parse(comefromSiteOut[0].toString()); //visitid
    mycontroller[0].text = comefromAcc[0] == null ||
            comefromAcc[0] == 'null' ||
            comefromAcc[0].isEmpty
        ? ''
        : comefromAcc[0].toString(); //mobile
    mycontroller[1].text = comefromAcc[1] == null ||
            comefromAcc[1] == 'null' ||
            comefromAcc[1].isEmpty
        ? ''
        : comefromAcc[1].toString(); //customer
    mycontroller[2].text = comefromAcc[9] == null ||
            comefromAcc[9] == 'null' ||
            comefromAcc[9].isEmpty
        ? ''
        : comefromAcc[9].toString();
         mycontroller[3].text = comefromAcc[6] == null ||
            comefromAcc[6] == 'null' ||
            comefromAcc[6].isEmpty
        ? ''
        : comefromAcc[6].toString();  //cantact name
    mycontroller[4].text = comefromAcc[7] == null ||
            comefromAcc[7] == 'null' ||
            comefromAcc[7].isEmpty
        ? ''
        : comefromAcc[7].toString();
         mycontroller[5].text = comefromAcc[18] == null ||
            comefromAcc[18] == 'null' ||
            comefromAcc[18].isEmpty
        ? ''
        : comefromAcc[18].toString();  //email
    mycontroller[7].text = comefromAcc[2] == null ||
            comefromAcc[2] == 'null' ||
            comefromAcc[2].isEmpty
        ? ''
        : comefromAcc[2].toString(); //bill add1
    mycontroller[8].text = comefromAcc[3] == null ||
            comefromAcc[3] == 'null' ||
            comefromAcc[3].isEmpty
        ? ''
        : comefromAcc[3].toString(); //bill add2
    mycontroller[9].text = comefromAcc[10] == null ||
            comefromAcc[10] == 'null' ||
            comefromAcc[10].isEmpty
        ? ''
        : comefromAcc[10].toString(); //area
    mycontroller[10].text = comefromAcc[5] == null ||
            comefromAcc[5] == 'null' ||
            comefromAcc[5].isEmpty
        ? ''
        : comefromAcc[5].toString(); //city
    mycontroller[11].text = comefromAcc[4] == null ||
            comefromAcc[4] == 'null' ||
            comefromAcc[4].isEmpty
        ? ''
        : comefromAcc[4].toString(); //pincode
         for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == comefromAcc[8]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }

    mycontroller[12].text = comefromAcc[11] == null ||
            comefromAcc[11] == 'null' ||
            comefromAcc[11].isEmpty
        ? ''
        : comefromAcc[11].toString(); //state
   
    comefromAcc.clear();
    notifyListeners();
  }
  mapvaluefromSiteOut(BuildContext context) async {
    visitId = comefromSiteOut[0] == null ||
            comefromSiteOut[0] == 'null' ||
            comefromSiteOut[0].isEmpty
        ? 0
        : int.parse(comefromSiteOut[0].toString()); //visitid
    mycontroller[0].text = comefromSiteOut[3] == null ||
            comefromSiteOut[3] == 'null' ||
            comefromSiteOut[3].isEmpty
        ? ''
        : comefromSiteOut[3].toString(); //mobile
    mycontroller[1].text = comefromSiteOut[2] == null ||
            comefromSiteOut[2] == 'null' ||
            comefromSiteOut[2].isEmpty
        ? ''
        : comefromSiteOut[2].toString(); //customer
    mycontroller[2].text = comefromSiteOut[5] == null ||
            comefromSiteOut[5] == 'null' ||
            comefromSiteOut[5].isEmpty
        ? ''
        : comefromSiteOut[5].toString(); //cantact name
    mycontroller[4].text = comefromSiteOut[4] == null ||
            comefromSiteOut[4] == 'null' ||
            comefromSiteOut[4].isEmpty
        ? ''
        : comefromSiteOut[4].toString(); //email
    mycontroller[7].text = comefromSiteOut[6] == null ||
            comefromSiteOut[6] == 'null' ||
            comefromSiteOut[6].isEmpty
        ? ''
        : comefromSiteOut[6].toString(); //bill add1
    mycontroller[8].text = comefromSiteOut[7] == null ||
            comefromSiteOut[7] == 'null' ||
            comefromSiteOut[7].isEmpty
        ? ''
        : comefromSiteOut[7].toString(); //bill add2
    mycontroller[9].text = comefromSiteOut[8] == null ||
            comefromSiteOut[8] == 'null' ||
            comefromSiteOut[8].isEmpty
        ? ''
        : comefromSiteOut[8].toString(); //area
    mycontroller[10].text = comefromSiteOut[9] == null ||
            comefromSiteOut[9] == 'null' ||
            comefromSiteOut[9].isEmpty
        ? ''
        : comefromSiteOut[9].toString(); //city
    mycontroller[11].text = comefromSiteOut[12] == null ||
            comefromSiteOut[12] == 'null' ||
            comefromSiteOut[12].isEmpty
        ? ''
        : comefromSiteOut[12].toString(); 
        
       
        //pincode
    mycontroller[12].text = comefromSiteOut[10] == null ||
            comefromSiteOut[10] == 'null' ||
            comefromSiteOut[10].isEmpty
        ? ''
        : comefromSiteOut[10].toString(); //state
    // methidstate(comefromoutStanding[10].toString(), context);
    if (mycontroller[12].text != null ||
        mycontroller[12].text != 'null' ||
        mycontroller[12].text.isNotEmpty) {
      await stateloop(mycontroller[12].text);
    }
    comefromSiteOut.clear();
    notifyListeners();
  }

   int visitId = 0;
  colletionTotal() {
    double val = 0.0;
    if (productDetails.isNotEmpty) {
      for (int i = 0; i < productDetails.length; i++) {
        val = val + productDetails[i].paidAmount;
      }
    } else {
      val = 0.0;
    }
// if(mycontroller[15].text){
//   mycontroller[15].text = val.toString();
// }
  
  mycontroller[15].text = val.toString();
    return config.slpitCurrency22(val.toString()); 
  }

  ClearDataAll() {
    visitId=0;
    isText1Correct = false;
    exceptionOnApiCall = '';
    customerapicLoading = false;
    showItemList=true;
    //
    allProductDetails.clear();
    productDetails.clear();
    filterProductDetails.clear();
    customerlist.clear();
    filterCustomerlist.clear();
    isSelectedCusTag = '';
    CusTag = '';
    isSelectedCusTagcode = '';
    customerbool = false;
    custCodebool = false;
    paymentmode = null;
    mycontroller[0].text = ""; //mobile
    mycontroller[1].text = ""; //customer
    mycontroller[2].text = ""; //cantact name
    mycontroller[3].text = ""; //alter mobile
    mycontroller[4].text = ""; //email
    mycontroller[5].text = ""; //gst
    mycontroller[6].text = ""; //pan
    mycontroller[7].text = ""; //bill add1
    mycontroller[8].text = ""; //bill add2
    mycontroller[9].text = ""; //area
    mycontroller[10].text = ""; //city
    mycontroller[11].text = ""; //pincode
    mycontroller[12].text = ""; //store
    mycontroller[13].text = ""; //Asign to
    //
    mycontroller[14].text = ""; //bottomsheet amount
    //
    mycontroller[15].text = ""; //totalAmount
    //
    mycontroller[16].text = ""; //card ref
    mycontroller[17].text = ""; //Cheque date
    mycontroller[18].text = ""; //cheque
    mycontroller[19].text = ""; //NEFT ref
    mycontroller[20].text = ""; //UPI ref
    //
    mycontroller[21].text = ""; //Remarks
    mycontroller[22].text = ""; //filter
    statebool = false;
    cardbool = false;
    cashbool = false;
    chequebool = false;
    upibool = false;
    neftbool = false;
    filedata.clear();
    files.clear();
    notifyListeners();
  }

  filterList(String v) {
    if (v.isNotEmpty) {
      allProductDetails = filterProductDetails
          .where((e) =>
              e.invoice!.toLowerCase().contains(v.toLowerCase()) ||
              e.date.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      allProductDetails = filterProductDetails;
      notifyListeners();
    }
  }

  isselectMethod(int i, BuildContext context, bool val) {
    if (val == true) {
      resetItems(i);

      isUpdateClicked = false;

      showBottomSheetInsert(context, i);
    }
  }

  resetItems(int i) {
    mycontroller[14].text =
        allProductDetails[i].balancetoPay.toStringAsFixed(2);
    //.clear();
  }

  String? paymentmode;
  resonChoosed(String val) {
    paymentmode = val;
    notifyListeners();
  }

  String? slelectedIteminvoice;
  String? slelectedItemDate;
  void showtoastproduct() {
    Fluttertoast.showToast(
        msg: "Amount should be greater than 0..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
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
  addProductDetails(
      BuildContext context, CollectionCustomerData? CollectionCusData) {
    if (formkey[1].currentState!.validate()) {
        bool itemAlreadyAdded = false;
        for (int i = 0; i < productDetails.length; i++) {
        if (productDetails[i].invoice == slelectedIteminvoice) {
          itemAlreadyAdded = true;
          break;
        }
      }
      if(itemAlreadyAdded){
showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
      notifyListeners();
        showtoastforall();
      }else{
 productDetails.add(CollectionLineData(
          // amount: double.parse(mycontroller[0].text.toString()),
          date: slelectedItemDate!,
          invoice: slelectedIteminvoice,
          purpose: CollectionCusData!.purpose,
          type: CollectionCusData.type,
          orgAmount: CollectionCusData.paidAmount,
          age: CollectionCusData.age,
          trnsAmount: CollectionCusData.trnsAmount,
          paidAmount: double.parse(mycontroller[14].text.toString()),
          balancetoPay: CollectionCusData.balancetoPay,
          docentry: CollectionCusData.docentry));
      showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
      allProductDetails.remove(CollectionCusData);

      notifyListeners();
      }
     
    }
  }

  validateFirst(BuildContext context) {
    // int count = 0;
    // if (paymentmode == null) {
    //   count = 1;
    //   paymentmodeErro = "Please Select PaymentMode..!!";
    //   notifyListeners();
    // } else {
    //   count = 0;
    //   paymentmodeErro = "";
    //   notifyListeners();
    // }
    // count = 0;
    if (formkey[0].currentState!.validate()) {
      // if (count == 0) {
      // showItemList = true;
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      // }
    }
    notifyListeners();
  }

  String validateCustomer(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      if (val == customerlist[i].customer) {
        cusvalue = customerlist[i].customer!;
      }
    }
    return cusvalue!;
  }

  String validateCustomerCode(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      // print(customerlist[i].cuscode);
      // print(val);

      if (val == customerlist[i].cuscode) {
        cusvalue = customerlist[i].cuscode;
      }
    }
    return cusvalue!;
  }

  String validateCustomerCantact(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      // print(customerlist[i].cuscode);
      // print(val);

      if (val == customerlist[i].contactname) {
        cusvalue = customerlist[i].contactname;
      }
    }
    return cusvalue!;
  }

  String validateCustomerMobile(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      // print(customerlist[i].cuscode);
      // print(val);

      if (val == customerlist[i].mobile) {
        cusvalue = customerlist[i].mobile;
      }
    }
    return cusvalue!;
  }

  bool saveprogress = false;

  validateFinal(BuildContext context) async {
    int count = 0;
    String imgUrl = '';
    if (cashbool != true &&
        cardbool != true &&
        chequebool != true &&
        upibool != true &&
        neftbool != true) {
      count = 1;
      paymentmodeErro = "Select Payment Mode..";
      // saveprogress = false;
      notifyListeners();
    } else {
      paymentmodeErro = "";
      notifyListeners();
    }
     print(("fdffff:::"+mycontroller[15].text));
    if (formkey[1].currentState!.validate()) {
     
//       if(mycontroller[15].text == "0"){
// showtoastproduct();
//       }else{
if (count == 0) {
        saveprogress = true;

        if (filedata != null || filedata.isNotEmpty) {
          for (int i = 0; i < filedata.length; i++) {
            await OrderAttachmentApiApi.getData(
              filedata[i].fileName,
            ).then((value) {
              // log("OrderAttachmentApiApi::" + value.toString());
              if (value == 'No Data Found..!!') {
                // fileError.add(filedata[i].fileName);
                // filename.add("");
              } else {
                imgUrl = value;
              }
            });
          }
        }
        List<Ipaylines> ipaylaine = [];

        for (int i = 0; i < productDetails.length; i++) {
          ipaylaine.add(Ipaylines(
              outsid: productDetails[i].docentry == null
                  ? 0
                  : int.parse(productDetails[i].docentry.toString()),
              transnum: productDetails[i].invoice,
              sumapplied: productDetails[i].paidAmount));
        }
        postCollectBody? getCollectionbody = postCollectBody(
            customerGrooup: isSelectedCusTagcode,
            contactName: mycontroller[2].text.toString(),
            customerName: mycontroller[1].text.toString(),
            Mobile: mycontroller[0].text.toString(),
            AssignedTo: '${ConstantValues.Usercode}',
            StoreCode: '${ConstantValues.Storecode}',
            alternateMobileNo: mycontroller[3].text.toString(),
            bil_Address1: mycontroller[7].text.toString(),
            bil_Address2: mycontroller[8].text.toString(),
            bil_Address3: '',
            bil_Area: mycontroller[9].text.toString(),
            bil_City: mycontroller[10].text.toString(),
            bil_Country: countrycode,
            bil_District: '',
            bil_Pincode: mycontroller[11].text.toString(),
            bil_State: statecode.toString(),
            companyName: '',
            customerEmail: mycontroller[4].text.toString(),
            gSTNo: mycontroller[5].text.toString(),
            pAN: mycontroller[6].text.toString(),
            docstatus: 'Open',
            visitid: visitId,
            amountpaid: mycontroller[15].text.toString(),
            cashamt: cashbool == true
                ? double.parse(mycontroller[15].text.toString())
                : 0.0,
            chqamt: chequebool == true
                ? double.parse(mycontroller[15].text.toString())
                : 0.0,
            chequedate: chequebool == true ? apiNdate : '',
            chequeref: chequebool == true ? mycontroller[18].text : '',
            chequeimg: chequebool == true ? '$imgUrl' : '',
            neftamt: neftbool == true
                ? double.parse(mycontroller[15].text.toString())
                : 0.0,
            neftref: neftbool == true ? mycontroller[19].text : '',
            cardamt: cardbool == true
                ? double.parse(mycontroller[15].text.toString())
                : 0.0,
            cardslipImg: cardbool == true ? '$imgUrl' : '',
            upiamt: upibool == true
                ? double.parse(mycontroller[15].text.toString())
                : 0.0,
            onaccount: getProduct.isEmpty ? '1' : '0',
            ipaylaine: ipaylaine,
            customerCode: mycontroller[0].text.toString(),
            cardref: mycontroller[16].text.toString(),
            upiref: mycontroller[20].text.toString(),
            remarks: mycontroller[21].text.toString());

        await CollectionPostApi.getCollectionData(getCollectionbody)
            .then((value) {
          if (value.stcode! <= 210 && value.stcode! >= 200) {
            saveprogress = false;
            showDialog<dynamic>(
                context: context,
                builder: (_) {
                  return CollectionSuccessPage(
                    paymentmode: neftbool == true
                        ? 'NEFT'
                        : upibool == true
                            ? 'UPI'
                            : chequebool == true
                                ? 'Cheque'
                                : cardbool == true
                                    ? 'Card'
                                    : 'Cash',
                    amount: getCollectionbody.amountpaid.toString(),
                    IpaylineLine: value.datadetail!.IpaylineLine,
                    ipaymaster: value.datadetail!.ipaymaster![0],
                  );
                }).then((value) {
              GetAllOutstandingscall(context);
              ClearDataAll();
            });
          } else if (value.stcode! <= 410 && value.stcode! >= 400) {
            saveprogress = false;
            showDialog<dynamic>(
                context: context,
                builder: (_) {
                  return warningDialog(
                    heading: 'Response',
                    msg: '${value.resType} ${value.exception}..!!',
                  );
                });
          } else {
            saveprogress = false;
            showDialog<dynamic>(
                context: context,
                builder: (_) {
                  return warningDialog(
                    heading: 'Response',
                    msg: '${value.stcode!}..!!Network Issue..\nTry again Later..!!',
                  );
                });
          }
        });
      }
      // }
      
    }

    notifyListeners();
  }

  String apiNdate = '';

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
      apiNdate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";
      print(apiNdate);
      mycontroller[17].text = chooseddate;
      notifyListeners();
    });
  }

  RemoveandAdd(CollectionLineData? collcetionline) {
    allProductDetails.clear();
    // for (int i = 0; i < filterProductDetails.length; i++) {
    //   if (filterProductDetails[i].invoice == collcetionline!.invoice) {
    filterProductDetails.add(CollectionCustomerData(
      // amount: collcetionline!.amount,
      date: collcetionline!.date,
      invoice: collcetionline.invoice,
      purpose: collcetionline.purpose,
      type: collcetionline.type,
      balancetoPay: collcetionline.balancetoPay,
      paidAmount: collcetionline.orgAmount,
      age: collcetionline.age,
      trnsAmount: collcetionline.trnsAmount, docentry: collcetionline.docentry,
      //  amount: null,
    ));
    //   }
    // }
    allProductDetails = filterProductDetails;
    getProduct.remove(collcetionline);
    print(allProductDetails.length);
    notifyListeners();
  }

  updateProductDetails(BuildContext context, int i) {
    if (formkey[1].currentState!.validate()) {
      productDetails[i].paidAmount =
          double.parse(mycontroller[14].text.toString());

      showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
    }
  }

  // getAmount(CollectionLineData? lineList) {
  //   double temp = 0.0;
  //   // print("Temptemp=temp=temp=temp=temp"+allProductDetails.length.toString());
  //   for (int i = 0; i < allProductDetails.length; i++) {
  //     if (allProductDetails[i].date == lineList!.date &&
  //         allProductDetails[i].invoice == lineList.invoice) {
  //       // print("Temptemp=temp=temp=temp=temp="+lineList.amount.toString());
  //       temp = lineList.amount;
  //     }
  //   }
  //   return temp;
  // }

  showBottomSheetInsert(BuildContext context, int i) {
    final theme = Theme.of(context);
    slelectedIteminvoice = allProductDetails[i].invoice.toString();
    slelectedItemDate = allProductDetails[i].date.toString();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
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
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Container(
                    //       // width: Screens.width(context)*0.8,
                    //       child: Text(allProductDetails[i].invoice.toString(),
                    //           style: theme.textTheme.bodyText1
                    //               ?.copyWith(color: theme.primaryColor)),
                    //     ),   Container(
                    //   // width: Screens.width(context)*0.7,
                    //   // color: Colors.red,
                    //   child: Text(allProductDetails[i].date.toString(),
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith() //color: theme.primaryColor
                    //       ),
                    // ),
                    //   ],
                    // ),
                    // Container(
                    //   // width: Screens.width(context)*0.8,
                    //   child: Text("Amount to Pay",
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith(color: theme.primaryColor)),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      // width: 270,
                      // height: 40,
                      child: new TextFormField(
                          controller: mycontroller[14],
                          onChanged: (val) {},
                          validator: (value) {
                            print("Amount value" +
                                allProductDetails[i].balancetoPay.toString());
                            if (value!.isEmpty) {
                              return "ENTER AMOUNT";
                            } else if (allProductDetails[i].balancetoPay <
                                double.parse(value)) {
                              return "Enter Correct Amount";
                            } else if (0 == double.parse(value)) {
                              return "Enter Correct Amount";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: 'Amount to Pay',
                            border: UnderlineInputBorder(),
                            labelStyle: theme.textTheme.bodyText1!
                                .copyWith(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in focused
                            ),
                            errorBorder: UnderlineInputBorder(),
                            focusedErrorBorder: UnderlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                                  // mycontroller[12].clear();
                                  addProductDetails(
                                      context, allProductDetails[i]);
                                },
                                child: Text("ok"))
                            : ElevatedButton(
                                onPressed: () {
                                  updateProductDetails(context, i);
                                },
                                child: Text("Update")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  UpdateshowBottomSheetInsert(BuildContext context, int i) {
    final theme = Theme.of(context);
    // slelectedIteminvoice = getProduct[i].invoice.toString();
    // slelectedItemDate = getProduct[i].date.toString();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
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
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Container(
                    //       // width: Screens.width(context)*0.8,
                    //       child: Text(allProductDetails[i].invoice.toString(),
                    //           style: theme.textTheme.bodyText1
                    //               ?.copyWith(color: theme.primaryColor)),
                    //     ),   Container(
                    //   // width: Screens.width(context)*0.7,
                    //   // color: Colors.red,
                    //   child: Text(allProductDetails[i].date.toString(),
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith() //color: theme.primaryColor
                    //       ),
                    // ),
                    //   ],
                    // ),
                    // Container(
                    //   // width: Screens.width(context)*0.8,
                    //   child: Text("Amount to Pay",
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith(color: theme.primaryColor)),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      // width: 270,
                      // height: 40,
                      child: new TextFormField(
                          controller: mycontroller[14],
                          onChanged: (val) {},
                          validator: (value) {
                            print("Amount value" +
                                double.parse(value!).toString());
                            if (value.isEmpty) {
                              return "ENTER AMOUNT";
                            } else if (double.parse(value) >
                                getProduct[i].balancetoPay) {
                              return "Enter Correct Amount";
                            } else if (0 == double.parse(value)) {
                              return "Enter Correct Amount";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Amount to Pay',
                            border: UnderlineInputBorder(),
                            labelStyle: theme.textTheme.bodyText1!
                                .copyWith(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in focused
                            ),
                            errorBorder: UnderlineInputBorder(),
                            focusedErrorBorder: UnderlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("cancel")),
                        ElevatedButton(
                            onPressed: () {
                              updateProductDetails(context, i);
                            },
                            child: Text("Update")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  List<InvoiceData> invoice = [];
  List<customerDetails> customerlist = [];
  List<customerDetails> get getcustomerlist => customerlist;
  List<customerDetails> filterCustomerlist = [];
  bool customerbool = false;
  bool custCodebool = false;
  bool contactbool = false;
  bool mobilebool = false;

  clearbool() {
    customerbool = false;
    custCodebool = false;
    contactbool = false;
    mobilebool = false;
    notifyListeners();
  }

  String paymentmodeErro = "";
  getExiCustomerData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].customer) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiCustomerCodeData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].cuscode) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiCustomerCantactData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].contactname) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiCustomerMobileData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].mobile) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  filterCollectionCuslist(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.customer!.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  filterCollectionCusCardCode(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.cuscode.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  filterCollectionCusCantact(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.contactname.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  filterCollectionCusMobile(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.mobile.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  // getData() {
  //   filterProductDetails = [
  //     CollectionCustomerData(
  //       invoice: "1623233",
  //       date: "2023-07-03",
  //       purpose: "Looking For Chair/Tables",
  //       amount: 2370.00,
  //       type: "Balance", balancetoPay: 0.0, paidAmount: 0.0, age: '',
  //       trnsAmount: 0.0,
  //       // isselect: false,
  //     ),
  //     CollectionCustomerData(
  //       invoice: "987765",
  //       date: "2022-06-13",
  //       purpose: "Looking For Chair/Tables",
  //       amount: 1070.00,
  //       type: "Balance", balancetoPay: 0.0, paidAmount: 0.0, age: '',
  //       trnsAmount: 0.0,
  //       // isselect: false
  //     ),
  //     CollectionCustomerData(
  //       invoice: "342323",
  //       date: "2023-10-11",
  //       purpose: "Looking For Chair/Tables",
  //       amount: 2000.00,
  //       type: "Balance",
  //       balancetoPay: 0.0, paidAmount: 0.0, age: '', trnsAmount: 0.0,
  //       // isselect: false,
  //     )
  //   ];
  //   customerlist = [
  //     customerDetails(
  //         cuscode: "A00001",
  //         customer: "Ram Electricals",
  //         contactname: "Saravanan",
  //         mobile: "9876543210"),
  //     customerDetails(
  //         cuscode: "A00002",
  //         customer: "Chennai Mobiles",
  //         contactname: "Senthil Kumar",
  //         mobile: "9812345210"),
  //     customerDetails(
  //         cuscode: "A00023",
  //         customer: "Ram & Co",
  //         contactname: "Sathyamurthi",
  //         mobile: "9876543987"),
  //     customerDetails(
  //         cuscode: "A00045",
  //         customer: "Krishna Builders",
  //         contactname: "Abdul Rahuman",
  //         mobile: "9876543210"),
  //   ];
  //   invoice = [
  //     InvoiceData(id: 1, invoiceNo: "12345", total: 20000, totalPayment: 18000),
  //     InvoiceData(id: 2, invoiceNo: "54321", total: 12022, totalPayment: 1200),
  //     InvoiceData(id: 3, invoiceNo: "10001", total: 25000, totalPayment: 12000),
  //   ];

  //   filterCustomerlist = customerlist;
  //   allProductDetails = filterProductDetails;
  //   notifyListeners();
  // }

  //New

  bool cashbool = false;
  bool cardbool = false;
  bool chequebool = false;
  bool upibool = false;
  bool neftbool = false;

  paymodeSelect(String type) {
    String type2 = type;
    cashbool = false;
    cardbool = false;
    chequebool = false;
    upibool = false;
    neftbool = false;

    mycontroller[16].text = ""; //card ref
    mycontroller[17].text = ""; //Cheque date
    mycontroller[18].text = ""; //cheque
    mycontroller[19].text = ""; //NEFT ref
    mycontroller[20].text = ""; //UPI ref
 files.clear();
        
        filedata.clear();
    switch (type2) {
      case "Cash":
        cashbool = true;
        break;
      case "Card":
        cardbool = true;

        break;

      case "UPI":
        upibool = true;
        break;

      case "Cheque":
        chequebool = true;
        break;
      case "NEFT":
        neftbool = true;
        break;
    }
  }

  bool returnboolValue(String type) {
    bool value = false;
    String type2 = type;

    switch (type2) {
      case "Cash":
        value = cashbool;
        break;
      case "Card":
        value = cardbool;
        break;

      case "UPI":
        value = upibool;
        break;

      case "Cheque":
        value = chequebool;
        break;
      case "NEFT":
        value = neftbool;
        break;
    }
    return value;
  }

  bool getcustomerapicLoading = false;
  FocusNode focusNode2 = FocusNode();
  List<CustomerTagTypeData> customerTagTypeData = [];
//
  clearnum() {
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
    isSelectedCusTagcode='';
     notifyListeners();
  }
  getCustomerTag() async {
    customerTagTypeData = [];
    final Database db = (await DBHelper.getInstance())!;
    customerTagTypeData = await DBOperation.getCusTagData(db);
    notifyListeners();
  }

  String statecode = '';

  String isSelectedCusTag = '';
  String isSelectedCusTagcode = '';
  String get getisSelectedCusTag => isSelectedCusTag;
  String? CusTag;

  List<File> files = [];
  bool? fileValidation = false;

  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than One Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  List<FilesData2> filedata = [];

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
    if (files.length <= 4) {
      for (int i = 0; i < filesz.length; i++) {
        files.add(filesz[i]);
        List<int> intdata = filesz[i].readAsBytesSync();
        String fileName = filesz[i].path.split('/').last;
        String fileBytes = base64Encode(intdata);
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String fullPath = '${tempDir.path}/$fileName';
         if(Platform.isAndroid){
filedata.add(FilesData2(
            fileBytes: base64Encode(intdata),
            fileName: fullPath
            // files[i].path.split('/').last
            ));
             }else{
              filedata.add(FilesData2(
            fileBytes: base64Encode(intdata),
            fileName: image.path
            // files[i].path.split('/').last
            ));
             }
        // filedata.add(
        //     FilesData2(fileBytes: base64Encode(intdata), fileName: fullPath));
        notifyListeners();
      }
      // log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
      showtoast();
    }

    // showtoast();

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

  FocusNode focusNode1 = FocusNode();
  String countrycode = '';
  String statename = '';
  bool statebool = false;
  bool statebool2 = false;
  List<stateHeaderData> stateData = [];
  List<stateHeaderData> filterstateData = [];
  stateApicallfromDB() async {
    stateData.clear();
    filterstateData.clear();

    final Database db = (await DBHelper.getInstance())!;
    stateData = await DBOperation.getstateData(db);
    filterstateData = stateData;
    print('State Length::' + filterstateData.length.toString());
    notifyListeners();
  }

  bool isText1Correct = false;

  methidstate(String name, BuildContext context) {
    // statebool = true;
    print("state" + name);
    statecode = '';
    statename = '';
    countrycode = '';

    for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].stateName.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        statecode = filterstateData[i].statecode.toString();
        statename = filterstateData[i].stateName.toString();
        countrycode = filterstateData[i].countrycode.toString();
        isText1Correct = false;
        // FocusScope.of(context).unfocus();
      }
    }
    //  notifyListeners();
  }

  setfasle() {
    statebool = false;
    notifyListeners();
  }

  stateontap(int i) {
    statebool = false;
    mycontroller[12].text = filterstateData[i].stateName.toString();
    statecode = filterstateData[i].statecode.toString();
    statename = filterstateData[i].stateName.toString();
    countrycode = filterstateData[i].countrycode.toString();

    notifyListeners();
  }

  firstPageNextBtn(BuildContext context) async {
    int passed = 0;
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
      } else if (mycontroller[12].text.isEmpty ||
          statecode.isEmpty && countrycode.isEmpty) {
        isText1Correct = true;
        notifyListeners();
      } else {
        if (passed == 0) {
          // showItemList = true;
          await onDoubletap(mycontroller[0].text.toString());
          pageController.animateToPage(1,
              duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
          // resetValidate();
        }
      }
    }
    notifyListeners();
  }

  FilePickerResult? result;

  selectattachment() async {
    List<File> filesz = [];

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
      if (filedata.isEmpty) {
        files.clear();
        filesz.clear();
        filedata.clear();
        notifyListeners();
      }

      filesz = result!.paths.map((path) => File(path!)).toList();

      // if (filesz.length != 0) {
      int remainingSlots = 5 - files.length;
      if (filesz.length <= remainingSlots) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

          // showtoast();
          files.add(filesz[i]);
          List<int> intdata = filesz[i].readAsBytesSync();
          filedata.add(FilesData2(
              fileBytes: base64Encode(intdata), fileName: filesz[i].path));

          //New
          // XFile? photoCompressedFile =await testCompressAndGetFile(filesz[i],filesz[i].path);
          // await FileStorage.writeCounter('${photoCompressedFile!.name}_1', photoCompressedFile);
          //

          notifyListeners();
          // return null;
        }
      } else {
        showtoast();
      }

      notifyListeners();
    }

    notifyListeners();
  }

  bool customerapicLoading = false;
  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;
  bool oldcutomer = false;
  List<GetCustomerData>? customerdetails;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;

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

  mapValues(GetCustomerData itemdata) {
    // mycontroller[0].text = itemdata[0].CardCode!;
    mycontroller[1].text = itemdata.customerName == null ||
            itemdata.customerName!.isEmpty ||
            itemdata.customerName == 'null'
        ? ''
        : itemdata.customerName!;
    mycontroller[2].text = itemdata.contactName == null ||
            itemdata.contactName == 'null' ||
            itemdata.contactName!.isEmpty
        ? ''
        : itemdata.contactName!;
    mycontroller[5].text = itemdata.gst == null ||
            itemdata.gst == '' ||
            itemdata.gst == 'null' ||
            itemdata.gst!.isEmpty
        ? ''
        : itemdata.gst!;

    if (itemdata.State != null ||
        itemdata.State != 'null' ||
        itemdata.State!.isNotEmpty) {
      mycontroller[12].text = itemdata.State!;
      //
      statecode = '';
      statename = '';
      countrycode = '';

      for (int i = 0; i < filterstateData.length; i++) {
        if (filterstateData[i].stateName.toString().toLowerCase() ==
            mycontroller[12].text.toString().toLowerCase()) {
          statecode = filterstateData[i].statecode.toString();
          statename = filterstateData[i].stateName.toString();
          countrycode = filterstateData[i].countrycode.toString();
          isText1Correct = false;
          // FocusScope.of(context).unfocus();
        }
      }
    } else {
      mycontroller[12].text = '';
    }

    mycontroller[7].text = itemdata.Address_Line_1 == null ||
            itemdata.Address_Line_1!.isEmpty ||
            itemdata.Address_Line_1 == 'null'
        ? ''
        : itemdata.Address_Line_1!;
    mycontroller[4].text = itemdata.email == null ||
            itemdata.email!.isEmpty ||
            itemdata.email == 'null'
        ? ''
        : itemdata.email!;
    mycontroller[11].text = itemdata.Pincode == null ||
            itemdata.Pincode!.isEmpty ||
            itemdata.Pincode == 'null'
        ? ''
        : itemdata.Pincode!;
    mycontroller[10].text = itemdata.City == null ||
            itemdata.City!.isEmpty ||
            itemdata.City == 'null'
        ? ''
        : itemdata.City!;
    mycontroller[3].text = itemdata.altermobileNo == null ||
            itemdata.altermobileNo == 'null' ||
            itemdata.altermobileNo!.isEmpty
        ? ''
        : itemdata.altermobileNo!;
    mycontroller[9].text = itemdata.area == null ||
            itemdata.area == 'null' ||
            itemdata.area!.isEmpty
        ? ''
        : itemdata.area!;

    mycontroller[8].text = itemdata.Address_Line_2 == null ||
            itemdata.Address_Line_2 == 'null' ||
            itemdata.Address_Line_2!.isEmpty
        ? ''
        : itemdata.Address_Line_2!;
    customerapicLoading = false;
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == itemdata.customerGroup) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
    }

    notifyListeners();
  }

  List<outstandingDBModel> valueDBmodel = [];
  List<outstandinglineDBModel> valueDBmodelchild = [];

  getdbmodel() async {
    notifyListeners();
    final Database db = (await DBHelper.getInstance())!;
    valueDBmodel = await DBOperation.getoutstandingMaster(db);
    valueDBmodelchild = await DBOperation.getoutstandingchild(db);
    // await countofKpi();

    List<Map<String, Object?>> assignDB =
        await DBOperation.getOutLFtr("AssignedTo", db);

    List<Map<String, Object?>> customerDB =
        await DBOperation.getOutLFtr("CustomerName", db);
    notifyListeners();

    await dataget(assignDB, customerDB);
    notifyListeners();
    // apiloading = true;
    print('valueDBModel:' + valueDBmodel.length.toString());
    print('valueDBmodelchild:' + valueDBmodelchild.length.toString());

    notifyListeners();
  }

  List<Distcolumn> assigncolumn = [];
  List<cuscolumn2> customercolumn = [];
  Future<void> dataget(List<Map<String, Object?>> assignDB, customerDB) async {
    for (int i = 0; i < assignDB.length; i++) {
      assigncolumn.add(Distcolumn(name: assignDB[i]['AssignedTo'].toString()));
      // log("assigncolumn::" + assigncolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < customerDB.length; i++) {
      customercolumn
          .add(cuscolumn2(name: customerDB[i]['CustomerName'].toString()));
      // log("customercolumn::" + customercolumn[i].name.toString());
      notifyListeners();
    }
  }

  double? totaloutstanding = 0.0;
  double? overdue = 0.0;
  double? upcoming = 0.0;
  String? KpiCustomer = '';
  String? KpiCustomerCode = '';

  List<outstandKPI> outstandingkpi = [];

  countofKpi() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result2 =
        await DBOperation.getoutstandingKPI(db);
    if (result2.isNotEmpty) {
      //  outstandKPI(
      totaloutstanding =
          double.parse(result2[0]['totaloutstanding'].toString());
      overdue = double.parse(result2[0]['overdue'].toString());
      upcoming = double.parse(result2[0]['upcoming'].toString());
      // );
    } else {
      //  outstandKPI(
      totaloutstanding = 0.0;
      overdue = 0.0;
      upcoming = 0.0;
      // );
    }
    notifyListeners();
  }

  onDoubletap(String? cusCode) async {
    allProductDetails.clear();
    valueDBmodelchild.clear();
    final Database db = (await DBHelper.getInstance())!;
    outstandingkpi =
        await DBOperation.getoutstandingchildInvoice(db, '$cusCode');
    List<Map<String, Object?>> result2 =
        await DBOperation.getoutontapKPI(db, cusCode);
    if (result2.isNotEmpty) {
      //  outstandKPI(
      totaloutstanding = result2[0]['totaloutstanding'] == null
          ? 0.0
          : double.parse(result2[0]['totaloutstanding'].toString());
      overdue = result2[0]['overdue'] == null
          ? 0.0
          : double.parse(result2[0]['overdue'].toString());
      upcoming = result2[0]['upcoming'] == null
          ? 0.0
          : double.parse(result2[0]['upcoming'].toString());
      KpiCustomer = result2[0]['CustomerName'].toString();
      KpiCustomerCode = result2[0]['CustomerCode'].toString();
      // );
    } else {
      //  outstandKPI(
      totaloutstanding = 0.0;
      overdue = 0.0;
      upcoming = 0.0;
      // );
    }

    getAllProduct(outstandingkpi);
    notifyListeners();
  }

  getAllProduct(List<outstandKPI> outstandingkpi) {
    // allProductDetails.clear();
    // filterProductDetails.clear();
    for (int i = 0; i < outstandingkpi.length; i++) {
      allProductDetails.add(CollectionCustomerData(
          invoice: outstandingkpi[i].TransNum,
          date: outstandingkpi[i].TransDate!,
          paidAmount: 0.0,
          purpose: outstandingkpi[i].TransRef1!,
          // amount: 0.0,
          type: '',
          trnsAmount: double.parse(outstandingkpi[i].TransAmount.toString()),
          balancetoPay: double.parse(outstandingkpi[i].BalanceToPay.toString()),
          age: outstandingkpi[i].age!.toInt().toString(),
          docentry: outstandingkpi[i].docentry.toString()));
    }
    filterProductDetails = allProductDetails;
    print('allproductcount' + allProductDetails.length.toString());
    notifyListeners();
  }
}

class CollectionCustomerData {
  String? invoice;
  String? docentry;

  String date;
  String purpose;
  String age;
  double paidAmount;
  double trnsAmount;

  double balancetoPay;

  // double amount;
  String type;
  // bool isselect;

  CollectionCustomerData(
      {required this.invoice,
      required this.date,
      required this.paidAmount,
      required this.purpose,
      // required this.amount,
      required this.type,
      required this.trnsAmount,
      required this.balancetoPay,
      required this.age,
      required this.docentry

      // required this.isselect,
      });
}

class customerDetails {
  String? customer;
  String cuscode;
  String contactname;
  // double amount;
  String mobile;

  customerDetails({
    required this.cuscode,
    required this.customer,
    required this.contactname,
    required this.mobile,
    // required this.type,
  });
}

class CollectionLineData {
  String? invoice;
  String? docentry;

  String date;
  String purpose;
  // double amount;
  String type;
  double orgAmount;
  String age;
  double paidAmount;
  double trnsAmount;

  double balancetoPay;

  CollectionLineData({
    required this.invoice,
    required this.date,
    required this.purpose,
    // required this.amount,
    required this.type,
    required this.orgAmount,
    required this.age,
    required this.paidAmount,
    required this.trnsAmount,
    required this.balancetoPay,
    required this.docentry,
  });
}

class InvoiceData {
  String? invoiceNo;
  int? total;
  int? id;

  int? totalPayment;

  InvoiceData({
    required this.id,
    required this.invoiceNo,
    required this.total,
    required this.totalPayment,
  });
}

class FilesData2 {
  String fileBytes;
  String fileName;
  // String filepath;

  FilesData2({
    required this.fileBytes,
    required this.fileName,
  });
}

class Distcolumn {
  String name;
  Distcolumn({
    required this.name,
  });
}

class cuscolumn2 {
  String name;
  cuscolumn2({
    required this.name,
  });
}
