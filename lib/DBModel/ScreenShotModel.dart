
import 'package:sellerkit/DBModel/EnqTypeModel.dart';



const String tableScreenShot = "ScreenShot";

class ScreenShotTab {
  static const String Filepath= "Filepath";
  static const String DateTime = "DateTime";

}
class ScreenShotModel{
 String? filePath;
 String dateTime;



ScreenShotModel({

 required this.dateTime,
  required this.filePath,
});

Map<String , Object?> toMap()=>{
  ScreenShotTab.Filepath:dateTime,
  ScreenShotTab.DateTime:filePath,

};
}
