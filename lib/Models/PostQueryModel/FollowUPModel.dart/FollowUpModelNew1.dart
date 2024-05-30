import 'FollowUPModel.dart';

class FlupMLHeader{
 String? FollwUPDate;
 List<FollowUPListData>? flupchild;

 FlupMLHeader({
  required this.FollwUPDate,
  required this.flupchild
 });


    Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "FollwUPDate": FollwUPDate,
      "follwupChild": flupchild!.map((e) => e.tojson()).toList()
    };
    return map;
  }
}