// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';

class FilterScreen2 extends StatefulWidget {
  const FilterScreen2({Key? key}) : super(key: key);

  @override
  State<FilterScreen2> createState() => _FilterScreen2State();
}

class _FilterScreen2State extends State<FilterScreen2> {
  @override
  String? dropdownValue;
  String? dropdownValue2;
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Container(
      // color: Colors.amber,
      width: 50,
      // height: Screens.bodyheight(context)*0.1,
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.004),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Screens.width(context),
                // height: Screens.bodyheight(context)*0.86,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: Screens.width(context),
                      child: Card(
                        elevation: 1,
                        // color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                "Assigned to",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.primaryColor, fontSize: 17),
                              )),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.01,
                              ),
                              Container(
                                // color: Colors.amber,
                                width: Screens.width(context),
                                padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                                // height: Screens.padingHeight(context) * 0.06,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black26)),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox.shrink(),
                                  value: dropdownValue2,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  onChanged: (String? val) {
                                    setState(() {
                                      dropdownValue2 = val!;
                                    });
                                  },
                                  items: <String>[
                                    "Option one",
                                    "Option Two",
                                  ].map((String? value2) {
                                    return DropdownMenuItem(
                                        value: value2,
                                        child: Text(value2.toString()));
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                //  Customer
                        SizedBox(
                width: Screens.width(context),
                child: Card(
                  elevation: 1,
                  // color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          "Customer",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 17),
                        )),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.01,
                        ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                          padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                          // height: Screens.padingHeight(context) * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox.shrink(),
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 30,
                            onChanged: (String? val) {
                              setState(() {
                                dropdownValue = val!;
                              });
                            },
                            items: <String>[
                              "Option 1",
                              "Option 2",
                            ].map((String? value2) {
                              return DropdownMenuItem(
                                  value: value2,
                                  child: Text(value2.toString()));
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                        ),
                        //Trans Number
                        SizedBox(
                width: Screens.width(context),
                child: Card(
                  elevation: 1,
                  // color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          "Trans Number",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 17),
                        )),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.01,
                        ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                    
                          height: Screens.padingHeight(context) * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: theme.primaryColor,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                        ),
                        //Loan number
                        SizedBox(
                width: Screens.width(context),
                child: Card(
                  elevation: 1,
                  // color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          "Loan Ref Number",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 17),
                        )),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.01,
                        ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                    
                          height: Screens.padingHeight(context) * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: theme.primaryColor,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                        ),
                        //age Above
                        SizedBox(
                width: Screens.width(context),
                child: Card(
                  elevation: 1,
                  // color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          "Age Above",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 17),
                        )),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.01,
                        ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                    
                          height: Screens.padingHeight(context) * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: TextField(
                            
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Age",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              // suffixIcon: Icon(
                              //   Icons.search,
                              //   color: theme.primaryColor,
                              // ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                        ),
                        //Balance Above
                        SizedBox(
                width: Screens.width(context),
                child: Card(
                  elevation: 1,
                  // color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          "Balance Above",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColor, fontSize: 17),
                        )),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.01,
                        ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                    
                          height: Screens.padingHeight(context) * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Balance",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              // suffixIcon: Icon(
                              //   Icons.search,
                              //   color: theme.primaryColor,
                              // ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                        ),
                
                  ],
                ),
              ),
            ),
            // SizedBox(height: Screens.padingHeight(context)*0.001,),
            
         
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          SizedBox
          
          (
            width: Screens.width(context)*0.4,
            child: ElevatedButton(onPressed: (){},
            
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
                )
              ),
             child: Text("Cancel"))),
            SizedBox(
              width: Screens.width(context)*0.4,
              
              child: ElevatedButton(onPressed: (){},
          
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
                )
              ),
               child: Text("Apply")))
         ],)
          ],
        ),
      ),
    );
    
  }
}
