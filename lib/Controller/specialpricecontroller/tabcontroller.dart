
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/specialpricecontroller/newpagecontroller.dart';
import 'package:sellerkit/Models/specialpriceModel/GetAllSPModel.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/newpricereq.dart';
import 'package:sellerkit/Services/SpecialPriceApi/GetAllSPApi.dart';
import 'package:sellerkit/Services/SpecialPriceApi/cancelaApi.dart';
import 'package:sellerkit/Services/SpecialPriceApi/statusupdateApi.dart';
import 'package:url_launcher/url_launcher.dart';

class tabpriceController extends ChangeNotifier{
bool isviewdetail=false;
bool isloadingstart=false;
Config config=Config();
List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());
List<tabdetails> tabdata=[];
List<tabdetails> filtertabdata=[];
ontapview(){
isviewdetail= !isviewdetail;

notifyListeners();
}
refershAfterClosedialog()async{
  
  clearbool();
  clearAlldata();
 await callgetAllApi();
  notifyListeners();
}

  String forwardSuccessMsg = '';
clearbool(){
 forwardSuccessMsg = '';
isviewdetail=false;
isloadingstart=false;
notifyListeners(); 
}
modifymethod(GetAllSPData getalldata){
  NewpriceController.modify.clear();
NewpriceController.modify.add(getalldata.AP.toString());
NewpriceController.modify.add(getalldata.CustomerCode.toString());

NewpriceController.modify.add(getalldata.CustomerMobile.toString());
NewpriceController.modify.add(getalldata.CustomerName.toString());
NewpriceController.modify.add(getalldata.ItemCode.toString());
NewpriceController.modify.add(getalldata.ItemName.toString());
NewpriceController.modify.add(getalldata.Quantity.toString());
NewpriceController.modify.add(getalldata.RP.toString());
NewpriceController.modify.add(getalldata.SP.toString());
NewpriceController.modify.add(getalldata.DocEntry.toString());
NewpriceReqState.iscomfromLead = true;
Get.toNamed(ConstantRoutes.newpriceReq);
          notifyListeners();
}
cancelmethod(String id){
  SpcanceldialogApi.getData(id).then((value){
   if (value.stcode! >= 200 && value.stcode! <= 210) {
          forwardSuccessMsg = 'Successfully Special Price Request Cancelled..!!';
          isloadingstart = false;
          notifyListeners();
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          forwardSuccessMsg = "${value.message}..!!${value.exception}";
          isloadingstart = false;
          notifyListeners();
        } else if (value.stcode! == 500) {
          forwardSuccessMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          isloadingstart = false;
          notifyListeners();
        } 
  });
}

statusupdate(String docentry,String status)async{
  forwardSuccessMsg='';
 isloadingstart=true;
 notifyListeners();
 SPupdateApi.getData(docentry, status).then((value) {
   if (value.stcode! >= 200 && value.stcode! <= 210) {
          forwardSuccessMsg = 'Successfully Updated..!!';
          isloadingstart = false;
          notifyListeners();
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          forwardSuccessMsg = "${value.message}..!!${value.exception}";
          isloadingstart = false;
          notifyListeners();
        } else if (value.stcode! == 500) {
          forwardSuccessMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          isloadingstart = false;
          notifyListeners();
        }
 });

}
 Future<void>  swipeRefreshIndiactor()async{
  await clearAlldata();
  // adddata();
 await callgetAllApi();
  notifyListeners();
}
init(){
  clearAlldata();
  // adddata();
  callgetAllApi();
}
bool datagotByApi=true;
List<GetAllSPData> GetAllData=[];
List<GetAllSPData> openSPdata=[];
List<GetAllSPData> ApprovedSpdata=[];
List<GetAllSPData> RejectSpdata=[];
List<GetAllSPData> filteropenSPdata=[];
List<GetAllSPData> filterApprovedSpdata=[];
List<GetAllSPData> filterRejectSpdata=[];
String? leadCheckDataExcep='';
String lottie='';
callgetAllApi()async{
  datagotByApi=false;
  notifyListeners();
  GetAllData.clear();
  openSPdata.clear();
  ApprovedSpdata.clear();
  RejectSpdata.clear();
  filteropenSPdata.clear();
  filterApprovedSpdata.clear();
  filterRejectSpdata.clear();
 await GetAllSPApi.getData().then((value) {
 if (value.stcode! >= 200 && value.stcode! <= 210) {
        

        if (value.SPdatageader != null && value.SPdatageader!.SPcheckdata!.isNotEmpty) {
          log("not null");
  // GetAllData=value.SPdatageader!.SPcheckdata!;
          // tableinsert(GetAllData);
mapvalues(value.SPdatageader!.SPcheckdata!);
          
        } else if (value.SPdatageader == null||value.SPdatageader!.SPcheckdata!.isEmpty) {
          log("Order data null");
          datagotByApi=true;
          lottie='Assets/no-data.png';
          leadCheckDataExcep = 'No Data..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        datagotByApi=true;
         lottie='';
        leadCheckDataExcep = '${value.message}..!!${value.exception}....!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        datagotByApi=true;
         lottie='Assets/NetworkAnimation.json';
        leadCheckDataExcep = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
     notifyListeners();
      }
  });
}

mapvalues(List<GetAllSPData> getAlldata){
  for(int i=0;i<getAlldata.length;i++){
    if(getAlldata[i].Status!.toLowerCase().toString() =="open"){
      openSPdata.add(
        GetAllSPData(
          UserType:getAlldata[i].UserType ,
          AP: getAlldata[i].AP, 
          ApprovedBy: getAlldata[i].ApprovedBy, 
          ApprovedOn: getAlldata[i].ApprovedOn, 
          AssignedTo:getAlldata[i]. AssignedTo, 
          Cost:getAlldata[i]. Cost, 
          CouponCode: getAlldata[i].CouponCode, 
          CreatedBy:getAlldata[i]. CreatedBy, 
          CreatedOn: getAlldata[i].CreatedOn, 
          CustomerCode: getAlldata[i].CustomerCode, 
          CustomerMobile:getAlldata[i]. CustomerMobile, 
          CustomerName:getAlldata[i]. CustomerName, 
          DocEntry:getAlldata[i]. DocEntry, 
          FromDate:getAlldata[i]. FromDate, 
          ItemCode:getAlldata[i]. ItemCode, 
          ItemName:getAlldata[i]. ItemName, 
          MRP:getAlldata[i]. MRP, 
          Quantity:getAlldata[i]. Quantity, 
          RP:getAlldata[i]. RP, 
          RequestDate:getAlldata[i]. RequestDate, 
          SP:getAlldata[i]. SP, 
          SSP1:getAlldata[i]. SSP1, 
          SSP2:getAlldata[i]. SSP2, 
          SSP3:getAlldata[i]. SSP3, 
          SSP4:getAlldata[i]. SSP4, 
          SSP5:getAlldata[i]. SSP5, 
          Status: getAlldata[i].Status, 
          StoreCode:getAlldata[i]. StoreCode, 
          ToDate:getAlldata[i]. ToDate, 
          UpdatedBy:getAlldata[i]. UpdatedBy, 
          UpdatedOn:getAlldata[i]. UpdatedOn, 
          UtilisedOn:getAlldata[i]. UtilisedOn, 
          UtilisedOrderEntry:getAlldata[i]. UtilisedOrderEntry, 
          traceid:getAlldata[i]. traceid
          ));
          filteropenSPdata=openSPdata;
    }
    else if(getAlldata[i].Status!.toLowerCase().toString() =="approved"){
        ApprovedSpdata.add(
        GetAllSPData(
          UserType:getAlldata[i].UserType ,
          AP: getAlldata[i].AP, 
          ApprovedBy: getAlldata[i].ApprovedBy, 
          ApprovedOn: getAlldata[i].ApprovedOn, 
          AssignedTo:getAlldata[i]. AssignedTo, 
          Cost:getAlldata[i]. Cost, 
          CouponCode: getAlldata[i].CouponCode, 
          CreatedBy:getAlldata[i]. CreatedBy, 
          CreatedOn: getAlldata[i].CreatedOn, 
          CustomerCode: getAlldata[i].CustomerCode, 
          CustomerMobile:getAlldata[i]. CustomerMobile, 
          CustomerName:getAlldata[i]. CustomerName, 
          DocEntry:getAlldata[i]. DocEntry, 
          FromDate:getAlldata[i]. FromDate, 
          ItemCode:getAlldata[i]. ItemCode, 
          ItemName:getAlldata[i]. ItemName, 
          MRP:getAlldata[i]. MRP, 
          Quantity:getAlldata[i]. Quantity, 
          RP:getAlldata[i]. RP, 
          RequestDate:getAlldata[i]. RequestDate, 
          SP:getAlldata[i]. SP, 
          SSP1:getAlldata[i]. SSP1, 
          SSP2:getAlldata[i]. SSP2, 
          SSP3:getAlldata[i]. SSP3, 
          SSP4:getAlldata[i]. SSP4, 
          SSP5:getAlldata[i]. SSP5, 
          Status: getAlldata[i].Status, 
          StoreCode:getAlldata[i]. StoreCode, 
          ToDate:getAlldata[i]. ToDate, 
          UpdatedBy:getAlldata[i]. UpdatedBy, 
          UpdatedOn:getAlldata[i]. UpdatedOn, 
          UtilisedOn:getAlldata[i]. UtilisedOn, 
          UtilisedOrderEntry:getAlldata[i]. UtilisedOrderEntry, 
          traceid:getAlldata[i]. traceid
          ));
          filterApprovedSpdata=ApprovedSpdata;
    }else{
       RejectSpdata.add(
        GetAllSPData(
          UserType:getAlldata[i].UserType ,
          AP: getAlldata[i].AP, 
          ApprovedBy: getAlldata[i].ApprovedBy, 
          ApprovedOn: getAlldata[i].ApprovedOn, 
          AssignedTo:getAlldata[i]. AssignedTo, 
          Cost:getAlldata[i]. Cost, 
          CouponCode: getAlldata[i].CouponCode, 
          CreatedBy:getAlldata[i]. CreatedBy, 
          CreatedOn: getAlldata[i].CreatedOn, 
          CustomerCode: getAlldata[i].CustomerCode, 
          CustomerMobile:getAlldata[i]. CustomerMobile, 
          CustomerName:getAlldata[i]. CustomerName, 
          DocEntry:getAlldata[i]. DocEntry, 
          FromDate:getAlldata[i]. FromDate, 
          ItemCode:getAlldata[i]. ItemCode, 
          ItemName:getAlldata[i]. ItemName, 
          MRP:getAlldata[i]. MRP, 
          Quantity:getAlldata[i]. Quantity, 
          RP:getAlldata[i]. RP, 
          RequestDate:getAlldata[i]. RequestDate, 
          SP:getAlldata[i]. SP, 
          SSP1:getAlldata[i]. SSP1, 
          SSP2:getAlldata[i]. SSP2, 
          SSP3:getAlldata[i]. SSP3, 
          SSP4:getAlldata[i]. SSP4, 
          SSP5:getAlldata[i]. SSP5, 
          Status: getAlldata[i].Status, 
          StoreCode:getAlldata[i]. StoreCode, 
          ToDate:getAlldata[i]. ToDate, 
          UpdatedBy:getAlldata[i]. UpdatedBy, 
          UpdatedOn:getAlldata[i]. UpdatedOn, 
          UtilisedOn:getAlldata[i]. UtilisedOn, 
          UtilisedOrderEntry:getAlldata[i]. UtilisedOrderEntry, 
          traceid:getAlldata[i]. traceid
          ));
          filterRejectSpdata=RejectSpdata;
    }
  }
  notifyListeners();
  datagotByApi=true;
  notifyListeners();
}

Discountcalculation(double? amount2,double? SP){
  
  log("SP:::"+SP.toString());
final  amount =SP! - amount2!;
log("amount:::"+amount.toString());
final Discount= (amount/SP)*100;

log("vDiscount:::"+Discount.toString());
return Discount.toStringAsFixed(2);

}
 Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
setListData(){
  filteropenSPdata = openSPdata;
  filterApprovedSpdata = ApprovedSpdata;
   filterRejectSpdata = RejectSpdata;
 notifyListeners();
}
SearchFilterOpenTab(String v){
  if (v.isNotEmpty) {
      filteropenSPdata = openSPdata
          .where((e) =>
              (e).CustomerCode!.toLowerCase().contains(v.toLowerCase()) ||
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteropenSPdata = openSPdata;
      notifyListeners();
    }

}SearchFilterWonTab(String v){
  if (v.isNotEmpty) {
      filterApprovedSpdata = ApprovedSpdata
          .where((e) =>
              (e).CustomerCode!.toLowerCase().contains(v.toLowerCase()) ||
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterApprovedSpdata = ApprovedSpdata;
      notifyListeners();
    }

}SearchFilterLostTab(String v){
  if (v.isNotEmpty) {
      filterRejectSpdata = RejectSpdata
          .where((e) =>
              (e).CustomerCode!.toLowerCase().contains(v.toLowerCase()) ||
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterRejectSpdata = RejectSpdata;
      notifyListeners();
    }

}
  clearAlldata(){
    forwardSuccessMsg = '';
    isloadingstart=false;
    lottie='';
    leadCheckDataExcep='';
    tabdata.clear();
isviewdetail=false;
mycontroller[5].text='';
filtertabdata.clear();
GetAllData.clear();
  openSPdata.clear();
  ApprovedSpdata.clear();
  RejectSpdata.clear();
  filteropenSPdata.clear();
  filterApprovedSpdata.clear();
  filterRejectSpdata.clear();
  datagotByApi=true;
notifyListeners();
  }

}

class tabdetails{
  String? username;
  String? storecode;
  String? cusname;
  String? spprice;
  String? mobile;
  String? reqprice;
  String? product;
  String? price;
  
  String? date;
  tabdetails({
    required this.username,
    required this.storecode,
    required this.cusname,
    required this.spprice,
    required this.mobile,
    required this.reqprice,
    required this.product,
    required this.price,
    required this.date

  });

}