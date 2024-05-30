import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier  {

  ThemeManager(){
    // timer();
    selectedThemeData();
  }
  Timer? _timer;
timer()async{
 
   _timer = Timer( Duration(seconds: 5), restartApp
//    (timer) async{
//     //  log("timer::"+.toString());
 
//  restartApp();
//   }
  );
 
}

void restartApp() {
  log("hiiiii");
    _timer?.cancel(); 
    // exit(0);
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  String selectedTheme = '';

  void changeTheme(String theme) async {
  final SharedPreferences pref2 = await pref;
  pref2.setString("SelectedTheme", theme);
  selectedTheme =  pref2.getString("SelectedTheme").toString();
  notifyListeners();
  }

  Future<String> selectedThemeData()async{
   final SharedPreferences pref2 = await pref;
 // pref2.setString("SelectedTheme", 'merron');
  selectedTheme =  pref2.getString("SelectedTheme").toString();
  if(selectedTheme == 'merron'){
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;

  }else if(selectedTheme == 'blue'){
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;

  }else if(selectedTheme == 'orange'){
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;

  }else{
    pref2.setString("SelectedTheme", 'merron');
    selectedTheme =  pref2.getString("SelectedTheme").toString();
    notifyListeners();
    return selectedTheme;
  }
  }

  String get isselectedTheme =>  selectedTheme;

}
