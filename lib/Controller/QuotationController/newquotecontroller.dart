
// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Models/CustomerMasterModel/CustomerMasterModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/OrderTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/levelofinterestModel.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/GetOrderCheckListModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/paymodemodel.dart';
import 'package:sellerkit/Models/QuoteModel/quotemodel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Pages/OrderBooking/Screens/OrderSuccessPage.dart';
import 'package:sellerkit/Pages/Quoatation/Succcesspage.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/firstdialog.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/shorefdialog.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetAllLeads.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/QuotationApi/addquotes.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/AttachmentFileLinkApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/OrderCheckListApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/paymentmode.dart';
import 'package:sellerkit/Services/PostQueryApi/QuotatationApi/QuotesQTHApi.dart';
import 'package:sellerkit/Services/PostQueryApi/QuotatationApi/quotesupdateApi.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';
import 'package:sellerkit/Services/refrealpartnerApi/refpartnerApi.dart';
import 'package:sqflite/sqflite.dart';

import '../../Pages/Quoatation/tabquote/widgets/warningorder.dart';
import '../../Widgets/AlertDilog.dart';
class NewquoteController extends ChangeNotifier{
   int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);

 bool isloading=false;
 String? leadnum='';
   
   init(BuildContext context) async{
      clearAllData();
     
      await  callGetAllApi();
    firstdialog(context);
   }
   List<PaymodeModalData> paymode=[];
   customerdetData? customermodeldata;
callcustomerapi()async{
  await customerDetailApi.getData().then((value) {
    if(value.stcode! >= 200 && value.stcode! <= 210){
customermodeldata=value.leadcheckdata;
    }
  });

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
// String apipurchaseDate = '';
//   void showpurchaseDate(BuildContext context) {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2050),
//     ).then((value) {
//       if (value == null) {
//         return;
//       }
//       String chooseddate = value.toString();
//       var date = DateTime.parse(chooseddate);
//       chooseddate = "";
//       chooseddate =
//           "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
//       apipurchaseDate =
//           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00";
//       log("APIFpurchase::" + apiFDate);
//       // isdatevalid = false;
//       mycontroller[35].text = chooseddate;
//       notifyListeners();
//     });
//   }

 callpaymodeApi() async {
  paymode.clear();
  notifyListeners();
    await PaymodeApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.paymode != null) {
          paymode = value.paymode!.paymodeModalData!;

          notifyListeners();
        } else if (value.paymode == null) {
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
  bool iscomeforupdate = false;
  bool value3 = false;
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
      DocDateold='';
      selectedapartname='';
      selectedapartcode='';
      refpartdata.clear();
      mycontroller[46].clear();
  filterrefpartdata.clear();
      paymentTerm=false;
       leveofdata.clear();
    ordertypedata.clear();
    valueChosedStatus=null;
    valueChosedCusType=null;
    valueChosedCusType=null;
      mycontroller[31].clear();
    log("step1"); isAnother == true;
    leadnum='';
      statecode = '';
      iscomeforupdate = false;
     value3 = false;
     countrycode = '';
     statename = '';
     customermodeldata=null;
    statebool = false;
    statebool2 = false;
    isText1Correct = false;
    isText1Correct2 = false;
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
    statebool = false;
    files.clear();
    filedata.clear();
    value = false;
    isSelectedpaymentTermsList = '';
    isSelectedpaymentTermsCode = '';
    // isSelectedenquirytype = '';
    // isSelectedAge = '';
    // isSelectedcomeas = '';
    // isSelectedGender = '';
    // isSelectedAdvertisement = '';
    // isSelectedenquiryReffers = '';
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
    leadOpenAllData.clear();
    filterleadOpenAllData.clear();
   
    // autoIsselectTag = false;
    // enqID = null;
    log("step2");

    resetListSelection();
    log("step3");

    notifyListeners();
  }bool isTextFieldEnabled = true;
  bool customerbool = false;
  bool areabool = false;
  bool citybool = false;
  bool pincodebool = false;
  bool statebool = false;
  bool statebool2 = false;
//  bool isselected=false;
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
 int? isleadselected;
  firstdialog(BuildContext context){
    showDialog(context: context, builder: (_){
return openleaddialog();
    });
    // .then((value) => 
    // Get.toNamed(ConstantRoutes.quotespage),
    // );
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
  onindexselect(GetAllLeadData leadOpenAllData)async{
    isloading=true;
     notifyListeners();
 await getdataFromDb();
 await callrefparnerApi();
 await getLeveofType();
    await  stateApicallfromDB();
   await getCustomerTag();
   await callpaymodeApi();
   
    notifyListeners();


    
    mycontroller[0].text =leadOpenAllData.customermob == null ||
           leadOpenAllData.customermob == "null" ||
            leadOpenAllData.customermob!.isEmpty
        ? ""
        :leadOpenAllData.customermob.toString();
    mycontroller[16].text =leadOpenAllData.CustomerName == null ||
           leadOpenAllData.CustomerName == "null" ||
            leadOpenAllData.CustomerName!.isEmpty
        ? ""
        :leadOpenAllData.CustomerName.toString();
    mycontroller[7].text =leadOpenAllData.cusEmail == null ||
           leadOpenAllData.cusEmail == "null" ||
            leadOpenAllData.cusEmail!.isEmpty
        ? ""
        :leadOpenAllData.cusEmail.toString();
    mycontroller[2].text =leadOpenAllData.add1 == null ||
           leadOpenAllData.add1 == "null" ||
            leadOpenAllData.add1!.isEmpty
        ? ""
        :leadOpenAllData.add1.toString();
    mycontroller[3].text =leadOpenAllData.add2 == null ||
           leadOpenAllData.add2 == "null" ||
            leadOpenAllData.add2!.isEmpty
        ? ""
        :leadOpenAllData.add2.toString();
    mycontroller[17].text =leadOpenAllData.area == null ||
           leadOpenAllData.area == "null" ||
            leadOpenAllData.area!.isEmpty
        ? ""
        :leadOpenAllData.area.toString();
    mycontroller[5].text =leadOpenAllData.City == null ||
           leadOpenAllData.City == "null" ||
            leadOpenAllData.City!.isEmpty
        ? ""
        :leadOpenAllData.City.toString();
    mycontroller[4].text =leadOpenAllData.pincode == null ||
           leadOpenAllData.pincode == "null"||leadOpenAllData.pincode == "0" ||
            leadOpenAllData.pincode!.isEmpty
        ? ""
        :leadOpenAllData.pincode.toString();
    mycontroller[18].text = leadOpenAllData.state == null ||
           leadOpenAllData.state == "null" ||
            leadOpenAllData.state!.isEmpty
        ? ""
        : leadOpenAllData.state.toString();
        leadnum=leadOpenAllData.LeadNum.toString();
        for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == leadOpenAllData.cusgroup) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
         isSelectedCusTag = customerTagTypeData[i].Name.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
   if(leadOpenAllData.OrderType !=null ||leadOpenAllData.OrderType != "null"||leadOpenAllData.OrderType!.isNotEmpty) {
for(int i=0;i<ordertypedata.length;i++){
          if(ordertypedata[i].Name==leadOpenAllData.OrderType){
valueChosedCusType=ordertypedata[i].Code;
          }
        }
       }
        
enqID = int.parse(leadOpenAllData.LeadNum.toString());
basetype=2;
    // mycontroller[0].text =leadOpenAllData.customermob.toString();
    // mycontroller[0].text =leadOpenAllData.customermob.toString();
       String? storecode;
    String? deliveryfrom;
    await GetLeadQTHApi.getData(leadOpenAllData.LeadNum.toString()).then((value) {
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
              log("selectedItemCode::"+selectedItemCode.toString());
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
      //            sporder= value
      //         .leadDeatilheadsData!.leadDeatilsQTLData![i].Info_SP;
      //       slppriceorder= value
      //         .leadDeatilheadsData!.leadDeatilsQTLData![i].Cost;
      //       storestockorder= value
      //         .leadDeatilheadsData!.leadDeatilsQTLData![i].StoreStock;
      //       whsestockorder=value
      //         .leadDeatilheadsData!.leadDeatilsQTLData![i].WhseStock ;
      //       isfixedpriceorder= value
      //         .leadDeatilheadsData!.leadDeatilsQTLData![i].isFixedPrice;
      //       allownegativestockorder=value
      //         .leadDeatilheadsData!.leadDeatilsQTLData![i].AllowNegativestock;
      //       alloworderbelowcostorder= value
      //         .leadDeatilheadsData!.leadDeatilsQTLData![i].AllowOrderBelowCost;
        
      //     selectedItemCode =
      //         value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemCode;
      //     selectedItemName =
      //        value.leadDeatilheadsData!.leadDeatilsQTLData![i].ItemName;
      //     mycontroller[11].text = value.leadDeatilheadsData!.leadDeatilsQTLData![i].Quantity.toString();
      //     mycontroller[10].text = value.leadDeatilheadsData!.leadDeatilsQTLData![i].Price.toString();
      //         storecode= ConstantValues.Storecode;
      //         // value
      //         // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
      //         deliveryfrom="store";
      //         // value
      //         // .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
      //     // total=value.leadDeatilsQTHData!.DocTotal!;
      //   notifyListeners();
      //   unitPrice = double.parse(mycontroller[10].text);
      //   quantity = double.parse(mycontroller[11].text);
      //   total = unitPrice! * quantity!;
      //  productDetails.add(DocumentLines(
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
      //      storecode: storecode,
      //     deliveryfrom: deliveryfrom,
      //      sp: sporder,
      //       slpprice: slppriceorder,
      //       storestock: storestockorder,
      //       whsestock:whsestockorder ,
      //       isfixedprice: isfixedpriceorder,
      //       allownegativestock:allownegativestockorder ,
      //       alloworderbelowcost: alloworderbelowcostorder,
      //   )); 
       

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
    isloading=false;
    // filterleadOpenAllData.
     notifyListeners();

   
   

  }

DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.quotespage);
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
    
            child: Text("This User is assigned to multiple stores. Creating new quotes is not possible",
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
                 Get.offAllNamed(ConstantRoutes.quotespage);
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
  getdataFromDb() async {
    final Database db = (await DBHelper.getInstance())!;
    allProductDetails = await DBOperation.getAllProducts(db);
    filterProductDetails = allProductDetails;
    notifyListeners();
  }
 List<GetAllLeadData> leadOpenAllData = [];
  List<GetAllLeadData> get getAllLeadData => leadOpenAllData;
  List<GetAllLeadData> filterleadOpenAllData = [];
  List<GetAllLeadData> get getFilterleadOpenAllData => filterleadOpenAllData;
  bool openleadloading=false;
   String leadopenExcep = '';
  String get getleadopenExcep => leadopenExcep;
  callGetAllApi() async {
    leadOpenAllData.clear();
    filterleadOpenAllData.clear();
    isloading=true;
    notifyListeners();
    //  final Database db = (await DBHelper.getInstance())!;
    // leadStatusLost = await DBOperation.getLeadStatusLost(db);
    await GetAllLeadApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckheader!.leadcheckdata != null) {
          // log("not null"+value.leadcheckheader!.length.toString());
          mapValues(value.leadcheckheader!.leadcheckdata!);
          isloading=false;
          notifyListeners();
        } else if (value.leadcheckheader == null) {
          leadopenExcep = 'No Leads..!!';
          isloading=false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading=false;
        leadopenExcep =
            'Some thing went wrong  \n${value.stcode} ${value.exception}..!!';
      } else if (value.stcode == 500) {
        leadopenExcep =
            'Some thing went wrong \n${value.stcode} ${value.exception}..!!';
      }
      notifyListeners();
    });
    // log("GetAll Lead Exception :::" + leadCheckDataExcep.toString());
  }
   mapValues2(GetCustomerData itemdata) {
    // mycontroller[0].text = itemdata[0].CardCode!;
    mycontroller[16].text =itemdata.customerName == null || itemdata.customerName!.isEmpty ||
            
            itemdata.customerName == 'null'
        ? ''
        : itemdata.customerName!;
    mycontroller[1].text = itemdata.contactName == null|| itemdata.contactName == 'null' ||
            itemdata.contactName!.isEmpty 
           
        ? ''
        : itemdata.contactName!;
    mycontroller[25].text = itemdata.gst == null ||itemdata.gst == '' ||
            
            itemdata.gst == 'null' ||
            itemdata.gst!.isEmpty
        ? ''
        : itemdata.gst!;
    mycontroller[18].text =itemdata.State == null|| itemdata.State == 'null' ||
            itemdata.State!.isEmpty 
            
        ? ''
        : itemdata.State!;
    mycontroller[2].text =itemdata.Address_Line_1 == null || itemdata.Address_Line_1!.isEmpty ||
            
            itemdata.Address_Line_1 == 'null'
        ? ''
        : itemdata.Address_Line_1!;
    mycontroller[7].text =itemdata.email == null || itemdata.email!.isEmpty ||
            
            itemdata.email == 'null'
        ? ''
        : itemdata.email!;
    mycontroller[4].text =itemdata.Pincode == null || itemdata.Pincode!.isEmpty ||
            
            itemdata.Pincode == 'null'||itemdata.Pincode == '0'
        ? ''
        : itemdata.Pincode!;
    mycontroller[5].text =itemdata.City == null || itemdata.City!.isEmpty ||
            
            itemdata.City == 'null'
        ? ''
        : itemdata.City!;
    mycontroller[6].text =itemdata.altermobileNo == null ||
            itemdata.altermobileNo == 'null'|| itemdata.altermobileNo!.isEmpty
            
        ? ''
        : itemdata.altermobileNo!;
    mycontroller[17].text =itemdata.area == null ||itemdata.area == 'null'|| itemdata.area!.isEmpty 
            
            
        ? ''
        : itemdata.area!;

    mycontroller[3].text = itemdata.Address_Line_2 == null||itemdata.Address_Line_2 == 'null' ||itemdata.Address_Line_2!.isEmpty 
            
            
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
      } 
    }
    // await callSummaryApi();
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
              (e).Status.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterleadOpenAllData = leadOpenAllData;
      notifyListeners();
    }
  }
  resetListSelection() {
    for (int i = 0; i < leadcheckdatas.length; i++) {
      leadcheckdatas[i].ischecked = false;
    }
  }
  List<OrderCheckData> leadcheckdatas = [];
  List<OrderCheckData> get getleadcheckdatas => leadcheckdatas;
  String LeadCheckDataExcep = '';
  String get getLeadCheckDataExcep => LeadCheckDataExcep;

  callLeadCheckApi() {
    GetOrderCheckListApi.getData('${ConstantValues.slpcode}').then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.Ordercheckdata != null) {
          leadcheckdatas = value.Ordercheckdata!;
          log("ininin");
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
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      }
    });
  }

  LeadcheckListClicked(bool? v, int i) {
    leadcheckdatas[i].ischecked = v;
    notifyListeners();
  }

 

   List<GlobalKey<FormState>> formkey =
      new List.generate(3, (i) => new GlobalKey<FormState>(debugLabel: "Lead"));
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());


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
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}Z";
      print("delivery date" + apiFDate);

      mycontroller[13].text = chooseddate;
      notifyListeners();
    });
  }
  List<File> files = [];
  bool? fileValidation = false;

  List<FilesData> filedata = [];

 
 
  FilePickerResult? result;
  selectattachment() async {
    List<File> filesz=[];
    log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
    if(filedata.isEmpty){
   files.clear();
      filesz.clear();
  filedata.clear();
  notifyListeners();
    }
    
    
    
      log("filedata::"+filedata.length.toString());

       filesz = result!.paths.map((path) => File(path!)).toList();



      // if (filesz.length != 0) {
         int remainingSlots = 5 - files.length;
         if (filesz.length <= remainingSlots) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

         
            // showtoast();
            files.add(filesz[i]);
            log("Files Lenght :::::" + files.length.toString());
            List<int> intdata = filesz[i].readAsBytesSync();
            filedata.add(FilesData(
                fileBytes: base64Encode(intdata), fileName: filesz[i].path));

        //New
        // XFile? photoCompressedFile =await testCompressAndGetFile(filesz[i],filesz[i].path);
        // await FileStorage.writeCounter('${photoCompressedFile!.name}_1', photoCompressedFile);
      //


            notifyListeners();
log("filedata222::"+filedata.length.toString());
            // return null;
          } 
        }else {
            showtoast();
          }
      
      notifyListeners();
    }
    
    notifyListeners();
  }

// Future<XFile?> testCompressAndGetFile(File file, String targetPath) async {
//     var result = await FlutterImageCompress.compressAndGetFile(
//         file.absolute.path, targetPath,
//         quality: 88,
//         rotate: 180,
//       );

//     print(file.lengthSync());

//     return result;
//   }


  Future imagetoBinary(ImageSource source) async {
    List<File> filesz=[];
    await LocationTrack.checkcamlocation();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // files.add(File());
    if(filedata.isEmpty){
 filedata.clear();
 filesz.clear();
    }
      filesz.add(File(image.path));
    
   
    notifyListeners();
 log("filesz lenghthhhhh::::::" + filedata.length.toString());
    if (files.length <= 4) {
      for (int i = 0; i < filesz.length; i++) {
        files.add(filesz[i]);
        List<int> intdata = filesz[i].readAsBytesSync();
         String fileName = filesz[i].path.split('/').last;
          String fileBytes = base64Encode(intdata);
           String tempPath='';
           if(Platform.isAndroid){

         tempPath = (await getExternalStorageDirectory())!.path;
        
        }else if(Platform.isIOS){
 tempPath = (await getApplicationDocumentsDirectory())!.path;
        }
       
           String fullPath = '$tempPath/$fileName'; 
        await filesz[i].copy(fullPath);
         File(fullPath).writeAsBytesSync(intdata);
  final result = await ImageGallerySaver.saveFile(fullPath,isReturnPathOfIOS: true);
    
        //  Directory tempDir = await getTemporaryDirectory();
        //   String tempPath = tempDir.path;
        //     String fullPath = '${tempDir.path}/$fileName';
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
        // filedata.add(FilesData(
        //     fileBytes: base64Encode(intdata),
        //     fileName: fullPath));
        notifyListeners();
      }
      // log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
     
      showtoast();
    }
    log("camera fileslength" + files.length.toString());
    log("camera filesdatalength" + filedata.length.toString());
    // showtoast();

    notifyListeners();
  }
  // selectattachment() async {
  //   log(files.length.toString());

  //   result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //   notifyListeners();

  //   if (result != null) {
  //     filedata.clear();

  //     List<File> filesz = result!.paths.map((path) => File(path!)).toList();

  //     if (filesz.length != 0) {
  //       for (int i = 0; i < filesz.length; i++) {
  //         // createAString();

  //         if (files.length <= 4) {
  //           // showtoast();
  //           files.add(filesz[i]);
  //           // log("Files Lenght :::::" + files.length.toString());
  //           List<int> intdata = filesz[i].readAsBytesSync();
  //           filedata.add(FilesData(
  //               fileBytes: base64Encode(intdata), fileName: filesz[i].path));
  //           notifyListeners();

  //           // return null;
  //         } else {
  //           showtoast();
  //         }
  //       }
  //     }
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }
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
  // Future imagetoBinary(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image == null) return;
  //   files.add(File(image.path));
  //   filedata.clear();
  //   notifyListeners();

  //   if (files.length <= 4) {
  //     for (int i = 0; i < files.length; i++) {
  //       List<int> intdata = files[i].readAsBytesSync();
  //       String fileName = files[i].path.split('/').last;
  //         String fileBytes = base64Encode(intdata);
  //        Directory tempDir = await getTemporaryDirectory();
  //         String tempPath = tempDir.path;
  //           String fullPath = '${tempDir.path}/$fileName';
  //       filedata.add(FilesData(
  //           fileBytes: base64Encode(intdata),
  //           fileName: fullPath));
  //       notifyListeners();
  //     }
  //     log("filesz lenghthhhhh::::::" + filedata.length.toString());

  //     // return null;
  //   } else {
  //     log("filesz lenghthhhhh::::::" + filedata.length.toString());
  //     showtoast();
  //   }
  //   log("camera fileslength" + files.length.toString());
  //   showtoast();

  //   notifyListeners();
  // }
   List<DocumentLines> productDetails = [];
  List<DocumentLines> get getProduct => productDetails;

  List<ItemMasterDBModel> allProductDetails = [];
  List<ItemMasterDBModel> filterProductDetails = [];

  List<ItemMasterDBModel> get getAllProductDetails => allProductDetails;

bool isloadingBtn = false;
  bool get getisloadingBtn => isloadingBtn;
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
  bool showItemList = true;
  bool get getshowItemList => showItemList;
   bool isUpdateClicked = false;
    double? unitPrice;
  double? quantity;
  double total = 0.00;
   String? selectedItemCode;
  String? get getselectedItemCode => selectedItemCode;

  String? selectedItemName;
  String? get getselectedItemName => selectedItemName;
   double? sporder =0.00;
  double? slppriceorder=0.00;
  double? storestockorder=0.00;
  double? whsestockorder=0.00;
  bool? isfixedpriceorder=false;
  bool? allownegativestockorder=false;
  bool? alloworderbelowcostorder=false;
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
                        // width: Screens.width(context)*0.8,
                        child: Text(productDetails[i].ItemCode.toString(),
                            style: theme.textTheme.bodyText1
                                ?.copyWith(color: theme.primaryColor)),
                      ),
                      Container(
                        // width: Screens.width(context)*0.7,
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
                      createTable(theme, indexshow),
                      SizedBox(
                        height: 5,
                      ),
                      createTable2(theme, indexshow),
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
                       createTable5(theme, indexshow),
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
                      InkWell(
                        onTap: (){
                                  showDialog<dynamic>(
                                                          context: context,
                                                          builder: (_) {
                                                            return ShowSearchDialog();
                                                          }).then((value) {
                                                            mycontroller[47].clear();
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
                      //  SizedBox(
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
                      //                                       mycontroller[47].clear();
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
                                    if (mycontroller[11].text.isNotEmpty&&int.parse(mycontroller[11].text) > 0) {
                                      mycontroller[12].clear();
                                      addProductDetails(context);
                                    } else {
                                      showtoastproduct();
                                    }
                                  },
                                  child: Text("ok"))
                              : ElevatedButton(
                                  onPressed: () {
                                    if (mycontroller[11].text.isNotEmpty&&int.parse(mycontroller[11].text) > 0) {
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
  
String? DocDateold='';

String? valueChosedrefcode;

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
 showBottomSheetInsert(BuildContext context, int i,) {
    final theme = Theme.of(context);
    selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    taxvalue=double.parse(allProductDetails[i].taxRate.toString());
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
                            st((){
if (val.length > 0) {
                              if (mycontroller[10].text.length > 0 &&
                                  mycontroller[11].text.length > 0) {
                                unitPrice = double.parse(mycontroller[10].text);
                                quantity = double.parse(mycontroller[11].text);
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
                      readOnly:   allProductDetails[i].isFixedPrice ==false ?false:
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
                        height: 10,
                      ),
                      SizedBox(
                        // width: 270,
                        // height: 40,
                        child: new TextFormField(
                          controller: mycontroller[11],
                          onChanged: (val) {
                            st((){
if (val.length > 0) {
                              if (mycontroller[10].text.length > 0 &&
                                  mycontroller[11].text.length > 0) {
                                unitPrice = double.parse(mycontroller[10].text);
                                quantity = double.parse(mycontroller[11].text);
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
                        onTap: (){
                                  showDialog<dynamic>(
                                                          context: context,
                                                          builder: (_) {
                                                            return ShowSearchDialog();
                                                          }).then((value) {
                                                            mycontroller[47].clear();
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
                      //  SizedBox(
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
                      //                                       mycontroller[47].clear();
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
                        height: 10,
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
                                    if(mycontroller[11].text.isNotEmpty&&int.parse(mycontroller[11].text)>0){
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
  List<bool> isselected = [true, false];
    addProductDetails(BuildContext context) {
    log("sellect" + selectedItemCode.toString());
    log("sellect" + selectedItemName.toString());
    log("sellect" + quantity.toString());
    log("sellect" + productDetails.length.toString());

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
            sp: sporder,
            slpprice: slppriceorder,
            storestock: storestockorder,
            whsestock:whsestockorder ,
            isfixedprice: isfixedpriceorder,
            allownegativestock:allownegativestockorder ,
            alloworderbelowcost: alloworderbelowcostorder,
            storecode:   ConstantValues.Storecode ,
            partcode:  selectedapartcode ==null || selectedapartcode.isEmpty?
   null:selectedapartcode,
   partname: selectedapartname==null||selectedapartname.isEmpty?
                  null:selectedapartname,
            deliveryfrom: isselected[0] == true ? "store" : "Whse"));
        // log("productslist" + productDetails.length.toString());
        // log("product" + productDetails[0].deliveryfrom.toString());
        showItemList = false;
        mycontroller[12].clear();
        Navigator.pop(context);
        isUpdateClicked = false;
        notifyListeners();
      }
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
  Config config = new Config();
 
   bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;
  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;
  bool oldcutomer = false;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
   seconPageBtnClicked() {
    if (productDetails.length > 0) {
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else {
      Get.snackbar("Field Empty", "Choose products..!!",
          backgroundColor: Colors.red);
    }
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
   
   List<CustomerData> filterCustomerList = [];
  List<CustomerData> get getfilterCustomerList => filterCustomerList;
   clearbool() {
    customerbool = false;
    areabool = false;
    citybool = false;
    pincodebool = false;
    statebool = false;

    notifyListeners();
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
 changeVisible() {
    showItemList = !showItemList;
    notifyListeners();
  }
  bool value = false;

  converttoShipping(bool value) {
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
          FocusScope.of(context).unfocus();
          pageController.animateToPage(++pageChanged,
              duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
          // resetValidate();
        }
      }
    }
    notifyListeners();
  }
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
  
bool paymentTerm=false;
thirPageBtnClicked(BuildContext context) {
    int passed = 0;
    if (formkey[1].currentState!.validate()) {

//       if(isSelectedpaymentTermsCode ==null ||isSelectedpaymentTermsCode.isEmpty){
// paymentTerm=true;
//       notifyListeners();
//     }else{
      // paymentTerm=false;
      notifyListeners();
 if (passed == 0) {
      
        saveToServer(context);
      // }
    }
     
    }
    // if (isSelectedenquiryReffers.isEmpty) {
    //   visibleRefferal = true;
    // }
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
  } List<GetCustomerData>? customerdetails;
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
            mapValues2(value.itemdata!.customerdetails![0]);
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
              
              AssignedToDialogUserState.LookingFor =
                  value.itemdata!.enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                  value.itemdata!.enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                 value.itemdata!.enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  value.itemdata!.enquirydetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq2(context, "Lead");
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
              // enquirydetails = value.itemdata!.enquirydetails;
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
             else if (value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
                  for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
                if(value.itemdata!.enquirydetails![i].DocType =="Order"){
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
              log("Anbuenq");
              // orderdetails = value.itemdata!.enquirydetails;
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
        exceptionOnApiCall =
            '${value.message!}..!!${value.exception}..!!';
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
 FocusNode focusNode2 = FocusNode();
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
// FocusScope.of(context).unfocus();
        log("22222state:::" + statecode.toString());
      }
    }
    //  notifyListeners();
  }
   FocusNode focusNode1 = FocusNode();
   FocusNode focusNode3 = FocusNode();

  ontapvalid(BuildContext context){
    
    methidstate(mycontroller[
                                                                    18]
                                                                .text,context);
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                focusNode1);
                                                        statebool = false;
                                                        notifyListeners();
   }
   ontapvalid2(BuildContext context){
    
    methidstate2(mycontroller[
                                                                    24]
                                                                .text);
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                focusNode3);
                                                        statebool = false;
                                                        notifyListeners();
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
     isSelectedCusTag='';
     
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
    isSelectedCusTag='';
    customerapicLoading = false;
    notifyListeners();
  }
   int? ordernum;
int? enqID;
  int? basetype;
  int docnum = 0;
   getTotalOrderAmount() {
    double? LineTotal = 0.00;
    for (int i = 0; i < productDetails.length; i++) {
      LineTotal = LineTotal! + productDetails[i].LineTotal!;
    }
    log("config.slpitCurrency22(LineTotal!.toString())::"+config.slpitCurrency22(LineTotal!.toString()));
    return config.slpitCurrency22(LineTotal!.toString()) ;
  }
  int? ordocentry;
//   mapvaluesfrommodify(BuildContext context) async {
//     productDetails.clear();
//     getdataFromDb();
//     getEnqRefferes();
//     await callLeadCheckApi();
//     await getCustomerTag();
//     await stateApicallfromDB();
//     value3 == true;
//     notifyListeners();
//     iscomeforupdate = true;
//     notifyListeners();
//     log("iscomeforupdate::::" + iscomeforupdate.toString());
//     // getCustomerListFromDB();
// //  for (int i = 0; i < customerTagTypeData.length; i++) {
// //       if (customerTagTypeData[i].Name ==  datafromlead[9]) {

// //         isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
// //         notifyListeners();
// //       }
// //       // log("isSelectedCsTag::" + dataenq[2].toString());
// //       notifyListeners();
// //     }
//     // log("datafromlead" + datafromlead[5].toString());
//     mycontroller[0].text = datafrommodify[1];
//     mycontroller[16].text = datafrommodify[2];
//     // mycontroller[1].text = datafromlead[1];
//     mycontroller[2].text = datafrommodify[6] == null ||
//             datafrommodify[6] == "null" ||
//             datafrommodify[6].isEmpty
//         ? ""
//         : datafrommodify[6];
//     mycontroller[3].text = datafrommodify[7] == null ||
//             datafrommodify[7] == "null" ||
//             datafrommodify[7].isEmpty
//         ? ""
//         : datafrommodify[7];
//     mycontroller[4].text = datafrommodify[10] == null ||
//             datafrommodify[10] == "null" ||
//             datafrommodify[10].isEmpty
//         ? ""
//         : datafrommodify[10];
//     mycontroller[5].text = datafrommodify[9] == null ||
//             datafrommodify[9] == "null" ||
//             datafrommodify[9].isEmpty
//         ? ""
//         : datafrommodify[9];
//     // mycontroller[5].text = datafrommodify[6];//city
//     mycontroller[18].text = datafrommodify[11] == null ||
//             datafrommodify[11] == "null" ||
//             datafrommodify[11].isEmpty
//         ? ""
//         : datafrommodify[11]; //pin
//     mycontroller[7].text = datafrommodify[4] == null ||
//             datafrommodify[4] == "null" ||
//             datafrommodify[4].isEmpty
//         ? ""
//         : datafrommodify[4]; //sta
//     mycontroller[17].text = datafrommodify[8] == null ||
//             datafrommodify[8] == "null" ||
//             datafrommodify[8].isEmpty
//         ? ""
//         : datafrommodify[8];
//     mycontroller[1].text = datafrommodify[5] == null ||
//             datafrommodify[5] == "null" ||
//             datafrommodify[5].isEmpty
//         ? ""
//         : datafrommodify[5];
//     mycontroller[6].text = datafrommodify[3] == null ||
//             datafrommodify[3] == "null" ||
//             datafrommodify[3].isEmpty
//         ? ""
//         : datafrommodify[3];
//     mycontroller[19].text = datafrommodify[12] == null ||
//             datafrommodify[12] == "null" ||
//             datafrommodify[12].isEmpty
//         ? ""
//         : datafrommodify[12];
//     mycontroller[20].text = datafrommodify[13] == null ||
//             datafrommodify[13] == "null" ||
//             datafrommodify[13].isEmpty
//         ? ""
//         : datafrommodify[13];
//     mycontroller[21].text = datafrommodify[14] == null ||
//             datafrommodify[14] == "null" ||
//             datafrommodify[14].isEmpty
//         ? ""
//         : datafrommodify[14];
//     mycontroller[22].text = datafrommodify[15] == null ||
//             datafrommodify[15] == "null" ||
//             datafrommodify[15].isEmpty
//         ? ""
//         : datafrommodify[15];
//     mycontroller[23].text = datafrommodify[16] == null ||
//             datafrommodify[16] == "null" ||
//             datafrommodify[16].isEmpty
//         ? ""
//         : datafrommodify[16];
//     mycontroller[24].text = datafrommodify[17] == null ||
//             datafrommodify[17] == "null" ||
//             datafrommodify[17].isEmpty
//         ? ""
//         : datafrommodify[17];
//         mycontroller[25].text=datafrommodify[19] == null ||
//             datafrommodify[19] == "null" ||
//             datafrommodify[19].isEmpty
//         ? ""
//         : datafrommodify[19];
//     ordocentry = int.parse(datafrommodify[0]);
//     ordernum = int.parse(datafrommodify[18]);
//     notifyListeners();
//     String? storecode;
//     String? deliveryfrom;
//     await GetOrderQTHApi.getData(datafrommodify[0]).then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         for (int i = 0;
//             i < value.OrderDeatilsheaderData!.OrderDeatilsQTLData!.length;
//             i++) {
//           selectedItemCode =
//               value.OrderDeatilsheaderData!.OrderDeatilsQTLData![i].ItemCode;
//           selectedItemName =
//               value.OrderDeatilsheaderData!.OrderDeatilsQTLData![i].ItemName;
//           mycontroller[11].text = value
//               .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].Quantity
//               .toString();
//           mycontroller[10].text = value
//               .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].Price
//               .toString();
//               storecode= value
//               .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].LocCode.toString();
//               deliveryfrom=value
//               .OrderDeatilsheaderData!.OrderDeatilsQTLData![i].deliveryFrom.toString();
//           // total=value.leadDeatilsQTHData!.DocTotal!;
//        unitPrice = double.parse(mycontroller[10].text);
//         quantity = double.parse(mycontroller[11].text);
//         total = unitPrice! * quantity!;
        
//         productDetails.add(DocumentLines(
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
//           deliveryfrom: deliveryfrom
//         ));
//         }
//         notifyListeners();
       
//         log("productslist" + productDetails.length.toString());
//         log("product" + productDetails[0].ItemDescription.toString());
//         showItemList = false;

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
//     datafrommodify.clear();
//     // productDetails.clear();
//     notifyListeners();
//   }
saveToServer(BuildContext context) async {
  await callcustomerapi();
    log("Step----------1");
    

    String date = config.currentDateOnly();
    PatchExCus patch = new PatchExCus();
    patch.CardCode = mycontroller[0].text;
    patch.CardName = mycontroller[16].text;
    //patch.CardType =  mycontroller[2].text;
    patch.U_Address1 = mycontroller[2].text == null || mycontroller[2].text.isEmpty
            ? null
            :mycontroller[2].text;
    patch.U_Address2 = mycontroller[3].text == null || mycontroller[3].text.isEmpty
            ? null
            :mycontroller[3].text;
    patch.area =mycontroller[17].text == null || mycontroller[17].text.isEmpty
            ? null
            : mycontroller[17].text;
    patch.U_ShipAddress1 = mycontroller[19].text == null || mycontroller[19].text.isEmpty
            ? null
            :mycontroller[19].text;
    patch.U_ShipAddress2 =mycontroller[20].text == null || mycontroller[20].text.isEmpty
            ? null
            : mycontroller[20].text;
    patch.U_Shiparea =mycontroller[21].text == null || mycontroller[21].text.isEmpty
            ? null
            : mycontroller[21].text;
    patch.altermobileNo =mycontroller[6].text == null || mycontroller[6].text.isEmpty
            ? null
            : mycontroller[6].text;
    patch.cantactName =mycontroller[1].text == null || mycontroller[1].text.isEmpty
            ? null
            : mycontroller[1].text;
    patch.gst =mycontroller[25].text == null || mycontroller[25].text.isEmpty
            ? null
            : mycontroller[25].text;
    patch.U_ShipCity =mycontroller[22].text == null || mycontroller[22].text.isEmpty
            ? null
            : mycontroller[22].text;
    patch.U_ShipState = statecode2;
    patch.U_ShipPincode =mycontroller[23].text == null || mycontroller[23].text.isEmpty
            ? null
            : mycontroller[23].text;
    patch.U_Pincode =mycontroller[4].text == null || mycontroller[4].text.isEmpty
            ? null
            : mycontroller[4].text;
    patch.U_City =mycontroller[5].text == null || mycontroller[5].text.isEmpty
            ? null
            : mycontroller[5].text;
    patch.U_State = statecode;
    patch.U_Country = countrycode;
    patch.U_ShipCountry = countrycode2;
    patch.levelof=valueChosedStatus==null ||valueChosedStatus!.isEmpty?null:valueChosedStatus;
        patch.ordertype=valueChosedCusType==null ||valueChosedCusType!.isEmpty?null:valueChosedCusType;

    // patch.gst=
    //patch.U_Country =  mycontroller[6].text;
    patch.U_EMail =mycontroller[7].text == null || mycontroller[7].text.isEmpty
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
    postLead.doctotal =double.parse(getTotalOrderAmount().toString().replaceAll(",", "")) ;
    postLead.paymentTerms = isSelectedpaymentTermsCode;
    // postLead.DocType = "dDocument_Items"; //
    postLead.CardCode = mycontroller[0].text; //
    postLead.CardName = mycontroller[16].text; //
    postLead.DocDate = config.currentDate(); //
    postLead.DocDateold=DocDateold!.isEmpty?config.currentDate():DocDateold;
    postLead.deliveryDate = apiFDate;
    postLead.paymentDate = apiNdate;
    // postLead.purchaseDate=apipurchaseDate;
    patch.enqid=enqID==null? 0:enqID;
    patch.enqtype=basetype==null? -1:basetype;
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

    // postLead.paymentTerms = isSelectedpaymentTermsList;
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
      log("Start Post" + oldcutomer.toString());
      if (oldcutomer == true) {
        log("postLead.paymentTerms::"+postLead.paymentTerms.toString());
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
  late QuoteSavePostModal successRes;
  QuoteSavePostModal get getsuccessRes => successRes;
  checkComeFromEnq(BuildContext context) async {
    log("ANBUUUU::");
    clearAllData();
    // customerapicLoading = true;
    // notifyListeners();
    //  getdataFromDb();
    // getEnqRefferes();
    // await callLeadCheckApi();
    // await stateApicallfromDB();
    // getCustomerTag();
    // if (datafromfollow.length > 0) {
    //   print("datatatatata: .....");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluesfromFollowup(context);
    //   notifyListeners();
    // }
    //  if (datafromopenlead.length > 0) {
    //   print("datatatatata: .....");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluesfromopenlead(context);
    //   notifyListeners();
    // }
    // if (dataenq.length > 0) {
    //   print("datatatatata: .....");
    //   customerapicLoading = true;
    //   mapValues3();
    // }
    // notifyListeners();
    if (datafromlead.length > 0) {
      log("ANBUORDER");
      clearAllData();
      customerapicLoading = true;
      mapvaluesfromlead(context);
      notifyListeners();
    }

    if (datafrommodify.length > 0) {
      log("ANBUORDER");
      clearAllData();
      isloading=true;
      // customerapicLoading = true;
      mapvaluesfrommodify(context);
      notifyListeners();
    }
    // if (datafromsiteout.length > 0) {
    //   log("ANBUORDER");
    //   clearAllData();
    //   customerapicLoading = true;
    //   mapvaluessiteout();
    //   notifyListeners();
    // }

  //   if (iscomfromSiteOutMobile.isNotEmpty) {}
  //   getdataFromDb();
  //   getEnqRefferes();
  //   callLeadCheckApi();
  //   getCustomerTag();
  //   await stateApicallfromDB();
  //  await callpaymodeApi();
    // getCustomerListFromDB();
    notifyListeners();
  }
  static List<String> datafrommodify = [];
  static List<String> datafromlead = [];
  static List<String> datafromsiteout = [];
  static List<String> datafromfollow = [];
  static List<String> datafromopenlead = [];
  String? GetleadItemCode;
  double? taxvalue;
  mapvaluesfromlead(BuildContext context) async {
     productDetails.clear();
   await getdataFromDb();
   await callrefparnerApi();
   await getLeveofType();
    await  stateApicallfromDB();
   await getCustomerTag();
   await callpaymodeApi();
    value3 == true;
    notifyListeners();
    // getCustomerListFromDB();
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafromlead[9]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
         isSelectedCusTag = customerTagTypeData[i].Name.toString();
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
         if(datafromlead[11] !=null ||datafromlead[11] != "null"||datafromlead[11].isNotEmpty) {
for(int i=0;i<ordertypedata.length;i++){
          if(ordertypedata[i].Name==datafromlead[11]){
valueChosedCusType=ordertypedata[i].Code;
          }
        }
       }
    enqID = int.parse(datafromlead[6]);
    basetype = 2;
    log("datafromlead[6]::" + datafromlead[6].toString());

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
              log("selectedItemCode::"+selectedItemCode.toString());
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
          //        sporder= value
          //     .leadDeatilheadsData!.leadDeatilsQTLData![i].Info_SP;
          //   slppriceorder= value
          //     .leadDeatilheadsData!.leadDeatilsQTLData![i].Cost;
          //   storestockorder= value
          //     .leadDeatilheadsData!.leadDeatilsQTLData![i].StoreStock;
          //   whsestockorder=value
          //     .leadDeatilheadsData!.leadDeatilsQTLData![i].WhseStock ;
          //   isfixedpriceorder= value
          //     .leadDeatilheadsData!.leadDeatilsQTLData![i].isFixedPrice;
          //   allownegativestockorder=value
          //     .leadDeatilheadsData!.leadDeatilsQTLData![i].AllowNegativestock;
          //   alloworderbelowcostorder= value
          //     .leadDeatilheadsData!.leadDeatilsQTLData![i].AllowOrderBelowCost;
        
         
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
          //      sp: sporder,
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

  mapvaluesfrommodify(BuildContext context) async {
    // log("daataa::"+datafrommodify[22].toString());
    productDetails.clear();
   await getdataFromDb();
   await callrefparnerApi();
   await getLeveofType();
    await  stateApicallfromDB();
   await getCustomerTag();
   await callpaymodeApi();
    value3 == true;
    notifyListeners();
    iscomeforupdate = true;
    notifyListeners();
    log("iscomeforupdate::::" + datafrommodify[20].toString());
    // getCustomerListFromDB();
     for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == datafrommodify[20]) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
         isSelectedCusTag = customerTagTypeData[i].Name.toString();
        notifyListeners();
      }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    }
      // log("isSelectedCsTag::" + dataenq[2].toString());
      notifyListeners();
    
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
            datafrommodify[10] == "null" ||
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
            datafrommodify[16].isEmpty
        ? ""
        : datafrommodify[16];
    mycontroller[24].text = datafrommodify[17] == null ||
            datafrommodify[17] == "null" ||
            datafrommodify[17].isEmpty
        ? ""
        : datafrommodify[17];
        mycontroller[25].text=datafrommodify[19] == null ||
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
    await GetQuotesQTHApi.getData(datafrommodify[0]).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        for (int ik = 0;
            ik < value.QuotesDeatilsheaderData!.OrderDeatilsQTLData!.length;
            ik++) {

               GetleadItemCode =
              value.QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].ItemCode;
            
              mycontroller[11].text =  value
              .QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].Quantity
              .toString();
          mycontroller[10].text = value
              .QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].Price
              .toString();
          storecode =value
              .QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].LocCode.toString();
          deliveryfrom = value
              .QuotesDeatilsheaderData!.OrderDeatilsQTLData![ik].deliveryFrom.toString();
              log("selectedItemCode::"+selectedItemCode.toString());
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
      //          sporder= value
      //         .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].Info_SP;
      //       slppriceorder= value
      //         .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].Cost;
      //       storestockorder= value
      //         .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].StoreStock;
      //       whsestockorder=value
      //         .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].WhseStock ;
      //       isfixedpriceorder= value
      //         .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].isFixedPrice;
      //       allownegativestockorder=value
      //         .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].AllowOrderBelowCost;
      //       alloworderbelowcostorder= value
      //         .QuotesDeatilsheaderData!.OrderDeatilsQTLData![i].AllowOrderBelowCost;
        
         
      //     // total=value.leadDeatilsQTHData!.DocTotal!;
      //  unitPrice = double.parse(mycontroller[10].text);
      //   quantity = double.parse(mycontroller[11].text);
      //   total = unitPrice! * quantity!;
        
      //   productDetails.add(DocumentLines(
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
      //        sp: sporder,
      //       slpprice: slppriceorder,
      //       storestock: storestockorder,
      //       whsestock:whsestockorder ,
      //       isfixedprice: isfixedpriceorder,
      //       allownegativestock:allownegativestockorder ,
      //       alloworderbelowcost: alloworderbelowcostorder,

      //   ));
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
    isloading=false;
    datafrommodify.clear();
    // productDetails.clear();
    notifyListeners();
  }
  callupdateApi(
      BuildContext context, PostOrder postLead, PatchExCus? patch) async {
    List<String> filename = [];
    List<String>? fileError = [];

    if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              log("message");
              postLead.attachmenturl1 = value;
            } else if (i == 1) {
              log("message");
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
    log("filename:::${filename.length}");

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

    await QuotesupdateApi.getData(ConstantValues.sapUserType, postLead, patch!)
        .then((value) {
      log("ANBUUU stcode " + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
         successRes = value;
        QuotesSuccessPageState.getsuccessRes = successRes;
         for(int i=0;i<paymode.length;i++){
        if(paymode[i].Code ==value.orderSavePostheader!.orderMasterdata![0].PaymentTerms){
QuotesSuccessPageState.paymode = paymode[i].ModeName.toString();
        }

       } 
        Get.toNamed(ConstantRoutes.successQuotes);
        iscomeforupdate = false;

        // log("docno : " + successRes.DocNo.toString());
        notifyListeners();
        // callCheckListApi(context, value.DocEntry!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, "${value.message}..!!${value.exception}..!!");
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, "${value.exception}..!!${value.stcode}");
      }
    });
    //
    // if (errorFiles.isNotEmpty) {
    //   showLeadDeatilsDialog(context, errorFiles);
    // }
  }
   callLeadSavePostApi(
      BuildContext context, PostOrder postLead, PatchExCus? patch) async {
    List<String> filename = [];
    List<String>? fileError = [];
    log("savetoserver2222::"+filedata.length.toString());

    if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
         log("savetoserverNames::"+filedata[i].fileName.toString());
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              log("message");
              postLead.attachmenturl1 = value;
            } else if (i == 1) {
              log("message");
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
    log("filename:::${filename.length}");

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

    await QuotesAddApi.getData(ConstantValues.sapUserType, postLead, patch!)
        .then((value) {
      log("ANBUUU stcode " + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        successRes = value;
        QuotesSuccessPageState.getsuccessRes = successRes;
         for(int i=0;i<paymode.length;i++){
        if(paymode[i].Code ==value.orderSavePostheader!.orderMasterdata![0].PaymentTerms){
QuotesSuccessPageState.paymode = paymode[i].ModeName.toString();
log("QuotesSuccessPageState.paymode:::"+QuotesSuccessPageState.paymode.toString());
        }

       } 
        Get.toNamed(ConstantRoutes.successQuotes);

        // log("docno : " + successRes.DocNo.toString());
        notifyListeners();
        // callCheckListApi(context, value.DocEntry!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, "${value.message}..!!${value.exception}..");
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
      }
    });
    //
    // if (errorFiles.isNotEmpty) {
    //   showLeadDeatilsDialog(context, errorFiles);
    // }
  }
  showLeadDeatilsDialog(BuildContext context, String msg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(msg: msg);
        });
  }
static bool isComeFromEnq = false;
  String isSelectedpaymentTermsList = '';
  String isSelectedpaymentTermsCode = '';
  String get getisSelectedpaymentTermsList => isSelectedpaymentTermsList;
  String? PaymentTerms;
   String isSelectedCusTag = '';
  String isSelectedCusTagcode = '';
  String get getisSelectedCusTag => isSelectedCusTag;
  String? CusTag;
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
   getCustomerTag() async {
    customerTagTypeData = [];
    final Database db = (await DBHelper.getInstance())!;
    customerTagTypeData = await DBOperation.getCusTagData(db);
    notifyListeners();
  }

//
  List<CustomerTagTypeData> customerTagTypeData = [];
   selectpaymentTerms(String selected, String refercode, String code) {
    isSelectedpaymentTermsList = selected;
    PaymentTerms = refercode;
    isSelectedpaymentTermsCode = code;
    log("AN11:" + isSelectedpaymentTermsCode.toString());

    // log("AN22:" + EnqRefer.toString());

    // log("AN33:" + isSelectedrefcode.toString());
    notifyListeners();
  }

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