import 'dart:convert';
import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class MenuAuthModel {
  List<MenuAuthData>? menuAuthData;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  MenuAuthModel(
      {required this.menuAuthData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory MenuAuthModel.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<MenuAuthData> dataList =
          list.map((data) => MenuAuthData.fromJson(data)).toList();
      return MenuAuthModel(
          menuAuthData: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return MenuAuthModel(
          menuAuthData: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory MenuAuthModel.error(String jsons, int stcode) {
    return MenuAuthModel(
        menuAuthData: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class MenuAuthData {
  int? DocEntry;
  int? UserKey;
  String? CompanyCode;
  String? MenuKey;
  String? AuthStatus;
  String? UserCode;
  String? MenuName;
  MenuAuthData({
    required this.DocEntry,
    required this.UserKey,
    required this.CompanyCode,
    required this.MenuKey,
    required this.AuthStatus,
    required this.UserCode,
    required this.MenuName,
  });

  factory MenuAuthData.fromJson(Map<String, dynamic> json) => MenuAuthData(
        UserKey: json['userKey'] ?? -1,
        CompanyCode: json['companyCode'] ?? "",
        MenuKey: json['menuKey'] ?? "",
        AuthStatus: json['authStatus'] ?? "",
        UserCode: json['UserCode'] ?? "",
        MenuName: json['menuName'] ?? "",
        DocEntry:  json['DocEntry'] ?? 0,
      );

  // Map<String, Object?> toMap() => {
  //       OfferZoneColumns.offerZoneId: UserKey,
  //       OfferZoneColumns.itemCode: itemCode,
  //       OfferZoneColumns.offerName: offerName,
  //       OfferZoneColumns.offerDetails: offerDetails,
  //       OfferZoneColumns.item: item,
  //       OfferZoneColumns.discoutDetails: discoutDetails,
  //       OfferZoneColumns.incentive: incentive,
  //       OfferZoneColumns.validTill: validTill,
  //     };
}
