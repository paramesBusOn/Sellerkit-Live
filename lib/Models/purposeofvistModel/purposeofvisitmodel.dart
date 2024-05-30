class purposeofvisit {
  List<visitpurpose>? purposevisit;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  purposeofvisit(
      {required this.purposevisit,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory purposeofvisit.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<visitpurpose> datalist =
          list.map((data) => visitpurpose.fromJson(data)).toList();
      return purposeofvisit(
          purposevisit: datalist,
          message: "success",
          status: true,
          stcode: stcode);
    } else {
      return purposeofvisit(
          purposevisit: null,
          message: "failure",
          status: false,
          stcode: stcode);
    }
  }
  factory purposeofvisit.error(String jsons, int stcode) {
    return purposeofvisit(
        purposevisit: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class visitpurpose {
  int? id;
  int? mastertypeid;
  String? code;
  String? description;
  String? descriptiontype;
  int? parentmasterid;
  int? status;
  int? createdby;
  String? createdon;
  int? updatedby;
  String? updatedon;
  visitpurpose(
      {required this.code,
      required this.createdby,
      required this.createdon,
      required this.description,
      required this.descriptiontype,
      required this.id,
      required this.mastertypeid,
      required this.parentmasterid,
      required this.status,
      required this.updatedby,
      required this.updatedon});
  factory visitpurpose.fromJson(Map<String, dynamic> jsons) {
    return visitpurpose(
        code: jsons["code"],
        createdby: jsons["createdBy"],
        createdon: jsons["createdOn"],
        description: jsons["description"],
        descriptiontype: jsons["descriptionTypes"],
        id: jsons["id"],
        mastertypeid: jsons["masterTypeId"],
        parentmasterid: jsons["parentMasterId"],
        status: jsons["status"],
        updatedby: jsons["updatedBy"],
        updatedon: jsons["updatedOn"]);
  }
}
// {id: 73, 
//masterTypeId: 9,
// code: 01, description: Demo,
// parentMasterId: 0,
// status: 1, 
//createdBy: 1, 
//createdOn: 2023-10-31T15:10:09.99, 
//updatedBy: 1,
// updatedOn: 2023-10-31T15:10:09.99, 
//descriptionTypes: null, 
//isFixed: 1,
// nextStatus: null},