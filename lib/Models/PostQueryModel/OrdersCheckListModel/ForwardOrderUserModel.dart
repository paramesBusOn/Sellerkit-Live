import 'dart:convert';

import '../../SerViceLayerModel/ErrorModelSl.dart';

class ForwardOrderUser
{
  int stCode;
  String? errorTitle;
  String? message;
  List<documentdta>? docdata;

  ForwardOrderUser({required this.stCode,this.errorTitle,required this.docdata,this.message});

  
  factory ForwardOrderUser.fromjson( int stcode){
      return ForwardOrderUser(
      stCode: stcode,
      errorTitle: null,
      docdata:null,
      );
  }

  factory ForwardOrderUser.issue(Map<String,dynamic> jsons, int stcode){

  
  var list =json.decode(jsons['data']) as List;
return  ForwardOrderUser(
      stCode: stcode,
      errorTitle: jsons['respDesc'],
      message: jsons['respCode']??'',
      docdata: null
      
      );
   
   }
     
  
  factory ForwardOrderUser.error(String? json, int stcode){
      return ForwardOrderUser(
      stCode: stcode,
      errorTitle: json,
      docdata: null
      );
  }
}
class documentdta{

}