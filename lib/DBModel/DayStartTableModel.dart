// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names
const String tableDayStart = "DayStart";

class DayStartColumns {
  // static const String docEntry = "Customer";
  static const String date = "Date";
  static const String time = "Time";
  static const String dayType = "DayType";
  static const String address = "Address";
}

class DayStartDBModel {
  // int? docEntry;
  String? date;
  String? time;
  String? dayType;
  String? address;

  DayStartDBModel({
    // required this.docEntry,
    required this.date,
    required this.time,
    required this.dayType,
    required this.address,
  });

  Map<String, Object?> toMap() => {
        DayStartColumns.date: date,
        DayStartColumns.time: time,
        DayStartColumns.dayType: dayType,
        DayStartColumns.address: address,
      };
}
