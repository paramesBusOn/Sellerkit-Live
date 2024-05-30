// To parse this JSON data, do
//
//     final stockDetails = stockDetailsFromJson(jsonString);


import 'dart:convert';

StockDetails stockDetailsFromJson(String str,int stcode) =>
    StockDetails.fromJson(json.decode(str),stcode);

String stockDetailsToJson(StockDetails data) => json.encode(data.toJson());

class StockDetails {
  StockDetails(
      {required this.status,
      required this.message,
      required this.brands,
      required this.segment,
      required this.divsion,
      required this.category,
      required this.exception,
      required this.stacode});

  bool? status;
  String? message;
  String? exception;
  List<Brand>? brands;
  List<Segment>? segment;
  List<Division>? divsion;
  List<Category>? category;
  int stacode;

  factory StockDetails.fromJson(Map<String, dynamic> json,int stcode) => StockDetails(
        status: json["status"],
        message: json["message"],
        exception: null,
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
        segment:
            List<Segment>.from(json["segment"].map((x) => Segment.fromJson(x))),
        divsion: List<Division>.from(
            json["divsion"].map((x) => Division.fromJson(x))),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
            stacode: stcode
      );

  factory StockDetails.exception(String jsons,int stcode) {
    return StockDetails(
        status: null,
        message: null,
        brands: null,
        segment: null,
        divsion: null,
        category: null,
        exception: jsons,
         stacode: stcode);
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "brands": List<dynamic>.from(brands!.map((x) => x.toJson())),
        "segment": List<dynamic>.from(segment!.map((x) => x.toJson())),
        "divsion": List<dynamic>.from(divsion!.map((x) => x.toJson())),
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class Brand {
  Brand({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class Segment {
  Segment({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class Division {
  Division({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class Category {
  Category({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
