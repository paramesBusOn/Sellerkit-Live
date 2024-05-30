// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Themes/theme_manager.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Navi3.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({Key? key}) : super(key: key);

  @override
  State<ThemeSetting> createState() => ThemeSettingState();
}

class ThemeSettingState extends State<ThemeSetting> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  static bool merron = true;
  static bool blue = true;
  static bool orange = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeManager>(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: appbar("Settings", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: Container(
          padding: paddings.padding2(context),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  themeProv.changeTheme("merron");
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Merron",
                        style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                        // width: Screens.width(context),
                        //   color: Colors.red,
                        child: Radio(
                            value: "merron",
                            groupValue: themeProv.isselectedTheme,
                            onChanged: (v) {
                              merron = merron;
                              //  print(v);
                            }))
                  ],
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              ListTile(
                onTap: () {
                  themeProv.changeTheme("blue");
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Blue",
                        style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                        // width: Screens.width(context),
                        //   color: Colors.red,
                        child: Radio(
                            value: "blue",
                            groupValue: themeProv.isselectedTheme,
                            onChanged: (v) {
                              themeProv.changeTheme("blue");
                            }))
                  ],
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              ListTile(
                onTap: () {
                  themeProv.changeTheme("orange");
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Orange",
                        style: theme.textTheme.subtitle1?.copyWith(),
                      ),
                    ),
                    Container(
                        // width: Screens.width(context),
                        //   color: Colors.red,
                        child: Radio(
                            value: "orange",
                            groupValue: themeProv.isselectedTheme,
                            onChanged: (v) {
                              themeProv.changeTheme("orange");
                            }))
                  ],
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
            ],
          ),
        ));
  }
}
