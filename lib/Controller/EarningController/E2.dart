// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Models/EarningModel/Earning2Model.dart';
// import 'package:sellerkit/Models/EarningModel/EraningModel1.dart';
// import 'package:flutter/material.dart';
// import 'package:sellerkit/Services/EarningAPI/Earning2API.dart';
// import '../../Services/EarningAPI/EarningAPI.dart';

// class EarningController2 extends ChangeNotifier {
//   EarningController2(){
//   }
// List<GlobalKey<FormState>> formkey =
//       List.generate(3, (i) => new GlobalKey<FormState>());
//   List<TextEditingController> dateController =
//       List.generate(5, (i) => TextEditingController());

//    List<EarningData2> earningloadData = [];
//   List<EarningData2> get getearningloadData => earningloadData;

  
// String apiFromDate='';
// String apiToDate='';

// String earningexp='';
// String get getearningexp=>earningexp;
// bool isloading=false;
// bool get getisloading=>isloading;
// bool loaddata=false;
// bool get getloaddata=>loaddata;



// callLoaddata()async{
  
// await EarningtableApi.getEarningtableData(apiFromDate,apiToDate).then((value) => {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.earningtabledata != null) {
//         earningloadData=value.earningtabledata!,
//       notifyListeners(),

//         print("earningloadData qqqqqqs:${earningloadData[0].transDetails}"),

//        } else if (value.earningtabledata == null) {
//           earningexp = 'No  Data in Earning2 table Api..!!',
//           isloading = false,
//       notifyListeners(),

//         }
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         isloading = false,
//         earningexp = 'Some thing went wrong in Earning2 Api..!!',
//       notifyListeners(),

//       } else if (value.stcode == 500) {
//         if (value.exception == 'No route to host') {
//           earningexp = 'Check your Internet Connection...!!',
//           isloading = false,
//       notifyListeners(),

//         } else {
//           earningexp = 'Something went wrong try again ...!!',
//           isloading = false,
//       notifyListeners(),

//         }
//       }

//     });
// }


// loadBtnClick(){
//    if( formkey[1].currentState!.validate()){
// callLoaddata();
//  notifyListeners();

//  } 
// }



// loadDataClear(){
// apiFromDate='';
// apiToDate='';
//  dateController[2].text='';
//   dateController[3].text='';
//   loaddata=false;
// earningloadData.clear();
// notifyListeners();

// }

//   void showFromDate(BuildContext context) {
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
//        apiFromDate =
//           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//       print( apiFromDate);

//       dateController[2].text = chooseddate;
//       notifyListeners();
//     });
//   }

 
//   void showToDate(BuildContext context) {
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
//        apiToDate =
//           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//       print(apiToDate);

//       dateController[3].text = chooseddate;
//       notifyListeners();
//     });
//   }

// }




