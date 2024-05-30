// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sellerkit/Constant/Screen.dart';

class RestrictionPage extends StatefulWidget {
  const RestrictionPage({Key? key}) : super(key: key);

  @override
  State<RestrictionPage> createState() => RestrictionPageState();
}

class RestrictionPageState extends State<RestrictionPage> {
  static bool loginbool=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loginbool=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(child:Lottie.asset('Assets/Animation - 1707327905595.json',
                                animate: true,
                                repeat: true,
                                height: Screens.padingHeight(context) * 0.3,
                                width: Screens.width(context) * 0.3) ,),
          ),
          
          Center(
            child: Text("You are out of Whitelisted zone..!!!",),
          ),
        ],
      ),
    );
  }
}