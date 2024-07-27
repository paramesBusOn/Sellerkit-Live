import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/DBModel/outstandingDBmodel.dart';
import 'package:sellerkit/DBModel/outstandinglinechild.dart';
import 'package:sellerkit/Models/OutStandingModel/outstandingmodel.dart';
import 'package:sellerkit/Services/OutstandingApi/outstandingApi.dart';
import 'package:sqflite/sqflite.dart';

import '../../Services/customerdetApi/customerdetApi.dart';

class Outstandingcontroller extends ChangeNotifier {
  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  List<OutPDFLines> outStndPDFDetList = [];
  static List<String> datafromAcc = [];
  customerdetData? frmAddmodeldata;
  outstandingLine? tocustomerDet;
  firstPageNextBtn() {
    int passed = 0;
    log("pageChanged: ${pageChanged}");
    if (passed == 0) {
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
    }
  }

  CancelfilterBtn() {
    int passed = 1;
    log("pageChanged: ${pageChanged}");
    if (passed == 1) {
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
    }
  }

  String? assignvalue;
  selectassign(String val) {
    assignvalue = val;
    notifyListeners();
  }

  clearfilterval() {
    iscusname = false;
    isassignto = false;
    assignvalue = null;
    cusnamevalue = null;
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[2].clear();
    selectedassignto.clear();
    mycontroller[3].clear();

    notifyListeners();
  }

  String? cusnamevalue;
  itemselectCusname(String itemvalue, bool isselected) {
    cusnamevalue = '';
    if (isselected) {
      selectedcusname.add(itemvalue);
    } else {
      selectedcusname.remove(itemvalue);
    }
    cusnamevalue = selectedcusname.join(', ');
    log("selectedcusname::" + selectedcusname.toString());
    log("cusnamevalue::" + cusnamevalue.toString());
    notifyListeners();
  }

  ontapcusname() {
    iscusname = !iscusname;
    notifyListeners();
  }
  // String? cusnamevalue;
  // selectcusname(String val) {
  //   cusnamevalue = val;
  //   notifyListeners();
  // }

  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    // if (currentBackPressTime == null ||
    //     now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
    //   currentBackPressTime = now;

    if (pageChanged == 1) {
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else if (pageChanged == 0) {
      return Future.value(true);
    }
    //  }
    return Future.value(false);
  }

  List<outstandingData> outstanddata = [];
  List<ontapKpi> ontapKpi2 = [];
  List<outstandingLine> outstandline = [];
  List<outstandingDBModel> valueDBmodel = [];
  List<outstandinglineDBModel> valueDBmodelchild = [];
  List<String> items = ['Anbu', 'Arun', 'vel'];
  bool apiloading = false;
  String errormsg = '';
  comefromAcc() async {
    await GetAllOutstandingscall();
    if (datafromAcc.length > 0) {
      cusnamevalue = datafromAcc[1];

      onfilterapply();
      datafromAcc.clear();
      notifyListeners();
    }
  }

  String lottie = '';
  GetAllOutstandingscall() async {
    valueDBmodel.clear();
    outstanddata.clear();
    outstandline.clear();
    valueDBmodelchild.clear();
    apiloading = true;
    lottie = '';
    // outsatandingmodel outsatandingModel = await GetoutstandingApi.getData();
    await GetoutstandingApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.outstandhead!.outstanddata != null &&
            value.outstandhead!.outstanddata!.isNotEmpty &&
            value.outstandhead!.outstandline != null &&
            value.outstandhead!.outstandline!.isNotEmpty) {
          apiloading = false;
          notifyListeners();
          outstanddata = value.outstandhead!.outstanddata!;
          outstandline = value.outstandhead!.outstandline!;
          log("outstanddata." + outstanddata.length.toString());
          log("outstandline::" + outstandline.length.toString());
          await tableinsert();
          // for (int i = 0;
          //     i < outsatandingModel.outstandhead!.outstanddata!.length;
          //     i++) {

          //   // outstanddata.add(outstandingData(
          //   //   alternateMobileNo:
          //   //       outsatandingModel.outstandhead!.outstanddata![i].alternateMobileNo,
          //   //   amountPaid: outsatandingModel.outstandhead!.outstanddata![i].amountPaid,
          //   //   assignedTo: outsatandingModel.outstandhead!.outstanddata![i].assignedTo,
          //   //   balanceToPay:outsatandingModel.outstandhead!.outstanddata![i].balanceToPay,
          //   //   collectionInc: outsatandingModel.outstandhead!.outstanddata![i].collectionInc,
          //   //   companyName: outsatandingModel.outstandhead!.outstanddata![i].companyName,
          //   //   contactName: outsatandingModel.outstandhead!.outstanddata![i].contactName,
          //   //   customerCode: outsatandingModel.outstandhead!.outstanddata![i].customerCode,
          //   //   customerEmail:outsatandingModel.outstandhead!.outstanddata![i].customerEmail,
          //   //   customerGroup: outsatandingModel.outstandhead!.outstanddata![i].customerGroup,
          //   //   customerMobile: outsatandingModel.outstandhead!.outstanddata![i].customerMobile,
          //   //   customerName: outsatandingModel.outstandhead!.outstanddata![i].customerName,
          //   //   gstNo: outsatandingModel.outstandhead!.outstanddata![i].gstNo,
          //   //   penaltyAfterDue: outsatandingModel.outstandhead!.outstanddata![i].penaltyAfterDue,
          //   //   storeCode: outsatandingModel.outstandhead!.outstanddata![i].storeCode,
          //   //   transAmount: outsatandingModel.outstandhead!.outstanddata![i].transAmount,
          //   // ));

          //   notifyListeners();
          // }
          // for (int i = 0;
          //     i < outsatandingModel.outstandhead!.outstandline!.length;
          //     i++){
          //      outstandline.add(outstandingLine(
          //       bil_Address1: outsatandingModel.outstandhead!.outstandline![i].bil_Address1,
          //       bil_Address2: outsatandingModel.outstandhead!.outstandline![i].bil_Address2,
          //       bil_Address3: outsatandingModel.outstandhead!.outstandline![i].bil_Address3,
          //       bil_Area: outsatandingModel.outstandhead!.outstandline![i].bil_Area,
          //       bil_City: outsatandingModel.outstandhead!.outstandline![i].bil_City,
          //       bil_Country: outsatandingModel.outstandhead!.outstandline![i].bil_Country,
          //       bil_District: outsatandingModel.outstandhead!.outstandline![i].bil_District,
          //       bil_Pincode: outsatandingModel.outstandhead!.outstandline![i].bil_Pincode,
          //       bil_State: outsatandingModel.outstandhead!.outstandline![i].bil_State,
          //       collectionType: outsatandingModel.outstandhead!.outstandline![i].collectionType,
          //       createdBy: outsatandingModel.outstandhead!.outstandline![i].createdBy,
          //       createdOn: outsatandingModel.outstandhead!.outstandline![i].createdOn,
          //       customerPORef: outsatandingModel.outstandhead!.outstandline![i].customerPORef,
          //       docentry: outsatandingModel.outstandhead!.outstandline![i].docentry,
          //       transDate: outsatandingModel.outstandhead!.outstandline![i].transDate,
          //       transDueDate: outsatandingModel.outstandhead!.outstandline![i].transDueDate,
          //       transNum: outsatandingModel.outstandhead!.outstandline![i].transNum,
          //       transRef1: outsatandingModel.outstandhead!.outstandline![i].transRef1,
          //       transType: outsatandingModel.outstandhead!.outstandline![i].transType,
          //       updatedBy: outsatandingModel.outstandhead!.outstandline![i].updatedBy,
          //       updatedOn: outsatandingModel.outstandhead!.outstandline![i].updatedOn,
          //       loanRef: outsatandingModel.outstandhead!.outstandline![i].loanRef,
          //       status: outsatandingModel.outstandhead!.outstandline![i].status,
          //       traceid: outsatandingModel.outstandhead!.outstandline![i].traceid,
          //       alternateMobileNo: outsatandingModel.outstandhead!.outstandline![i].alternateMobileNo,
          //       amountPaid: outsatandingModel.outstandhead!.outstandline![i].amountPaid,
          //       assignedTo: outsatandingModel.outstandhead!.outstandline![i].assignedTo,
          //        balanceToPay: outsatandingModel.outstandhead!.outstandline![i].balanceToPay,
          //        collectionInc: outsatandingModel.outstandhead!.outstandline![i].collectionInc,
          //        companyName: outsatandingModel.outstandhead!.outstandline![i].companyName,
          //        contactName: outsatandingModel.outstandhead!.outstandline![i].contactName,
          //        customerCode: outsatandingModel.outstandhead!.outstandline![i].customerCode,
          //        customerEmail: outsatandingModel.outstandhead!.outstandline![i].customerEmail,
          //        customerGroup: outsatandingModel.outstandhead!.outstandline![i].customerGroup,
          //        customerMobile: outsatandingModel.outstandhead!.outstandline![i].customerMobile,
          //        customerName: outsatandingModel.outstandhead!.outstandline![i].customerName,
          //        gstNo: outsatandingModel.outstandhead!.outstandline![i].gstNo,
          //        penaltyAfterDue: outsatandingModel.outstandhead!.outstandline![i].penaltyAfterDue,
          //        storeCode: outsatandingModel.outstandhead!.outstandline![i].storeCode,
          //        transAmount: outsatandingModel.outstandhead!.outstandline![i].transAmount
          //        )) ;
          //     }

          log("valueDBmodel2222:::" + valueDBmodel.length.toString());
        } else {
          apiloading = false;
          log("NODAta on outstanding");
          lottie = 'Assets/no-data.png';
          errormsg = 'No Outstanding..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        apiloading = false;
        lottie = '';
        errormsg = '${value.message}..${value.exception}..!!';
        notifyListeners();
      } else if (value.stcode! == 500) {
        if (value.exception!.contains("Network is unreachable")) {
          apiloading = false;
          lottie = 'Assets/NetworkAnimation.json';
          errormsg = '${value.stcode}..Network Issue..\nTry again Later..!!';
          notifyListeners();
        } else {
          apiloading = false;
          lottie = 'Assets/warning.png';
          errormsg =
              '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';

          notifyListeners();
        }
        // apiloading = false;
        //  lottie='Assets/NetworkAnimation.json';
        // errormsg = '${value.stcode}..Network Issue..\nTry again Later..!!';

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

  bool iscusname = false;
  bool isassignto = false;

  List<String> selectedcusname = [];
  List<String> selectedassignto = [];
  ontapassignto() {
    isassignto = !isassignto;
    notifyListeners();
  }

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

  String? assignto = '';
  onfilterapply() async {
    final Database db = (await DBHelper.getInstance())!;
    log("assignvalue::" + assignvalue.toString());
    log("cusnamevalue::" + cusnamevalue.toString());
    await DBOperation.getfilterapply(
            db,
            assignvalue == null ? '' : assignvalue!,
            cusnamevalue == null ? '' : cusnamevalue!,
            mycontroller[2].text.isEmpty ? '' : mycontroller[2].text,
            mycontroller[3].text.isEmpty ? '' : mycontroller[3].text,
            mycontroller[4].text.isEmpty ? 0 : int.parse(mycontroller[4].text),
            mycontroller[5].text.isEmpty ? 0 : int.parse(mycontroller[5].text))
        .then((value) async {
      valueDBmodel.clear();
      valueDBmodel = value;
      await countofKpi();
      clearfilterval();
      notifyListeners();
    });
  }

  getCustomerDet(String cuscode) async {
    tocustomerDet = null;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result2 =
        await DBOperation.getmapvaluestocollection(db, cuscode);
    log("result2::" + result2.length.toString());
    if (result2.isNotEmpty) {
      tocustomerDet = outstandingLine(
        bil_Address1: result2[0]['Bil_Address1'].toString(),
        bil_Address2: result2[0]['Bil_Address2'].toString(),
        bil_Address3: '',
        bil_Area: result2[0]['Bil_Area'].toString(),
        bil_City: result2[0]['Bil_City'].toString(),
        bil_Country: result2[0]['Bil_Country'].toString(),
        bil_District: result2[0]['Bil_City'].toString(),
        bil_Pincode: result2[0]['Bil_Pincode'].toString(),
        bil_State: result2[0]['Bil_State'].toString(),
        assignedTo: result2[0]['AssignedTo'].toString(),
        contactName: result2[0]['ContactName'].toString(),
        customerCode: result2[0]['CustomerCode'].toString(),
        customerEmail: result2[0]['CustomerEmail'].toString(),
        customerMobile: result2[0]['CustomerCode'].toString(),
        customerName: result2[0]['ContactName'].toString(),
        gstNo: result2[0]['GstNo'].toString(),
        storeCode: result2[0]['StoreCode'].toString(),
      );
    }
    notifyListeners();
  }

  callcustomerapi() async {
    await customerDetailApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        frmAddmodeldata = value.leadcheckdata;
        log("frmAddmodeldatalenght:::${frmAddmodeldata!.cardName}");
        notifyListeners();
      }
    });
    notifyListeners();
  }

  double totalPayAmt = 0;
  getpdfviewList(String custCode) async {
    outStndPDFDetList = [];
    totalPayAmt = 0;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result2 =
        await DBOperation.getoutstndPdfList(db, custCode);
    for (int i = 0; i < result2.length; i++) {
      outStndPDFDetList.add(OutPDFLines(
        id: 1,
        transNum: result2[i]['TransNum'].toString(),
        transDate: result2[i]['TransDate'].toString(),
        transDueDate: result2[i]['TransDueDate'].toString(),
        transType: result2[i]['TransType'].toString(),
        transAmt: double.parse(result2[i]['TransAmount'].toString()),
        balanceTopay: double.parse(result2[i]['BalanceToPay'].toString()),
      ));

      notifyListeners();
    }
    for (int ik = 0; ik < outStndPDFDetList.length; ik++) {
      totalPayAmt = totalPayAmt + outStndPDFDetList[ik].balanceTopay!;
      notifyListeners();
    }
  }

  List<TimeCall>? timePeriodDet = [];

  getpdfviewList2(String custCode) async {
    timePeriodDet = [];
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> result2 =
        await DBOperation.getoutstndPdfSecList(db, custCode);

    timePeriodDet!.add(TimeCall(
      c1: double.parse(result2[0]['C1'].toString()),
      c2: double.parse(result2[0]['C2'].toString()),
      c3: double.parse(result2[0]['C3'].toString()),
      c4: double.parse(result2[0]['C4'].toString()),
      c5: double.parse(result2[0]['C5'].toString()),
    ));
    notifyListeners();
  }

  onDoubletap(String? cusCode) async {
    valueDBmodelchild.clear();
    final Database db = (await DBHelper.getInstance())!;
    outstandingkpi = await DBOperation.getoutstandingchildInvoice(db, cusCode);
    notifyListeners();
  }

  double? totaloutstanding = 0.0;
  double? overdue = 0.0;
  double? upcoming = 0.0;
  clearontap() {
    ontapKpi2.clear();
    totaloutstanding = 0.0;
    overdue = 0.0;
    upcoming = 0.0;
    outstandingkpi.clear();
    notifyListeners();
  }

  ontapkpicall(String cuscode) async {
    ontapKpi2.clear();
    totaloutstanding = 0.0;
    overdue = 0.0;
    upcoming = 0.0;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result2 =
        await DBOperation.getoutontapKPI(db, cuscode);
    if (result2.isNotEmpty) {
      ontapKpi2.add(ontapKpi(
          totaloutstanding:
              double.parse(result2[0]['totaloutstanding'].toString()),
          overdue: double.parse(result2[0]['overdue'].toString()),
          upcoming: double.parse(result2[0]['upcoming'].toString()),
          Bil_City: result2[0]['Bil_City'].toString(),
          Bil_State: result2[0]['Bil_State'].toString(),
          CustomerName: result2[0]['CustomerName'].toString(),
          CustomerCode: result2[0]['CustomerCode'].toString()));

      totaloutstanding =
          double.parse(ontapKpi2[0].totaloutstanding!.toStringAsFixed(2));
      overdue = double.parse(ontapKpi2[0].overdue!.toStringAsFixed(2));
      upcoming = double.parse(ontapKpi2[0].upcoming!.toStringAsFixed(2));
      //  outstandKPI(
    }
  }

  mapvaluestocollection(String cuscode) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result2 =
        await DBOperation.getmapvaluestocollection(db, cuscode);
    log("result2::" + result2.length.toString());
    if (result2.isNotEmpty) {
      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['CustomerCode'].toString());
      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['CustomerName'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['AlternateMobileNo'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['ContactName'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['CustomerEmail'].toString());
      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['GstNo'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['Bil_Address1'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['Bil_Address2'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['Bil_Area'].toString());
      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['Bil_City'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['Bil_Country'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['Bil_Pincode'].toString());
      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['Bil_State'].toString());

      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['StoreCode'].toString());
      NewCollectionContoller.comefromoutStanding
          .add(result2[0]['AssignedTo'].toString());
      log("HHH" + NewCollectionContoller.comefromoutStanding[0].toString());
      Get.offAllNamed(ConstantRoutes.newcollection);
    }
  }

//  NewCollectionContoller. comefromoutStanding.add()
  countofKpi() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result2 =
        await DBOperation.getoutstandingKPI(db);
    if (result2.isNotEmpty) {
      //  outstandKPI(
      totaloutstanding = result2[0]['totaloutstanding'] == null
          ? 0.0
          : double.parse(result2[0]['totaloutstanding'].toString());
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

  Config config = Config();
  List<outstandKPI> outstandingkpi = [];
  getdbmodel() async {
    apiloading = true;
    notifyListeners();
    final Database db = (await DBHelper.getInstance())!;
    valueDBmodel = await DBOperation.getoutstandingMaster(db);
    valueDBmodelchild = await DBOperation.getoutstandingchild(db);
    await countofKpi();
    log("valueDBmodel." + valueDBmodel.length.toString());
    log("valueDBmodelchild::" + valueDBmodelchild.length.toString());
    List<Map<String, Object?>> assignDB =
        await DBOperation.getOutLFtr("AssignedTo", db);

    List<Map<String, Object?>> customerDB =
        await DBOperation.getOutLFtr("CustomerName", db);
    notifyListeners();

// List<Map<String, Object?>> loanrefDB= await DBOperation.getOutLFtr("AssignedTo",db);

// List<Map<String, Object?>> ageDB= await DBOperation.getOutLFtr("AssignedTo",db);

// List<Map<String, Object?>> balanceDB= await DBOperation.getOutLFtr("AssignedTo",db);
    await dataget(assignDB, customerDB);
    notifyListeners();
    apiloading = false;
    notifyListeners();
  }

  List<Distcolumn> assigncolumn = [];
  List<cuscolumn2> customercolumn = [];
  Future<void> dataget(List<Map<String, Object?>> assignDB, customerDB) async {
    assigncolumn.clear();
    customercolumn.clear();
    notifyListeners();
    for (int i = 0; i < assignDB.length; i++) {
      assigncolumn.add(Distcolumn(name: assignDB[i]['AssignedTo'].toString()));
      log("assigncolumn::" + assigncolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < customerDB.length; i++) {
      customercolumn
          .add(cuscolumn2(name: customerDB[i]['CustomerName'].toString()));
      log("customercolumn::" + customercolumn[i].name.toString());
      notifyListeners();
    }
  }

  clearalldata() {
    ontapKpi2.clear();
    valueDBmodel.clear();
    outstanddata.clear();
    outstandline.clear();
    valueDBmodelchild.clear();
    apiloading = false;
    errormsg = '';
    customercolumn.clear();
    assigncolumn.clear();
    notifyListeners();
  }
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

class ontapKpi {
  double? totaloutstanding;
  double? overdue;
  double? upcoming;
  String? Bil_City;
  String? Bil_State;
  String? CustomerName;
  String? CustomerCode;
  ontapKpi(
      {required this.totaloutstanding,
      required this.overdue,
      required this.upcoming,
      required this.Bil_City,
      required this.Bil_State,
      required this.CustomerName,
      required this.CustomerCode});
}

class outstandKPI {
  String? TransNum;
  String? TransDate;
  String? TransRef1;
  double? age;
  double? BalanceToPay;
  double? TransAmount;
  int? docentry;
  double? penaltyAfterDue;

  outstandKPI(
      {this.docentry,
      required this.penaltyAfterDue,
      required this.TransNum,
      required this.TransDate,
      required this.TransRef1,
      required this.age,
      required this.BalanceToPay,
      required this.TransAmount});
}

class TimeCall {
  double? c1;
  double? c2;
  double? c3;
  double? c4;
  double? c5;

  TimeCall({
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
  });
  Map<String, dynamic> tojason() {
    Map<String, dynamic> map = {
      "c1": c1,
      "c2": c2,
      "c3": c3,
      "c4": c4,
      "c5": c5,
    };
    return map;
  }
}
