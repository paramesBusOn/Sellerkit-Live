import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import 'package:sellerkit/Models/specialpriceModel/AprovergetModel.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/newpricereq.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/widgets/WarningDialog.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import 'package:sellerkit/Services/SpecialPriceApi/ApprovergetApi.dart';
import 'package:sellerkit/Services/SpecialPriceApi/NewAddApi.dart';
import 'package:sellerkit/Services/SpecialPriceApi/newupdateApi.dart';
import 'package:sellerkit/Widgets/AlertDilog.dart';
import 'package:sqflite/sqflite.dart';

class NewpriceController extends ChangeNotifier {
  final formkey = GlobalKey<FormState>();
  List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());

  Config config = new Config();
  bool iscopymobile = false;
  bool isitemcode = false;
  bool isimmediate = false;
  bool isloadingBtn = false;
  bool isinitialloading = false;
  bool isselectitem = false;
  String? isselectedprice = '';
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
   for (int ij=0;ij<filterdataprice.length;ij++){
    if(filterdataprice[ij].itemCode ==Scancode){
      itemAlreadyscanned=true;
      indexscanning =ij;
        notifyListeners();
      break;
    
    }
   
   }
    if(itemAlreadyscanned ==true){
//       resetItems(indexscanning!);
fixingitems(indexscanning!);
// showBottomSheetInsert(context, indexscanning!);
 notifyListeners();
   }else{
    showtoastforscanning2();
     notifyListeners();
   }
   
 


//  checkscannedcode(code);
 notifyListeners();

  }

  void showtoastforscanning2() {
    Fluttertoast.showToast(
        msg: "No Data Found..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  init() {
    clearAlldata();
    getdataFromDb();
    // addbuttonval();
  }
  clearwarning() {
    mycontroller[0].clear();
    mycontroller[2].clear();
   
    customerapicalled = false;
   
    notifyListeners();
  }
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.specialpricereq);
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
                 Get.offAllNamed(ConstantRoutes.specialpricereq);
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
checkitemcodeselect(){
  if(mycontroller[3].text.isEmpty ||mycontroller[4].text.isEmpty){
    isselectitem=true;
   
    notifyListeners();
    showtoastforscanning();
  }else{
     
 isselectitem=false;
 notifyListeners();
  }
}

static List<String> modify=[];
 checkComeFromEnq(BuildContext context) async {
   clearAlldata();
  if(modify.length >0){
    clearAlldata();
    isinitialloading=true;
    mapvaluestomodify();

  }
 }
bool iscomeforupdate=false;
int? Docentry;
 mapvaluestomodify()async{
  iscomeforupdate=true;
  notifyListeners();
  await getdataFromDb();
Docentry=int.parse(modify[9]);
mycontroller[0].text =modify[2];
mycontroller[1].text=modify[1];
mycontroller[2].text=modify[3];

// NewpriceReqState.focusNode.requestFocus();

for(int i=0;i<filterdataprice.length;i++){
  if(filterdataprice[i].itemCode==modify[4]){
    // NewpriceReqState.focusNode.unfocus();
fixingitems(i);

notifyListeners();
break;
  }
}

 isinitialloading=false;
 modify.clear();
 notifyListeners();
 }
  addvalue(String? code) {
    log("code:::" + code.toString());
    if (isselectedprice == code) {
      isselectedprice = '';
    } else {
      isselectedprice = code;
    }
    notifyListeners();
  }
 void showtoastforscanning() {
    Fluttertoast.showToast(
        msg: "Select Item Code..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  filterList(String v) {
    if (v.isNotEmpty) {
      filterdataprice = listPriceAvail
          .where((e) => e.itemCode!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterdataprice = listPriceAvail;
      notifyListeners();
    }
  }

  fixingitems(int i) {
    log("filterdataprice[i].sp.toString();::" +
        filterdataprice[i].sp.toString());
    mycontroller[3].text = filterdataprice[i].itemCode.toString();
    mycontroller[4].text = filterdataprice[i].itemName.toString();
    mycontroller[6].text = filterdataprice[i].sp!.toStringAsFixed(2);
    mycontroller[7].clear();
    mycontroller[9].clear();
    //  itemvisible();
    // isitemcode =false;

    notifyListeners();
  }

  isimediate(bool val) {
    isimmediate = val;
    notifyListeners();
    if (isimmediate == true) {
      mycontroller[8].clear();
      notifyListeners();
    }
  }
String Apitodate='';
  getDate2(BuildContext context) async {
    // errorTime = "";

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
//  firstDate: DateTime.now().subtract(Duration(days: 1)),
//   lastDate: DateTime(2100),
    if (pickedDate != null) {
      mycontroller[8].text = "";
      print(pickedDate);
      String chooseddate = pickedDate.toString();
      var date = DateTime.parse(chooseddate);
      Apitodate="${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}Z";
      var datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[8].text = datetype;
      // mycontroller[44].text = datetype!;
      // print(datetype);
    } else {
      print("Date is not selected");
    }
    notifyListeners();
  }

  copynumber(bool val) {
    iscopymobile = val;
    log("valval::" + val.toString());
    notifyListeners();
    if (iscopymobile == false) {
      mycontroller[1].clear();
    } else {
      mycontroller[1].text = mycontroller[0].text;
    }
    notifyListeners();
  }

  List<button> planof = [];
  addbuttonval() {
    planof = [
      button(name: "SSP1", isclicked: false),
      button(name: "SSP2", isclicked: false),
      button(name: "SSP3", isclicked: false),
      button(name: "SSP4", isclicked: false),
      button(name: "SSP5", isclicked: false),
    ];
    notifyListeners();
  }

  List<ItemMasterDBModel> listPriceAvail = [];
  List<ItemMasterDBModel> filterdataprice = [];
  getdataFromDb() async {
    isinitialloading=true;
     notifyListeners();
    final Database db = (await DBHelper.getInstance())!;
    listPriceAvail = await DBOperation.getAllProducts(db);
    filterdataprice = listPriceAvail;

    notifyListeners();
  isinitialloading=false;
  notifyListeners();
  }

  itemvisible() {
    isitemcode = !isitemcode;
    notifyListeners();
  }
   List<GetApproverheader> getApproverheader=[];
Approvergetcall(){
mycontroller[9].clear();
  ApprovergetApi.getdata(mycontroller[3].text, mycontroller[7].text).then((value) {
    if(value.stcode! >= 200 && value.stcode! <= 210){
      getApproverheader=value.getApproverheader!;
      mycontroller[9].text="Authoriser_Code : ${getApproverheader[0].Authoriser_Code}\nAuthoriser_Name : ${getApproverheader[0].Authoriser_Name}\n ${getApproverheader[0].Slab!.isEmpty ?'':"Slab : ${getApproverheader[0].Slab}"  } ";
    }

  });
}
bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;
  validate(BuildContext context,ThemeData theme) async{
    if (formkey.currentState!.validate()) {
       FocusScope.of(context).unfocus();
       notifyListeners();
       showDeatilsDialog22(context,theme);      
    }
  }

  submitfinal(BuildContext context)async{
    isloadingBtn=true;
      notifyListeners();
      addspecialprice specialpricedoc = addspecialprice();
    specialpricedoc.  docentry=Docentry==null?null:Docentry;
      specialpricedoc.customerMobile =
          mycontroller[0].text == null || mycontroller[0].text.isEmpty
              ? null
              : mycontroller[0].text;//
              specialpricedoc.customerCode =
          mycontroller[1].text == null || mycontroller[1].text.isEmpty
              ? null
              : mycontroller[1].text;
              specialpricedoc.customerName =
          mycontroller[2].text == null || mycontroller[2].text.isEmpty
              ? null
              : mycontroller[2].text;
              specialpricedoc.itemCode =
          mycontroller[3].text == null || mycontroller[3].text.isEmpty
              ? null
              : mycontroller[3].text;
              specialpricedoc.itemName =
          mycontroller[4].text == null || mycontroller[4].text.isEmpty
              ? null
              : mycontroller[4].text;
              specialpricedoc.quantity =
          mycontroller[5].text == null || mycontroller[5].text.isEmpty
              ? 0.0
              :double.parse(mycontroller[5].text) ;
              specialpricedoc.rp =
          mycontroller[7].text == null || mycontroller[7].text.isEmpty
              ? 0.0
              :double.parse( mycontroller[7].text);
            
             if(isimmediate ==true){
               specialpricedoc.fromDate =config.currentDate();
              specialpricedoc.toDate =config.currentDate();
             }else{
               specialpricedoc.fromDate =mycontroller[8].text == null || mycontroller[8].text.isEmpty
              ? null
              : Apitodate;
 specialpricedoc.toDate =
          mycontroller[8].text == null || mycontroller[8].text.isEmpty
              ? null
              : Apitodate;
             }

             if(iscomeforupdate ==true){
SpecialupdateApi.getdata(specialpricedoc).then((value){
  if (value.stcode! >= 200 && value.stcode! <= 210) {
       isloadingBtn = false;

       
        notifyListeners();
      showDeatilsDialogsuccess(context, "${value.message}..!!Special Price Updated successfully..");
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showDeatilsDialog(context, "${value.message}..!!${value.exception}..");
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showDeatilsDialog(context, "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
      }
});
notifyListeners();
             }

     else{
       await SpecialAddApi.getdata(specialpricedoc).then((value) {
 if (value.stcode! >= 200 && value.stcode! <= 210) {
       isloadingBtn = false;

       
        notifyListeners();
      showDeatilsDialogsuccess(context, "${value.message}..!!Special Price Requested successfully..");
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showDeatilsDialog(context, "${value.message}..!!${value.exception}..");
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showDeatilsDialog(context, "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
      }
       }); 
     }   
  }

  showDeatilsDialogsuccess(BuildContext context, String msg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(msg: msg);
        }).then((value) {
 clearAlldata();
      Get.offAllNamed(ConstantRoutes.specialpricereq);
        });
  }
 showDeatilsDialog(BuildContext context, String msg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(msg: msg);
        });
  }

  showDeatilsDialog22(BuildContext context,ThemeData theme) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: statusRespPage(context, theme));
        });
  }
  Container statusRespPage(BuildContext context, ThemeData theme) {
    return Container(
       width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )), 
                ),
                child: Text(
                  "Alert",
                )),
          ),
          Container(
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.05,
              right: Screens.width(context) * 0.05,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Text(
                  "Do You want Confirm Submit Special Price Request",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(
                      //color:Colors.green
                      ),
                )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
               
              ],
            ),
          ),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                  )),
                            ),
                           onPressed: () {
                            Navigator.pop(context);
                           },
                           child: Text(
                             "No",
                             style: theme.textTheme.bodyText1
                                 ?.copyWith(color: Colors.white),
                           ),
                          
                         ),
                   ),
                   Container(
                     width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                  )),
                            ),
                           onPressed: () {
                            Navigator.pop(context);
                            submitfinal(context);
                           },
                           child: Text(
                             "Yes",
                             style: theme.textTheme.bodyText1
                                 ?.copyWith(color: Colors.white),
                           ),
                           
                         ),
                   ),
                 ],
               )
        ],
      ),
    );
  }
  List<GetCustomerData> customerdetails=[];
  List<GetenquiryData> enquirydetails = [];
  List<GetenquiryData> leaddetails = [];
  List<GetenquiryData>? quotationdetails;
  List<GetenquiryData>? orderdetails;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
callApi(BuildContext context) {
    //
    //fs
    isinitialloading = true;
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
            customerdetails = value.itemdata!.customerdetails!;
            mapValues(value.itemdata!.customerdetails![0]);
            
            notifyListeners();

            // if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.enquirydetails![0].DocType;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.enquirydetails![0].Store;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.enquirydetails![0].AssignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.enquirydetails![0].CurrentStatus;
            //   alertDialogOpenLeadOREnq(context, "enquiry");
            // }
            //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            //             value.itemdata!.orderdetails != null) {
            //                log("Anbuenq");
            //           orderdetails = value.itemdata!.orderdetails;
            //           alertDialogOpenLeadOREnq(context,"Orders");
            //         }
            if (value.itemdata!.enquirydetails != null&&value.itemdata!.enquirydetails!.isNotEmpty 
                ) {
              log("Anbulead");
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
                }
              }
              if (leaddetails.isNotEmpty) {
                AssignedToDialogUserState.LookingFor = leaddetails![0].DocType;
                AssignedToDialogUserState.Store = leaddetails![0].Store;
                AssignedToDialogUserState.handledby =
                    leaddetails![0].AssignedTo;
                AssignedToDialogUserState.currentstatus =
                    leaddetails![0].CurrentStatus;

                alertDialogOpenLeadOREnq(context, "Lead");
              } else if (enquirydetails.isNotEmpty) {
                AssignedToDialogUserState.LookingFor =
                    enquirydetails[0].DocType;
                AssignedToDialogUserState.Store = enquirydetails![0].Store;
                AssignedToDialogUserState.handledby =
                    enquirydetails![0].AssignedTo;
                AssignedToDialogUserState.currentstatus =
                    enquirydetails![0].CurrentStatus;

                alertDialogOpenLeadOREnq(context, "enquiry");
              }
            }
            // else if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //   for (int i = 0; i < value.itemdata!.enquirydetails!.length; i++) {

            //   }
            //   log("Anbuenq");
            //   enquirydetails = value.itemdata!.enquirydetails;

            // }
          } else {
            
            isinitialloading = false;
            notifyListeners();
          }
        } else if (value.itemdata == null) {
          
          isinitialloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isinitialloading = false;
        exceptionOnApiCall = '${value.stcode!}..!!${value.exception}..!! ';
        notifyListeners();
      } else if (value.stcode == 500) {
        isinitialloading = false;
        exceptionOnApiCall =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
  }
  mapValues(GetCustomerData itemdata) {
    log("MApvalues");
    PatchExCus patch = new PatchExCus();
    
    mycontroller[0].text = itemdata.mobileNo!;
    mycontroller[2].text = itemdata.customerName!;
    customerapicalled = false;
   isinitialloading=false;
    notifyListeners();
  }
   clearnum() {
    
    mycontroller[2].clear();
    
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
     mycontroller[8].clear();
      mycontroller[9].clear();
    customerapicalled = false;
    
    notifyListeners();
  }
  FocusNode focusNode4 = FocusNode();
    void alertDialogOpenLeadOREnq(BuildContext context, typeOfDataCus) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          AssignedToDialogUserState.typeOfDataCus = typeOfDataCus;
          // assignto = false;
          return WarningDialog();
        }).then((value) {
      if (isAnother == false) {
        FocusScope.of(context).requestFocus(focusNode4);
      } else {}

      // clearAllData(context);
    });
  }
   bool isAnother = true;
  clearAlldata() {
    Docentry==null;
    iscomeforupdate=false;
    isAnother = true;
    exceptionOnApiCall = '';
    Apitodate='';
    customerapicalled = false;
    isselectitem=false;
    getApproverheader.clear();
    isinitialloading=false;
    iscopymobile = false;
    isitemcode = false;
    isimmediate = false;
    isloadingBtn = false;
    isselectedprice = '';
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
    listPriceAvail.clear();
    filterdataprice.clear();
    notifyListeners();
  }
}

class button {
  String? name;
  bool? isclicked;
  button({required this.name, required this.isclicked});
}
