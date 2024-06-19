import 'package:flutter/material.dart';

import '../../Models/GridContainerModels/GridContainerModel.dart';
import '../../Models/KpiModel/KpiModelList.dart';
import '../../Services/DashBoardApi/KpiApi/KpiApi.dart';
import '../../Services/DashBoardApi/KpiApi/NewKPIAPI.dart';

class KPIController extends ChangeNotifier {

//  List<GridConValue> get getData1 =>data1;
//   List<GridConValue> get getData2 =>data2;
//     List<GridConValue> data1=[
//     GridConValue("Enquiries","4",'fcedee'),
//     GridConValue("Open Leads","24",'ebf4fa'),
//     GridConValue("Lead Conversion","67%",'ebfaef'),
//     GridConValue("Today Followup","7",'ebf4fa'),
//     GridConValue("Overdue Followup","26",'ebfaef'),
//     GridConValue("Sales Conversion","86%",'fcedee'),
//   ];

//     List<GridConValue> data2=[
//     GridConValue("Sales","₹ 3.45",'fcedee'),
//     GridConValue("Target","₹ 4.98",'ebfaef'),
//     GridConValue("Ach%","80%",'ebf4fa'),
//     GridConValue("Day Target","60K",'fcedee'),
//     GridConValue("Till Now","12%",'ebf4fa'),
//     GridConValue("Run Rate","96%",'ebfaef'),
//   ];

  List <KpiModelData2>? kpiData=[];

  List <KpiModelData2>? get  getKpiData =>kpiData;
  bool exception = false;

  Future<void> swipeRefreshIndiactor()async{
    kpiData=null;
    notifyListeners();
    callKpiApi();
  }

  callKpiApi()async{
   await NewKpiApi.sampleDetails().then((value) {
      if(value.stsCode!>=200 && value.stsCode!<=210){
        if(value.data !=  null){
          kpiData = value.data!;
          notifyListeners();
        }else if(value.data == null){

        }
      }else {

      }
    });
  }
}