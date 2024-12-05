// import 'dart:math';
import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/DBHelper/db_helper.dart';
import 'package:sellerkit/DBHelper/db_operation.dart';
import 'package:sellerkit/DBModel/ReportsModel/leadanalysis_model.dart';
import 'package:sellerkit/Models/LeadAnalysisModel/LeadAnalysisModel.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/columnChart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/lineCahrt.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/piechart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/viewDetailsAlertBox.dart';
import 'package:sellerkit/Services/ReportsApi/LeadAnalysisApi.dart';
import 'package:sellerkit/Services/ReportsApi/NewLeadReportAPI.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/Screen.dart';
import '../../Models/LeadAnalysisModel/TestReportModel.dart';
import '../../Pages/Reports/Reports/widgets/CardChart.dart';
import '../../Pages/Reports/Reports/widgets/barChart.dart';
import '../../Pages/Reports/Reports/widgets/bubbleChart.dart';
import '../../Pages/Reports/Reports/widgets/splineChart.dart';

class ReportsController extends ChangeNotifier {
  List<TextEditingController> mycontroller =
      List.generate(50, (i) => TextEditingController());
  List<TextEditingController> myDatecontroller =
      List.generate(50, (i) => TextEditingController());
  final List<GlobalKey<SfCartesianChartState>> cartesianChartKey =
      List.generate(10, (i) => GlobalKey<SfCartesianChartState>());
  List<DateRangeData> dateRange = [
    DateRangeData(rangeType: 'This Week', color: 0),
    DateRangeData(rangeType: 'This Month', color: 0),
    DateRangeData(rangeType: 'This Year', color: 0),
    DateRangeData(rangeType: 'This Qtr', color: 0),
    DateRangeData(rangeType: 'Today', color: 0),
    DateRangeData(rangeType: 'Yesterday', color: 0),
    DateRangeData(rangeType: 'Custom', color: 0),
  ];
  Config config = Config();
  TextEditingController searchcontroller = TextEditingController();

  bool chartload = false;
  String selectedRangetype = '';

  String? apidate;
  String apiwonpurchaseDate = '';
  List<Distcolumn> assigncolumn = [];
  List<Distcusgroupcolumn> cusgroupcolumn = [];
  List<DistEnqstatuscolumn> enqstatuscolumn = [];
  List<Distlookingforcolumn> lookingforcolumn = [];
  List<Distlookingforcolumn> filterlookingforcolumn = [];
  List<Distlookingforcolumn> lookingforcolumnforshow = [];
  List<Distlevelcolumn> intlevelcolumn = [];
  List<Distordercolumn> ordercolumn = [];

  List<DistLeadValColumn> leadValColumn = [];
  List<DistLeadDateColumn> leadDateColumn = [];
  List<DistNextFColumn> nextFollowDtColumn = [];

  List<String> selectedinterest = [];
  // 1786

  List<String> selectedBrand = [];
  List<String> selectedReferal = [];
  List<String> selectedCategory = [];
  List<String> selectedSubCatogory = [];

  List<String> selectedorder = [];
  List<String> selectedStoreCd = [];

  List<String> selectedlookingfor = [];
  List<String> selectedenqstatus = [];
  List<String> selectedcusgoup = [];
  List<String> selectedassignto = [];
  List<String> tapTitle = [];

  String pieChartTitle = '';
  String barChartTitle = '';
  String cardChartTitle = '';
  String columnChartTitle = '';
  String lineChartTitle = '';
  String splineChartTitle = '';
  String bubbleChartTitle = '';
  String tableChartTitle = '';

  bool isenqstatus = false;
  bool islookingfor = false;
  bool iscusgroup = false;
  bool isassignto = false;
  bool isinterest = false;
  bool isorder = false;
  String? kpilottie;
  String? reportexp;
  String? dropdownValue;
  String? assignvalue;
  String? chooseTitle;
  String? cusnamevalue;
  String? enquirystatusvalue;
  String? lookingforvalue;
  String? brandVal;
  String? referalVal;
  String? categoryVal;
  String? subCategoryVal;
  List<bool> lookingforvalue22 = [];
  String? interestlevelvalue;
  String? ordertypevalue;
  String? storeCodeVal;

  String? viewType;
  String? viewTypeCode;

  bool progress = false;
  String errormsg = '';
  List<LeadAnalysisMasterData> leadAnalysismasterDataset2 = [];
  List<LeadAnalysisMasterData> leadAnalysismasterDataset = [];

  List<LeadAnalysisReportData> leadAnalysisReportDataset = [];

  List<LeadAnalysisMasterData> rangeFilterDBData = [];
  List<LeadAnalysisViewData> leadRerportViewData = [];
  List<LeadReportQueryData> leadRerportQueryData = [];
  List<LeadAnalysisViewData> leadTablViewData = [];
  List<LeadReportQueryData> leadTableQueryData = [];
  List<SplitLeadData> splitTitleName = [];

  String startDate = '';
  String endDate = '';
  String qryStartDate = '';
  String qryEndDate = '';
  String? custmStartDate;
  String? custmEndDate;
  List<Map<String, dynamic>> tablercolumn = [];
  bool tableColumLoad = false;
  List<PieChartData> pieChartData = [];
  List<ColumnChartData> columnChartData = [];
  List<BubbleChartData> bubbleChartData = [];
  List<BarChartData> barChartData = [];
  List<LineChartData> lineChartData = [];
  List<SplineChartData> splineChartData = [];
  List<CardChart> cardChartData = [];
  List<Color> pieChartsClr = [];
  List<Color> bubbleChartsClr = [];
  List<Color> barChartsClr = [];

  List<Color> coloumnChartsClr = [];
  List<Color> cardChartsClr = [];
  List<RItemList> rlistItem = [];
  bool dropdown = false;
  bool dateFormate = false;
  bool rangeVal = false;
  bool isValSelect = false;
  List<TestName> rTestListItem2 = [];
  List<Color> defaultColor = [];
  List<Color> cityPark = [];
  List<Color> classroom = [];
  List<Color> colorblindSafe = [];
  List<Color> electric = [];
  List<Color> heighContrast = [];
  List<Color> sunset = [];
  List<Color> sunset2 = [];
  List<Color> electricShuffle = [];
  List<Color> twilight = [];
  List<Color> barchartcolors = [];
  List<ItemnameR> rdata = [];
  List<ItemnameR> itemNamerx = [];
  bool onTapDateRange = false;
  DateTimeRange? selectedDateRange;
  List<LeadReportQueryData>? chartType = [];

  clearAllData() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncateLeadAnalysisDB(db);
    await DBOperation.truncateLeadReportDB(db);
    await DBOperation.truncateLeadViewDB(db);
    await DBOperation.truncateLeadQueryDB(db);
    await DBOperation.truncateTestLeadReportDB(db);
    for (int j = 0; j < dateRange.length; j++) {
      dateRange[j].color = 0;
    }
    dateRange[1].color = 1;

    mycontroller = List.generate(50, (i) => TextEditingController());
    List.generate(50, (i) => TextEditingController());
    searchcontroller = TextEditingController();
    leadAnalysismasterDataset2 = [];
    // kpilottie = null;
    // reportexp = null;
    chartload = false;
    selectedRangetype = '';
    apidate = '';
    apiwonpurchaseDate = '';
    assigncolumn = [];
    onTapDateRange = false;
    selectedDateRange = null;
    chartType = [];
    cusgroupcolumn = [];
    enqstatuscolumn = [];
    lookingforcolumn = [];
    filterlookingforcolumn = [];
    lookingforcolumnforshow = [];
    intlevelcolumn = [];
    ordercolumn = [];
    leadValColumn = [];
    leadDateColumn = [];
    nextFollowDtColumn = [];
    selectedinterest = [];
    selectedBrand = [];
    selectedReferal = [];
    selectedCategory = [];
    selectedSubCatogory = [];
    selectedorder = [];
    selectedStoreCd = [];
    selectedlookingfor = [];
    selectedenqstatus = [];
    selectedcusgoup = [];
    selectedassignto = [];
    tapTitle = [];
    pieChartTitle = '';
    barChartTitle = '';
    cardChartTitle = '';
    columnChartTitle = '';
    lineChartTitle = '';
    splineChartTitle = '';
    bubbleChartTitle = '';
    tableChartTitle = '';
    isenqstatus = false;
    islookingfor = false;
    iscusgroup = false;
    isassignto = false;
    isinterest = false;
    isorder = false;

    dropdownValue = '';
    assignvalue = '';
    chooseTitle = '';
    cusnamevalue = '';
    enquirystatusvalue = '';
    lookingforvalue = '';
    brandVal = '';
    referalVal = '';
    categoryVal = '';
    subCategoryVal = '';
    lookingforvalue22 = [];
    interestlevelvalue = '';
    ordertypevalue = '';
    storeCodeVal = '';
    viewType = '';
    viewTypeCode = '';
    progress = false;
    errormsg = '';
    leadAnalysismasterDataset = [];
    leadAnalysisReportDataset = [];
    rangeFilterDBData = [];
    leadRerportViewData = [];
    leadRerportQueryData = [];
    leadTablViewData = [];
    leadTableQueryData = [];
    splitTitleName = [];
    custmStartDate = '';
    custmEndDate = '';
    tablercolumn = [];
    tableColumLoad = false;
    pieChartData = [];
    columnChartData = [];
    bubbleChartData = [];
    barChartData = [];
    lineChartData = [];
    splineChartData = [];
    cardChartData = [];
    pieChartsClr = [];
    bubbleChartsClr = [];
    barChartsClr = [];
    coloumnChartsClr = [];
    cardChartsClr = [];
    rlistItem = [];
    dropdown = false;
    dateFormate = false;
    rangeVal = false;
    isValSelect = false;
    rTestListItem2 = [];
    defaultColor = [];
    cityPark = [];
    classroom = [];
    colorblindSafe = [];
    electric = [];
    heighContrast = [];
    sunset = [];
    sunset2 = [];
    twilight = [];
    barchartcolors = [];
    rdata = [];
    itemNamerx = [];
    notifyListeners();
  }

  init() {
    clearAllData();
    initialMonthDataLoading();
    notifyListeners();
  }

  ontaporder() {
    isorder = !isorder;
    notifyListeners();
  }

  ontapinterest() {
    isinterest = !isinterest;
    notifyListeners();
  }

  ontapassignto() {
    isassignto = !isassignto;
    notifyListeners();
  }

  ontapcusgroup() {
    iscusgroup = !iscusgroup;
    notifyListeners();
  }

  onenqstatus() {
    isenqstatus = !isenqstatus;
    notifyListeners();
  }

  ontaplooking() {
    islookingfor = !islookingfor;
    notifyListeners();
  }

  itemselectassignto(String itemvalue, bool isselected) {
    log('itemvalueitemvalue:$itemvalue');
    if (isselected) {
      log(selectedassignto.toString());
      selectedassignto.add(
        itemvalue,
      );
    } else {
      selectedassignto.remove(itemvalue);
    }
    assignvalue = selectedassignto.join(', ');
    log('assignvalueassignvalue:${assignvalue!.toString()}');
    notifyListeners();
  }

  selectcheckval(
    String title,
    String itemvalue,
    bool isselected,
  ) {
    if (isselected) {
      if (chooseTitle!.isEmpty) {
        tapTitle.add(
          title,
        );
        chooseTitle = tapTitle.join(', ');
      } else {
        log('message::${chooseTitle!.contains('$title').toString()}');
        if (chooseTitle!.contains(title).toString() == isselected.toString()) {
        } else {
          tapTitle.add(
            title,
          );
          chooseTitle = tapTitle.join(', ');
        }
      }
    } else {
      tapTitle.remove(title);
    }

    if (title == 'AssignedTo') {
      itemselectassignto(itemvalue, isselected);
    }
    if (title == 'CustomerGroup') {
      itemselectCusgroup(itemvalue, isselected);
    }
    if (title == 'StoreCode') {
      itemselectStroeCd(itemvalue, isselected);
    }
    if (title == 'Status') {
      itemselectenqstatus(itemvalue, isselected);
    }
    if (title == 'OrderType') {
      itemselectorder(itemvalue, isselected);
    }
    if (title == 'InterestLevel') {
      itemselectinterest(itemvalue, isselected);
    }
    if (title == 'Refferal') {
      itemselectRef(itemvalue, isselected);
    }
    if (title == 'Brand') {
      itemselectBrand(itemvalue, isselected);
    }
    if (title == 'Category') {
      itemselectCategory(itemvalue, isselected);
    }
    if (title == 'SubCategory') {
      itemselectSubCatogory(itemvalue, isselected);
    }
  }

  itemselect(String itemvalue, bool isselected) {
    lookingforvalue = '';
    if (isselected) {
      selectedlookingfor.add(itemvalue);
    } else {
      selectedlookingfor.remove(itemvalue);
    }
    lookingforvalue = selectedlookingfor.join(', ');
    notifyListeners();
  }

  itemselectinterest(String itemvalue, bool isselected) {
    interestlevelvalue = '';
    if (isselected) {
      selectedinterest.add(itemvalue);
    } else {
      selectedinterest.remove(itemvalue);
    }
    interestlevelvalue = selectedinterest.join(', ');

    notifyListeners();
  }

  itemselectRef(String itemvalue, bool isselected) {
    referalVal = '';
    if (isselected) {
      selectedReferal.add(itemvalue);
    } else {
      selectedReferal.remove(itemvalue);
    }
    referalVal = selectedReferal.join(', ');

    notifyListeners();
  }

  itemselectBrand(String itemvalue, bool isselected) {
    brandVal = '';
    if (isselected) {
      selectedBrand.add(itemvalue);
    } else {
      selectedBrand.remove(itemvalue);
    }
    brandVal = selectedBrand.join(', ');

    notifyListeners();
  }

  itemselectCategory(String itemvalue, bool isselected) {
    categoryVal = '';
    if (isselected) {
      selectedCategory.add(itemvalue);
    } else {
      selectedCategory.remove(itemvalue);
    }
    categoryVal = selectedCategory.join(', ');

    notifyListeners();
  }

  itemselectSubCatogory(String itemvalue, bool isselected) {
    subCategoryVal = '';
    if (isselected) {
      selectedSubCatogory.add(itemvalue);
    } else {
      selectedSubCatogory.remove(itemvalue);
    }
    subCategoryVal = selectedSubCatogory.join(', ');

    notifyListeners();
  }

  itemselectenqstatus(String itemvalue, bool isselected) {
    enquirystatusvalue = '';
    if (isselected) {
      selectedenqstatus.add(itemvalue);
    } else {
      selectedenqstatus.remove(itemvalue);
    }
    enquirystatusvalue = selectedenqstatus.join(', ');
    // log("selectedlookingfor::$selectedenqstatus");
    // log("enquirystatusvalue::$enquirystatusvalue");
    notifyListeners();
  }

  itemselectorder(String itemvalue, bool isselected) {
    ordertypevalue = '';
    if (isselected) {
      selectedorder.add(itemvalue);
    } else {
      selectedorder.remove(itemvalue);
    }
    ordertypevalue = selectedorder.join(', ');
    // log("selectedorder::$selectedorder");
    // log("ordertypevalue::$ordertypevalue");
    notifyListeners();
  }

  itemselectStroeCd(String itemvalue, bool isselected) {
    ordertypevalue = '';
    if (isselected) {
      selectedStoreCd.add(itemvalue);
    } else {
      selectedStoreCd.remove(itemvalue);
    }
    storeCodeVal = selectedStoreCd.join(', ');
    // log("selectedorder::$storeCodeVal");
    // log("ordertypevalue::$ordertypevalue");
    notifyListeners();
  }

  itemselectCusgroup(String itemvalue, bool isselected) {
    cusnamevalue = '';
    if (isselected) {
      selectedcusgoup.add(itemvalue);
    } else {
      selectedcusgoup.remove(itemvalue);
    }
    cusnamevalue = selectedcusgoup.join(', ');
    // log("selectedcusgoup::$selectedcusgoup");
    log("cusnamevalue::$cusnamevalue");
    notifyListeners();
  }

  void showfromDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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
      apiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[16].text = chooseddate;
      notifyListeners();
    });
  }

  void showToDate(BuildContext context, int index) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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
      apiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);
      myDatecontroller[index].text = chooseddate;
      mycontroller[17].text = chooseddate;
      notifyListeners();
    });
  }

  // Future<void> dataget(List<Map<String, Object?>> assignDB, cusgropDB,
  //     enqstatusDB, lookingforDB, intlevelDB, ordertypeDB) async {
  //   assigncolumn.clear();
  //   cusgroupcolumn.clear();
  //   enqstatuscolumn.clear();
  //   // lookingforcolumn.clear();
  //   // filterlookingforcolumn.clear();
  //   // lookingforcolumnforshow.clear();
  //   intlevelcolumn.clear();
  //   ordercolumn.clear();
  //   notifyListeners();
  //   for (int i = 0; i < assignDB.length; i++) {
  //     assigncolumn
  //         .add(Distcolumn(name: assignDB[i]['AssignedToUserName'].toString()));
  //    // log("assigncolumn::" + assigncolumn.length.toString());
  //     notifyListeners();
  //   }
  //   for (int i = 0; i < cusgropDB.length; i++) {
  //     cusgroupcolumn.add(
  //         Distcusgroupcolumn(name: cusgropDB[i]['CustomerGroup'].toString()));
  //    // log("cusgroupcolumn::" + cusgroupcolumn.length.toString());
  //     notifyListeners();
  //   }
  //   for (int i = 0; i < enqstatusDB.length; i++) {
  //     enqstatuscolumn.add(
  //         DistEnqstatuscolumn(name: enqstatusDB[i]['SlpStatusTab'].toString()));
  //    // log("enqstatuscolumn::" + enqstatuscolumn.length.toString());
  //     notifyListeners();
  //   }
  //   // for (int i = 0; i < lookingforDB.length; i++) {
  //   //   lookingforcolumn.add(Distlookingforcolumn(
  //   //       name: lookingforDB[i]['Lookingfor'].toString(), ischecck: false));

  //   //   filterlookingforcolumn = lookingforcolumn;
  //   //   //  // log("lookingforcolumn::" + filterlookingforcolumn.length.toString());

  //   //   notifyListeners();
  //   // }

  //   for (int i = 0; i < intlevelDB.length; i++) {
  //     intlevelcolumn.add(
  //         Distlevelcolumn(name: intlevelDB[i]['InterestLevel'].toString()));
  //    // log("intlevelcolumn::" + intlevelcolumn.length.toString());
  //     notifyListeners();
  //   }
  //   for (int i = 0; i < ordertypeDB.length; i++) {
  //     ordercolumn
  //         .add(Distordercolumn(name: ordertypeDB[i]['OrderType'].toString()));
  //    // log("assigncolumn::" + ordercolumn.length.toString());
  //     notifyListeners();
  //   }
  // }
  // List<LeadReportQueryData>? chartType2 = [];

  initialMonthDataLoading() async {
    log('message::${dateRange[1].color}');
    final Database db = (await DBHelper.getInstance())!;
    tableColumLoad = false;
    onTapDateRange = true;
    pieChartData = [];
    lineChartData = [];
    cardChartData = [];
    barChartData = [];
    bubbleChartData = [];
    cardChartData = [];
    tablercolumn = [];
    kpilottie = null;
    reportexp = null;
    leadAnalysismasterDataset2 = [];
    leadAnalysisReportDataset = [];
    splineChartData = [];
    leadRerportQueryData = [];
    leadTablViewData = [];
    leadTableQueryData = [];
    columnChartData = [];
    chartType = [];
    leadRerportViewData = [];
    leadRerportQueryData = [];
    minValuesAmount = 0;
    maxValuesAmount = 0;
    minSelectedAmount = 0;
    maxSelectedAmount = 0;
    chartload = true;
    onTapDateRange = true;
    await DBOperation.truncateLeadAnalysisDB(db);
    await DBOperation.truncateLeadReportDB(db);
    await DBOperation.truncateLeadViewDB(db);
    await DBOperation.truncateLeadQueryDB(db);
    allColorsData();

    String rangeType = 'Month';
    if (rangeType.contains('Month')) {
      dateRange[1].color = 1;
      visibleSelectedDate = true;
      String startDate2 = config
          .findFirstDateOfTheMonth2(DateTime.now())
          .toString()
          .replaceAll('.000', '');
      String endDate2 = config
          .findLastDateOfTheMonth2(DateTime.now())
          .toString()
          .replaceAll('.000', '');

      startDate = config
          .alignDate(config.findFirstDateOfTheMonth(DateTime.now()).toString());
      endDate = config
          .alignDate(config.findLastDateOfTheMonth(DateTime.now()).toString());
      log('startDate::$startDate::$endDate');
      qryStartDate = startDate2;
      qryEndDate = endDate2;
      NewLeadAnalysisApi.fromDate = startDate2;
      NewLeadAnalysisApi.endDate = endDate2;
      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          if (value.datadetail != null &&
              (value.datadetail!.leadMasterData.isNotEmpty)) {
            log('message11111111');
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;
            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;
            log('vv${value.datadetail!.leadViewData.length}');
            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            await DBOperation.insertLeadReportDBData(
                leadAnalysisReportDataset, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);
            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                    docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                    reportCode: viewResult[iv]['ReportCode'].toString(),
                    viewName: viewResult[iv]['ViewName'].toString(),
                    viewCode: viewResult[iv]['ViewCode'].toString()));
                notifyListeners();
              }
            }
            if (queryResult.isNotEmpty) {
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
            }

            await splitFilterData();
            if (leadTablViewData.isNotEmpty) {
              viewType = leadTablViewData[0].viewName;
              viewTypeCode = leadTablViewData[0].viewCode;
            }

            await initialDataLoading();
            notifyListeners();

            // List<Map<String, Object?>> result =
            //     await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate!),
            //         alignYYMMDD(endDate!), leadAnalysisTable, 'CreatedDate');
            // // rangeFilterGetData(result);
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            kpilottie = 'Assets/no-data.png';
            reportexp = "No Data Found..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }else{
           if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            log('excep'+kpilottie.toString());
            onTapDateRange = false;
           
            notifyListeners();
          }
        }
      });
      chartload = false;
      visibleSelectedDate = true;
      notifyListeners();
    }
  }

  initialDataLoading() async {
    chartType = [];
    final Database db = (await DBHelper.getInstance())!;
    // log('viewTypeCodeviewTypeCode::${viewTypeCode.toString()}');
    List<Map<String, Object?>> getViewCodeQuery =
        await DBOperation.getLeadReportQuerywiseData(db, viewTypeCode!);

    if (getViewCodeQuery.isNotEmpty) {
      for (var im = 0; im < getViewCodeQuery.length; im++) {
        chartType!.add(LeadReportQueryData(
            chartType: getViewCodeQuery[im]['ChartType'].toString(),
            leadQuery: getViewCodeQuery[im]['Query'].toString(),
            viewCode: getViewCodeQuery[im]['ViewCode'].toString(),
            kpiTitle: getViewCodeQuery[im]['KPITitle'].toString(),
            queryExt: getViewCodeQuery[im]['QueryExt'].toString(),
            rowCode: int.parse(getViewCodeQuery[im]['RowCode'].toString())));
      }
    }
    // log('chartTypechartTypechartType::${chartType!.length}');
    notifyListeners();
    for (var ik = 0; ik < chartType!.length; ik++) {
      if (chartType!.isNotEmpty) {
        List<Map<String, Object?>> getFilterData =
            await DBOperation.getLeadMaserFilterData(
                db,
                chooseTitle!,
                chartType![ik].leadQuery.toString(),
                chartType![ik].queryExt,
                splitTitleName,
                assignvalue == null ? '' : assignvalue!,
                cusnamevalue == null ? '' : cusnamevalue!,
                enquirystatusvalue == null ? '' : enquirystatusvalue!,
                storeCodeVal == null ? '' : storeCodeVal!,
                interestlevelvalue == null ? '' : interestlevelvalue!,
                ordertypevalue == null ? '' : ordertypevalue!,
                referalVal == null ? '' : referalVal!,
                brandVal == null ? '' : brandVal!,
                categoryVal == null ? '' : categoryVal!,
                subCategoryVal == null ? '' : subCategoryVal!,
                minSelectedAmount != 0
                    ? minSelectedAmount
                    : currentRangeValues!.start,
                maxSelectedAmount != 0
                    ? maxSelectedAmount
                    : currentRangeValues!.end,
                qryStartDate,
                qryEndDate);

        if (getFilterData.length > 0 || getFilterData.isNotEmpty) {
          for (var i = 0; i < getFilterData.length; i++) {
            if (chartType![ik].viewCode == 'A100') {
              if (chartType![ik].chartType.toString() == 'Card') {
                if (getFilterData[i]['name'] != null) {
                  cardChartTitle = chartType![ik].kpiTitle;
                  cardChartData.add(CardChart(
                    name: getFilterData[i]['name'].toString(),
                    value: getFilterData[i]['value'] != null
                        ? double.parse(getFilterData[i]['value'].toString())
                        : 0,
                  ));
                }

                for (var id = 0; id < cardChartData.length; id++) {
                  List<Color> sunsetShuffle = sunset2;
                  for (var ix = 0; ix < sunsetShuffle.length; ix++) {
                    if (ix == id) {
                      cardChartData[id].colors = sunsetShuffle[ix];
                    }
                    notifyListeners();
                  }
                }

                notifyListeners();
              }
              if (chartType![ik].chartType.toString() == 'Pie_Chart') {
                if (getFilterData[i]['name'] != null &&
                    getFilterData[i]['value'] != null &&
                    double.parse(getFilterData[i]['value'].toString()) != 0) {
                  pieChartTitle = chartType![ik].kpiTitle;
                  pieChartDataBiding(getFilterData[i]['name'].toString(),
                      double.parse(getFilterData[i]['value'].toString()));
                  notifyListeners();
                }
              }

              notifyListeners();
              if (chartType![ik].chartType.toString() == 'Bar_Chart') {
                if (getFilterData[i]['x'] != null &&
                    getFilterData[i]['y'] != null) {
                  barChartTitle = chartType![ik].kpiTitle;

                  barChartData.add(BarChartData(
                    // 10,
                    x: getFilterData[i]['x'].toString(),
                    y: int.parse(getFilterData[i]['y'].toString()),
                  ));
                }
                List<Color> heighContrastSuffle = barchartcolors..shuffle();
                for (var ix = 0; ix < barChartData.length; ix++) {
                  for (var i = 0; i < heighContrastSuffle.length; i++) {
                    if (i == ix) {
                      barChartData[ix].colors = heighContrastSuffle[i];
                    }
                  }
                }
                notifyListeners();
              }
            }
          }
          notifyListeners();
        }
      }
    }
    onTapDateRange = false;
    notifyListeners();
  }

  onfilterapply() async {
    final Database db = (await DBHelper.getInstance())!;
    onTapDateRange = true;
    cardChartData = [];
    kpilottie = null;
    reportexp = null;
    pieChartData = [];
    lineChartData = [];
    barChartData = [];
    splineChartData = [];
    columnChartData = [];
    bubbleChartData = [];
    tablercolumn = [];
    allColorsData();
    String frmDate = selectedDateRange != null
        ? config.currentQueryDateOnly(selectedDateRange!.start.toString())
        : '';
    String toDate = selectedDateRange != null
        ? config.currentQueryDateOnly(selectedDateRange!.end.toString())
        : '';
    if (chartType!.isEmpty) {
      chartType = [];
      if (leadTablViewData.isNotEmpty) {
        viewType = leadTablViewData[0].viewName;
        viewTypeCode = leadTablViewData[0].viewCode;
      }

      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getViewCodeQuery =
          await DBOperation.getLeadReportQuerywiseData(db, viewTypeCode!);
      if (getViewCodeQuery.isNotEmpty) {
        for (var im = 0; im < getViewCodeQuery.length; im++) {
          chartType!.add(LeadReportQueryData(
              chartType: getViewCodeQuery[im]['ChartType'].toString(),
              leadQuery: getViewCodeQuery[im]['Query'].toString(),
              viewCode: getViewCodeQuery[im]['ViewCode'].toString(),
              kpiTitle: getViewCodeQuery[im]['KPITitle'].toString(),
              queryExt: getViewCodeQuery[im]['QueryExt'].toString(),
              rowCode: int.parse(getViewCodeQuery[im]['RowCode'].toString())));
        }
      }
    }
    if (chartType!.isNotEmpty) {
      for (var ik = 0; ik < chartType!.length; ik++) {
        List<Map<String, Object?>> getFilterData =
            await DBOperation.getLeadMaserFilterData(
                db,
                chooseTitle!,
                chartType![ik].leadQuery.toString(),
                chartType![ik].queryExt,
                splitTitleName,
                // replaceAll('1 =1 AND', ' '),
                assignvalue == null ? '' : assignvalue!,
                cusnamevalue == null ? '' : cusnamevalue!,
                enquirystatusvalue == null ? '' : enquirystatusvalue!,
                storeCodeVal == null ? '' : storeCodeVal!,
                interestlevelvalue == null ? '' : interestlevelvalue!,
                ordertypevalue == null ? '' : ordertypevalue!,
                referalVal == null ? '' : referalVal!,
                brandVal == null ? '' : brandVal!,
                categoryVal == null ? '' : categoryVal!,
                subCategoryVal == null ? '' : subCategoryVal!,
                minSelectedAmount != 0
                    ? minSelectedAmount
                    : currentRangeValues!.start,
                maxSelectedAmount != 0
                    ? maxSelectedAmount
                    : currentRangeValues!.end,
                frmDate.isEmpty ? qryStartDate : frmDate,
                toDate.isEmpty ? qryEndDate : toDate
                // '9999-12-31' : endDate,
                );
        // log(' getFilterData.length::::${getFilterData.length}');
        if (getFilterData.length > 0 || getFilterData.isNotEmpty) {
          for (var i = 0; i < getFilterData.length; i++) {
            if (chartType![ik].viewCode == 'A100') {
              if (chartType![ik].chartType.toString() == 'Card') {
                if (getFilterData[i]['name'] != null) {
                  cardChartTitle = chartType![ik].kpiTitle;

                  cardChartData.add(CardChart(
                    name: getFilterData[i]['name'].toString(),
                    value: getFilterData[i]['value'] != null
                        ? double.parse(getFilterData[i]['value'].toString())
                        : 0,
                  ));
                }

                for (var id = 0; id < cardChartData.length; id++) {
                  List<Color> sunsetShuffle = sunset2;
                  for (var ix = 0; ix < sunsetShuffle.length; ix++) {
                    if (ix == id) {
                      cardChartData[id].colors = sunsetShuffle[ix];
                    }
                    notifyListeners();
                  }
                }
                notifyListeners();
              }

              if (chartType![ik].chartType.toString() == 'Pie_Chart') {
                if (getFilterData[i]['name'] != null &&
                    getFilterData[i]['value'] != null &&
                    double.parse(getFilterData[i]['value'].toString()) != 0) {
                  pieChartTitle = chartType![ik].kpiTitle;

                  pieChartDataBiding(getFilterData[i]['name'].toString(),
                      double.parse(getFilterData[i]['value'].toString()));
                  notifyListeners();
                }
              }
              notifyListeners();
              if (chartType![ik].chartType.toString() == 'Bar_Chart') {
                if (getFilterData[i]['x'] != null &&
                    getFilterData[i]['y'] != null) {
                  barChartTitle = chartType![ik].kpiTitle;

                  barChartData.add(BarChartData(
                    // 10,
                    x: getFilterData[i]['x'].toString(),
                    y: int.parse(getFilterData[i]['y'].toString()),
                  ));
                }
                notifyListeners();
              }
              List<Color> heighContrastSuffle = barchartcolors..shuffle();
              for (var ix = 0; ix < barChartData.length; ix++) {
                for (var i = 0; i < heighContrastSuffle.length; i++) {
                  if (i == ix) {
                    barChartData[ix].colors = heighContrastSuffle[i];
                  }
                }
              }
              notifyListeners();
            }

            if (chartType![ik].viewCode == 'A101') {
              if (chartType![ik].chartType.toString() == 'Card') {
                if (getFilterData[i]['name'] != null) {
                  cardChartTitle = chartType![ik].kpiTitle;

                  cardChartData.add(CardChart(
                    name: getFilterData[i]['name'].toString(),
                    value: getFilterData[i]['value'] != null
                        ? double.parse(getFilterData[i]['value'].toString())
                        : 0,
                  ));
                }

                for (var id = 0; id < cardChartData.length; id++) {
                  List<Color> sunsetShuffle = sunset2;
                  for (var ix = 0; ix < sunsetShuffle.length; ix++) {
                    if (ix == id) {
                      cardChartData[id].colors = sunsetShuffle[ix];
                    }
                    notifyListeners();
                  }
                }
                notifyListeners();
              }
              if (chartType![ik].chartType.toString() == 'Bubble_Chart') {
                if (getFilterData[i]['x'] != null &&
                    getFilterData[i]['value'] != null) {
                  bubbleChartTitle = chartType![ik].kpiTitle;

                  bubbleChartData.add(BubbleChartData(
                    name: getFilterData[i]['name'].toString(),
                    x: double.parse(getFilterData[i]['x'].toString()),
                    size: double.parse(getFilterData[i]['value'].toString()),
                    y: double.parse(getFilterData[i]['value'].toString()),
                    //  0.34,
                  ));
                }

                notifyListeners();
                List<Color> twilightSuffle = twilight..shuffle();
                for (var iz = 0; iz < bubbleChartData.length; iz++) {
                  for (var ic = 0; ic < twilightSuffle.length; ic++) {
                    if (ic == iz) {
                      bubbleChartData[iz].color = twilightSuffle[ic];
                      notifyListeners();
                    }
                    notifyListeners();
                  }
                }
              }
            }

            if (chartType![ik].viewCode == 'A102') {
              if (chartType![ik].chartType.toString() == 'Card') {
                if (getFilterData[i]['name'] != null) {
                  cardChartTitle = chartType![ik].kpiTitle;

                  cardChartData.add(CardChart(
                    name: getFilterData[i]['name'].toString(),
                    value: getFilterData[i]['value'] != null
                        ? double.parse(getFilterData[i]['value'].toString())
                        : 0,
                  ));
                }

                for (var id = 0; id < cardChartData.length; id++) {
                  List<Color> sunsetShuffle = sunset2;
                  for (var ix = 0; ix < sunsetShuffle.length; ix++) {
                    if (ix == id) {
                      cardChartData[id].colors = sunsetShuffle[ix];
                    }
                    notifyListeners();
                  }
                }
                notifyListeners();
              }
              if (chartType![ik].chartType.toString() == 'Column_Chart') {
                if (getFilterData[i]['name'] != null &&
                    getFilterData[i]['x'] != null &&
                    getFilterData[i]['y'] != null) {
                  columnChartTitle = chartType![ik].kpiTitle;

                  columnChartData.add(ColumnChartData(
                    double.parse(getFilterData[i]['x'].toString()),
                    double.parse(getFilterData[i]['y'].toString()),
                    getFilterData[i]['name'].toString(),
                  ));
                }
              }
              if (chartType![ik].chartType.toString() == 'Line_Chart') {
                if (getFilterData[i]['x'] != null &&
                    getFilterData[i]['y'] != null) {
                  lineChartTitle = chartType![ik].kpiTitle;

                  lineChartData.add(LineChartData(
                    x: getFilterData[i]['x'].toString(),
                    y: double.parse(getFilterData[i]['y'].toString()),
                  ));
                }
                List<Color> colorblindSafeSuffle = colorblindSafe..shuffle();
                for (var im = 0; im < lineChartData.length; im++) {
                  for (var iv = 0; iv < colorblindSafeSuffle.length; iv++) {
                    if (iv == im) {
                      lineChartData[im].colors = colorblindSafeSuffle[iv];
                      notifyListeners();
                    } else if (im > iv) {
                      lineChartData[im].colors = const Color(0xFF480091);
                      notifyListeners();
                    }
                  }
                  notifyListeners();
                }
                notifyListeners();
              }

              if (chartType![ik].chartType.toString() == 'Spline_Chart') {
                if (getFilterData[i]['x'] != null &&
                    getFilterData[i]['y'] != null) {
                  splineChartTitle = chartType![ik].kpiTitle;
                  splineChartData.add(SplineChartData(
                    getFilterData[i]['x'].toString(),
                    int.parse(getFilterData[i]['y'].toString()),
                  ));
                  notifyListeners();
                }

                notifyListeners();
              }
            }
            if (chartType![ik].viewCode == 'A103') {
              tableColumLoad = true;
              if (chartType![ik].chartType.toString() == 'Card') {
                if (getFilterData[i]['name'] != null) {
                  cardChartTitle = chartType![ik].kpiTitle;
                  cardChartData.add(CardChart(
                    name: getFilterData[i]['name'].toString(),
                    value: getFilterData[i]['value'] != null
                        ? double.parse(getFilterData[i]['value'].toString())
                        : 0,
                  ));
                }

                notifyListeners();

                for (var id = 0; id < cardChartData.length; id++) {
                  List<Color> sunsetShuffle = sunset2;
                  for (var ix = 0; ix < sunsetShuffle.length; ix++) {
                    if (ix == id) {
                      cardChartData[id].colors = sunsetShuffle[ix];
                    }
                    notifyListeners();
                  }
                }
              }
              if (chartType![ik].chartType.toString() == 'Table') {
                tableChartTitle = chartType![ik].kpiTitle;

                tablercolumn.add({
                  "LeadId": getFilterData[i]['LeadId'],
                  "LeadDate": getFilterData[i]['LeadDate'] != null
                      ? config
                          .alignDate(getFilterData[i]['LeadDate'].toString())
                      : '',
                  "CustomerName": getFilterData[i]['CustomerName'],
                  "CustomerMobile": getFilterData[i]['CustomerMobile'],
                  "PurchasePlan":
                      getFilterData[i]['NextFollowupDate'].toString().isNotEmpty
                          ? config.alignDate(
                              getFilterData[i]['PurchasePlan'].toString())
                          : '',
                  "NextFollowupDate":
                      getFilterData[i]['NextFollowupDate'].toString().isNotEmpty
                          ? config.alignDate(
                              getFilterData[i]['NextFollowupDate'].toString())
                          : '',
                  "Status": getFilterData[i]['Status'],
                  "LastFollowupStatus": getFilterData[i]['LastFollowupStatus'],
                  "LastFollowupDate":
                      getFilterData[i]['LastFollowupDate'].toString().isNotEmpty
                          ? config.alignDate(
                              getFilterData[i]['LastFollowupDate'].toString())
                          : '',
                  "ItemName": getFilterData[i]['ItemName'],
                  "Brand": getFilterData[i]['Brand'],
                  "Category": getFilterData[i]['Category'],
                  "SubCategory": getFilterData[i]['SubCategory'],
                  "LeadValue": Config.k_m_b_generator22(
                      getFilterData[i]['LeadValue'].toString()),
                });

                notifyListeners();
              }
              if (tablercolumn.isNotEmpty) {
                tablercolumn.sort((a, b) => b['LeadId'].compareTo(a['LeadId']));
              }
              // log('tablercolumn::${tablercolumn.length}');

              tableColumLoad = false;
              notifyListeners();
            }
            // if (chartType![ik].rowCode.toString() == '3') {
            //   if (getFilterData[i]['x'] != null &&
            //       getFilterData[i]['y'] != null) {
            //     lineChartData.add(LineChartData(
            //         getFilterData[i]['x'].toString(),
            //         double.parse(getFilterData[i]['y'].toString()),
            //         Colors.blue));
            //   }
            //   notifyListeners();
            // }
            // if (chartType![ik].rowCode.toString() == '4') {
            //   if (getFilterData[i]['x'] != null &&
            //       getFilterData[i]['y'] != null) {
            //     splineChartData.add(SplineChartData(
            //       getFilterData[i]['x'].toString(),
            //       int.parse(getFilterData[i]['y'].toString()),
            //     ));
            //     notifyListeners();
            //   }
            //   notifyListeners();
            // }
          }
          notifyListeners();
          onTapDateRange = false;
        }
        // else {
        //   kpilottie = 'Assets/no-data.png';
        //   reportexp = "No Data Found..!!";
        //   notifyListeners();
        // }
        notifyListeners();
      }
    } else {
      onTapDateRange = false;
    }
    notifyListeners();
  }

  // List<piechartColors> piechartDataClr = [];

  Color getBubbleColor(String name) {
    switch (name) {
      case 'Comparing Online':
        return const Color(0xFF074650);
      case 'Design Send to Customer':
        return const Color(0xFF009292);
      case 'New Lead':
        return const Color(0xFFC83D95);
      case 'Stock on Order':
        return const Color(0xFFFEB5DA);
      case 'Under Finance Process':
        return const Color(0xFF480091);
      case 'Under followup':
        return const Color(0xFFB66DFF);
      case 'start Design':
        return const Color(0xFFB5DAFE);
      default:
        return const Color(0xFF6DB6FF);
    }
  }

  Color getLineChartColor(
    LineChartData lineData,
  ) {
    // #074650	#009292	#FE6DB6	#FEB5DA	#480091	#B66DFF	#B5DAFE	#6DB6FF
    switch (lineData.x) {
      case 'Bulk':
        return const Color(0xFF074650);
      case 'Dealer':
        return const Color(0xFF009292);
      case 'Other':
        return const Color(0xFFFE6DB6);
      case 'Project':
        return const Color(0xFFFEB5DA);
      case 'Recurring':
        return const Color(0xFF480091);
      case 'Retail':
        return const Color(0xFFB66DFF);
      default:
        return const Color(0xFFB5DAFE);
    }
  }

  clearfilterval() {
    for (var i = 0; i < rTestListItem2.length; i++) {
      for (var ik = 0; ik < rTestListItem2[i].itemNamer.length; ik++) {
        rTestListItem2[i].itemNamer[ik].isCheckbox = false;
      }
    }
    searchcontroller.text = '';
    selectedStoreCd = [];
    selectedDateRange = null;
    selectedassignto = [];
    currentRangeValues =
        RangeValues(minSelectedAmount = minValuesAmount, maxValuesAmount);
    maxSelectedAmount = 0;
    minSelectedAmount = 0;
    myDatecontroller = List.generate(25, (i) => TextEditingController());
    maxSelectedAmount = maxValuesAmount;
    minSelectedAmount = minValuesAmount;
    dropdownValue = null;
    chooseTitle = '';
    tapTitle = [];
    assignvalue = '';
    storeCodeVal = '';
    lookingforvalue = null;
    lookingforvalue22 = [];
    ordertypevalue = null;
    storeCodeVal = null;
    assignvalue = null;
    cusnamevalue = null;
    islookingfor = false;
    selectedlookingfor.clear();
    isenqstatus = false;
    selectedenqstatus.clear();
    selectedcusgoup.clear();
    iscusgroup = false;
    isassignto = false;
    isorder = false;
    isinterest = false;
    selectedinterest.clear();
    selectedorder.clear();
    selectedassignto.clear();
    enquirystatusvalue = null;
    lookingforvalue = null;
    ordertypevalue = null;
    interestlevelvalue = null;
    lookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();

    notifyListeners();
  }

  isselectRange(int i, String rangeType, BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncateLeadViewDB(db);
    await DBOperation.truncateLeadQueryDB(db);
    await DBOperation.truncateLeadAnalysisDB(db);
    await DBOperation.truncateLeadReportDB(db);
    await DBOperation.truncateTestLeadReportDB(db);
    kpilottie = null;
    reportexp = null;
    leadAnalysismasterDataset2 = [];

    for (int j = 0; j < dateRange.length; j++) {
      if (j == i) {
        dateRange[j].color = 1;
      } else {
        dateRange[j].color = 0;
      }
    }
    qryStartDate = '';
    qryEndDate = '';
    pieChartData = [];
    selectedDateRange = null;
    lineChartData = [];
    barChartData = [];
    bubbleChartData = [];
    cardChartData = [];
    tablercolumn = [];
    splineChartData = [];
    leadRerportQueryData = [];
    columnChartData = [];
    insertTestValues = [];
    rTestListItem2 = [];
    leadAnalysisReportDataset = [];
    leadRerportViewData = [];
    leadRerportQueryData = [];
    leadTablViewData = [];
    leadTableQueryData = [];
    minValuesAmount = 0;
    maxValuesAmount = 0;
    minSelectedAmount = 0;
    maxSelectedAmount = 0;
    visibleSelectedDate = false;
    startDate = '';
    endDate = '';
    allColorsData();
    if (rangeType.contains('Week')) {
      String startDate2 =
          config.findFirstDateOfTheWeek2(DateTime.now()).toString();
      String endDate2 =
          config.findLastDateOfTheWeek2(DateTime.now()).toString();
      qryStartDate = startDate2;
      qryEndDate = endDate2;
      startDate = config
          .alignDate(config.findFirstDateOfTheWeek(DateTime.now()).toString());
      endDate = config
          .alignDate(config.findLastDateOfTheWeek(DateTime.now()).toString());

      NewLeadAnalysisApi.fromDate = startDate2;
      NewLeadAnalysisApi.endDate = endDate2;
      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          if (value.datadetail != null &&
              value.datadetail!.leadMasterData.isNotEmpty) {
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;
            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;

            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);

            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                  docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                  reportCode: viewResult[iv]['ReportCode'].toString(),
                  viewName: viewResult[iv]['ViewName'].toString(),
                  viewCode: viewResult[iv]['ViewCode'].toString(),
                ));
              }
              notifyListeners();
            }
            if (queryResult.isNotEmpty) {
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
              notifyListeners();
            }
            // await DBOperation.insertLeadReportDBData(
            //     leadAnalysisReportDataset, db);
            await splitFilterData();
            // await initialDataLoading();
            await onfilterapply();

            List<Map<String, Object?>> result =
                await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate),
                    alignYYMMDD(endDate), leadAnalysisTable, 'CreatedDate');
            // rangeFilterGetData(result);
            notifyListeners();
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            kpilottie = 'Assets/no-data.png';
            onTapDateRange = false;
            reportexp = "No Data Found..!!";
            notifyListeners();
          }
        }
      else  if (value.stcode! <= 410 && value.stcode! >= 400) {
          errormsg = value.respDesc.toString();
          notifyListeners();
        }else{
          if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }
      });
      visibleSelectedDate = true;

      notifyListeners();
      chartload = false;
    } else if (rangeType.contains('Month')) {
      String startDate2 = config
          .findFirstDateOfTheMonth2(DateTime.now())
          .toString()
          .replaceAll('.000', '');
      String endDate2 = config
          .findLastDateOfTheMonth2(DateTime.now())
          .toString()
          .replaceAll('.000', '');
      startDate = config
          .alignDate(config.findFirstDateOfTheMonth(DateTime.now()).toString());
      endDate = config
          .alignDate(config.findLastDateOfTheMonth(DateTime.now()).toString());
      qryStartDate = startDate2;
      qryEndDate = endDate2;
      NewLeadAnalysisApi.fromDate = startDate2;
      NewLeadAnalysisApi.endDate = endDate2;
      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          if (value.datadetail != null &&
              value.datadetail!.leadMasterData.isNotEmpty) {
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;
            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;
            // log('leadAnalysismasterDataset2 length::${leadAnalysismasterDataset2.length}');

            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            await DBOperation.insertLeadReportDBData(
                leadAnalysisReportDataset, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);
            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              leadTablViewData = [];
              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                    docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                    reportCode: viewResult[iv]['ReportCode'].toString(),
                    viewName: viewResult[iv]['ViewName'].toString(),
                    viewCode: viewResult[iv]['ViewCode'].toString()));
              }
            }
            if (queryResult.isNotEmpty) {
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
            }

            await splitFilterData();
            // await initialDataLoading();
            await onfilterapply();

            List<Map<String, Object?>> result =
                await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate!),
                    alignYYMMDD(endDate!), leadAnalysisTable, 'CreatedDate');
            // rangeFilterGetData(result);
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            kpilottie = 'Assets/no-data.png';
            onTapDateRange = false;
            reportexp = "No Data Found..!!";
            notifyListeners();
          }
        }else{
           if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }
      });
      chartload = false;
      visibleSelectedDate = true;
      notifyListeners();
    } else if (rangeType.contains('Year')) {
      startDate = config
          .alignDate(config.findFirstDateOfTheYear(DateTime.now()).toString());
      endDate = config
          .alignDate(config.findLastDateOfTheYear(DateTime.now()).toString());
      print("StartEnd Date:$startDate$endDate");

      String startDate2 =
          config.findFirstDateOfTheYear2(DateTime.now()).toString();
      String endDate2 =
          config.findLastDateOfTheYear2(DateTime.now()).toString();
      qryStartDate = startDate2;
      qryEndDate = endDate2;
      print("StartEnd2 Date:$startDate2::$endDate2");
      NewLeadAnalysisApi.fromDate = startDate2;
      NewLeadAnalysisApi.endDate = endDate2;
      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          if (value.datadetail != null &&
              value.datadetail!.leadMasterData.isNotEmpty) {
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;

            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;
            // log('leadAnalysismasterDataset2 length::${leadAnalysismasterDataset2.length}');

            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            await DBOperation.insertLeadReportDBData(
                leadAnalysisReportDataset, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);
            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              leadTablViewData = [];

              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                    docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                    reportCode: viewResult[iv]['ReportCode'].toString(),
                    viewName: viewResult[iv]['ViewName'].toString(),
                    viewCode: viewResult[iv]['ViewCode'].toString()));
              }
            }
            if (queryResult.isNotEmpty) {
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
            }
            await splitFilterData();
            // await initialDataLoading();
            await onfilterapply();

            List<Map<String, Object?>> result =
                await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate!),
                    alignYYMMDD(endDate!), leadAnalysisTable, 'CreatedDate');
            // rangeFilterGetData(result);
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            kpilottie = 'Assets/no-data.png';
            reportexp = "No Data Found..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }else{
          if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            onTapDateRange = false;
            notifyListeners();
          }
           
        }
      });
      chartload = false;
      visibleSelectedDate = true;
      notifyListeners();
    } else if (rangeType.contains('Qtr')) {
      startDate =
          config.alignDate(config.getStartOfQuarter(DateTime.now()).toString());
      endDate =
          config.alignDate(config.getEndOfQuarter(DateTime.now()).toString());

      String startDate2 = config.getStartOfQuarterd2(DateTime.now()).toString();
      String endDate2 = config.getEndOfQuarter2(DateTime.now()).toString();
      qryStartDate = startDate2;
      qryEndDate = endDate2;
      print("StartEnd Date:$startDate2::$endDate2");
      NewLeadAnalysisApi.fromDate = startDate2;
      NewLeadAnalysisApi.endDate = endDate2;
      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          if (value.datadetail != null &&
              value.datadetail!.leadMasterData.isNotEmpty) {
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;
            // log('leadAnalysismasterDataset2 length::${leadAnalysismasterDataset2.length}');

            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;
            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            await DBOperation.insertLeadReportDBData(
                leadAnalysisReportDataset, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);
            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              leadTablViewData = [];

              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                    docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                    reportCode: viewResult[iv]['ReportCode'].toString(),
                    viewName: viewResult[iv]['ViewName'].toString(),
                    viewCode: viewResult[iv]['ViewCode'].toString()));
              }
            }
            if (queryResult.isNotEmpty) {
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
            }
            await splitFilterData();
            // await initialDataLoading();
            await onfilterapply();

            List<Map<String, Object?>> result =
                await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate!),
                    alignYYMMDD(endDate!), leadAnalysisTable, 'CreatedDate');
            // rangeFilterGetData(result);
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            kpilottie = 'Assets/no-data.png';
            reportexp = "No Data Found..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }else{
          if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }
      });
      chartload = false;

      visibleSelectedDate = true;
    } else if (rangeType.contains('Today')) {
      String startDate2 = config.alignTodayDate2(DateTime.now().toString());
      String endDate2 = config.alignTodayDate2(DateTime.now().toString());

      startDate = config.alignDate(DateTime.now().toString());
      endDate = config.alignDate(DateTime.now().toString());
      qryStartDate = config.currentQueryDateOnly(startDate2);
      qryEndDate = config.currentQueryDateOnly(endDate2);
      visibleSelectedDate = true;
      NewLeadAnalysisApi.fromDate = startDate2.toString();
      NewLeadAnalysisApi.endDate = endDate2.toString();
      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          if (value.datadetail != null &&
              value.datadetail!.leadMasterData.isNotEmpty) {
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;

            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;
            // log('leadAnalysismasterDataset2 length::${leadAnalysismasterDataset2.length}');

            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            await DBOperation.insertLeadReportDBData(
                leadAnalysisReportDataset, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);
            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                    docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                    reportCode: viewResult[iv]['ReportCode'].toString(),
                    viewName: viewResult[iv]['ViewName'].toString(),
                    viewCode: viewResult[iv]['ViewCode'].toString()));
              }
            }
            if (queryResult.isNotEmpty) {
              leadTableQueryData = [];
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
            }
            await splitFilterData();
            // await initialDataLoading();
            await onfilterapply();

            List<Map<String, Object?>> result =
                await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate),
                    alignYYMMDD(endDate), leadAnalysisTable, 'CreatedDate');
            // rangeFilterGetData(result);
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            kpilottie = 'Assets/no-data.png';
            reportexp = "No Data Found..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }else{
          if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }
      });
      chartload = false;
      visibleSelectedDate = true;
    } else if (rangeType.contains('Yesterday')) {
      startDate = config.alignDate(
          config.findFirstDateOfYesterDay(DateTime.now()).toString());
      endDate = config.alignDate(
          config.findFirstDateOfYesterDay(DateTime.now()).toString());
      String startDate2 =
          config.findFirstDateOfYesterDay2(DateTime.now()).toString();
      String endDate2 =
          config.findFirstDateOfYesterDay2(DateTime.now()).toString();

      qryStartDate = config.currentQueryDateOnly(startDate2);
      qryEndDate = config.currentQueryDateOnly(endDate2);
      visibleSelectedDate = true;
      print("StartEnd Date:$startDate$endDate");

      NewLeadAnalysisApi.fromDate = startDate2.toString();
      NewLeadAnalysisApi.endDate = endDate2.toString();
      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          if (value.datadetail != null &&
              value.datadetail!.leadMasterData.isNotEmpty) {
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;
            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;
            // log('leadAnalysismasterDataset2 length::${leadAnalysismasterDataset2.length}');

            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            await DBOperation.insertLeadReportDBData(
                leadAnalysisReportDataset, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);
            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              leadTablViewData = [];
              onTapDateRange = true;

              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                    docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                    reportCode: viewResult[iv]['ReportCode'].toString(),
                    viewName: viewResult[iv]['ViewName'].toString(),
                    viewCode: viewResult[iv]['ViewCode'].toString()));
              }
            }
            if (queryResult.isNotEmpty) {
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
            }
            await splitFilterData();

            // await initialDataLoading();
            await onfilterapply();

            List<Map<String, Object?>> result =
                await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate!),
                    alignYYMMDD(endDate), leadAnalysisTable, 'CreatedDate');
            // rangeFilterGetData(result);
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            onTapDateRange = false;
            kpilottie = 'Assets/no-data.png';
            reportexp = "No Data Found..!!";
            notifyListeners();
          }
        }else{
          if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }
      });
      chartload = false;

      visibleSelectedDate = true;
      notifyListeners();
    } else if (rangeType.contains('Custom')) {
      await datePicker(context, 'Custom', 0);
      // await showDialog<dynamic>(
      //     barrierDismissible: true,
      //     context: context,
      //     builder: (_) {
      //       return SelectionDatePicker(
      //           // reportsCnt: reportCon,
      //           );
      //     }).then((value) {
      //   if (startDate!.isNotEmpty && endDate!.isNotEmpty) {
      //     visibleSelectedDate = true;
      //   }
      // });
      String startDate2 = config.alignTodayDate2(custmStartDate.toString());
      String endDate2 = config.alignTodayDate2(custmEndDate.toString());
      // log("StartEnd Date2:$custmStartDate:::$custmEndDate");

      NewLeadAnalysisApi.fromDate = startDate2.toString();
      NewLeadAnalysisApi.endDate = endDate2.toString();
      qryStartDate = config.currentQueryDateOnly(startDate2);
      qryEndDate = config.currentQueryDateOnly(endDate2);

      await NewLeadAnalysisApi.getdata().then((value) async {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          if (value.datadetail != null &&
              value.datadetail!.leadMasterData.isNotEmpty) {
            progress = false;
            leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
            leadAnalysisReportDataset = value.datadetail!.leadReportData;
            leadRerportViewData = value.datadetail!.leadViewData;
            leadRerportQueryData = value.datadetail!.leadQueryData;
            // log('leadAnalysismasterDataset2 length::${leadAnalysismasterDataset2.length}');

            await DBOperation.insertLeadAnalysisDBData(
                leadAnalysismasterDataset2, db);
            // await DBOperation.insertLeadReportDBData(
            //     leadAnalysisReportDataset, db);
            await DBOperation.insertLeadViewDBData(leadRerportViewData, db);
            await DBOperation.insertLeadQueryDBData(leadRerportQueryData, db);
            List<Map<String, Object?>> viewResult =
                await DBOperation.getLeadViewColumn(db);
            List<Map<String, Object?>> queryResult =
                await DBOperation.getLeadQueryColumn(db);
            if (viewResult.isNotEmpty) {
              leadTablViewData = [];

              for (var iv = 0; iv < viewResult.length; iv++) {
                leadTablViewData.add(LeadAnalysisViewData(
                    docEntry: int.parse(viewResult[iv]['DocEntry'].toString()),
                    reportCode: viewResult[iv]['ReportCode'].toString(),
                    viewName: viewResult[iv]['ViewName'].toString(),
                    viewCode: viewResult[iv]['ViewCode'].toString()));
              }
            }
            if (queryResult.isNotEmpty) {
              for (var ib = 0; ib < queryResult.length; ib++) {
                leadTableQueryData.add(LeadReportQueryData(
                    chartType: queryResult[ib]['ChartType'].toString(),
                    rowCode: int.parse(queryResult[ib]['RowCode'].toString()),
                    queryExt: queryResult[ib]['QueryExt'].toString(),
                    kpiTitle: queryResult[ib]['KPITitle'].toString(),
                    leadQuery: queryResult[ib]['Query'].toString(),
                    viewCode: queryResult[ib]['ViewCode'].toString()));
              }
              // await initialDataLoading();
              await splitFilterData();

              await onfilterapply();
            }
            List<Map<String, Object?>> result =
                await DBOperation.getRangeWiseData(db, alignYYMMDD(startDate!),
                    alignYYMMDD(endDate!), leadAnalysisTable, 'CreatedDate');
            // rangeFilterGetData(result);
          } else if (value.datadetail!.leadMasterData.isEmpty) {
            onTapDateRange = false;
            kpilottie = 'Assets/no-data.png';
            reportexp = "No Data Found..!!";
            notifyListeners();
          }
          notifyListeners();
        }else{
          if(value.exception!.contains("Network is unreachable")){
kpilottie = 'Assets/network-signal.png';
            reportexp = "Network Issue..\nTry again Later..!!";
            onTapDateRange = false;
            notifyListeners();
          }
        }
      });
      chartload = false;
      visibleSelectedDate = true;
      notifyListeners();

      // List<Map<String, Object?>> result = await DBOperation.getRangeWiseData(
      //     db,
      //     alignYYMMDD(startDate!),
      //     alignYYMMDD(endDate!),
      //     leadAnalysisTable,
      //     'CreatedDate');
      // rangeFilterGetData(result);
    } else {
      chartload = false;
      visibleSelectedDate = true;
      startDate = '';
      endDate = '';
      onTapDateRange = false;
    }
    notifyListeners();
  }

  String alignYYMMDD(String date) {
    if (date.isEmpty) {
      return '0000-00-00';
    } else {
      DateFormat originalFormat = DateFormat('dd-MM-yyyy');

      // Parse the original date
      DateTime originalDate = originalFormat.parse(date);
      DateFormat outputFormat = DateFormat('yyyy-MM-dd');

      // Format the date with the desired output format
      String formattedDate = outputFormat.format(originalDate);
      print(formattedDate);
      return formattedDate;
    }
  }

  tablerColumn() {
    double totalVal = 0;
    tablercolumn = [];
    pieChartData = [];
    for (int i = 0; i < rangeFilterDBData.length; i++) {
      tablercolumn.add({
        "LeadId": rangeFilterDBData[i].leadId,
        "LeadDate": rangeFilterDBData[i].leadDate.isNotEmpty
            ? config.alignDate(rangeFilterDBData[i].leadDate)
            : rangeFilterDBData[i].leadDate,
        "CustomerCode": rangeFilterDBData[i].customerCode,
        "CustomerName": rangeFilterDBData[i].customerName,
        "CustomerMobile": rangeFilterDBData[i].customerMobile,
        "CustomerEmail": rangeFilterDBData[i].customerEmail,
        "CompanyName": rangeFilterDBData[i].companyName,
        "CustomerGroup": rangeFilterDBData[i].customerGroup,
        "StoreCode": rangeFilterDBData[i].storeCode,
        "StoreName": rangeFilterDBData[i].storeName,
        "Address1": rangeFilterDBData[i].address1,
        "Address2": rangeFilterDBData[i].address2,
        "Area": rangeFilterDBData[i].area,
        "City": rangeFilterDBData[i].city,
        "District": rangeFilterDBData[i].district,
        "State": rangeFilterDBData[i].state,
        "Country": rangeFilterDBData[i].country,
        "Pincode": rangeFilterDBData[i].pincode,
        "Gender": rangeFilterDBData[i].gender,
        "AgeGroup": rangeFilterDBData[i].ageGroup,
        "CameAs": rangeFilterDBData[i].cameAs,
        "Headcount": rangeFilterDBData[i].headcount,
        "Maxbudget": rangeFilterDBData[i].maxbudget,
        "AssignedTo": rangeFilterDBData[i].assignedTo,
        "Refferal": rangeFilterDBData[i].refferal,
        "InterestLevel": rangeFilterDBData[i].interestLevel,
        "OrderType": rangeFilterDBData[i].orderType,
        "PurchasePlan": config.alignDate(rangeFilterDBData[i].purchasePlan),
        "NextFollowupDate": rangeFilterDBData[i].nextFollowupDate.isNotEmpty
            ? config.alignDate(rangeFilterDBData[i].nextFollowupDate)
            : rangeFilterDBData[i].nextFollowupDate,
        "DealDescription": rangeFilterDBData[i].dealDescription,
        "Status": rangeFilterDBData[i].status,
        "LastFollowupStatus": rangeFilterDBData[i].lastFollowupStatus,
        "LastFollowupDate": rangeFilterDBData[i].lastFollowupDate.isNotEmpty
            ? config.alignDate(rangeFilterDBData[i].lastFollowupDate)
            : rangeFilterDBData[i].lastFollowupDate,
        "ItemCode": rangeFilterDBData[i].itemCode,
        "ItemName": rangeFilterDBData[i].itemName,
        "Brand": rangeFilterDBData[i].brand,
        "Category": rangeFilterDBData[i].category,
        "SubCategory": rangeFilterDBData[i].subCategory,
        "LeadValue": rangeFilterDBData[i].leadValue,
        "CreatedBy": rangeFilterDBData[i].createdBy,
        "CreatedDate": rangeFilterDBData[i].createdDate.isNotEmpty
            ? config.alignDate(rangeFilterDBData[i].createdDate)
            : rangeFilterDBData[i].createdDate,
        "UpdatedBy": rangeFilterDBData[i].updatedBy,
        "UpdatedDate": rangeFilterDBData[i].updatedDate.isNotEmpty
            ? config.alignDate(rangeFilterDBData[i].updatedDate)
            : rangeFilterDBData[i].updatedDate,
        "TraceId": rangeFilterDBData[i].traceId,
        "CustomerCreatedOn": rangeFilterDBData[i].customerCreatedOn
      });
      // pieChartDataBiding(rangeFilterDBData[i].refferal,);
    }
    totalVal = 0;

    for (int j = 0; j < pieChartData.length; j++) {
      totalVal = totalVal + pieChartData[j].value;
      double percentage = pieCtCal(
        totalVal,
        // pieChartData[j].value,
      );
      pieChartData[j].percentage = percentage;
    }
    tableColumLoad = false;
    notifyListeners();
  }

  // pieChartDataBiding(
  //   String valueName,
  //   double leadValue,
  // ) async {
  //   if (pieChartData.isEmpty) {
  //     pieChartData.add(PieChartData(valueName, 1, 0));
  //   } else {
  //     String name = '';
  //     for (int i = 0; i < pieChartData.length; i++) {
  //       if (valueName == pieChartData[i].valueName) {
  //         name = pieChartData[i].valueName;

  //         pieChartData[i] =
  //             PieChartData(valueName, pieChartData[i].value + 1, 0);
  //       }
  //     }
  //     if (name.isEmpty) {
  //       pieChartData.add(PieChartData(valueName, 1, 0));
  //     }
  //   }
  // }

  pieChartDataBiding(
    String valueName,
    double leadValue,
  ) async {
    if (pieChartData.isEmpty) {
      pieChartData.add(PieChartData(
        valueName,
        leadValue,
        0,
        1,
      ));
    } else {
      String name = '';
      for (int i = 0; i < pieChartData.length; i++) {
        if (valueName == pieChartData[i].valueName) {
          name = pieChartData[i].valueName;
          pieChartData[i] = PieChartData(
              valueName, leadValue, 0, pieChartData[i].valueCount + 1);
        }
      }

      if (name.isEmpty) {
        pieChartData.add(PieChartData(valueName, leadValue, 0, 1));
      }
    }
    double totalVal = 0;
    if (pieChartData.isNotEmpty) {
      for (int j = 0; j < pieChartData.length; j++) {
        totalVal = totalVal + pieChartData[j].value;
      }

      pieCtCal(
        totalVal,
      );
    }

    notifyListeners();
  }

  double pieCtCal(
    double totvalue,
  ) {
    double temp = 0.0;

    for (int j = 0; j < pieChartData.length; j++) {
      temp = (pieChartData[j].value / totvalue) * 100;
      double percentage = temp;
      log(temp.toString());
      // pieChartData[j].percentage = percentage;
      // log('percentagepercentage::$percentage');
      notifyListeners();
      pieChartData[j].percentage = percentage;
    }
    return temp;
  }

  rangeFilterGetData(List<Map<String, Object?>> result) {
    chartload = true;

    //
    if (result.isNotEmpty) {
      rangeFilterDBData = [];
      // finalFilterData = [];
      for (int i = 0; i < result.length; i++) {
        rangeFilterDBData.add(LeadAnalysisMasterData(
            leadId: result[i]['LeadId'] == null
                ? 0
                : int.parse(result[i]['LeadId'].toString()),
            leadDate: result[i]['LeadDate'].toString(),
            customerCode: result[i]['CustomerCode'].toString(),
            customerName: result[i]['CustomerName'].toString(),
            customerMobile: result[i]['CustomerMobile'].toString(),
            customerEmail: result[i]['CustomerEmail'].toString(),
            companyName: result[i]['CompanyName'].toString(),
            customerGroup: result[i]['CustomerGroup'].toString(),
            storeCode: result[i]['StoreCode'].toString(),
            storeName: result[i]['StoreName'].toString(),
            address1: result[i]['Address1'].toString(),
            address2: result[i]['Address2'].toString(),
            area: result[i]['Area'].toString(),
            city: result[i]['City'].toString(),
            district: result[i]['District'].toString(),
            state: result[i]['State'].toString(),
            country: result[i]['Country'].toString(),
            pincode: result[i]['pincode'] == null
                ? 0
                : int.parse(result[i]['pincode'].toString()),
            gender: result[i]['Gender'].toString(),
            ageGroup: result[i]['AgeGroup'].toString(),
            cameAs: result[i]['CameAs'].toString(),
            headcount: result[i]['Headcount'] == null
                ? 0
                : int.parse(result[i]['Headcount'].toString()),
            maxbudget: result[i]['Maxbudget'] == null
                ? 0
                : double.parse(result[i]['Maxbudget'].toString()),
            assignedTo: result[i]['AssignedTo'].toString(),
            refferal: result[i]['Refferal'].toString(),
            interestLevel: result[i]['InterestLevel'].toString(),
            orderType: result[i]['OrderType'].toString(),
            purchasePlan: result[i]['PurchasePlan'].toString(),
            nextFollowupDate: result[i]['NextFollowupDate'].toString(),
            dealDescription: result[i]['DealDescription'].toString(),
            status: result[i]['Status'].toString(),
            lastFollowupStatus: result[i]['LastFollowupStatus'].toString(),
            lastFollowupDate: result[i]['LastFollowupDate'].toString(),
            itemCode: result[i]['ItemCode'].toString(),
            itemName: result[i]['ItemName'].toString(),
            brand: result[i]['Brand'].toString(),
            category: result[i]['Category'].toString(),
            subCategory: result[i]['SubCategory'].toString(),
            leadValue: result[i]['LeadValue'] == null
                ? 0
                : double.parse(result[i]['LeadValue'].toString()),
            createdBy: result[i]['CreatedBy'] == null
                ? 0
                : int.parse(result[i]['CreatedBy'].toString()),
            createdDate: result[i]['CreatedDate'].toString(),
            updatedBy: result[i]['UpdatedBy'] == null
                ? 0
                : int.parse(result[i]['UpdatedBy'].toString()),
            updatedDate: result[i]['UpdatedDate'].toString(),
            traceId: result[i]['TraceId'].toString(),
            customerCreatedOn: result[i]['CustomerCreatedOn'].toString()));
        // assigntoAdd(result[i]['AssignedTo'].toString());
        // groupnametoAdd(result[i]['CustomerGroup'].toString());
        // enquiryStatustoAdd(result[i]['Status'].toString());
        // intervelColumn(result[i]['InterestLevel'].toString());
        // orderColumnAdd(result[i]['OrderType'].toString());
      }
      // finalFilterData = rangeFilterDBData;
      // tablerColumn();
    } else {
      chartload = false;
    }
    chartload = false;

    // log('object${rangeFilterDBData.length}');
    notifyListeners();
  }

  assigntoAdd(String data) {
    String temp = '';
    if (assigncolumn.isEmpty) {
      assigncolumn.add(Distcolumn(
        name: data,
        listitem: [],
      ));
    } else {
      for (int i = 0; i < assigncolumn.length; i++) {
        if (assigncolumn[i].name == data) {
          temp = data;
        }
      }
      if (temp.isEmpty) {
        assigncolumn.add(Distcolumn(name: data, listitem: []));
      }
    }
  }

  groupnametoAdd(String data) {
    String temp = '';
    if (cusgroupcolumn.isEmpty) {
      cusgroupcolumn.add(Distcusgroupcolumn(name: data));
    } else {
      for (int i = 0; i < cusgroupcolumn.length; i++) {
        if (cusgroupcolumn[i].name == data) {
          temp = data;
        }
      }
      if (temp.isEmpty) {
        cusgroupcolumn.add(Distcusgroupcolumn(name: data));
      }
    }
  }

  enquiryStatustoAdd(String data) {
    String temp = '';
    if (enqstatuscolumn.isEmpty) {
      enqstatuscolumn.add(DistEnqstatuscolumn(name: data));
    } else {
      for (int i = 0; i < enqstatuscolumn.length; i++) {
        if (enqstatuscolumn[i].name == data) {
          temp = data;
        }
      }
      if (temp.isEmpty) {
        enqstatuscolumn.add(DistEnqstatuscolumn(name: data));
      }
    }
  }

  datePicker(BuildContext context, String rangeType, int i) async {
    final theme = Theme.of(context);
    log('selectedRangetype::${selectedRangetype.toString()}');
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );

    final pickedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(DateTime.now().year, 12, 31),
        initialDateRange: initialDateRange,
        // initialDateRange: initialDateRange,
        // firstDate: DateTime.now(),
        // lastDate:  DateTime.now(),
        builder: (context, Widget? child) => Theme(
              data: theme.copyWith(
                  appBarTheme: theme.appBarTheme
                      .copyWith(backgroundColor: theme.primaryColor),
                  colorScheme: ColorScheme.light(
                      onPrimary: Colors.white, primary: theme.primaryColor)),
              child: child!,
            )
        // builder: (context, child) {
        //   return SizedBox(
        //     width: MediaQuery.of(context).size.width * 0.8, // Adjust width here
        //     height:
        //         MediaQuery.of(context).size.height * 0.8, // Adjust height here
        //     child: child,
        //   );
        // },
        );

    notifyListeners();
    if (pickedDateRange != null) {
      selectedDateRange = pickedDateRange;

      if (rangeType == 'Lead Date') {
        myDatecontroller[i].text =
            '${config.alignDate(selectedDateRange!.start.toString())} to ${config.alignDate(selectedDateRange!.end.toString())}';
        mycontroller[17].text =
            '${config.alignDate(selectedDateRange!.start.toString())} to ${config.alignDate(selectedDateRange!.end.toString())}';
      }
      if (rangeType == 'Custom') {
        custmStartDate = selectedDateRange!.start.toString();
        custmEndDate = selectedDateRange!.end.toString();
        startDate = config.alignDate(selectedDateRange!.start.toString());
        endDate = config.alignDate(selectedDateRange!.end.toString());

        notifyListeners();
      }
      notifyListeners();
    }

    notifyListeners();
  }

  DateTimeRange dateRange2 = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  Future pickDateRange(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange2,
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
    );
    dateRange2 = newDateRange ?? dateRange2;
    notifyListeners();
  }

  orderColumnAdd(String data) {
    String temp = '';
    if (ordercolumn.isEmpty) {
      ordercolumn.add(Distordercolumn(name: data));
    } else {
      for (int i = 0; i < ordercolumn.length; i++) {
        if (ordercolumn[i].name == data) {
          temp = data;
        }
      }
      if (temp.isEmpty) {
        ordercolumn.add(Distordercolumn(name: data));
      }
    }
  }

  RangeValues? currentRangeValues = const RangeValues(0, 100);
  double minValuesAmount = 0;
  double maxValuesAmount = 0;
  double minSelectedAmount = 0;
  double maxSelectedAmount = 0;
  // leadValColumnAdd(double data) {
  //   minValuesAmount = 0;
  //   maxValuesAmount = 0;
  //   String temp = '';
  //   if (leadValColumn.isEmpty) {
  //     leadValColumn.add(DistLeadValColumn(name: data));
  //   } else {
  //     for (int i = 0; i < leadValColumn.length; i++) {
  //       if (leadValColumn[i].name == data) {
  //         temp = data.toString();
  //       }
  //       // log('leadValColumn lngth::${leadValColumn[i].name}');
  //     }
  //     if (temp.isEmpty) {
  //       leadValColumn.add(DistLeadValColumn(name: data));
  //     }
  //   }

  //   final mapWithBiggestCaseNumber =
  //       leadValColumn.reduce((a, b) => a.name > b.name ? a : b);
  //   // log("mapWithBiggestCaseNumber::" +
  //   //     mapWithBiggestCaseNumber.name.toString());
  //   final mapWithLowestCaseNumber =
  //       leadValColumn.reduce((a, b) => a.name < b.name ? a : b);
  //   // log("mapWithLowestCaseNumber::" + mapWithLowestCaseNumber.name.toString());

  //   currentRangeValues = RangeValues(
  //       mapWithLowestCaseNumber.name, mapWithBiggestCaseNumber.name);
  //   minValuesAmount = mapWithLowestCaseNumber.name;
  //   maxValuesAmount = mapWithBiggestCaseNumber.name;
  // }

  // leadDateColumnAdd(String data) {
  //   String temp = '';
  //   if (leadDateColumn.isEmpty) {
  //     leadDateColumn.add(DistLeadDateColumn(name: data));
  //   } else {
  //     for (int i = 0; i < leadDateColumn.length; i++) {
  //       if (leadDateColumn[i].name == data) {
  //         temp = data;
  //       }
  //     }
  //     if (temp.isEmpty) {
  //       leadDateColumn.add(DistLeadDateColumn(name: data));
  //     }
  //   }
  // }

  leadFolwDtColumnAdd(String data) {
    String temp = '';
    if (nextFollowDtColumn.isEmpty) {
      nextFollowDtColumn.add(DistNextFColumn(name: data));
    } else {
      for (int i = 0; i < nextFollowDtColumn.length; i++) {
        if (nextFollowDtColumn[i].name == data) {
          temp = data;
        }
      }
      if (temp.isEmpty) {
        nextFollowDtColumn.add(DistNextFColumn(name: data));
      }
    }
  }

  intervelColumn(String data) {
    String temp = '';
    if (intlevelcolumn.isEmpty) {
      intlevelcolumn.add(Distlevelcolumn(name: data));
    } else {
      for (int i = 0; i < intlevelcolumn.length; i++) {
        if (intlevelcolumn[i].name == data) {
          temp = data;
        }
      }
      if (temp.isEmpty) {
        intlevelcolumn.add(Distlevelcolumn(name: data));
      }
    }
  }

  selectedDatePickerValue(DateTime? startDt, DateTime? endDt) {
    // log('Test1 $startDt');
    // log('Test2 $endDt');

    if (startDt != null && endDt != null) {
      //  String chooseddate = startDt.toString();
      //   var date = DateTime.parse(chooseddate);
      //   chooseddate = "";
      //   chooseddate =
      //       "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      //   startDate = chooseddate;

      //commanded by sharmi
      custmStartDate = startDt.toString();
      custmEndDate = endDt.toString();
      startDate = config.alignDate(startDt.toString());
      endDate = config.alignDate(endDt.toString());

      notifyListeners();
    }
  }

  bool visibleSelectedDate = false;
  onSubmitDatePicker() {
    if (startDate!.isNotEmpty && endDate!.isNotEmpty) {
      visibleSelectedDate = true;
    }
  }

  // openCustomrange(String rangeType, BuildContext context,
  //     ReportsController reportCon) async {
  //   if (rangeType.contains('Custom')) {
  //     visibleSelectedDate = false;
  //     startDate = '';
  //     endDate = '';
  //     await showDialog<dynamic>(
  //         barrierDismissible: true,
  //         context: context,
  //         builder: (_) {
  //           return SelectionDatePicker(
  //             reportsCnt: reportCon,
  //           );
  //         }).then((value) {
  //       if (startDate!.isNotEmpty && endDate!.isNotEmpty) {
  //         visibleSelectedDate = true;
  //       }
  //     });
  //   } else {
  //     visibleSelectedDate = false;
  //     startDate = '';
  //     endDate = '';
  //   }
  //   notifyListeners();
  // }

  Future renderPDF(dynamic data) async {
    List<int> imageBytes = [];

    imageBytes = await _readImageData(data);
    // }
    // final List<int> imageBytes = await _readImageData();
    final PdfBitmap bitmap = PdfBitmap(imageBytes);
    final PdfDocument document = PdfDocument();
    document.pageSettings.size =
        Size(bitmap.width.toDouble(), bitmap.height.toDouble());
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();
    page.graphics.drawImage(
        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    final List<int> bytes = document.saveSync();
    document.dispose();
    //Get external storage directory
    final Directory directory = await getApplicationSupportDirectory();
    //Get directory path
    final String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
    //Write PDF bytes data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }

  Future<List<int>> _readImageData(dynamic key) async {
    final ui.Image data = await key.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  // List<LeadAnalysisData> finalFilterData = [];

  mapTableData() {
    leadAnalysismasterDataset = leadAnalysismasterDataset2;
    notifyListeners();
  }

  getApi() async {
    progress = true;
    errormsg = '';
    final Database db = (await DBHelper.getInstance())!;

    await LeadAnalysisApi.getdata().then((value) async {
      if (value.stcode! <= 210 && value.stcode! >= 200) {
        if (value.datadetail!.leadMasterData.isNotEmpty &&
            value.datadetail!.leadReportData.isNotEmpty) {
          progress = false;
          leadAnalysismasterDataset2 = value.datadetail!.leadMasterData;
          leadAnalysisReportDataset = value.datadetail!.leadReportData;

          await DBOperation.truncateLeadAnalysisDB(db);
          await DBOperation.truncateLeadReportDB(db);
          await DBOperation.insertLeadAnalysisDBData(
              leadAnalysismasterDataset2, db);
          await DBOperation.insertLeadReportDBData(
              leadAnalysisReportDataset, db);
          await splitFilterData();
        } else {
          errormsg = 'No Data';
          progress = false;
        }
      } else if (value.stcode! <= 410 && value.stcode! >= 400) {
        errormsg = '${value.respDesc}';
        progress = false;
      } else {
        errormsg = '${value.respDesc}';
        progress = false;
      }
    });
    //set Default Value
    dateRange[4].color = 1;

    visibleSelectedDate = true;
    startDate = config.alignDate(DateTime.now().toString());
    endDate = config.alignDate(DateTime.now().toString());
    print("StartEnd Date:$startDate$endDate");
    List<Map<String, Object?>> result = await DBOperation.getRangeWiseData(
        db,
        alignYYMMDD(startDate),
        alignYYMMDD(endDate),
        leadAnalysisTable,
        'CreatedDate');
    rangeFilterGetData(result);

    notifyListeners();
  }

  // static List<SplitLeadData> splitReportdataaa = [];

  static List<TestReportValues> insertTestValues = [];

  onChangedDropDown(int i) {
    if (rTestListItem2[i].rangeType != 'DateTime') {
      if (rTestListItem2[i].onTabList == true) {
        rTestListItem2[i].onTabList = false;
      } else if (rTestListItem2[i].onTabList == false) {
        rTestListItem2[i].onTabList = true;
      }
    }
  }

  Future splitFilterData() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncateTestLeadReportDB(db);

    assigncolumn.clear();
    cusgroupcolumn.clear();
    enqstatuscolumn.clear();
    intlevelcolumn.clear();
    ordercolumn.clear();
    rTestListItem2 = [];
    minValuesAmount = 0;
    maxValuesAmount = 0;
    rdata = [];
    assigncolumn = [];
    splitTitleName = [];
    rlistItem = [];
    bool onTapstatus = false;
    String rangeTypee = '';
    splitTitleName = NewLeadAnalysisApi.splitdataaa55;
    await DBOperation.insertTestLeadReportDBData(insertTestValues, db);
    List<Map<String, Object?>> assigResultTit =
        await DBOperation.getLeadReportTitColumn(db);
    for (var im = 0; im < splitTitleName.length; im++) {
      rdata = [];

      for (var i = 0; i < assigResultTit.length; i++) {
        if (assigResultTit[i]['Title'].toString() ==
            splitTitleName[im].leadReportData) {
          try {
            DateTime ccccc =
                DateTime.parse(assigResultTit[i]['TestValues'].toString());
            rangeTypee = 'DateTime';
            onTapstatus = true;
          } catch (e) {
            if (assigResultTit[i]['TestValues']
                .toString()
                .replaceAll(' ', '')
                .isAlphabetOnly) {
              rangeTypee = 'Text';
              onTapstatus = false;
            } else if (assigResultTit[i]['TestValues'].toString().isNum) {
              onTapstatus = true;
              rangeTypee = 'Integer';
            }
          }
          if (assigResultTit[i]['TestValues'] == null ||
              assigResultTit[i]['TestValues'] == 'null') {
          } else {
            rdata.add(ItemnameR(
              isCheckbox: false,
              itemrangeType: rangeTypee,
              title: splitTitleName[im].leadReportData,
              textlist: assigResultTit[i]['TestValues'].toString(),
            ));
          }
        }
      }
      if (rTestListItem2.isEmpty) {
        rTestListItem2.add(TestName(
            onTabList: onTapstatus,
            rangeType: rangeTypee,
            titleName: splitTitleName[im].leadReportData,
            itemNamer: rdata));
      } else {
        for (var ik = 0; ik < rTestListItem2.length; ik++) {
          if (rTestListItem2[ik].titleName.toString() ==
              splitTitleName[im].leadReportData) {
          } else {
            rTestListItem2.add(TestName(
                onTabList: onTapstatus,
                rangeType: rangeTypee,
                titleName: splitTitleName[im].leadReportData,
                itemNamer: rdata));
            break;
          }
        }
      }
    }
    for (var iv = 0; iv < rTestListItem2.length; iv++) {
      itemNamerx = rTestListItem2[iv].itemNamer;
      itemNamerx.sort((a, b) =>
          a.textlist!.toLowerCase().compareTo(b.textlist!.toLowerCase()));
      for (var ix = 0; ix < rTestListItem2[iv].itemNamer.length; ix++) {
        await chagneLeadval(ix);
      }
    }

    notifyListeners();
  }

  chagneLeadval(int im) {
    // log("itemNamerx[im].itemrangeType::${itemNamerx[im].itemrangeType}");
    if (itemNamerx[im].itemrangeType == 'Integer') {
      final mapWithBiggestCaseNumber = itemNamerx.reduce((a, b) =>
          double.parse(a.textlist) > double.parse(b.textlist) ? a : b);
      final mapWithLowestCaseNumber = itemNamerx.reduce((a, b) =>
          double.parse(a.textlist) < double.parse(b.textlist) ? a : b);

      currentRangeValues = RangeValues(
          double.parse(mapWithLowestCaseNumber.textlist),
          double.parse(mapWithBiggestCaseNumber.textlist));
      minValuesAmount = double.parse(mapWithLowestCaseNumber.textlist);
      maxValuesAmount = double.parse(mapWithBiggestCaseNumber.textlist);
    }
  }

  // List<String>? chartQuery = [];

  selectViewDet(int i) async {
    kpilottie = null;
    reportexp = null;
    pieChartData = [];
    columnChartData = [];
    bubbleChartData = [];
    barChartData = [];
    cardChartData = [];
    lineChartData = [];
    splineChartData = [];
    viewType = '';
    viewTypeCode = '';
    searchcontroller.text = '';
    final Database db = (await DBHelper.getInstance())!;
    viewType = leadTablViewData[i].viewName.toString();
    viewTypeCode = leadTablViewData[i].viewCode.toString();
    searchcontroller.text = leadTablViewData[i].viewName.toString();
    List<Map<String, Object?>> getViewCodeQuery =
        await DBOperation.getLeadReportQuerywiseData(
            db, viewTypeCode.toString());
    if (getViewCodeQuery.isNotEmpty) {
      for (var im = 0; im < getViewCodeQuery.length; im++) {
        if (viewTypeCode == getViewCodeQuery[im]['ViewCode'].toString()) {
          chartType!.add(LeadReportQueryData(
              chartType: getViewCodeQuery[im]['ChartType'].toString(),
              leadQuery: getViewCodeQuery[im]['Query'].toString(),
              viewCode: getViewCodeQuery[im]['ViewCode'].toString(),
              kpiTitle: getViewCodeQuery[im]['KPITitle'].toString(),
              queryExt: getViewCodeQuery[im]['QueryExt'].toString(),
              rowCode: int.parse(getViewCodeQuery[im]['RowCode'].toString())));
        }
      }
    }
    onfilterapply();

    notifyListeners();
  }

  showBottomSheetInsert(BuildContext context, ThemeData theme) {
    chartType = [];
    log('leadTablViewDataleadTablViewData::${startDate}::${endDate}');
    if ((startDate.isNotEmpty && endDate.isNotEmpty) &&
        leadTablViewData.length > 0) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return ViewDetailsAlertBox();
          });
      notifyListeners();
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return StatefulBuilder(builder: (context, st) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                insetPadding: const EdgeInsets.all(0),
                content: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: Screens.width(context) * 0.8,
                    // height: Screens.padingHeight(context) * 0.15,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: theme.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: Screens.width(context) * 0.6,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.1,
                                    right: Screens.width(context) * 0.01,
                                  ),
                                  child: Text(
                                    'Alert',
                                    style: theme.textTheme.bodyMedium!
                                        ?.copyWith(color: Colors.white),
                                  )),
                              IconButton(
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                                onPressed: () {
                                  st(
                                    () {
                                      Navigator.pop(context);
                                      notifyListeners();
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.8,
                            padding: EdgeInsets.only(
                              top: Screens.padingHeight(context) * 0.03,
                              bottom: Screens.padingHeight(context) * 0.02,
                            ),
                            child: const Text("Please Choose The Date Range")),
                        GestureDetector(
                          onTap: () {
                            st(
                              () {
                                Navigator.pop(context);
                                notifyListeners();
                              },
                            );
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                top: Screens.padingHeight(context) * 0.01,
                                bottom: Screens.padingHeight(context) * 0.01,
                              ),
                              width: Screens.width(context) * 0.8,
                              color: theme.primaryColor,
                              child: Text(
                                "OK",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                        ),
                      ],
                    )),
              );
            });
          });
    }
  }

  onTapFilter(BuildContext context, ThemeData theme) {
    clearfilterval();
    mycontroller[17].text = '';
    if ((startDate.isNotEmpty && endDate.isNotEmpty) ||
        leadTablViewData.length > 0) {
      for (var i = 0; i < rTestListItem2.length; i++) {
        if (rTestListItem2[i].rangeType == 'Text') {
          rTestListItem2[i].onTabList = false;
        } else {
          rTestListItem2[i].onTabList = true;
        }
        notifyListeners();
      }
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return StatefulBuilder(builder: (context, st) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                insetPadding: const EdgeInsets.all(0),
                content: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: Screens.width(context) * 0.8,
                    // height: Screens.padingHeight(context) * 0.15,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: theme.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: Screens.width(context) * 0.6,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.1,
                                    right: Screens.width(context) * 0.01,
                                  ),
                                  child: Text(
                                    'Alert',
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  )),
                              IconButton(
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                                onPressed: () {
                                  st(
                                    () {
                                      Navigator.pop(context);
                                      notifyListeners();
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.8,
                            padding: EdgeInsets.only(
                              top: Screens.padingHeight(context) * 0.03,
                              bottom: Screens.padingHeight(context) * 0.02,
                            ),
                            child: const Text("Please Choose The Date Range")),
                        GestureDetector(
                          onTap: () {
                            st(
                              () {
                                Navigator.pop(context);
                                notifyListeners();
                              },
                            );
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                top: Screens.padingHeight(context) * 0.01,
                                bottom: Screens.padingHeight(context) * 0.01,
                              ),
                              width: Screens.width(context) * 0.8,
                              color: theme.primaryColor,
                              child: Text(
                                "OK",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                        ),
                      ],
                    )),
              );
            });
          });
    }
    notifyListeners();
  }

  allColorsData() {
    defaultColor = [];
    cityPark = [];
    classroom = [];
    colorblindSafe = [];
    electric = [];
    heighContrast = [];
    sunset = [];
    sunset2 = [];
    twilight = [];
    barchartcolors = [];
    // Default
    defaultColor = [
      const Color(0xFF01B8AA),
      const Color(0xFF374649),
      // const Color(0xFFFD625E),
      const Color(0xFFF2C80F),
      const Color(0xFF5F6B6D),
      const Color(0xFF8AD4EB),
      const Color(0xFFFE9666),
      const Color(0xFFA66999)
    ];
// City Park
    cityPark = [
      const Color(0xFF73B761),
      const Color(0xFF4A588A),
      const Color(0xFFECC846),
      // const Color(0xFFCD4C46),
      const Color(0xFF71AFE2),
      const Color(0xFF8D6FD1),
      const Color(0xFFEE9E64),
      const Color(0xFF95DABB)
    ];
// Classroom
    classroom = [
      const Color(0xFF4A8DDC),
      const Color(0xFF4C5D8A),
      const Color(0xFFF3C911),
      // const Color(0xFFDC5B57),
      const Color(0xFF33AE81),
      const Color(0xFF95C8F0),
      const Color(0xFFDD915F),
      const Color(0xFF9A64A0)
    ];
// Colorblind Safe
    colorblindSafe = [
      const Color(0xFF074650),
      const Color(0xFF009292),
      const Color(0xFFDD915F),
      const Color(0xFFB5DAFE),
      const Color(0xFFFEB5DA),
      const Color(0xFF480091),
      // const Color(0xFFB66DFF),
      const Color(0xFF6DB6FF)
    ];

    barchartcolors = [
      const Color(0xFFC88EA7),
      const Color(0xFF698474),
      const Color.fromARGB(255, 233, 188, 53),
      const Color(0xFF35B0AB),
      const Color(0xFFBBAB8C),
      const Color(0xFFDA7297),
      const Color(0xFF1679AB)
    ];
    // Electric
    electric = [
      const Color(0XFF508D69),
      const Color.fromARGB(255, 90, 76, 56),
      const Color.fromARGB(255, 180, 224, 183),
      const Color(0XFFFF9D7B),
      const Color(0xFF288FB4),
      const Color(0xFF655D8A),
      const Color(0xFF30E3DF),
      const Color.fromARGB(255, 185, 221, 23),

      // Color.fromARGB(255, 45, 148, 245),
      // Color.fromARGB(255, 241, 116, 195),
      // Color.fromARGB(255, 235, 135, 77),
      // Color.fromARGB(255, 116, 222, 236),
      // Color.fromARGB(255, 119, 240, 204),
      // Color.fromARGB(255, 108, 133, 235),
      // const Color(0xFFF64F5C),

      // const Color(0xFF750985),
      // const Color(0xFF118DFF),
      // // const Color(0xFFC83D95),
      // const Color(0xFFFF985E),
      // const Color(0xFF1DD5EE),
      // const Color(0xFF42F7C0),
      // const Color(0xFF3049AD),
      // const Color(0xFFF64F5C),
    ];
    electricShuffle = electric..shuffle();
    // log('electricShuffle length11:::${electricShuffle.length}');
    // High Contrast
    heighContrast = [
      const Color(0xFF107C10),
      // const Color(0xFF002050),
      const Color(0xFFF17925),
      const Color(0xFF5C2D91),
      // const Color(0xFFA80000),
      const Color(0xFF004B50),
      const Color(0xFF0078D7),
      const Color(0xFFD83B01),
      const Color(0xFFB4009E),
    ];

    //  Sunset
    sunset = [
      const Color(0xFF3049AD),
      const Color(0xFFB6B0FF),
      const Color(0xFFFF994E),
      // const Color(0xFFC83D95),
      // const Color(0xFFFFBBED),
      const Color(0xFF42F9F9),
      const Color(0xFF00B2D9),
      const Color(0xFFFFD86C),
    ];
    sunset2 = [
      // set2
      const Color(0xFF00B2D9),
      const Color(0xFF107C10),
      const Color(0xFFB6B0FF),
      const Color(0xFF3049AD),
    ];
    //  Twilight
    twilight = [
      const Color(0xFFF17925),
      const Color(0xFF004753),
      const Color(0xFFCCAA14),
      const Color(0xFF4B4C4E),
      const Color(0xFFD82C20),
      const Color(0xFFA3D0D4),
      const Color(0xFF536F18),
      const Color(0xFF46ABB0),
    ];
  }

  openViewDetails(
    BuildContext context,
  ) async {
    await showDialog<dynamic>(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return ViewDetailsAlertBox();
        }).then((value) {}).then((value) {
      notifyListeners();
    }).then((value) {});
  }

  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/SellerKit2.db');
    return Future.value(source1);
  }

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("storage/emulated/0/Sqlite Backup");
    return Future.value(copyTo);
  }

  Future<bool> getPermissionStorage() async {
    try {
      var statusStorage = await Permission.storage.status;
      if (statusStorage.isDenied) {
        Permission.storage.request();
        return Future.value(false);
      }
      if (statusStorage.isGranted) {
        return Future.value(true);
      }
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
    return Future.value(false);
  }

  showSnackBars(String e, Color color) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      title: "Warning..",
      message: e,
      backgroundColor: Colors.green,
    ));
  }

  Future<String> createDirectory() async {
    try {
      await copyTo!.create();
      String newPath = copyTo!.path;
      createDBFile(newPath);
      return newPath;
    } catch (e) {
      print('datata1111::' + e.toString());
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/SellerKit2.db";
      log("getPath::" + getPath);
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }
}

class DateRangeData {
  String? rangeType;
  int? color;
  DateRangeData({this.rangeType, this.color});
}

class Distcolumn {
  String name;
  List<RItemList> listitem;
  Distcolumn({required this.name, required this.listitem});
}

class RItemList {
  dynamic itemRlist;
  RItemList({required this.itemRlist});
}

class Distcusgroupcolumn {
  String name;
  Distcusgroupcolumn({
    required this.name,
  });
}

class DistEnqstatuscolumn {
  String name;
  DistEnqstatuscolumn({
    required this.name,
  });
}

class Distlookingforcolumn {
  String name;
  bool ischecck;
  Distlookingforcolumn({required this.name, required this.ischecck});
}

class Distlevelcolumn {
  String name;
  Distlevelcolumn({
    required this.name,
  });
}

class Distordercolumn {
  String name;
  Distordercolumn({
    required this.name,
  });
}

class DistLeadValColumn {
  double name;
  DistLeadValColumn({
    required this.name,
  });
}

class DistLeadDateColumn {
  String name;
  DistLeadDateColumn({
    required this.name,
  });
}

class DistNextFColumn {
  String name;
  DistNextFColumn({
    required this.name,
  });
}

class TestName {
  bool? onTabList;
  String? titleName;
  String? rangeType;
  List<ItemnameR> itemNamer;
  TestName(
      {this.titleName,
      required this.itemNamer,
      this.rangeType,
      this.onTabList});
}

class ItemnameR {
  bool? isCheckbox;
  bool? isListBody;
  String? title;
  dynamic textlist;
  String? itemrangeType;
  ItemnameR({
    this.isCheckbox,
    required this.title,
    required this.textlist,
    this.itemrangeType,
  });
}

class piechartColors {
  String piechrtColor;
  String itemName;
  piechartColors({
    required this.piechrtColor,
    required this.itemName,
  });
}

  // getdbmodel() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   // GetfromdbEnqData = await DBOperation.getEnqdatafilter(db);
  //   //// log("GetfromdbEnqData::" + GetfromdbEnqData.length.toString());
  //   List<Map<String, Object?>> assignDB =
  //       await DBOperation.getFilterValueLeadAnalysis(
  //           "AssignedTo", leadAnalysisTable, db);
  //   List<Map<String, Object?>> cusgropDB =
  //       await DBOperation.getFilterValueLeadAnalysis(
  //           "CustomerGroup", leadAnalysisTable, db);
  //   List<Map<String, Object?>> enqstatusDB =
  //       await DBOperation.getFilterValueLeadAnalysis(
  //           "Status", leadAnalysisTable, db);
  //   // List<Map<String, Object?>> lookingforDB =
  //   //     await DBOperation.getFilterValueLeadAnalysis(
  //   //         "Lookingfor", leadAnalysisTable, db);
  //   List<Map<String, Object?>> intlevelDB =
  //       await DBOperation.getFilterValueLeadAnalysis(
  //           "InterestLevel", leadAnalysisTable, db);
  //   List<Map<String, Object?>> ordertypeDB =
  //       await DBOperation.getFilterValueLeadAnalysis(
  //           "OrderType", leadAnalysisTable, db);
  //   notifyListeners();

  //   await dataget(assignDB, cusgropDB, enqstatusDB, 'lookingforDB', intlevelDB,
  //       ordertypeDB);
  //   notifyListeners();
  // }
  // GlobalKey<SfCartesianChartState> cartesianChartKey =
  //     GlobalKey<SfCartesianChartState>();
  // GlobalKey<SfCartesianChartState> cartesianChartKeyBar =
  //     GlobalKey<SfCartesianChartState>();
  // GlobalKey<SfCartesianChartState> cartesianChartKeyBubble =
  //     GlobalKey<SfCartesianChartState>();
  // GlobalKey<SfCartesianChartState> cartesianChartKeySpline =
  //     GlobalKey<SfCartesianChartState>();
  // GlobalKey<SfCartesianChartState> cartesianChartKeyLine =
  //     GlobalKey<SfCartesianChartState>();
  // GlobalKey<SfCartesianChartState> cartesianChartKeyColumn =
  //     GlobalKey<SfCartesianChartState>();