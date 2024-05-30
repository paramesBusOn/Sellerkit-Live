// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/Models/CollectionModel/CollectionModel.dart';
import 'package:sellerkit/Pages/Collection/widgets/AlertdialogBoxFollowUp.dart';
import 'package:sellerkit/Pages/Collection/widgets/warnningDialog.dart';
import 'package:sellerkit/Services/CollectionApi/CollectionCancelApi.dart';
import 'package:sellerkit/Services/CollectionApi/CollectionGetApi.dart';

import '../../../Constant/Configuration.dart';
import '../../Services/customerdetApi/customerdetApi.dart';

class ColletionContoller extends ChangeNotifier {
  Config config = Config();

  get getorderBillRefer => null;
  init() async {
    await clearAllData();
    GetCollectionApi();
    // getdbmodel();
  }
  Future<void> refreshindicator()async{
    await clearAllData();
    GetCollectionApi();
     notifyListeners();
  }

  clearAllData() {
    mycontroller[0].text = '';
    mycontroller[1].text = '';
    calldialog = false;
    canceldialogbool = false;
    detailsDialog = false;

    preogress = false;
    errormsg = '';
    collectionGetList = [];
    filetercollectionGetListOpen = [];
    filetercollectionGetListClose = [];
 collectionGetList = [];
    collectionGetLine = [];
    collectionGetListOpen = [];
    collectionGetListClose = [];
    collectionGetListOpen = [];
    collectionGetListClose = [];
    notifyListeners();
  }

  bool calldialog = false;
  bool canceldialogbool = false;
  bool detailsDialog = false;

  bool preogress = false;
  String? errormsg = '';
  List<CollectionDataIpayMaster> collectionGetList = [];
  List<CollectionDataIpayMaster> filetercollectionGetListOpen = [];
  List<CollectionDataIpayMaster> filetercollectionGetListClose = [];

  List<CollectionDataIpayMaster> collectionGetListOpen = [];
  List<CollectionDataIpayMaster> collectionGetListClose = [];

  splistMaster(List<CollectionDataIpayMaster> collectionGetList) {
    collectionGetListOpen.clear();
    filetercollectionGetListOpen.clear();
    collectionGetListClose.clear();
    filetercollectionGetListClose.clear();
    for (int i = 0; i < collectionGetList.length; i++) {
      if (collectionGetList[i].docstatus == "Open") {
        collectionGetListOpen.add(CollectionDataIpayMaster(
            docentry: collectionGetList[i].docentry,
            docNum: collectionGetList[i].docNum,
            docDate: collectionGetList[i].docDate,
            customerGrooup: collectionGetList[i].customerGrooup,
            customercode: collectionGetList[i].customercode,
            customerName: collectionGetList[i].customerName,
            Mobile: collectionGetList[i].Mobile,
            AssignedTo: collectionGetList[i].AssignedTo,
            StoreCode: collectionGetList[i].StoreCode,
            alternateMobileNo: collectionGetList[i].alternateMobileNo,
            bil_Address1: collectionGetList[i].bil_Address1,
            bil_Address2: collectionGetList[i].bil_Address2,
            bil_Address3: collectionGetList[i].bil_Address3,
            bil_Area: collectionGetList[i].bil_Area,
            bil_City: collectionGetList[i].bil_City,
            bil_Country: collectionGetList[i].bil_Country,
            bil_District: collectionGetList[i].bil_District,
            bil_Pincode: collectionGetList[i].bil_Pincode,
            bil_State: collectionGetList[i].bil_State,
            companyName: collectionGetList[i].companyName,
            contactName: collectionGetList[i].contactName,
            customerEmail: collectionGetList[i].customerEmail,
            gSTNo: collectionGetList[i].gSTNo,
            pAN: collectionGetList[i].pAN,
            docstatus: collectionGetList[i].docstatus,
            visitid: collectionGetList[i].visitid,
            amountpaid: collectionGetList[i].amountpaid,
            cashamt: collectionGetList[i].cashamt,
            chqamt: collectionGetList[i].chqamt,
            chequedate: collectionGetList[i].chequedate,
            chequeref: collectionGetList[i].chequeref,
            chequeimg: collectionGetList[i].chequeimg,
            neftamt: collectionGetList[i].neftamt,
            neftref: collectionGetList[i].neftref,
            cardamt: collectionGetList[i].cardamt,
            cardslipImg: collectionGetList[i].cardslipImg,
            cardref: collectionGetList[i].cardref,
            upiref: collectionGetList[i].upiref,
            upiamt: collectionGetList[i].upiamt,
            onaccount: collectionGetList[i].onaccount));
        filetercollectionGetListOpen = collectionGetListOpen;
      }  if (collectionGetList[i].docstatus == "Closed") {
        collectionGetListClose.add(CollectionDataIpayMaster(
            docentry: collectionGetList[i].docentry,
            docNum: collectionGetList[i].docNum,
            docDate: collectionGetList[i].docDate,
            customerGrooup: collectionGetList[i].customerGrooup,
            customercode: collectionGetList[i].customercode,
            customerName: collectionGetList[i].customerName,
            Mobile: collectionGetList[i].Mobile,
            AssignedTo: collectionGetList[i].AssignedTo,
            StoreCode: collectionGetList[i].StoreCode,
            alternateMobileNo: collectionGetList[i].alternateMobileNo,
            bil_Address1: collectionGetList[i].bil_Address1,
            bil_Address2: collectionGetList[i].bil_Address2,
            bil_Address3: collectionGetList[i].bil_Address3,
            bil_Area: collectionGetList[i].bil_Area,
            bil_City: collectionGetList[i].bil_City,
            bil_Country: collectionGetList[i].bil_Country,
            bil_District: collectionGetList[i].bil_District,
            bil_Pincode: collectionGetList[i].bil_Pincode,
            bil_State: collectionGetList[i].bil_State,
            companyName: collectionGetList[i].companyName,
            contactName: collectionGetList[i].contactName,
            customerEmail: collectionGetList[i].customerEmail,
            gSTNo: collectionGetList[i].gSTNo,
            pAN: collectionGetList[i].pAN,
            docstatus: collectionGetList[i].docstatus,
            visitid: collectionGetList[i].visitid,
            amountpaid: collectionGetList[i].amountpaid,
            cashamt: collectionGetList[i].cashamt,
            chqamt: collectionGetList[i].chqamt,
            chequedate: collectionGetList[i].chequedate,
            chequeref: collectionGetList[i].chequeref,
            chequeimg: collectionGetList[i].chequeimg,
            neftamt: collectionGetList[i].neftamt,
            neftref: collectionGetList[i].neftref,
            cardamt: collectionGetList[i].cardamt,
            cardslipImg: collectionGetList[i].cardslipImg,
            upiamt: collectionGetList[i].upiamt,
            cardref: collectionGetList[i].cardref,
            onaccount: collectionGetList[i].onaccount,
            upiref: collectionGetList[i].upiref));
        filetercollectionGetListClose = collectionGetListClose;
      }
    }
    notifyListeners();
  }

  List<GlobalKey<FormState>> formkey = new List.generate(
      3, (i) => new GlobalKey<FormState>(debugLabel: "NewCollection"));
  List<TextEditingController> mycontroller =
      List.generate(30, (i) => TextEditingController());
  List<CollectionDataIpayDocLine> collectionGetLine = [];
  List<IpayMasterTempList> collectionList = [];
  
String lottie='';
  GetCollectionApi() async {
    preogress = true;

    collectionGetList = [];
    collectionGetLine = [];
    collectionGetListOpen = [];
    collectionGetListClose = [];
    errormsg = '';
     lottie='';

    // getCollectBody? getCollectionApiBodyData = getCollectBody(
    //     listtype: 'listtype',
    //     valuetype: 'valuetype',
    //     fromperiod: 'fromperiod',
    //     toperiod: 'toperiod',
    //     status: 'status',
    //     userid: 'userid');

    await CollectionGetApi.getCollectionData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        collectionGetList = value.datadetail!.ipaymaster!;
        collectionGetLine = value.datadetail!.ipayDocLine!;
        splistMaster(collectionGetList);
        // filetercollectionGetList = collectionGetList;
        if (collectionGetList.isEmpty && collectionGetLine.isEmpty) {
          preogress = false;
          lottie='Assets/no-data.png';
          errormsg = 'No Data..';
        } else {
          // mapCollectionvalue(collectionGetList, collectionGetLine);
        }
        preogress = false;

        print('collectionGetList:' + collectionGetList.length.toString());
        print('collectionGetLine:' + collectionGetLine.length.toString());
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        preogress = false;
         lottie='';
        errormsg = '${value.respDesc} ${value.respCode}';
      } else {
        preogress = false;
          lottie='Assets/NetworkAnimation.json';
        errormsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      }
    });
    notifyListeners();
  }

  customerdetData? frmAddmodeldata;

  callcustCompnyapi() async {
    await customerDetailApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        frmAddmodeldata = value.leadcheckdata;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  showDialogColllection(
      BuildContext context, int j, CollectionDataIpayMaster? masterList,String tabvalue) {
    canceldialogbool = false;
    detailsDialog = false;
    calldialog = true;
    List<CollectionDataIpayDocLine>? lineDetails = [];
    for (int i = 0; i < collectionGetLine.length; i++) {
      if (masterList!.docentry == collectionGetLine[i].docentry) {
        lineDetails.add(CollectionDataIpayDocLine(
            docentry: collectionGetLine[i].docentry,
            linenum: collectionGetLine[i].linenum,
            outsid: collectionGetLine[i].outsid,
            transnum: collectionGetLine[i].transnum,
            transDate: collectionGetLine[i].transDate,
            transDueDate: collectionGetLine[i].transDueDate,
            transtype: collectionGetLine[i].transtype,
            transRef1: collectionGetLine[i].transRef1,
            loanRef: collectionGetLine[i].loanRef,
            collectionType: collectionGetLine[i].collectionType,
            transAmount: collectionGetLine[i].transAmount,
            penaltyAfterDue: collectionGetLine[i].penaltyAfterDue,
            collectionInc: collectionGetLine[i].collectionInc,
            totalAlreadyPaid: collectionGetLine[i].totalAlreadyPaid,
            balanceToPayBef: collectionGetLine[i].balanceToPayBef,
            sumApplied: collectionGetLine[i].sumApplied));
      }
    }
    showDialog(
        context: context,
        builder: (_) {
          return CollectionFollowDialog(
            index: j,
            masterDetails: masterList,
            lineDetails: lineDetails,
            tabvalue: tabvalue,
          );
        }).then((value) {
          
      calldialog = false;
      detailsDialog = false;
      canceldialogbool = false;
      //  Navigator.pop(context);
      refreshindicator();
      notifyListeners();
    });
  }

  cancelApi(BuildContext context, String docentry, String remarks) async {
    // canceldialogbool = true;

    if (formkey[0].currentState!.validate()) {
      canceldialogbool = false;
      detailsDialog = false;
      calldialog = false;
      mycontroller[1].text = '';
      await ColectionCancell.getCollectionData(docentry, remarks).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return warningDialog(
                  heading: 'Response',
                  msg: '${value.respDesc}..!!',
                );
              }).then((value) {
            Navigator.pop(context);
            GetCollectionApi();
            // canceldialogbool = false;
            // detailsDialog = false;
            // calldialog = false;
          });
        } else if (value.stcode! <= 410 && value.stcode! >= 400) {
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return warningDialog(
                  heading: 'Response',
                  msg: '${value.respCode} ${value.respDesc}..!!',
                );
              }).then((value) {
            Navigator.pop(context);

            // canceldialogbool = false;
            // detailsDialog = false;
            // calldialog = false;
          });
        } else {
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return warningDialog(
                  heading: 'Response',
                  msg: '${value.stcode} ${value.respDesc}..!!',
                );
              }).then((value) {
            Navigator.pop(context);
          });
        }
      });
    }

    notifyListeners();
  }

  getPaymentMode(CollectionDataIpayMaster? masterList) {
    // log("masterList!.cardamt!.toStringAsFixed(2)::"+masterList!.cardamt!.toStringAsFixed(2));
    if ( masterList!.cardamt! > 0.00) {
      return 'Card';
    } else if (masterList.cashamt!> 0.00) {
      return 'Cash';
    } else if (masterList.chqamt!> 0.00) {
      return 'Cheque';
    } else if (masterList.neftamt!> 0.00) {
      return 'NEFT';
    } else if (masterList.upiamt! > 0.00) {
      return 'UPI';
    } else {
      return '';
    }
  }

  SearchFilterOpenTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filetercollectionGetListOpen = collectionGetListOpen
          .where((e) =>
              (e).docNum!.toString().toLowerCase().contains(v.toLowerCase()) ||
              (e).docDate!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .customerName
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .bil_Address1
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filetercollectionGetListOpen = collectionGetListOpen;
      notifyListeners();
    }
  }

  SearchFilterCloseTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filetercollectionGetListClose = collectionGetListClose
          .where((e) =>
              (e).docNum!.toString().toLowerCase().contains(v.toLowerCase()) ||
              (e).docDate!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .customerName
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .bil_Address1
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filetercollectionGetListClose = collectionGetListClose;
      notifyListeners();
    }
  }
  // mapCollectionvalue(List<CollectionDataIpayMaster> collectionGetList2,
  //     List<CollectionDataIpayDocLine> collectionGetLine2) {
  //   collectionGetList = [];
  //   for (int j = 0; j < collectionGetList2.length; j++) {
  //     for (int i = 0; i < collectionGetLine2.length; i++) {
  //       if (collectionGetList2[j].docentry == collectionGetLine2[i].docentry) {

  //         collectionGetList.add(CollectionDataIpayMaster(
  //             docentry: collectionGetList2[j].docentry,
  //             docNum: collectionGetList2[j].docNum,
  //             docDate: collectionGetList2[j].docDate,
  //             customerGrooup: collectionGetList2[j].customerGrooup,
  //             customercode: collectionGetList2[j].customercode,
  //             customerName: collectionGetList2[j].customerName,
  //             Mobile: collectionGetList2[j].Mobile,
  //             AssignedTo: collectionGetList2[j].AssignedTo,
  //             StoreCode: collectionGetList2[j].StoreCode,
  //             alternateMobileNo: collectionGetList2[j].alternateMobileNo,
  //             bil_Address1: collectionGetList2[j].bil_Address1,
  //             bil_Address2: collectionGetList2[j].bil_Address2,
  //             bil_Address3: collectionGetList2[j].bil_Address3,
  //             bil_Area: collectionGetList2[j].bil_Area,
  //             bil_City: collectionGetList2[j].bil_City,
  //             bil_Country: collectionGetList2[j].bil_Country,
  //             bil_District: collectionGetList2[j].bil_District,
  //             bil_Pincode: collectionGetList2[j].bil_Pincode,
  //             bil_State: collectionGetList2[j].bil_State,
  //             companyName: collectionGetList2[j].companyName,
  //             contactName: collectionGetList2[j].contactName,
  //             customerEmail: collectionGetList2[j].customerEmail,
  //             gSTNo: collectionGetList2[j].gSTNo,
  //             pAN: collectionGetList2[j].pAN,
  //             docstatus: collectionGetList2[j].docstatus,
  //             visitid: collectionGetList2[j].visitid,
  //             amountpaid: collectionGetList2[j].amountpaid,
  //             cashamt: collectionGetList2[j].cashamt,
  //             chqamt: collectionGetList2[j].chqamt,
  //             chequedate: collectionGetList2[j].chequedate,
  //             chequeref: collectionGetList2[j].chequeref,
  //             chequeimg: collectionGetList2[j].chequeimg,
  //             neftamt: collectionGetList2[j].neftamt,
  //             neftref: collectionGetList2[j].neftref,
  //             cardamt: collectionGetList2[j].cardamt,
  //             cardslipImg: collectionGetList2[j].cardslipImg,
  //             upiamt: collectionGetList2[j].upiamt,
  //             onaccount: collectionGetList2[j].onaccount,));
  //       }
  //     }
  //   }
  // }
}

class IpayMasterTempList {
  int? docentry;
  int? docNum;
  String? docDate;

  String? alternateMobileNo;
  String? contactName;
  String? customerName;
  String? customerGrooup;
  String? customercode;
  String? customerEmail;
  String? companyName;
  String? pAN;
  String? gSTNo;
  String? bil_Address1;
  String? bil_Address2;
  String? bil_Address3;
  String? bil_Area;
  String? bil_City;
  String? bil_District;
  String? bil_State;
  String? bil_Country;
  String? bil_Pincode;
//
  String? StoreCode;
  String? AssignedTo;
  String? Mobile;

  String? docstatus;
  int? visitid;
  double? amountpaid;
  double? cashamt;
  double? chqamt;
  String? chequedate;
  String? chequeref;
  String? chequeimg;
  double? neftamt;
  String? neftref;
  double? cardamt;
  String? cardslipImg;
  double? upiamt;
  int? onaccount;
  List<IpayDocLineTempList>? ipaylinetempList;
//

  IpayMasterTempList({
    //
    required this.docentry,
    required this.docNum,
    required this.docDate,
//
    required this.customerGrooup,
    required this.customercode,
    required this.customerName,
    required this.Mobile,
    required this.AssignedTo,
    required this.StoreCode,
    required this.alternateMobileNo,
    required this.bil_Address1,
    required this.bil_Address2,
    required this.bil_Address3,
    required this.bil_Area,
    required this.bil_City,
    required this.bil_Country,
    required this.bil_District,
    required this.bil_Pincode,
    required this.bil_State,
    required this.companyName,
    required this.contactName,
    required this.customerEmail,
    required this.gSTNo,
    required this.pAN,
    //
    required this.docstatus,
    required this.visitid,
    required this.amountpaid,
    required this.cashamt,
    required this.chqamt,
    required this.chequedate,
    required this.chequeref,
    required this.chequeimg,
    required this.neftamt,
    required this.neftref,
    required this.cardamt,
    required this.cardslipImg,
    required this.upiamt,
    required this.onaccount,
    required this.ipaylinetempList,
  });
}

class IpayDocLineTempList {
  int? docentry;
  int? linenum;
  int? outsid;
  String? transnum;
  String? transDate;
  String? transDueDate;
  String? transtype;
  String? transRef1;
  String? loanRef;
  String? collectionType;
  double? transAmount;
  double? penaltyAfterDue;
  double? collectionInc;

  double? totalAlreadyPaid;
  double? balanceToPayBef;
  double? sumApplied;

  IpayDocLineTempList({
    required this.docentry,
    required this.linenum,
    required this.outsid,
    required this.transnum,
    required this.transDate,
    required this.transDueDate,
    required this.transtype,
    required this.transRef1,
    required this.loanRef,
    required this.collectionType,
    required this.transAmount,
    required this.penaltyAfterDue,
    required this.collectionInc,
    required this.totalAlreadyPaid,
    required this.balanceToPayBef,
    required this.sumApplied,
  });
}
