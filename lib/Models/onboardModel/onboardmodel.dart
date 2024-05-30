import 'dart:convert';

class onBoardModal {
List<onBoardData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  onBoardModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory onBoardModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list =jsons as List;
      List<onBoardData> dataList =
          list.map((data) => onBoardData.fromJson(data)).toList();
      return onBoardModal(
        itemdata: dataList,
        message: "sucess",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return onBoardModal(
        itemdata: null,
        message: "failed",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory onBoardModal.issues(Map<String,dynamic> jsons,int stcode) {
    return onBoardModal(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }

  factory onBoardModal.error(String jsons,int stcode) {
    return onBoardModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class onBoardData {
  onBoardData({
    required this.id,
    required this.loadContent,
    required this.urL1,
    required this.urL2,
    required this.urL3,
    required this.urL4,
    required this.urL5


  });
int? id;
String? loadContent;
String? urL1;
String? urL2;
String? urL3;
String? urL4;
String? urL5;
  


  factory onBoardData.fromJson(Map<String, dynamic> json) =>
   onBoardData(
    id: json['id']??0, 
    loadContent: json['loadContent']??"", 
    urL1: json['urL1']??"", 
    urL2: json['urL2']??"", 
    urL3: json['urL3']??"", 
    urL4: json['urL4']??"", 
    urL5: json['urL5']??""
    );
    
   
  
}