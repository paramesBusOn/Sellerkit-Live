// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
// import 'package:table_calendar/table_calendar.dart';
import '../../../Constant/Screen.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class FollowUpPage extends StatefulWidget {
  FollowUpPage({Key? key}) : super(key: key);

  @override
  State<FollowUpPage> createState() => _FollowUpPageState();
}

class _FollowUpPageState extends State<FollowUpPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? _focusedDay;
  DateTime? _selectedDay;
  var now;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusedDay = DateTime.now();
    now = Jiffy();
    print("jiifi: " + now.EEEE);
    print("MEd: " + now.MEd);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(       
       drawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        appBar: appbar("Followup", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: SafeArea(
          child: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            child: Stack(
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.02),
                  child: Column(
                    children: [
                      Container(
                        width: Screens.width(context),
                        color: Colors.grey[200],
                        // child: TableCalendar(
                        //   firstDay: DateTime.utc(1990, 10, 16),
                        //   lastDay: DateTime.utc(2050, 3, 14),
                        //   focusedDay: _focusedDay!,
                        //   selectedDayPredicate: (day) {
                        //     return isSameDay(_focusedDay, day);
                        //   },
                        //   onDaySelected: (selectedDay, focusedDay) {
                        //     setState(() {
                        //       _selectedDay = selectedDay;
                        //       _focusedDay =focusedDay; // update `_focusedDay` here as well
                        //     });
                        //   },
                        // ),
                      ),
                      SizedBox(height: Screens.bodyheight(context)*0.02,),
                      Container(
                          width: Screens.width(context), child: Text("Today - ${now.MEd}",
                          style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                          )),
                      Expanded(child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: Screens.width(context),
                            // height: Screens.bodyheight(context)*0.3,
                            // color: Colors.blueGrey,
                            padding: EdgeInsets.only(
                              top: Screens.bodyheight(context)*0.01
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width:Screens.width(context)*0.2,
                                  height: Screens.bodyheight(context)*0.08,
                                //  color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                  width:Screens.width(context)*0.1,
                                  height: Screens.bodyheight(context)*0.05,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  //  color: Colors.amber
                                  ),
                                  child: Icon(Icons.credit_card_outlined,
                                  color: theme.primaryColor,),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                            width:Screens.width(context)*0.1,
                                 // height: Screens.bodyheight(context)*0.05,
                                 // color: Colors.yellow,
                                        child: Text("26m",textAlign: TextAlign.center,
                                        style: theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey
                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 Container(
                                  width:Screens.width(context)*0.5,
                                  height: Screens.bodyheight(context)*0.08,
                                 // color: Colors.blue,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(child: Text('5:00 pm',
                                     /// textAlign:TextAlign.center,
                                        style: theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey
                                        ),)),
                                      Container(child: Text('Call with sam',
                                     //  textAlign:TextAlign.center,
                                        style: theme.textTheme.bodyText1?.copyWith(
                                         // color: Colors.grey
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                 Container(
                                  width:Screens.width(context)*0.2,
                                  height: Screens.bodyheight(context)*0.08,
                                 // color: Colors.yellow,
                                  child: Row(
                                    children: [
                                     Container(
                                      alignment: Alignment.center,
                                       width:Screens.width(context)*0.1,
                                  height: Screens.bodyheight(context)*0.08,
                                       decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellow,
                                  ),
                                  child: Text("G",
                                    textAlign:TextAlign.center,
                                        style: theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.white
                                        ),),
                                     )  ,
                                         Container(
                                      alignment: Alignment.center,
                                       width:Screens.width(context)*0.1,
                                  height: Screens.bodyheight(context)*0.08,
                                       decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: Text("G",
                                    textAlign:TextAlign.center,
                                        style: theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.white
                                        ),),
                                     )  ,
                                  ],)
                                ),
                              ],
                            ),

                          );
                        },
                      ),)
                    ],
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context),
                    color: Colors.white54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
