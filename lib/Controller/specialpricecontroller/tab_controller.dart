import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';
import 'package:sellerkit/Controller/OrderController/ordernew_controller.dart';

import 'package:sellerkit/Controller/specialpricecontroller/newpage_controller.dart';
import 'package:sellerkit/DBModel/itemmasertdb_model.dart';
import 'package:sellerkit/Models/ordergiftModel/ParticularpricelistModel.dart';
import 'package:sellerkit/Models/specialpriceModel/GetAllSPModel.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/newpricereq.dart';
import 'package:sellerkit/Services/SpecialPriceApi/GetAllSPApi.dart';
import 'package:sellerkit/Services/SpecialPriceApi/cancelaApi.dart';
import 'package:sellerkit/Services/SpecialPriceApi/statusupdateApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../DBHelper/db_helper.dart';
import '../../DBHelper/db_operation.dart';

class tabpriceController extends ChangeNotifier {
   bool isapprovedpage = false;
  bool isviewdetail = false;
  bool isloadingstart = false;
  Config config = Config();
  List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());
  List<tabdetails> tabdata = [];
  List<tabdetails> filtertabdata = [];
  ontapapproved() {
    isapprovedpage = !isapprovedpage;

    notifyListeners();
  }
  ontapview() {
    isviewdetail = !isviewdetail;

    notifyListeners();
  }
  
List<ParticularpriceData> Particularprice=[];
getLeveofType() async {
    Particularprice.clear();
   final Database db = (await DBHelper.getInstance())!;
    Particularprice = await DBOperation.getparticularprice(db);
    notifyListeners();
}
  refershAfterClosedialog() async {
    clearbool();
    clearAlldata();
    await callgetAllApi();
    getLeveofType();
    getdataFromDb();
    notifyListeners();
  }

  String forwardSuccessMsg = '';
  clearbool() {
    forwardSuccessMsg = '';
    isviewdetail = false;
    isapprovedpage = false;
    isloadingstart = false;
    notifyListeners();
  }

  modifymethod(GetAllSPData getalldata) {
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

  cancelmethod(String id) {
    SpcanceldialogApi.getData(id).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        forwardSuccessMsg = 'Successfully Special Price Request Cancelled..!!';
        isloadingstart = false;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        forwardSuccessMsg = "${value.message}..!!${value.exception}";
        isloadingstart = false;
        notifyListeners();
      } else if (value.stcode! == 500) {
        forwardSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        isloadingstart = false;
        notifyListeners();
      }
    });
  }

  statusupdate(String docentry, String status) async {
    forwardSuccessMsg = '';
    isloadingstart = true;
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
        forwardSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        isloadingstart = false;
        notifyListeners();
      }
    });
  }

  Future<void> swipeRefreshIndiactor() async {
    await clearAlldata();
    // adddata();
    await callgetAllApi();
     getLeveofType();
    getdataFromDb();
    notifyListeners();
  }

  init() {
    clearAlldata();
    // adddata();
    getdataFromDb();
   // getdataFromDb();
    callgetAllApi();
     getLeveofType();
  }

  List<ItemMasterDBModel> allProductDetails = [];
  List<ItemMasterDBModel> filterProductDetails = [];
  getdataFromDb() async {
    final Database db = (await DBHelper.getInstance())!;
    allProductDetails = await DBOperation.getAllProducts(db);
     await mapvaluesdb(allProductDetails);
    filterProductDetails = filterProductDetails;

    notifyListeners();
  }
 mapvaluesdb(List<ItemMasterDBModel> allProductDetails)async{
    for(int i=allProductDetails.length-1;i>=0;i--){
      if(allProductDetails[i].Isbundle ==true){
        log("allProductDetailsbundle::"+allProductDetails[i].itemCode.toString());
        allProductDetails.removeAt(i);
      }
    }
notifyListeners();
  }
  bool datagotByApi = true;
  List<GetAllSPData> GetAllData = [];
  List<GetAllSPData> openSPdata = [];
  List<GetAllSPData> ApprovedSpdata = [];
  List<GetAllSPData> RejectSpdata = [];
  List<GetAllSPData> filteropenSPdata = [];
  List<GetAllSPData> filterApprovedSpdata = [];
  List<GetAllSPData> filterRejectSpdata = [];
  String? leadCheckDataExcep = '';
  String lottie = '';
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
  callitemdetails(String openSPdata,BuildContext context) {
    bool istrue = false;
    int? index;
    istrue = false;
    index = null;
    for (int i = 0; i < allProductDetails.length; i++) {
      if (allProductDetails[i].itemCode == openSPdata) {
        istrue = true;
        index = i;
        break;
      }
    }
    if (istrue == true) {
      showBottomSheetInsert2(context, index!);
       notifyListeners();
    }else{
      showtoastforscanning();
      notifyListeners();
    }
  }
Widget createTableparticular(ThemeData theme, int ij,BuildContext context) {
 
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
 Particularprice.length > 0 &&   Particularprice[0] !=null?   Container(
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
                                :
          "${Particularprice[0].PriceList}",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ):Container(),
 Particularprice.length > 1 &&   Particularprice[1] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  Particularprice.length > 2 &&  Particularprice[2] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
   Particularprice.length > 3 &&  Particularprice[3] !=null?  Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  Particularprice.length > 4 &&  Particularprice[4] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
  Particularprice.length > 0 &&  Particularprice[0].PriceList !=null?
     Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(Particularprice[0].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[0].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 1 &&  Particularprice[1].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
         Particularprice[1].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[1].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 2 &&  Particularprice[2].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[2].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[2].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 3 &&   Particularprice[3].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[3].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[3].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
   Particularprice.length > 4 &&   Particularprice[4].PriceList !=null? Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[4].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[4].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
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


  Widget createTableparticular2(ThemeData theme, int ij,BuildContext context) {
 
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
 Particularprice.length > 5 &&   Particularprice[5] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ):Container(),
 Particularprice.length > 6 &&   Particularprice[6] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  Particularprice.length > 7 &&  Particularprice[7] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
   Particularprice.length > 8 &&  Particularprice[8] !=null?  Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  Particularprice.length > 9 &&  Particularprice[9] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
  Particularprice.length > 5 &&  Particularprice[5].PriceList !=null?
     Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(Particularprice[5].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[5].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 6 &&  Particularprice[6].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
         Particularprice[6].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[6].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 7 &&  Particularprice[7].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[7].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[7].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 8 &&   Particularprice[8].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[8].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[8].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
   Particularprice.length > 9 &&   Particularprice[9].PriceList !=null? Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[9].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[9].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
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

  Widget createTableparticular3(ThemeData theme, int ij,BuildContext context) {
 
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
 Particularprice.length > 10 &&   Particularprice[10] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ):Container(),
 Particularprice.length > 11 &&   Particularprice[11] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  Particularprice.length > 12 &&  Particularprice[12] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
   Particularprice.length > 13 &&  Particularprice[13] !=null?  Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  Particularprice.length > 14 &&  Particularprice[14] !=null?   Container(
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
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
  Particularprice.length > 10 &&  Particularprice[10].PriceList !=null?
     Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(Particularprice[10].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[10].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 11 &&  Particularprice[11].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
         Particularprice[11].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[11].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 12 &&  Particularprice[12].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[12].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[12].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  Particularprice.length > 13 &&   Particularprice[13].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[13].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[13].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
   Particularprice.length > 14 &&   Particularprice[14].PriceList !=null? Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          Particularprice[14].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(allProductDetails[ij].mgrPrice.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(allProductDetails[ij].sp.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(allProductDetails[ij].ssp1.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(allProductDetails[ij].ssp2.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(allProductDetails[ij].ssp3.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(allProductDetails[ij].ssp4.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(allProductDetails[ij].ssp5.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp1Inc.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp2Inc.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp3Inc.toString()):
        Particularprice[14].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(allProductDetails[ij].ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
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
    // selectedItemName = allProductDetails[i].itemName.toString();
    // selectedItemCode = allProductDetails[i].itemCode.toString();
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
                    ConstantValues.showallslab!.toLowerCase() !='y'?Container():      createTable4(theme, i),
                    
                      if(ConstantValues.showallslab!.toLowerCase() =='y')...[
  Container()
]

else ...[
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
                      SizedBox(
                        height: 5,
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      //  SizedBox(
                      //       width: 15,
                      //     ),
                   ConstantValues.showallslab!.toLowerCase() !='y'?Container():     createTable(theme, i),
                    ConstantValues.showallslab!.toLowerCase() !='y'?Container():    SizedBox(
                        height: 5,
                      ),
                  ConstantValues.showallslab!.toLowerCase() !='y'?Container():      createTable2(theme, i),
                 ConstantValues.showallslab!.toLowerCase() !='y'?Container():       SizedBox(
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
                     ConstantValues.showallslab!.toLowerCase() !='y'?Container():   SizedBox(
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
          "SP",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
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
   ConstantValues.showallslab!.toLowerCase() !='y'?Container():     Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Cost",
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
          config.slpitCurrency22(allProductDetails[ij].sp.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyMedium?.copyWith(
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
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    ConstantValues.showallslab!.toLowerCase() !='y'?Container():    Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(allProductDetails[ij].slpPrice.toString()),
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

  callgetAllApi() async {
    datagotByApi = false;
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
        if (value.SPdatageader != null &&
            value.SPdatageader!.SPcheckdata!.isNotEmpty) {
          log("not null");
          // GetAllData=value.SPdatageader!.SPcheckdata!;
          // tableinsert(GetAllData);
          mapvalues(value.SPdatageader!.SPcheckdata!);
        } else if (value.SPdatageader == null ||
            value.SPdatageader!.SPcheckdata!.isEmpty) {
          log("Order data null");
          datagotByApi = true;
          lottie = 'Assets/no-data.png';
          leadCheckDataExcep = 'No Data..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        datagotByApi = true;
        lottie = '';
        leadCheckDataExcep = '${value.message}..!!${value.exception}....!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        if (value.exception!.contains("Network is unreachable")) {
          datagotByApi = true;
          lottie = 'Assets/network-signal.png';
          leadCheckDataExcep =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          notifyListeners();
        } else {
          datagotByApi = true;
          lottie = 'Assets/warning.png';
          leadCheckDataExcep =
              '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';

          notifyListeners();
        }
        // datagotByApi=true;
        //  lottie='Assets/NetworkAnimation.json';
        // leadCheckDataExcep = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
  }
covertToorder(GetAllSPData getAlldata){
 OrderNewController. datafromsp.clear();
 OrderNewController. datafromsp.add(getAlldata.DocEntry.toString());
 OrderNewController. datafromsp.add(getAlldata.CustomerCode.toString());
 OrderNewController. datafromsp.add(getAlldata.CustomerName.toString());
 OrderNewController. datafromsp.add(getAlldata.ItemCode.toString());
 OrderNewController. datafromsp.add(getAlldata.ItemName.toString());
 OrderNewController. datafromsp.add(getAlldata.Quantity.toString());
 OrderNewController. datafromsp.add(getAlldata.RP.toString());
 OrderNewController. datafromsp.add(getAlldata.CouponCode.toString());
  OrderBookNewState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.ordernew);
    notifyListeners();
}
  mapvalues(List<GetAllSPData> getAlldata) {
    for (int i = 0; i < getAlldata.length; i++) {
      if (getAlldata[i].Status!.toLowerCase().toString() == "open") {
        openSPdata.add(GetAllSPData(
            UserType: getAlldata[i].UserType,
            AP: getAlldata[i].AP,
            ApprovedBy: getAlldata[i].ApprovedBy,
            ApprovedOn: getAlldata[i].ApprovedOn,
            AssignedTo: getAlldata[i].AssignedTo,
            Cost: getAlldata[i].Cost,
            CouponCode: getAlldata[i].CouponCode,
            CreatedBy: getAlldata[i].CreatedBy,
            CreatedOn: getAlldata[i].CreatedOn,
            CustomerCode: getAlldata[i].CustomerCode,
            CustomerMobile: getAlldata[i].CustomerMobile,
            CustomerName: getAlldata[i].CustomerName,
            DocEntry: getAlldata[i].DocEntry,
            FromDate: getAlldata[i].FromDate,
            ItemCode: getAlldata[i].ItemCode,
            ItemName: getAlldata[i].ItemName,
            MRP: getAlldata[i].MRP,
            Quantity: getAlldata[i].Quantity,
            RP: getAlldata[i].RP,
            RequestDate: getAlldata[i].RequestDate,
            SP: getAlldata[i].SP,
            SSP1: getAlldata[i].SSP1,
            SSP2: getAlldata[i].SSP2,
            SSP3: getAlldata[i].SSP3,
            SSP4: getAlldata[i].SSP4,
            SSP5: getAlldata[i].SSP5,
            Status: getAlldata[i].Status,
            StoreCode: getAlldata[i].StoreCode,
            ToDate: getAlldata[i].ToDate,
            UpdatedBy: getAlldata[i].UpdatedBy,
            UpdatedOn: getAlldata[i].UpdatedOn,
            UtilisedOn: getAlldata[i].UtilisedOn,
            UtilisedOrderEntry: getAlldata[i].UtilisedOrderEntry,
            traceid: getAlldata[i].traceid));
            openSPdata.sort((a, b) => b.RequestDate!.compareTo(a.RequestDate!));
        filteropenSPdata = openSPdata;
      } else if (getAlldata[i].Status!.toLowerCase().toString() == "approved") {
        ApprovedSpdata.add(GetAllSPData(
            UserType: getAlldata[i].UserType,
            AP: getAlldata[i].AP,
            ApprovedBy: getAlldata[i].ApprovedBy,
            ApprovedOn: getAlldata[i].ApprovedOn,
            AssignedTo: getAlldata[i].AssignedTo,
            Cost: getAlldata[i].Cost,
            CouponCode: getAlldata[i].CouponCode,
            CreatedBy: getAlldata[i].CreatedBy,
            CreatedOn: getAlldata[i].CreatedOn,
            CustomerCode: getAlldata[i].CustomerCode,
            CustomerMobile: getAlldata[i].CustomerMobile,
            CustomerName: getAlldata[i].CustomerName,
            DocEntry: getAlldata[i].DocEntry,
            FromDate: getAlldata[i].FromDate,
            ItemCode: getAlldata[i].ItemCode,
            ItemName: getAlldata[i].ItemName,
            MRP: getAlldata[i].MRP,
            Quantity: getAlldata[i].Quantity,
            RP: getAlldata[i].RP,
            RequestDate: getAlldata[i].RequestDate,
            SP: getAlldata[i].SP,
            SSP1: getAlldata[i].SSP1,
            SSP2: getAlldata[i].SSP2,
            SSP3: getAlldata[i].SSP3,
            SSP4: getAlldata[i].SSP4,
            SSP5: getAlldata[i].SSP5,
            Status: getAlldata[i].Status,
            StoreCode: getAlldata[i].StoreCode,
            ToDate: getAlldata[i].ToDate,
            UpdatedBy: getAlldata[i].UpdatedBy,
            UpdatedOn: getAlldata[i].UpdatedOn,
            UtilisedOn: getAlldata[i].UtilisedOn,
            UtilisedOrderEntry: getAlldata[i].UtilisedOrderEntry,
            traceid: getAlldata[i].traceid));
             ApprovedSpdata.sort((a, b) => b.RequestDate!.compareTo(a.RequestDate!));
        filterApprovedSpdata = ApprovedSpdata;
      } else {
        RejectSpdata.add(GetAllSPData(
            UserType: getAlldata[i].UserType,
            AP: getAlldata[i].AP,
            ApprovedBy: getAlldata[i].ApprovedBy,
            ApprovedOn: getAlldata[i].ApprovedOn,
            AssignedTo: getAlldata[i].AssignedTo,
            Cost: getAlldata[i].Cost,
            CouponCode: getAlldata[i].CouponCode,
            CreatedBy: getAlldata[i].CreatedBy,
            CreatedOn: getAlldata[i].CreatedOn,
            CustomerCode: getAlldata[i].CustomerCode,
            CustomerMobile: getAlldata[i].CustomerMobile,
            CustomerName: getAlldata[i].CustomerName,
            DocEntry: getAlldata[i].DocEntry,
            FromDate: getAlldata[i].FromDate,
            ItemCode: getAlldata[i].ItemCode,
            ItemName: getAlldata[i].ItemName,
            MRP: getAlldata[i].MRP,
            Quantity: getAlldata[i].Quantity,
            RP: getAlldata[i].RP,
            RequestDate: getAlldata[i].RequestDate,
            SP: getAlldata[i].SP,
            SSP1: getAlldata[i].SSP1,
            SSP2: getAlldata[i].SSP2,
            SSP3: getAlldata[i].SSP3,
            SSP4: getAlldata[i].SSP4,
            SSP5: getAlldata[i].SSP5,
            Status: getAlldata[i].Status,
            StoreCode: getAlldata[i].StoreCode,
            ToDate: getAlldata[i].ToDate,
            UpdatedBy: getAlldata[i].UpdatedBy,
            UpdatedOn: getAlldata[i].UpdatedOn,
            UtilisedOn: getAlldata[i].UtilisedOn,
            UtilisedOrderEntry: getAlldata[i].UtilisedOrderEntry,
            traceid: getAlldata[i].traceid));
            RejectSpdata.sort((a, b) => b.RequestDate!.compareTo(a.RequestDate!));
        filterRejectSpdata = RejectSpdata;
      }
    }
    notifyListeners();
    datagotByApi = true;
    notifyListeners();
  }

  Discountcalculation(double? amount2, double? SP) {
    log("SP:::" + SP.toString());
    final amount = SP! - amount2!;
    log("amount:::" + amount.toString());
    final Discount = (amount / SP) * 100;

    log("vDiscount:::" + Discount.toString());
    return Discount.toStringAsFixed(2);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  setListData() {
    filteropenSPdata = openSPdata;
    filterApprovedSpdata = ApprovedSpdata;
    filterRejectSpdata = RejectSpdata;
    notifyListeners();
  }

  SearchFilterOpenTab(String v) {
    if (v.isNotEmpty) {
      filteropenSPdata = openSPdata
          .where((e) =>
              (e).CustomerCode!.toLowerCase().contains(v.toLowerCase()) ||
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteropenSPdata = openSPdata;
      notifyListeners();
    }
  }

  SearchFilterWonTab(String v) {
    if (v.isNotEmpty) {
      filterApprovedSpdata = ApprovedSpdata.where((e) =>
          (e).CustomerCode!.toLowerCase().contains(v.toLowerCase()) ||
          (e).CustomerName!.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterApprovedSpdata = ApprovedSpdata;
      notifyListeners();
    }
  }

  SearchFilterLostTab(String v) {
    if (v.isNotEmpty) {
      filterRejectSpdata = RejectSpdata.where((e) =>
          (e).CustomerCode!.toLowerCase().contains(v.toLowerCase()) ||
          (e).CustomerName!.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterRejectSpdata = RejectSpdata;
      notifyListeners();
    }
  }

  clearAlldata() {
    allProductDetails.clear();
    Particularprice.clear();
    filterProductDetails.clear();
    forwardSuccessMsg = '';
    isloadingstart = false;
    lottie = '';
    leadCheckDataExcep = '';
    tabdata.clear();
    isviewdetail = false;
    isapprovedpage = false;
    mycontroller[5].text = '';
    filtertabdata.clear();
    GetAllData.clear();
    openSPdata.clear();
    ApprovedSpdata.clear();
    RejectSpdata.clear();
    filteropenSPdata.clear();
    filterApprovedSpdata.clear();
    filterRejectSpdata.clear();
    datagotByApi = true;
    notifyListeners();
  }
}

class tabdetails {
  String? username;
  String? storecode;
  String? cusname;
  String? spprice;
  String? mobile;
  String? reqprice;
  String? product;
  String? price;

  String? date;
  tabdetails(
      {required this.username,
      required this.storecode,
      required this.cusname,
      required this.spprice,
      required this.mobile,
      required this.reqprice,
      required this.product,
      required this.price,
      required this.date});
}
