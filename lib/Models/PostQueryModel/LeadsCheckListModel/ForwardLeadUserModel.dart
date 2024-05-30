import '../../SerViceLayerModel/ErrorModelSl.dart';

class ForwardLeadUser
{
  int stCode;
  String? error;

  ForwardLeadUser({required this.stCode,this.error});

  
  factory ForwardLeadUser.fromjson( int stcode,Map<String,dynamic> json){
      return ForwardLeadUser(
      stCode: stcode,
      error: json['respDesc'],
      
      );
  }

  factory ForwardLeadUser.issue(Map<String,dynamic> json, int stcode){
      return ForwardLeadUser(
      stCode: stcode,
      error: json['respDesc']);
  }
   factory ForwardLeadUser.error(String? jsons, int stcode){
      return ForwardLeadUser(
      stCode: stcode,
      error: jsons,
      );
  }
}