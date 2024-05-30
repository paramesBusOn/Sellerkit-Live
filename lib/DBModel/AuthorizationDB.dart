const String loginverificationDB = "LoginverificationDB";

class LoginVerificationDB {
  static const String id = "Id";
  static const String code = "Code";
  static const String restrictionType = "RestrictionType";
  static const String restrictionData = "RestrictionData";
  static const String remarks = "Remarks";
}

class VerificationData {
  int? id;
  String? code;
  int? restrictionType;
  String? restrictionData;
  String? remarks;

  VerificationData({
    required this.id,
    required this.code,
    required this.restrictionData,
    required this.restrictionType,
    required this.remarks,
  });

  Map<String, Object?> toMap() => {
        LoginVerificationDB.id: id,
        LoginVerificationDB.code: code,
        LoginVerificationDB.restrictionData: restrictionData,
        LoginVerificationDB.remarks: remarks,
        LoginVerificationDB.restrictionType: restrictionType,
      };
}
