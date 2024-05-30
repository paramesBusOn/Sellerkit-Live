import 'dart:convert';


class ForwardQuotesUser
{
  int stCode;
  String? errorTitle;
  String? message;
  List<documentdta>? docdata;

  ForwardQuotesUser({required this.stCode,this.errorTitle,required this.docdata,this.message});

  
  factory ForwardQuotesUser.fromjson( int stcode){
      return ForwardQuotesUser(
      stCode: stcode,
      errorTitle: null,
      docdata:null,
      );
  }

  factory ForwardQuotesUser.issue(Map<String,dynamic> jsons, int stcode){

  
  var list =json.decode(jsons['data']) as List;
return  ForwardQuotesUser(
      stCode: stcode,
      errorTitle: jsons['respDesc'],
      message: jsons['respCode']??'',
      docdata: null
      
      );
   
   }
     
  
  factory ForwardQuotesUser.error(String? json, int stcode){
      return ForwardQuotesUser(
      stCode: stcode,
      errorTitle: json,
      docdata: null
      );
  }
}
class documentdta{

}