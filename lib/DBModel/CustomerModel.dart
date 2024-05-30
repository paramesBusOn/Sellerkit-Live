// import 'package:sellerkit/DBModel/EnqTypeModel.dart';

const String tableCustomerMaster = "CustomerMaster";

class CustomerMasterDB {
  static const String id = "id";
  static const String cardcode = "cardcode";
  static const String cardname = "cardname";
  static const String cantactName = "cantactName";
  static const String mobile = "mobile";
  static const String alterMobileno = "alterMobileno";
  static const String email = "email";
  static const String gst = "gst";
  static const String address1 = "address1";
  static const String address2 = "address2";
  static const String zipcode = "zipcode";
  static const String city = "city";
  static const String state = "state";
  static const String area = "area";
  static const String tag = "tag";
}

class CustomerMasterDBModel {
  CustomerMasterDBModel({
    required this.id,
    required this.cardcode,
    required this.cardname,
    required this.cantactName,
    required this.mobile,
    required this.alterMobileno,
    required this.email,
    required this.gst,
    required this.address1,
    required this.address2,
    required this.zipcode,
    required this.city,
    required this.state,
    required this.area,
    required this.tag,
  });

  int? id;
  String? cardcode;
  String? cardname;
  String? cantactName;
  String? mobile;
  String? alterMobileno;
  String? email;
  String? gst;
  String? address1;
  String? address2;
  String? zipcode;
  String? city;
  String? state;
  String? area;
  String? tag;

  Map<String, Object?> toMap() => {
        // CustomerMasterDB.cardcode:dateTime,
        // CustomerMasterDB.DateTime:filePath,

        CustomerMasterDB.id: id,
        CustomerMasterDB.cardcode: cardcode,
        CustomerMasterDB.cardname: cardname,
        CustomerMasterDB.cantactName: cantactName,
        CustomerMasterDB.mobile: mobile,
        CustomerMasterDB.alterMobileno: alterMobileno,
        CustomerMasterDB.email: email,
        CustomerMasterDB.gst: gst,
        CustomerMasterDB.address1: address1,
        CustomerMasterDB.address2: address2,
        CustomerMasterDB.zipcode: zipcode,
        CustomerMasterDB.city: city,
        CustomerMasterDB.state: state,
        CustomerMasterDB.area: area,
        CustomerMasterDB.tag: tag
      };

      // Map<String, Object?> toMap() => {
      //   LeadStatusReason.code: code,
      //   LeadStatusReason.name: name,
      //   LeadStatusReason.statusType: statusType,
      // };

}
