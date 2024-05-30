// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/CustomerCreationModel.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Controller/LeadController/LeadNewController.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class LeadSuccessPage extends StatefulWidget {
  LeadSuccessPage({Key? key}) : super(key: key);

  @override
  State<LeadSuccessPage> createState() => LeadSuccessPageState();
}

class LeadSuccessPageState extends State<LeadSuccessPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   print("data doccc: "+ context.read<LeadNewController>().getsuccessRes.DocNo.toString());
    });
  }

  static datadetails? getsuccessRes;
  DateTime? currentBackPressTime;
  Config config = new Config();
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.leadstab);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          // backgroundColor: Colors.grey[200],
          /// resizeToAvoidBottomInset: true,
          key: scaffoldKey,
          appBar: appbar("Leads", scaffoldKey, theme, context),
          drawer: drawer3(context),
          body: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/newleadsucess.png"),
                    fit: BoxFit.cover)),
            child: getsuccessRes == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Positioned(
                        top: Screens.bodyheight(context) * 0.3,
                        child: Container(
                          alignment: Alignment.center,
                          width: Screens.width(context),
                          height: Screens.bodyheight(context) * 0.6,
                          //color: Colors.red,
                          padding: EdgeInsets.only(
                            left: Screens.width(context) * 0.1,
                            right: Screens.width(context) * 0.1,
                            // top: Screens.bodyheight(context)*0.02,
                            // bottom: Screens.bodyheight(context)*0.02
                          ),

                          // margin: EdgeInsets.symmetric(
                          //   horizontal:  Screens.width(context)*0.1,
                          //   // left: Screens.width(context)*0.1,
                          //   // right: Screens.width(context)*0.1,
                          //     ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "Lead Created Successfully",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.grey),
                                )),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "Lead Entry #${getsuccessRes!.leaddetail![0].DocNo.toString()}",
                                  style: theme.textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.003,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "${getsuccessRes!.leaddetail![0].CardName}",
                                  style: theme.textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.003,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "${getsuccessRes!.leaddetail![0].CardCode}",
                                  style: theme.textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.003,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: getsuccessRes!.leaddetail![0].U_sk_email==null||getsuccessRes!.leaddetail![0].U_sk_email!.isEmpty?Text(""): Text(
                                  "${getsuccessRes!.leaddetail![0].U_sk_email}",
                                  style: theme.textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.04,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.8,
                                  height: Screens.padingHeight(context)*0.1,
                                  // color: Colors.blue,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children:
                                                  [
                                        // Expanded(
                                        //   child: 
                                          Wrap(
                                              spacing: 10.0, // width
                                              runSpacing: 8.0, // height
                                              children: listText(theme,getsuccessRes!.dataline!
                                                  )
                                               
                                                  ),
                                        // ),
                                      ],
                                    ),
                                  )
                                  ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.03,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "Next Followup Date " +
                                      config
                                          .alignDate(
                                              getsuccessRes!.leaddetail![0].U_sk_NextFollowDt!)
                                          .toString(),
                                  style: theme.textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.01,
                              // ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   width: Screens.width(context) * 0.8,
                              //   //   color: Colors.blue,
                              //   child: Center(
                              //       child: Text(
                              //     "Next Followup Date " +
                              //         config
                              //             .alignDate(
                              //                 getsuccessRes!.U_sk_NextFollowDt!)
                              //             .toString(),
                              //     style: theme.textTheme.bodyText2,
                              //     textAlign: TextAlign.center,
                              //   )),
                              // ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("Set Reminder: "),
                                        FlutterSwitch(
                                            showOnOff: true,
                                            width: 60,
                                            height: 25,
                                            activeText: "On",
                                            inactiveText: "Off",
                                            activeColor: theme.primaryColor,
                                            value: context
                                                .watch<LeadNewController>()
                                                .remswitch,
                                            onToggle: (val) {
                                              context
                                                  .read<LeadNewController>()
                                                  .switchremainder(val,"Remainder for Lead Next followup on${config
                                          .alignDate(
                                              getsuccessRes!.leaddetail![0].U_sk_NextFollowDt!)} for ${getsuccessRes!.leaddetail![0].CardName}");
                                              //  print(val);
                                              // setState(() {
                                              //   switched = val;
                                              //   reqfinance = "Y";
                                              // });
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.05,
                              ),
                              Container(
                                width: Screens.width(context),
                                height: Screens.bodyheight(context) * 0.06,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.offAllNamed(ConstantRoutes.leadstab);
                                  },
                                  child: Text("Done"),
                                  // style: Elev,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          )),
    );
  }

  List<Widget> listText(ThemeData theme, List<LeadLine> data) {
    return List.generate(
      data.length,
      (index) => Container(
        width: Screens.width(context),
          
          child: Text(data[index].itemName.toString(),
              textAlign: TextAlign.center, style: theme.textTheme.bodyText2)),
    );
  }
}
