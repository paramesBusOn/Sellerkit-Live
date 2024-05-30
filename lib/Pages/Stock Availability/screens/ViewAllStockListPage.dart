// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/StockAvailabilityController/StockListController.dart';
import '../../../DBModel/ItemMasertDBModel.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class StockListOfDetails extends StatefulWidget {
  StockListOfDetails({Key? key}) : super(key: key);

  @override
  State<StockListOfDetails> createState() => StockListOfDetailsState();
}

class StockListOfDetailsState extends State<StockListOfDetails> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
    DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();//StockListController
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
       print("are you sure");
   //if(context.read<StockListController>().getviewAll[0].brand != 'null'){
     if(context.read<StockListController>().getviewAllBrandSelected == true){
     print("Brand");
     context.read<StockListController>().brandViewAllData().then((value) {
       context.read<StockListController>().clearViewAllData();

      });
    }else if(context.read<StockListController>().getviewAllProductSelected == true){
     print("category");
      context.read<StockListController>().productViewAllData().then((value) {
       context.read<StockListController>().clearViewAllData();

      });

    }else{
     print("segment");
  context.read<StockListController>().segmentViewAllData().then((value) {
       context.read<StockListController>().clearViewAllData();
     });
    }
    }
   ScaffoldMessenger.of(context).removeCurrentSnackBar();
      return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(       
          drawerEnableOpenDragGesture: false,
          key: scaffoldKey,
          appBar: appbar("Stock List", scaffoldKey, theme, context),
          drawer: drawer3(context),
          body: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            padding: paddings.padding3(context),
            child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.stock);
                      });
                    }
                  },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                 height: Screens.bodyheight(context) * 0.06,
                 decoration: BoxDecoration(
                   color: theme.primaryColor
                       .withOpacity(0.1), //Colors.grey[200],
                   borderRadius: BorderRadius.circular(
                       Screens.width(context) * 0.02),
                 ),
                 child: TextField(
                   autocorrect: false,
                   onChanged: (v) {
                   context.read<StockListController>().filterList2(v);
                   },
                   decoration: InputDecoration(
                     filled: false,
                     hintText: 'Search Here!!..',
                     enabledBorder: InputBorder.none,
                     focusedBorder: InputBorder.none,
                     prefixIcon: IconButton(
                       icon: const Icon(Icons.search),
                       onPressed: () {
                         FocusScopeNode focus = FocusScope.of(context);
                         if (!focus.hasPrimaryFocus) {
                           focus.unfocus();
                         }
                       }, //
                       color: theme.primaryColor,
                     ),
                     contentPadding: const EdgeInsets.symmetric(
                       vertical: 12,
                       horizontal: 5,
                     ),
                   ),
                 ),
               ),
                 SizedBox(height: Screens.bodyheight(context)*0.005,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Wrap(
                              spacing: 10.0, // gap between adjacent chips
                              runSpacing: 15.0, // gap between lines
                              children:
                                  listContainersProduct(theme, 
                                  context.read<StockListController>().searchviewAll
                                   )),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: Screens.width(context),
                    child: ElevatedButton(
                      onPressed: () {
                         if(context.read<StockListController>().getviewAllBrandSelected == true){
                 print("Brand");
                 context.read<StockListController>().brandViewAllData().then((value) {
                   context.read<StockListController>().clearViewAllData();
                 });
                }else if(context.read<StockListController>().getviewAllProductSelected == true){
                 print("category");
                  context.read<StockListController>().productViewAllData().then((value) {
                   context.read<StockListController>().clearViewAllData();
            
                  });
            
                }else{
                 print("segment");
             context.read<StockListController>().segmentViewAllData().then((value) {
                   context.read<StockListController>().clearViewAllData();
                 });
                }
                      },
                      child: Text("Ok"),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
    List<ItemMasterDBModel> content,
  ) {
    // if(content[0].brand != 'null'){
   if(context.read<StockListController>().getviewAllBrandSelected == true){
      return List.generate(
   context.read<StockListController>().searchviewAll.length,
    //    content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockListController>().isselectedBrandViewAll(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.28,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color:  context.watch<StockListController>().searchviewAll[index].isselected==1
           //     content[index].isselected == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(content[index].brand,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: 
         context.watch<StockListController>().searchviewAll[index].isselected==1             
                      //content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
   
    }
    // else if(content[0].category != 'null'){

      else if(context.read<StockListController>().getviewAllProductSelected == true){
     
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockListController>().isselectedProductViewAll(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.28,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color:
                context.watch<StockListController>().searchviewAll[index].isselected == 1
                // content[index].isselected == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(content[index].category,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
        
                     color:
                     context.watch<StockListController>().searchviewAll[index].isselected == 1
                     // content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    
    }
    /// ELSE 
    /// 
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<StockListController>().isselectedSegmentViewAll(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.28,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: 
                context.watch<StockListController>().searchviewAll[index].isselected == 1
                //content[index].isselected == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(content[index].segment,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: 
                      context.watch<StockListController>().searchviewAll[index].isselected == 1
                      //content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
   
  }
}
