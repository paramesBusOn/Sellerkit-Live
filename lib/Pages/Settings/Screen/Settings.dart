// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sellerkit/Pages/Settings/Screen/themeSetting.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: appbar("Settings", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: Container(
          padding: paddings.padding2(context),
          child: Column(
            children: [
              ListTile(
                onTap: (){

                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("About Us",
                      style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                      // width: Screens.width(context),
                      //   color: Colors.red,
                      child: Icon(
                        Icons.chevron_right_sharp,
                        color: theme.primaryColor,
                        size: Screens.bodyheight(context) * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
               ListTile(
                onTap: (){

                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("Contact Us",
                      style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                      // width: Screens.width(context),
                      //   color: Colors.red,
                      child: Icon(
                        Icons.chevron_right_sharp,
                        color: theme.primaryColor,
                        size: Screens.bodyheight(context) * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
               ListTile(
                onTap: (){

                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("Help",
                      style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                      // width: Screens.width(context),
                      //   color: Colors.red,
                      child: Icon(
                        Icons.chevron_right_sharp,
                        color: theme.primaryColor,
                        size: Screens.bodyheight(context) * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
               ListTile(
                onTap: (){

                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("Privacy policy",
                      style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                      // width: Screens.width(context),
                      //   color: Colors.red,
                      child: Icon(
                        Icons.chevron_right_sharp,
                        color: theme.primaryColor,
                        size: Screens.bodyheight(context) * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
                ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ThemeSetting()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("Themes",
                      style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                      // width: Screens.width(context),
                      //   color: Colors.red,
                      child: Icon(
                        Icons.chevron_right_sharp,
                        color: theme.primaryColor,
                        size: Screens.bodyheight(context) * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
             SizedBox(height: Screens.bodyheight(context)*0.01,),
              Center(
                child: Container(
                  child: Column(
                    children:[
                      Container(
                        child: Text("Version 1.0.2"),
                      ),
                      SizedBox(height: Screens.bodyheight(context)*0.01,),
                       Container(
                        child: Text("8620sjry93hy12h"),
                      ),
                    ]
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
