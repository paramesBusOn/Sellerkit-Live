// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';

class FilterOpenLeadPage extends StatefulWidget {
   FilterOpenLeadPage({Key? key ,}) : super(key: key);

// OpenLeadController openLeadController;
  @override
  State<FilterOpenLeadPage> createState() => FilterOpenLeadPageState();
}

class FilterOpenLeadPageState extends State<FilterOpenLeadPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return 

      Container(
        padding: paddings.padding2(context),
        child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.openLeadPage);
                      });
                    }
                  },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context)*0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Brand",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              10.0, // gap between adjacent chips
                                          runSpacing: 10.0, // gap between lines
                                          children: listContainers(
                                              theme,
                                            ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("object");
                                       context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isbrandViewclick , true);
                                      context.read<OpenLeadController>().getviewAll("Brand");
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
                  //new ch
                  
          Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Group Property",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              10.0, // gap between adjacent chips
                                          runSpacing: 10.0, // gap between lines
                                          children: listGpPty(
                                              theme,
                                            ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
                                    context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isgrpPropViewclick , true);
                                      //  context.watch<OpenLeadController>().isgrpPropViewclick  = true;
                                     context.read<OpenLeadController>().getviewAll("GroupProperty");
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
        
        
                               Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Group Segment",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              10.0, // gap between adjacent chips
                                          runSpacing: 10.0, // gap between lines
                                          children: listGpSeg(
                                              theme,
                                         ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
                                    context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isgrpSegmViewclick , true);
        
                                      //  context.watch<OpenLeadController>().isgrpSegmViewclick = true;
                                     context.read<OpenLeadController>().getviewAll("GroupSegment");
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
        
                               Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Division",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              10.0, // gap between adjacent chips
                                          runSpacing: 10.0, // gap between lines
                                          children: listDivision(
                                              theme,
                                           ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
                              context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isDivisViewclick , true);
        
                                      //  context.watch<OpenLeadController>().isDivisViewclick = true;
                                    context.read<OpenLeadController>().getviewAll("Division");
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
                               Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Branch",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              10.0, // gap between adjacent chips
                                          runSpacing: 10.0, // gap between lines
                                          children: listBranch(
                                              theme,
                                           ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
        
                  context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isBrnchViewclick , true);
                                      //  context.watch<OpenLeadController>().isBrnchViewclick = true;
                                      context.read<OpenLeadController>().getviewAll("Branch");
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
                               Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Sales Executive",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              10.0, // gap between adjacent chips
                                          runSpacing: 10.0, // gap between lines
                                          children: listSalesExec(
                                              theme,
                                           ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
                  context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isSalesExecViewclick , true);
                                      
                                      //  context.watch<OpenLeadController>().isSalesExecViewclick = true;
                                      context.read<OpenLeadController>().getviewAll("SalesExecutive");
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
                               Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Branch Manager",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              5.0, // gap between adjacent chips
                                          runSpacing: 5.0, // gap between lines
                                          children: listBranchMang(
                                              theme,
                                            ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
                  context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isBrnchMangViewclick , true);
        
                                      //  context.watch<OpenLeadController>().isBrnchMangViewclick = true;
                                    context.read<OpenLeadController>().getviewAll("BranchManager");
        
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
        
            Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Screens.width(context),
                              //height: Screens.bodyheight(context) * 0.26,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015,
                                  vertical: Screens.bodyheight(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Regional Manager",
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context)*0.01,
                                  ),
                                  SizedBox(
                                      width: Screens.width(context),
                                      child: Wrap(
                                          spacing:
                                              10.0, // gap between adjacent chips
                                          runSpacing: 10.0, // gap between lines
                                          children: listRegMang(
                                              theme,
                                          ))),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () {
                  context.read<OpenLeadController>().trueMethod(context.read<OpenLeadController>().isReginlMangViewclick , true);
        
                                      //  context.watch<OpenLeadController>().isReginlMangViewclick = true;
                                       context.read<OpenLeadController>().getviewAll("RegionalManager");
        
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context),
                                      child:   Text(
                                        "View All",
                                        style: theme.textTheme.bodyText1?.copyWith(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ))),
        
           
                    ],
                  ),
                ),
              ),
        
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                     SizedBox(
                    width: Screens.width(context)*0.2,
                    height: Screens.bodyheight(context)*0.065,
        
                    child: ElevatedButton(
                        onPressed: () {
                    showSearchDialogBox(context,);
                        },
                        onLongPress: (){
        
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.search)//const Text('Search')
                        ),
                  ),
                  SizedBox(
                    width: Screens.width(context)*0.5,
                    height: Screens.bodyheight(context)*0.065,
        
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<OpenLeadController>().viewListOpnLead();
                        },
                      
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Search')),
                  ),
                     SizedBox(
                    width: Screens.width(context)*0.2,
                    height: Screens.bodyheight(context)*0.065,
                    child: ElevatedButton(
                        onPressed:  context.watch<OpenLeadController>().clearbtn == true?null: (){
                         context.read<OpenLeadController>().clearAllDataSelect();
                       //   widget.openLeadController.clearAllData();
                        },
                       
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.filter_alt_off)//const Text('Clear')
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  
   // );
  }

  Widget buildSlideLabel(String value, ThemeData theme) => Text(
        value.toString(),
        style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
      );

  List<Widget> listContainers(
    ThemeData theme,
  //  OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getBrandData.length <= 9) {
      return List.generate(
       context.watch<OpenLeadController>(). getBrandData.length,
        (index) => StatefulBuilder(
          builder: (context,st) {
            return GestureDetector(
              onTap: () {
                //  openLeadController.isselectedBrand(index);
                context.read<OpenLeadController>().isselectedBrand(index);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color:context.watch<OpenLeadController>(). getBrandData[index].color == 1
                        ? theme.primaryColor
                        : Colors.white,
                    border: Border.all(color: theme.primaryColor, width: 1),
                    borderRadius:BorderRadius.circular(5)),
                child: Text(context.watch<OpenLeadController>().getBrandData[index].discColumn!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 12,
                      color: context.watch<OpenLeadController>().getBrandData[index].color == 1
                          ? Colors.white
                          : theme.primaryColor,
                    )),
              ),
            );
          }
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
           context.read<OpenLeadController>().isselectedBrand(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>(). getBrandData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text( context.watch<OpenLeadController>().getBrandData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color: context.watch<OpenLeadController>().getBrandData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

    List<Widget> listGpPty(
    ThemeData theme,
    // OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getGroupProperty.length <= 9) {
      return List.generate(
        context.watch<OpenLeadController>().getGroupProperty.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            context.read<OpenLeadController>().isselectedGropPropM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getGroupProperty[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getGroupProperty[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getGroupProperty[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            context.read<OpenLeadController>().isselectedGropPropM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getGroupProperty[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getGroupProperty[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getGroupProperty[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

   List<Widget> listGpSeg(
    ThemeData theme,
    // OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getgroupSegment.length <= 9) {
      return List.generate(
        context.watch<OpenLeadController>().getgroupSegment.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            context.read<OpenLeadController>().isselectedGropSegmtM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getgroupSegment[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getgroupSegment[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getgroupSegment[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
          context.read<OpenLeadController>().isselectedGropSegmtM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getgroupSegment[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getgroupSegment[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getgroupSegment[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

   List<Widget> listDivision(
    ThemeData theme,
    // OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getDivisionData.length <= 9) {
      return List.generate(
        context.watch<OpenLeadController>().getDivisionData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
           context.read<OpenLeadController>().isselectedDivisionM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getDivisionData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getDivisionData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getDivisionData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
             context.read<OpenLeadController>().isselectedDivisionM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getDivisionData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getDivisionData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getDivisionData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

     List<Widget> listBranch(
    ThemeData theme,
    // OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getBranchData.length <= 9) {
      return List.generate(
        context.watch<OpenLeadController>().getBranchData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
           context.read<OpenLeadController>().isselectedBranchM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getBranchData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getBranchData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getBranchData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
              context.read<OpenLeadController>().isselectedBranchM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getBranchData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getBranchData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getBranchData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

    List<Widget> listSalesExec(
    ThemeData theme,
    // OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getsalesExecutiveData.length <= 9) {
      return List.generate(
        context.watch<OpenLeadController>().getsalesExecutiveData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
             context.read<OpenLeadController>().isselectedSalesExeM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getsalesExecutiveData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getsalesExecutiveData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getsalesExecutiveData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
             context.read<OpenLeadController>().isselectedSalesExeM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getsalesExecutiveData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getsalesExecutiveData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getsalesExecutiveData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

     List<Widget> listBranchMang(
    ThemeData theme,
    // OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getbranchManagerData.length <= 9) {
      return List.generate(
        context.watch<OpenLeadController>().getbranchManagerData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            context.read<OpenLeadController>(). isselectedBrnMagM(index);
          },
          child: Container(
          //  alignment: Alignment.center,
           // width: Screens.width(context) ,
           // height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getbranchManagerData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getbranchManagerData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getbranchManagerData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
          context.read<OpenLeadController>(). isselectedBrnMagM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getbranchManagerData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getbranchManagerData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getbranchManagerData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

  
     List<Widget> listRegMang(
    ThemeData theme,
    // OpenLeadController openLeadController,
  ) {
    if (context.watch<OpenLeadController>().getRegionalManager.length <= 9) {
      return List.generate(
        context.watch<OpenLeadController>().getRegionalManager.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            context.read<OpenLeadController>().isselectedRegMagM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getRegionalManager[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getRegionalManager[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getRegionalManager[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
              context.read<OpenLeadController>().isselectedRegMagM(index);
          },
          child: Container(
           
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context.watch<OpenLeadController>().getRegionalManager[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(context.watch<OpenLeadController>().getRegionalManager[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:context.watch<OpenLeadController>().getRegionalManager[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

   void showSearchDialogBox(BuildContext context,) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              content: Container(
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
                width: Screens.width(context) * 0.8,
                child: Form(
                  key: context.watch<OpenLeadController>().searchKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                          controller: context.watch<OpenLeadController>().searchcon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required *";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Search here',
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(),
                              suffixIcon: InkWell(
                                  onTap: () {
                                   context.read<OpenLeadController>().validateSearch(context);
                                  },
                                  child: Icon(Icons.search,
                                      color: theme.primaryColor)))),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}
