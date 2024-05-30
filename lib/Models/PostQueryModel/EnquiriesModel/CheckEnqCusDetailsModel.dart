import 'dart:convert';
import 'dart:developer';

class CheckEnqDetailsModel {
List<CheckEnqDetailsData>? checkEnqDetailsData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  CheckEnqDetailsModel(
      {required this.checkEnqDetailsData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory CheckEnqDetailsModel.fromJson(String? jsons,int stcode) {
    if ( stcode >= 200 && stcode <= 210 ) {
      
      if(jsons!.isEmpty){
 return CheckEnqDetailsModel(
        checkEnqDetailsData: null,
        message: "Success",
        status: false,
        stcode: stcode,
        exception:null
      );
      }else{
        var list = json.decode(jsons) as List;
      log("list"+list.toString());
  List<CheckEnqDetailsData> dataList =
          list.map((data) => CheckEnqDetailsData.fromJson(data)).toList();
      return CheckEnqDetailsModel(
        checkEnqDetailsData: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
      }
    
    }

     else {
      return CheckEnqDetailsModel(
        checkEnqDetailsData: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory CheckEnqDetailsModel.error(String jsons,int stcode) {
    return CheckEnqDetailsModel(
        checkEnqDetailsData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class CheckEnqDetailsData {
  CheckEnqDetailsData({
    required this.Type,
    required this.DocEntry,
    required this.Current_Branch,
    required this.User_Branch,

  });

  String? Type;
  int? DocEntry;
  currentbranch? Current_Branch;
  String? User_Branch;

  factory CheckEnqDetailsData.fromJson(Map<String, dynamic> json) =>
   CheckEnqDetailsData(
     Type: json['type'] ?? '',
     DocEntry: json['docEntry'] ?? 0,
     Current_Branch:currentbranch.fromJson(json['currentbranch']) ,
     User_Branch: json['userbranch'] ?? '',

     );
   
}
class currentbranch{
  String? currentBranch;
  currentbranch({
   this.currentBranch,
  });
  factory currentbranch.fromJson(Map<String,dynamic> json){
    return currentbranch(
      currentBranch: json['currentbranch']);
  }
}