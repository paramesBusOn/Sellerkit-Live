import 'dart:convert';
import 'dart:developer';

class ChallengeModel {
  List<ChallengeData>? challengeDatadetails;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ChallengeModel(
      {required this.challengeDatadetails,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ChallengeModel.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<ChallengeData> dataList =
          list.map((data) => ChallengeData.fromJson(data)).toList();
          // log("datatlist"+dataList[0].challengeproductlist![0].challenge.toString());
      return ChallengeModel(
          challengeDatadetails: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return ChallengeModel(
          challengeDatadetails: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory ChallengeModel.error(String jsons, int stcode) {
    return ChallengeModel(
        challengeDatadetails: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ChallengeData{
  int? id;
  String? code;
  String? description;
  int? status;
  String? fromdate;
  String? todate;
  int? createdby;
  String? createdon;
  int? updatedby;
  String? updatedon;
  List<challengeproduct>? challengeproductlist;
  List<challengestore>? challengestorelist;

ChallengeData({
required this.challengeproductlist,
required this.challengestorelist,
required this.code,
required this.createdby,
required this.createdon,
required this.description,
required this.fromdate,
required this.id,
required this.status,
required this.todate,
required this.updatedby,
required this.updatedon
});
factory ChallengeData.fromJson(Map<String,dynamic> jsons){
if(jsons["challengeProductLists"] != null || jsons["challengeStoreLists"] !=null){
  var list1=jsons["challengeProductLists"] as List;
  var list2=jsons["challengeStoreLists"] as List;
   List<challengeproduct> datalist1=list1.map((data) => challengeproduct.fromJson(data)).toList();
 
  
  // log("list2222::"+list1.toString());
  List<challengestore> datalist2=list2.map((data) => challengestore.fromJson(data)).toList();
log("list111::"+datalist2[0].slpcode.toString());

return ChallengeData(
  challengeproductlist: datalist1, 
  challengestorelist: datalist2, 
  code: jsons["code"], 
  createdby: jsons["createdBy"], 
  createdon: jsons["createdOn"], 
  description: jsons["description"], 
  fromdate: jsons["fromDate"], 
  id: jsons["id"], 
  status: jsons["status"], 
  todate: jsons["toDate"], 
  updatedby: jsons["updatedBy"], 
  updatedon: jsons["updatedOn"]
  );
  }else{
    return ChallengeData(
      challengeproductlist: null, 
      challengestorelist: null, 
    code: jsons["code"], 
  createdby: jsons["createdBy"], 
  createdon: jsons["createdOn"], 
  description: jsons["description"], 
  fromdate: jsons["fromDate"], 
  id: jsons["id"], 
  status: jsons["status"], 
  todate: jsons["toDate"], 
  updatedby: jsons["updatedBy"], 
  updatedon: jsons["updatedOn"]
      );
  }
  }
}

class challengeproduct{
  int? id;
  int? challengeid;
  String? brand;
  String? catagory;
  String? subcatagory;
  String? itemcode;
  int? itemid;
  int? quantity;
  double? incentive;
  double? challenge;

  challengeproduct({
    required this.brand,
    required this.catagory,
    required this.challenge,
    required this.challengeid,
    required this.id,
    required this.incentive,
    required this.itemcode,
    required this.itemid,
    required this.quantity,
    required this.subcatagory

  });

  factory challengeproduct.fromJson(Map<String,dynamic> jsons){
    // log("JJJJ"+jsons.toString());
    // if(jsons["challengeProductLists"] !=null){
      return challengeproduct(
        brand: jsons["brand"], 
        catagory: jsons["catogery"], 
        challenge: jsons["challenge"], 
        challengeid: jsons["challengeId"], 
        id: jsons["id"], 
        incentive: jsons["incentive"], 
        itemcode: jsons["itemCode"], 
        itemid: jsons["itemId"], 
        quantity: jsons["quantity"], 
        subcatagory: jsons["subCatogery"]
        );
  //   }else{
  //  return   challengeproduct(
  //       brand: null, 
  //       catagory: null, 
  //       challenge: null, 
  //       challengeid: null, 
  //       id: null, 
  //       incentive: null, 
  //       itemcode: null, 
  //       itemid: null, 
  //       quantity: null, 
  //       subcatagory: null
  //       );
  //   }
  }
}

class challengestore{
  int? id;
  int? challengeid;
  int? userid;
  String? slpcode;
  int? storeid;
 challengestore({
  required this.challengeid,
  required this.id,
  required this.slpcode,
  required this.storeid,
  required this.userid

 }); 


 factory challengestore.fromJson(Map<String,dynamic> jsons){
  // if(jsons["challengeStoreLists"] != null){
    return challengestore(
      challengeid: jsons["challengeId"], 
      id: jsons["id"], 
      slpcode: jsons["slpCode"], 
      storeid: jsons["storeId"], 
      userid: jsons["userId"]
      );
  // }else{
  //   return challengestore(
  //     challengeid: null, 
  //     id: null, 
  //     slpcode: null, 
  //     storeid: null, 
  //     userid: null);
  // }
 }
}