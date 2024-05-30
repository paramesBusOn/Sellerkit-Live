// ignore_for_file: file_names, constant_identifier_names
const String tableSiteCheckIn = "SiteCheckIn";

class SiteCheckInColumns {
  // static const String docEntry = "Customer";
  static const String customer = "Customer";
  static const String mobile = "Mobile";
  static const String cantactName = "CantactName";
  static const String address1 = "Address1";
  static const String address2 = "Address2";
  static const String area = "Area";
  static const String city = "City";
  static const String pincode = "Pincode";
  static const String state = "State";
  static const String purpose = "Purpose";
  static const String siteType = "SiteType";
  static const String date = "Date";
  static const String time = "Time";
  static const String datetime = "DateTime";
}

class SiteCheckInDBModel {
  // int? docEntry;
  String? customer;
  int? mobile;
  String? cantactName;
  String? address1;
  String? address2;
  String? area;
  String? city;
  int? pincode;
  String? state;
  String? purpose;
  String? siteType;
  String? date;
  String? time;
  String? datetime;

  SiteCheckInDBModel(
      {
      // required this.docEntry,
      required this.customer,
      required this.mobile,
      required this.cantactName,
      required this.address1,
      required this.address2,
      required this.area,
      required this.city,
      required this.pincode,
      required this.siteType,
      required this.date,
      required this.time,
      required this.datetime,
      required this.purpose,
      required this.state});

  Map<String, Object?> toMap() => {
        SiteCheckInColumns.customer: customer,
        SiteCheckInColumns.mobile: mobile,
        SiteCheckInColumns.cantactName: cantactName,
        SiteCheckInColumns.address1: address1,
        SiteCheckInColumns.address2: address2,
        SiteCheckInColumns.area: area,
        SiteCheckInColumns.city: city,
        SiteCheckInColumns.pincode: pincode,
        SiteCheckInColumns.state: state,
        SiteCheckInColumns.siteType: siteType,
        SiteCheckInColumns.date: date,
        SiteCheckInColumns.time: time,
        SiteCheckInColumns.datetime: datetime,
        SiteCheckInColumns.purpose: purpose
      };
}
