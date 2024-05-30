import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Models/TargetModel/TargetModel.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/Screen.dart';
import '../../Models/TargetModel/TargetUsersModel.dart';
import '../../Services/TargetApi/TargetApi/TargetApi.dart';
import '../../Services/TargetApi/TargetApi/TargetUsersApi.dart';

class TargetTabController extends ChangeNotifier {
  // TargetTabController() {
  //   defaultuseData();
  // }

  void init() {
    defaultuseData();
    clearTargetListData();
    logData();
    notifyListeners();
  }

  bool isloading = true;
  bool get getisloading => isloading;
  List<TargetLineData> targetMonthTableData = [];
  List<TargetLineData> targetTodayTableData = [];

  List<TargetLineData> get getMonthTableData => targetMonthTableData;

  List<TargetLineData> get getTodaydTableData => targetTodayTableData;

  String targetCheckDataExcep = '';
  String noTargetInit = '';

  String get gettargetCheckDataExcep => targetCheckDataExcep;
  List<TargetMasterData> targetTodayMasterData22 = [];
  List<TargetMasterData> targetMonthMasterData22 = [];
  bool apicall = false;
  List<TargetMasterData> targetMonthData = [];
  List<TargetMasterData> targetTodayData = [];

  List<TargetMasterData> get getMonthdData => targetMonthData;

  List<TargetMasterData> get getTodaydData => targetTodayData;
  TextEditingController searchcontroller = TextEditingController();

  int processvalue = 0;
  int get getprocessvalue => processvalue;
  String? selectedUser;
  String salesPerName = '';

  logData() {
    log('targetUserList11: ${targetUserList.length}');
    log('isloading: $isloading');
  }

  // applyUserFilter(BuildContext context) async {
  //   selectedUser = null;
  //   targetUserList = [];
  //   isloading = false;
  //   Navigator.pop(context);

  //   notifyListeners();
  // }

  List<TargetUserDataModel> targetUserList = [];
  List<TargetUserDataModel> filterTargetUserList = [];
  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filterTargetUserList = targetUserList
          .where((e) => e.name!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterTargetUserList = targetUserList;
      notifyListeners();
    }
  }

  showSnackBars(String e, Color color) {
    Get.showSnackbar(GetSnackBar(
      title: "Alert",
      message: e,
    ));
  }

  defaultuseData() async {
    log('targetUserList[0].id::${ConstantValues.UserId.toString()}');
    GetTargetApi.slpId = ConstantValues.UserId;
    await callGetTargetTableApi();

    notifyListeners();
  }

  Future callTargetUsersApi(BuildContext context) async {
    filterTargetUserList = [];
    targetUserList = [];
    await GetTargetUsersApi.getData().then((value) async {
      isloading = false;

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.targetuserDataList!.isNotEmpty) {
          apicall = true;

          targetUserList = value.targetuserDataList!;
          targetUserList.sort(
              (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

          filterTargetUserList = targetUserList;
          searchcontroller.text = ConstantValues.firstName.toString();
          selectedUser = ConstantValues.UserId;
          // for (var i = 0; i < filterTargetUserList.length; i++) {
          //   if (filterTargetUserList[i].id.toString() ==
          //           ConstantValues.UserId ||
          //       filterTargetUserList[i].name == ConstantValues.Usercode) {
          //     searchcontroller.text = filterTargetUserList[i].name.toString();

          //     selectedUser = ConstantValues.UserId;
          //     log('targetUserList22::${targetUserList.length}');
          //   }
          // }
          notifyListeners();

          log('targetUserList::${targetUserList.length}');
          notifyListeners();
        } else if (value.targetuserDataList!.isEmpty) {
          targetTodayMasterData22 = [];
          targetMonthMasterData22 = [];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User Setup Not Initialised..!!'),
              backgroundColor: Colors.red,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(5),
              dismissDirection: DismissDirection.up,
            ),
          );

          isloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        targetCheckDataExcep = 'Kindly using the after some times..!!';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kindly using the after some times..!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        );
        isloading = false;
      } else if (value.stcode == 500) {
        targetTodayMasterData22 = [];
        targetMonthMasterData22 = [];
        lottie = 'Assets/NetworkAnimation.json';
        targetCheckDataExcep = 'Check Your Internet Connection..!!';

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Check Your Internet Connection..!!'),
        //     backgroundColor: Colors.red,
        //     elevation: 10,
        //     behavior: SnackBarBehavior.floating,
        //     margin: EdgeInsets.all(5),
        //     dismissDirection: DismissDirection.up,
        //   ),
        // );
        // showSnackBars("Check your Internet Connection...!!", Colors.green);
        // targetCheckDataExcep = 'Check your Internet Connection...!!';
        isloading = false;
      } else {
        targetTodayMasterData22 = [];
        targetMonthMasterData22 = [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong try again ...!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        );
        // targetCheckDataExcep = 'Something went wrong try again ...!!';
        isloading = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  dropvalues(String val) {
    selectedUser = val;
    log('selectedUserselectedUser:$selectedUser');
    notifyListeners();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  showbottombtn(BuildContext context) {
    if (targetUserList.isNotEmpty) {
      showUserBottomSheet(context);
      notifyListeners();
    }
    notifyListeners();
  }

  String lottie = '';
  callGetTargetTableApi() async {
    isloading = true;
    targetTodayMasterData22 = [];
    targetMonthMasterData22 = [];
    await GetTargetApi.getData().then((value) {
      lottie = '';
      targetCheckDataExcep = '';
      noTargetInit = '';
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.targetdata != null) {
          log('value.targetdata!.targetMasterData length::${value.targetdata!.targetMasterData.length}');
          mapValues(value.targetdata!.targetMasterData);
          notifyListeners();

          mapTableValues(value.targetdata!.targetLineData!);
          isloading = false;

          notifyListeners();
        } else if (value.targetdata == null) {
          targetTodayMasterData22 = [];
          targetMonthMasterData22 = [];
          targetCheckDataExcep = 'No Data ..!!';
          lottie = 'Assets/no-data.png';
          isloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        log('value.respDesc::${value.respDesc}');
        if (value.respDesc == "8134-Target Setup not initialised properly") {
          lottie = '';
          noTargetInit = value.respDesc.toString();
        } else {
          targetCheckDataExcep = 'Something went wrong try again..!!';
        }

        isloading = false;
      } else if (value.stcode == 500) {
        targetTodayMasterData22 = [];
        targetMonthMasterData22 = [];
        targetCheckDataExcep = 'Check Your Internet Connection...!!';

        lottie = 'Assets/NetworkAnimation.json';

        isloading = false;
      } else {
        targetCheckDataExcep = 'Something went wrong try again...!!';
        isloading = false;
      }

      notifyListeners();
    });
    notifyListeners();
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  mapTableValues(List<TargetLineData> targettdata) {
    targetMonthTableData = [];
    targetTodayTableData = [];
    log('targettdatatargettdata::${targettdata.length}');
    for (int i = 0; i < targettdata.length; i++) {
      if (targettdata[i].period == "MTD") {
        targetMonthTableData.add(TargetLineData(
            productGroup: targettdata[i].productGroup,
            targetVal: targettdata[i].targetVal,
            ach_Perc: targettdata[i].ach_Perc,
            period: targettdata[i].period,
            achVal: targettdata[i].achVal));
        notifyListeners();
      }
      if (targettdata[i].period == "TODAY") {
        targetTodayTableData.add(TargetLineData(
            productGroup: targettdata[i].productGroup,
            targetVal: targettdata[i].targetVal,
            ach_Perc: targettdata[i].ach_Perc,
            period: targettdata[i].period,
            achVal: targettdata[i].achVal));
        notifyListeners();
      }
    }
    notifyListeners();
  }

  int? groupValueSelected = 0;
  int? get getgroupValueSelected => groupValueSelected;
  groupSelectvalue(int i) {
    groupValueSelected = i;
    notifyListeners();
  }

  mapValues(List<TargetMasterData> targetvalues) {
    List<TargetMasterData> targetMonthData2 = [];
    List<TargetMasterData> targetTodayData2 = [];

    for (int i = 0; i < targetvalues.length; i++) {
      if (targetvalues[i].period == "MTD") {
        targetMonthData2.add(TargetMasterData(
            period: targetvalues[i].period,
            achPer: targetvalues[i].achPer,
            achQty: targetvalues[i].achQty,
            achVal: targetvalues[i].achVal,
            bTGQty: targetvalues[i].bTGQty,
            bTGValue: targetvalues[i].bTGValue,
            expClosePerc: targetvalues[i].expClosePerc,
            expCloseQty: targetvalues[i].expCloseQty,
            expCloseVal: targetvalues[i].expCloseVal,
            targetQty: targetvalues[i].targetQty,
            targetValue: targetvalues[i].targetValue,
            runRatePerc: targetvalues[i].runRatePerc,
            runRateVal: targetvalues[i].runRateVal));
        targetMonthData = targetMonthData2;
        targetMonthMasterData22 = targetMonthData;
        notifyListeners();
      }
      if (targetvalues[i].period == "TODAY") {
        targetTodayData2.add(TargetMasterData(
            period: targetvalues[i].period,
            achPer: targetvalues[i].achPer,
            achQty: targetvalues[i].achQty,
            achVal: targetvalues[i].achVal,
            bTGQty: targetvalues[i].bTGQty,
            bTGValue: targetvalues[i].bTGValue,
            expClosePerc: targetvalues[i].expClosePerc,
            expCloseQty: targetvalues[i].expCloseQty,
            expCloseVal: targetvalues[i].expCloseVal,
            targetQty: targetvalues[i].targetQty,
            targetValue: targetvalues[i].targetValue,
            runRatePerc: targetvalues[i].runRatePerc,
            runRateVal: targetvalues[i].runRateVal));
        targetTodayData = targetTodayData2;
        targetTodayMasterData22 = targetTodayData;
        notifyListeners();
      }
      notifyListeners();
    }
    log('targetMonthData::${targetMonthData.length}');
    log('targetTodayData ::${targetTodayData.length}');

    notifyListeners();
  }

  clearTargetListData() {
    targetTodayMasterData22 = [];
    targetMonthMasterData22 = [];
    salesPerName = '';
    noTargetInit = '';
    lottie = '';
    searchcontroller.text = '';
    targetCheckDataExcep = '';
    targetTodayTableData.clear();
    targetMonthTableData.clear();
    targetTodayData.clear();
    targetMonthData = [];
    targetTodayData = [];
    filterTargetUserList = [];
    targetUserList = [];
    targetMonthData.clear();
    isloading = false;
    apicall = false;
    selectedUser = null;
    notifyListeners();
  }

  clearTargetFilterData() {
    lottie = '';
    searchcontroller.text = '';
    filterTargetUserList = [];
    targetUserList = [];
    isloading = false;
    apicall = false;
    selectedUser = null;
    notifyListeners();
  }

  targetApplyBtn(BuildContext context) async {
    log('searchcontroller.text::${searchcontroller.text}');
    for (var i = 0; i < filterTargetUserList.length; i++) {
      if (selectedUser.toString() == filterTargetUserList[i].id.toString()) {
        targetTodayMasterData22 = [];
        targetMonthMasterData22 = [];
        GetTargetApi.slpId = filterTargetUserList[i].id.toString();
        salesPerName = searchcontroller.text;
        await callGetTargetTableApi();

        Navigator.pop(context);
        notifyListeners();
      } else {
        notifyListeners();
      }
    }
    notifyListeners();
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.toNamed(ConstantRoutes.dashboard);
      notifyListeners();

      return Future.value(true);
    }
    notifyListeners();

    return Future.value(true);
  }

  showUserBottomSheet(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, st) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: Screens.width(context),
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Screens.padingHeight(context) * 0.02,
                ),
                Form(
                  key: formkey,
                  child: TextFormField(
                    readOnly: true,
                    controller: searchcontroller,
                    textDirection: TextDirection.ltr,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Select User Name';
                      }
                      return null;
                    },
                    // onTap: () {
                    //   searchcontroller = searchcontroller;

                    //   searchcontroller.selection = TextSelection(
                    //     baseOffset: 0,
                    //     extentOffset: searchcontroller.text.length,
                    //   );
                    // },
                    // onChanged: ((value) {
                    //   st(
                    //     () {
                    //       filterSearchBoxList(value);
                    //     },
                    //   );
                    // }),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          //  when the TextFormField in focused
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: 'Select User Name',
                        suffixIcon: Icon(Icons.arrow_drop_down, size: 25)),
                  ),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.02,
                ),
                Visibility(
                  visible: apicall,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.02,
                      ),
                      filterTargetUserList.isEmpty
                          ? Container()
                          : Container(
                              alignment: Alignment.center,
                              // width: Screens.width(context) * 0.5,
                              height: Screens.bodyheight(context) * 0.25,
                              child: ListView.builder(
                                  itemCount: filterTargetUserList.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    log('filterTargetUserList.length::${filterTargetUserList.length}');
                                    return InkWell(
                                      onTap: () {
                                        st(
                                          () {
                                            selectedUser =
                                                targetUserList[i].id.toString();

                                            searchcontroller.text =
                                                filterTargetUserList[i]
                                                    .name!
                                                    .toString();
                                          },
                                        );
                                        disableKeyBoard(context);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(
                                                Screens.bodyheight(context) *
                                                    0.008),
                                            alignment: Alignment.centerLeft,
                                            width: Screens.width(context),
                                            child: Text(
                                              "${filterTargetUserList[i].name}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor),
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.35,
                      child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: Text("Cancel")),
                    ),
                    Container(
                      width: Screens.width(context) * 0.35,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              st(
                                () {
                                  targetApplyBtn(context);
                                },
                              );
                              //   GetTargetApi.slpId = selectedUser;
                              //   await callGetTargetTableApi();
                              //   log("ccccc::" +
                              //       targetTodayMasterData22.length.toString());

                              //   Navigator.pop(context);
                            }
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: Text("Apply")),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.04,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget createTable(
    ThemeData theme,
  ) {
    log('targetTodayTableDatatargetTodayTableDataxx::${targetTodayTableData.length}');
    var todaykeyss = targetTodayTableData;
    var monthkeyss2 = targetMonthTableData;
    log('todaykeysstodaykeyss::${getTodaydTableData.length}');
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Product Group",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        // alignment: Alignment.center,
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        child: Text(
          "Target",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        child: Text(
          "Achieved",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Text(
          "Ach %",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.right,
        ),
      ),
    ]));
    print("Above Row");
    for (int i = 0; i < todaykeyss.length; ++i) {
      print("in Row");
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            groupValueSelected == 0
                ? '${todaykeyss[i].productGroup}'
                : '${monthkeyss2[i].productGroup}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
            child: Text(
              groupValueSelected == 0
                  ? '${todaykeyss[i].targetVal}'
                  : '${monthkeyss2[i].targetVal}',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyText1?.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          child: Text(
            groupValueSelected == 0
                ? '${todaykeyss[i].achVal}'
                : '${monthkeyss2[i].achVal}',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          child: Text(
            groupValueSelected == 0
                ? '${todaykeyss[i].ach_Perc}'
                : '${monthkeyss2[i].ach_Perc}',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(2.2), //tp
      1: FlexColumnWidth(1.5), //seg
      2: FlexColumnWidth(1.5), //tar
      3: FlexColumnWidth(1.4), //ach
      // 4: FlexColumnWidth(1.1), //ach%
    }, children: rows);
  }
}
