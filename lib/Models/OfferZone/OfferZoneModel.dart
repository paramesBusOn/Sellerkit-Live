import 'dart:convert';
import 'dart:developer';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class OfferZoneModel {
  List<OfferZoneData>? offerZoneData1;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  OfferZoneModel(
      {required this.offerZoneData1,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory OfferZoneModel.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list =jsons as List;
      List<OfferZoneData> dataList =
          list.map((data) => OfferZoneData.fromJson(data)).toList();
      return OfferZoneModel(
          offerZoneData1: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return OfferZoneModel(
          offerZoneData1: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory OfferZoneModel.error(String jsons, int stcode) {
    return OfferZoneModel(
        offerZoneData1: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class OfferZoneData {
  int? IMId;
  int? offerId;
  int? itemCode;
  String? offerName;
  String? offerDetails;
  String? mediaurl1;
  String? mediaurl2;
  String? incentive;
  String? validTill;
  List<offerproductlist>? offerproductlistdetails;
  // List<offerstorelist>? offerstorelistdetails;
  OfferZoneData({
    this.IMId,
    required this.offerId,
    required this.itemCode,
    required this.offerName,
    required this.offerDetails,
    required this.mediaurl1,
    required this.mediaurl2,
    required this.incentive,
    required this.validTill,
    required this.offerproductlistdetails,
    // required this.offerstorelistdetails
  });

  factory OfferZoneData.fromJson(Map<String, dynamic> jsons) {
    if(jsons["offerProductMobileDtos"] !=null ){
      var list1=jsons["offerProductMobileDtos"] as List;
      // log("messagelist1"+list1.toString());
      //  var list2=jsons["offerStoreListsDto"] as List;
      //  log("messagelist1"+list2.toString());
        List<offerproductlist> dataList2 =
          list1.map((data) => offerproductlist.fromJson(data)).toList();
          //  List<offerstorelist> dataList3 =
          // list2.map((data) => offerstorelist.fromJson(data)).toList();

    return OfferZoneData(
        offerId: jsons['id'] ?? -1,
        itemCode: jsons['status'] ?? 0,
        offerName: jsons['code'] ?? "",
        offerDetails: jsons['description'] ?? "",
        mediaurl1: jsons['offerBandUrl1'] ?? "",
        mediaurl2: jsons['offerBandUrl2'] ?? "",
        incentive: jsons['Incentive'] ?? "",
        validTill: jsons['toDate'] ?? "",
        offerproductlistdetails: dataList2,
        
      );
    }else{
      return OfferZoneData(
          offerId: jsons['id'] ?? -1,
        itemCode: jsons['status'] ?? "",
        offerName: jsons['code'] ?? "",
        offerDetails: jsons['description'] ?? "",
        mediaurl1: jsons['offerBandUrl1'] ?? "",
        mediaurl2: jsons['offerBandUrl2'] ?? "",
        incentive: jsons['Incentive'] ?? "",
        validTill: jsons['toDate'] ?? "",
        offerproductlistdetails: null, 
        
        );
    }
  }

  Map<String, Object?> toMap() => {
        OfferZoneColumns.offerZoneId: offerId,
        OfferZoneColumns.itemCode: itemCode,
        OfferZoneColumns.offerName: offerName,
        OfferZoneColumns.offerDetails: offerDetails,
        OfferZoneColumns.mediaurl1: mediaurl1,
        OfferZoneColumns.mediaurl2: mediaurl2,
        OfferZoneColumns.incentive: incentive,
        OfferZoneColumns.validTill: validTill,
        
      };
}

class offerproductlist{
  int? id;
  int? offerid;
  String? itemid;
  String? itemName;
  String? brand;
  String? category;
  String? subCategory;
  String? itemDescription;

  offerproductlist({
    required this.id,
    required this.itemid,
    required this.offerid,
    required this.itemName,
    required this.brand,
    required this.category,
    required this.subCategory,
    required this.itemDescription,

  });
  factory offerproductlist.fromJson(Map<String,dynamic> jsons){
    return offerproductlist(
      id: jsons["id"]??0, 
      itemid: jsons["itemCode"]??"", 
      offerid: jsons["offerId"], 
      itemName:jsons["itemName"], 
      brand:jsons["brand"]??'', 
      category:jsons["category"]??'', 
      subCategory:jsons["subCategory"]??'', 
      itemDescription:jsons["itemDescription"]??'', 
      );
  }
  Map<String, Object?> toMap() => {
        offerzoneColumnchild1.id: id,
        offerzoneColumnchild1.offerid:offerid,
        offerzoneColumnchild1.itemid:itemid,
        offerzoneColumnchild1.itemName:itemName,
        offerzoneColumnchild1.brand:brand,
        offerzoneColumnchild1.category:category,
        offerzoneColumnchild1.subCategory:subCategory,
        offerzoneColumnchild1.itemDescription:itemDescription,

      };
}
class offerstorelist{
  int? id;
  int? offerid;
  int? storeid;
  offerstorelist({
    required this.id,
    required this.offerid,
    required this.storeid
  });
  factory offerstorelist.fromJson(Map<String,dynamic> jsons){
    return offerstorelist(
      id: jsons['id'], 
      offerid: jsons['offerId'], 
      storeid: jsons['storeId']
      );
  }
  Map<String, Object?> toMap() => {
        offerzoneColumnchild2.id2: id,
        offerzoneColumnchild2.offerId2:offerid,
        offerzoneColumnchild2.storeId:storeid
        
        
      };
}