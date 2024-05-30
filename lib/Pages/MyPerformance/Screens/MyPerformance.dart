// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../Constant/padings.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import '../../../Widgets/Navi3.dart';

class MyPerformance extends StatefulWidget {
  const MyPerformance({Key? key}) : super(key: key);

  @override
  State<MyPerformance> createState() => _MyPErformanceState();
}

class _MyPErformanceState extends State<MyPerformance> {
     final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
      final theme = Theme.of(context);
    return Scaffold(        drawerEnableOpenDragGesture: false,

      key: scaffoldKey,
      appBar: appbar("My Performance", scaffoldKey,theme,context),
      drawer: drawer3(context),
      body: Container(
          padding: paddings.padding2(context),
          child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width:Screens.width(context),
                  height: Screens.bodyheight(context)*0.4,
                 // color: Colors.blue,
                  child: charts.LineChart(_createSampleData(),
                  defaultRenderer:
              charts.LineRendererConfig(includeArea: true, stacked: true),
                  animate: true),
                ),
                SizedBox(height: Screens.bodyheight(context)*0.01,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context)*0.3,
                     // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            width: Screens.width(context)*0.07,
                            height: Screens.bodyheight(context)*0.03,
                            color: Colors.green,
                          ),
                           SizedBox(width: Screens.width(context)*0.01,),
                          Container(
                            child: Text("Mobile"),
                          )
                        ],
                      ),
                    ),
                       SizedBox(
                      width: Screens.width(context)*0.3,
                     // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            width: Screens.width(context)*0.07,
                            height: Screens.bodyheight(context)*0.03,
                            color: Colors.red,
                          ),
                          SizedBox(width: Screens.width(context)*0.01,),
                          Container(
                            child: Text("Tablet"),
                          )
                        ],
                      ),
                    ),
                       Container(
                         alignment: Alignment.centerRight,
                      width: Screens.width(context)*0.3,
                     // color: Colors.red,
                      child: Row(
                       
                        children: [
                          Container(
                            width: Screens.width(context)*0.07,
                            height: Screens.bodyheight(context)*0.03,
                            color: Colors.blue,
                          ),
                           SizedBox(width: Screens.width(context)*0.01,),
                          Container(
                            child: Text("Desktop"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                  SizedBox(height: Screens.bodyheight(context)*0.01,),
          
                  SizedBox(
                  //  color: Colors.red,
                    height: Screens.bodyheight(context)*0.5,
                    child: SingleChildScrollView(
                      child:  Wrap(
            spacing: 20.0, // gap between adjacent chips
            runSpacing: 10.0, // gap between lines
            children:listContainers(theme,content) //<Widget>[
              // Chip(
              //   avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('AH')),
              //   label: Text('Hamilton'),
              // ),
              // Chip(
              //   avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('ML')),
              //   label: Text('Lafayette'),
              // ),
              // Chip(
              //   avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('HM')),
              //   label: Text('Mulligan'),
              // ),
              // Chip(
              //   avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('JL')),
              //   label: Text('Laurens'),
              // ),
            //],
          )))]),
          )));
  }
  
   static List<charts.Series<LinearSales, int>> _createSampleData() {
    List<LinearSales> mobilesales =[
      LinearSales(0, 65),
      LinearSales(1, 75),
      LinearSales(2, 80),
      LinearSales(3, 90),
    ];

    List<LinearSales> desktopsales =[
      LinearSales(0, 5),
      LinearSales(1, 10),
      LinearSales(2, 5),
      LinearSales(3, 15),
    ];
    List<LinearSales> tabsales =[
     LinearSales(0, 10),
      LinearSales(1, 20),
      LinearSales(2, 20),
      LinearSales(3, 30),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: ( LinearSales sales, _) => sales.sales,
        data: desktopsales,
      ),
      charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: tabsales,
      ),
      charts.Series<LinearSales, int>(
        id: 'Mobile',
        displayName: "Mobile",
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: mobilesales,
        labelAccessorFn: (LinearSales sales,int)=>sales.year.toString()
      ),
    ];
  }
  //cahrts depends on which one get high sales its show larger widh....

  List<Content> content =[
    Content("3.45 Lacs", "MTD"),
    Content("64%", "Target Ach"),
    Content("2.96 Lacs", "BTG"),
    Content("3.86 Lacs", "Open Opportun"),
    Content("2496.00 Lacs", "Earning"),
    Content("3323.00s", "Earning Opportun"),
    Content("Rank #42", "Over all"),
    Content("Rank #44", "Team"),
  ];
  List<Widget> listContainers(ThemeData theme,List<Content> content){
    return List.generate(content.length, (index) => 
 Container(
         
           decoration: BoxDecoration(
             //color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.primaryColor)
           ),
           child: Column(
             children: [
               Container(
                 width: Screens.width(context)*0.4,
                   padding: EdgeInsets.symmetric(
          vertical: Screens.bodyheight(context)*0.02,
          horizontal: Screens.width(context)*0.04
        ), child: Text(content[index].one,  style: theme.textTheme.bodySmall?.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold),),
               ),
               Container(
          padding: EdgeInsets.symmetric(
          vertical: Screens.bodyheight(context)*0.02,
          horizontal: Screens.width(context)*0.04
        ),
        width: Screens.width(context)*0.4,
                  decoration: BoxDecoration( 
             color: theme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft:Radius.circular(10) )
           ),
                 child: Text(content[index].two,  style: theme.textTheme.bodySmall?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
               )
             ],
           ),
         ),
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class Content {
  final String one ;
  final String two;
  Content(this.one, this.two);
}


// Expanded(child: GridView.builder(
        //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             crossAxisSpacing: 5,
                   
        //           ),
        //           itemCount: 6,
        //           itemBuilder: (BuildContext context, int index) {
        //             return Container(
        //  padding: EdgeInsets.all(20),
         
        //    child: Container(
        //        decoration: BoxDecoration(
        //      //color: theme.primaryColor,
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(color: theme.primaryColor)
        //    ),
        //      child: Column(
        //        children: [
        //          Container(
        //              padding: EdgeInsets.symmetric(
        //   vertical: Screens.bodyheight(context)*0.02,
        //   horizontal: Screens.width(context)*0.04
        // ),
        //            child: Text("85 Lacks",  style: theme.textTheme.subtitle1?.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold),),
        //          ),
        //          Container(
        //              padding: EdgeInsets.symmetric(
        //   vertical: Screens.bodyheight(context)*0.02,
        //   horizontal: Screens.width(context)*0.04
        // ),
        //             decoration: BoxDecoration(
        //        color: theme.primaryColor,
        //         borderRadius: BorderRadius.only(
        //           bottomRight: Radius.circular(10),
        //           bottomLeft:Radius.circular(10) )
        //      ),
        //            child: Text("Month Taget",  style: theme.textTheme.subtitle1?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
        //          )
        //        ],
        //      ),
        //    ),
        //  );
        //           },
        //         ),)