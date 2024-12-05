
class ChecklistupdateModel{
  int stCode;
  String? error;

  ChecklistupdateModel({required this.stCode,this.error});

  
  factory ChecklistupdateModel.fromjson( int stcode,Map<String,dynamic> json){
      return ChecklistupdateModel(
      stCode: stcode,
      error: json['respDesc'],
      
      );
  }

  factory ChecklistupdateModel.issue(Map<String,dynamic> json, int stcode){
      return ChecklistupdateModel(
      stCode: stcode,
      error: json['respDesc']);
  }
   factory ChecklistupdateModel.error(String? jsons, int stcode){
      return ChecklistupdateModel(
      stCode: stcode,
      error: jsons,
      );
  }
}