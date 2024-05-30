import 'dart:convert';

import 'package:printing/printing.dart';


import 'dart:convert';

class AddressrModel {
    PlusCode plusCode;
    List<Result> results;
    String status;
    int? stcode;

    AddressrModel({
      this.stcode,
        required this.plusCode,
        required this.results,
        required this.status,
    });

    // factory AddressrModel.fromRawJson(String str) => AddressrModel.fromJson(json.decode(str));

    // String toRawJson() => json.encode(toJson());

    factory AddressrModel.fromJson(Map<String, dynamic> json,int stcode) => AddressrModel(
        plusCode: PlusCode.fromJson(json["plus_code"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
        stcode: stcode
    );

    Map<String, dynamic> toJson() => {
        "plus_code": plusCode.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
    };
}

class PlusCode {
    String compoundCode;
    String globalCode;

    PlusCode({
        required this.compoundCode,
        required this.globalCode,
    });

    factory PlusCode.fromRawJson(String str) => PlusCode.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
    );

    Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
    };
}

class Result {
    List<AddressComponent> addressComponents;
    String formattedAddress;
    Geometry geometry;
    String placeId;
    List<String> types;
    PlusCode? plusCode;

    Result({
        required this.addressComponents,
        required this.formattedAddress,
        required this.geometry,
        required this.placeId,
        required this.types,
        this.plusCode,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
        plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
    );

    Map<String, dynamic> toJson() => {
        "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "place_id": placeId,
        "types": List<dynamic>.from(types.map((x) => x)),
        "plus_code": plusCode?.toJson(),
    };
}

class AddressComponent {
    String longName;
    String shortName;
    List<String> types;

    AddressComponent({
        required this.longName,
        required this.shortName,
        required this.types,
    });

    factory AddressComponent.fromRawJson(String str) => AddressComponent.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
    };
}

class Geometry {
    Viewport? bounds;
    Location location;
    String locationType;
    Viewport viewport;

    Geometry({
        this.bounds,
        required this.location,
        required this.locationType,
        required this.viewport,
    });

    factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        bounds: json["bounds"] == null ? null : Viewport.fromJson(json["bounds"]),
        location: Location.fromJson(json["location"]),
        locationType: json["location_type"],
        viewport: Viewport.fromJson(json["viewport"]),
    );

    Map<String, dynamic> toJson() => {
        "bounds": bounds?.toJson(),
        "location": location.toJson(),
        "location_type": locationType,
        "viewport": viewport.toJson(),
    };
}

class Viewport {
    Location northeast;
    Location southwest;

    Viewport({
        required this.northeast,
        required this.southwest,
    });

    factory Viewport.fromRawJson(String str) => Viewport.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
    );

    Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
    };
}

class Location {
    double lat;
    double lng;

    Location({
        required this.lat,
        required this.lng,
    });

    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}


// class AddressrModel {
//   AddressMasterData? addressdata;
//   String? address2;
//   bool? status;
//   String? exception;
//   int? stcode;
//   AddressrModel(
//       {
//         required this.addressdata,
//       required this.address2,
//       required this.status,
//       this.exception,
//       required this.stcode});
//   factory AddressrModel.fromJson(Map<String, dynamic> jsons, int stcode) {
//     if (jsons["display_name"] != null) {
//       print('json'+jsons.toString());
//       // var list = jsonDecode(jsons["data"]) as List;
//       // List<AddressMasterData> dataList =
//       //     list.map((data) => AddressMasterData.fromJson(data)).toList();
//       return AddressrModel(
//           addressdata: AddressMasterData.fromJson(jsons['address']),
//           address2: jsons["display_name"].toString(),
//           status: true,
//           stcode: stcode,
//           exception: null);
//     } else {
//       return AddressrModel(
//           addressdata: null,
//           address2: jsons["display_name"].toString(),
//           status: false,
//           stcode: stcode,
//           exception: null);
//     }
//   }

//   factory AddressrModel.error(String jsons, int stcode) {
//     return AddressrModel(
//         addressdata: null,
//         address2: null,
//         status: null,
//         stcode: stcode,
//         exception: jsons);
//   }
// }

// class AddressMasterData {
//   int? autoId;
//   String custCode;
//   String? address1;
//   String? address2;
//   String? address3;
//   String billCity;
//   String billstate;
//   String billPincode;
//   String billCountry;
//   String? location1;
//   String? location2;
//   String? createdateTime;
//   String? updatedDatetime;
//   String? createdUserID;
//   String? updateduserid;
//   String? lastupdateIp;
//   String? premiumid;
//   // String shipAddress;
//   // String shipCity;
//   // String shipstate;
//   // String shipPincode;
//   // String shipCountry;
//   AddressMasterData({
//     this.autoId,
//     required this.custCode,
//     required this.address1,
//     required this.address2,
//     this.address3,
//     required this.billCity,
//     required this.billCountry,
//     required this.billPincode,
//     required this.billstate,
//     required this.location1,
//     required this.location2,
//     this.createdateTime,
//     this.updatedDatetime,
//     this.createdUserID,
//     this.lastupdateIp,
//     this.updateduserid,
//     // required this.shipCity,
//     //required this.shipAddress,

//     // required this.shipCountry,
//     // required this.shipPincode,
//     // required this.shipstate
//   });
//   // {\"custcode\":\"B1111\",\"address1\":null,\"address2\":\"P.O. BOX\",\"address3\":null,\"city\":\"MOSHI\",
// // \"statecode\":null,\"pincode\":null,\"countrycode\":\"TZ\",\"geolocation1\":\"\",\"geolocation2\":\"\",
// // \"createdateTime\":\"2023-04-05T10:42:42.253\",\"updatedDatetime\":\"2023-04-05T10:42:42.253\",
// // \"createdUserID\":\"1\",\"updateduserid\":\"1\",\"lastupdateIp\":\"\"}
//   factory AddressMasterData.fromJson(Map<String, dynamic> json) =>
//       AddressMasterData(
//           address1: json['suburb'] ?? '',
//           address2: json['address2'] ?? '',
//           // address3: json['createdateTime'] ?? '',
//           billCity: json['city'] ?? '',
//           billCountry: json['countrycode'] ?? '',
//           billPincode: json['pincode'] ?? '',
//           billstate: json['state'] ?? '',
//           location1: json['geolocation1'] ?? '',
//           custCode: json['custcode'] ?? '',
//           createdUserID: json['createdUserID'] ?? '',
//           createdateTime: json['createdateTime'] ?? '',
//           lastupdateIp: json['lastupdateIp'] ?? '',
//           updatedDatetime: json['updatedDatetime'] ?? '',
//           updateduserid: json['updateduserid'] ?? '',
//           location2: json['geolocation2'] ?? '');
// }

// json['createdateTime'] ?? '',