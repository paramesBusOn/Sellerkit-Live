// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';

class ItemMasterCatNewModal {
List<String>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ItemMasterCatNewModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ItemMasterCatNewModal.fromJson(String jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // print("object::"+jsons.toString());
      List<dynamic> list = json.decode(jsons) ;
      //  print("object::"+list.toString());
        List<String> dataList = list.map((data) => data.toString()).toList();
      // List<ItemMasterCatagoryNewData> dataList =
      //     list.map((data) => ItemMasterCatagoryNewData.fromJson(data)).toList();
      return ItemMasterCatNewModal(
        itemdata: dataList,
        message: "sucess",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return ItemMasterCatNewModal(
        itemdata: null,
        message: "failed",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory ItemMasterCatNewModal.error(String jsons,int stcode) {
    return ItemMasterCatNewModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class ItemMasterCatagoryNewData {
  ItemMasterCatagoryNewData();

  


  factory ItemMasterCatagoryNewData.fromJson(Map<String, dynamic> json) {
    // print("!-----------------------------2--------");
  return ItemMasterCatagoryNewData(
    );
     }
}
