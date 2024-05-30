// ignore_for_file: unnecessary_new

import 'dart:convert';

// import 'package:fijkplayer/fijkplayer.dart';

class FeedsModal {
 List <FeedsModalData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  FeedsModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory FeedsModal.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<FeedsModalData> dataList =
          list.map((data) => FeedsModalData.fromJson(data)).toList();
      return FeedsModal(
          leadcheckdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return FeedsModal(
          leadcheckdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory FeedsModal.error(String jsons, int stcode) {
    return FeedsModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class FeedsModalData {
  FeedsModalData2? leadcheckdata2;
  String? Reaction;
  String? ProfilePic;
  String? createdUserName;
 

  FeedsModalData(
      {
        required this.createdUserName,
       required this.leadcheckdata2, 
      required this.Reaction,
      required this.ProfilePic,
     
      });

  factory FeedsModalData.fromJson(Map<String, dynamic> jsons) => FeedsModalData(
        
        Reaction: jsons['reaction'] ?? '',
        ProfilePic: jsons['profile'] ?? '',
        createdUserName:jsons['createdUserName'] ?? '',

       leadcheckdata2: FeedsModalData2.fromJson(jsons["feedMaster"])
      );

 
}


class FeedsModalData2 {
  int? FeedsID;
  String? CreatedDate;
  String? Title;
  String? Description;
  String? MediaType;
  String MediaURL1;
  String MediaURL2;
  String MediaURL3;
  String? ValidTill;
  String? UserCode;
 
  int? CreatedBy;
  // FijkPlayer? player;

  FeedsModalData2(
      {required this.FeedsID,
      required this.CreatedDate,
      required this.Title,
      required this.Description,
      required this.MediaType,
      required this.MediaURL1,
      required this.MediaURL2,
      required this.MediaURL3,
      required this.ValidTill,
      required this.UserCode,
     
      required this.CreatedBy,
      });

  factory FeedsModalData2.fromJson(Map<String, dynamic> json) => FeedsModalData2(
        FeedsID: json['id'] ?? -1,
        CreatedDate: json['createdOn'] ?? '',
        Title: json['title'] ?? '',
        Description: json['description'] ?? '',
        MediaType: json['mediaType'] ?? '',
        MediaURL1: json['media1'] ?? '',
        MediaURL2: json['media2'] ?? '',
        MediaURL3: json['media3'] ?? '',
        ValidTill: json['validTill'] ?? '',
        UserCode: json['UserCode'] ?? '',
       
        CreatedBy: json['createdBy'] ?? '',
      );


} 