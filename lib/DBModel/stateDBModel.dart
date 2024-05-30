// import 'package:sellerkit/DBModel/EnqTypeModel.dart';

const String tableStateMaster = "StateMaster";

class StateMasterDB {
  static const String statecode = "statecode";
  static const String statename = "statename";
  static const String cuntrycode = "cuntrycode";
  static const String countryname = "countryname";
  
}

class StateMasterDBModel {
  StateMasterDBModel({
    required this.stateCode,
    required this.stateName,
    required this.cuntryCode,
    required this.countryName,
    
  });

  String? stateCode;
  String? stateName;
  String? cuntryCode;
  String? countryName;
  

  Map<String, Object?> toMap() => {
       

        StateMasterDB.statecode: stateCode,
        StateMasterDB.statename: stateName,
        StateMasterDB.cuntrycode: cuntryCode,
        StateMasterDB.countryname: countryName,
        
      };

     

}
