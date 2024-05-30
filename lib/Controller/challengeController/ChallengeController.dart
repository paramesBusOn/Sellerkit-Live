

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sellerkit/Services/ChallengeApi/challengeApi.dart';

import '../../Models/ChallengeModel/challengemodel.dart';

class challengeController extends ChangeNotifier{
  challengeController(){
getchallenges();
  }

List<ChallengeData> challengeDatadetails=[];
List<ChallengeData> get getchallengedatadetails=>challengeDatadetails;

 List<challengeproduct>? challengeproductlist22=[];
  List<challengeproduct>? get getchallengeproductlist=>challengeproductlist22;

  List<challengestore> challengestorelist=[];
  List<challengestore> get getchallengestorelist=>challengestorelist;

getchallenges()async{
  await ChallengeApi.getdata().then((value) {
if(value.stcode! >= 200 && value.stcode! <= 210){
  if(value.challengeDatadetails != null){
    
    for(int i=0;i<value.challengeDatadetails!.length;i++){
challengeDatadetails=value.challengeDatadetails!;
// for(int ij=0;ij<value.challengeDatadetails![i].challengeproductlist!.length;ij++){
challengeproductlist22=value.challengeDatadetails![i].challengeproductlist;
// }
challengestorelist=value.challengeDatadetails![i].challengestorelist!;
// log("challengeDatadetails"+value.challengeDatadetails![i].challengestorelist![2].slpcode.toString());
// log("challengestorelist"+challengestorelist[1].slpcode.toString());

notifyListeners();

 }
  }
}

  });
}


}