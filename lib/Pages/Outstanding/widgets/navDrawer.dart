
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OutStandingController/OutStandingController.dart';
import 'package:sellerkit/Pages/Outstanding/Screens/filterScreen2.dart';

class navDrawer extends StatefulWidget {
  const navDrawer({Key? key}) : super(key: key);

  @override
  State<navDrawer> createState() => _navDrawerState();
}

class _navDrawerState extends State<navDrawer> {
  String? dropdownValue;
  // String? dropdownValue2;
  @override

  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Drawer(
      // backgroundColor: Colors.grey[300],
      child: ListView(
        children: [
           InkWell(
            onTap: (){
              setState(() {
                  FocusScope.of(context).unfocus();
                });
            },
             child: Container(
                 // color: Colors.amber,
                 // width: 50,
                 // height: Screens.bodyheight(context)*0.1,
                 // padding: EdgeInsets.symmetric(
                 //     horizontal: Screens.width(context) * 0.02,
                 //     vertical: Screens.padingHeight(context) * 0.004),
                 child: SingleChildScrollView(
                   child: Column(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
              Container(
                        alignment: Alignment.bottomCenter,
                        height: Screens.padingHeight(context)*0.1,
                       width: Screens.width(context),
                       padding: EdgeInsets.only(bottom: 10),
                       decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft:Radius.circular(Screens.padingHeight(context)*0.05),
                       bottomRight: Radius.circular(Screens.padingHeight(context)*0.05),
                        )
           
                       ),
                       child: Text("Outstanding",style: theme.textTheme.bodyText2!.copyWith(color: Colors.white),),
                      ),
              Container(
                width: Screens.width(context),
                  height: Screens.bodyheight(context)*0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
           
                       Container(
                             width: Screens.width(context),
                            child: Padding(
                             padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                
                                children: [
                                Container(
                                  // color:Colors.amber,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                              onTap: (){
                                                setState(() {
                                             context.read<Outstandingcontroller>().     ontapassignto();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Assigned to",
                                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                                              contentPadding: EdgeInsets.all(8.0),
                                              border:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // // UnderlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.grey)
                                              // ), 
                                              suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
                                            ),
                                            
                                            ),
                               context.watch<Outstandingcontroller>(). isassignto ==true &&
                              context.watch<Outstandingcontroller>(). assigncolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:context.watch<Outstandingcontroller>(). assigncolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<Outstandingcontroller>().selectedassignto.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<Outstandingcontroller>().itemselectassignto(item.name,ischecked!)
                                           ,
                                    
                                         )
                                         ).toList()
                                      ),
                                    ) ,
                                  ): Container()
                                   
                                    ],
                                  ),
                                ),
                              
                              ],),
                            ),
                          ),
           
           
                      
                      // Container(
                      //   width: Screens.width(context),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
           
                              
                      //         Container(
                      //             child: Text(
                      //           "Assigned to",
                      //           style: theme.textTheme.bodyMedium!.copyWith(
                      //               color: theme.primaryColor, fontSize: 15),
                      //         )),
                      //         SizedBox(
                      //           height: Screens.padingHeight(context) * 0.01,
                      //         ),
                      //         Container(
                      //           // color: Colors.amber,
                      //           width: Screens.width(context),
                      //           padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                      //           height: Screens.padingHeight(context) * 0.06,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(8),
                      //               border: Border.all(color: Colors.black26)),
                      //           child: DropdownButton(
                      //             isExpanded: true,
                      //             underline: SizedBox.shrink(),
                      //             value: context.read<Outstandingcontroller>(). assignvalue,
                      //             icon: Icon(Icons.arrow_drop_down),
                      //             iconSize: 30,
                      //             onChanged: ( val) {
                      //               setState(() {
                      //                context.read<Outstandingcontroller>().selectassign(val.toString()); 
                      //               //  context.read<Outstandingcontroller>(). assignvalue  = val!;
                      //               });
                      //             },
                      //             items:context.read<Outstandingcontroller>().  assigncolumn.map((e) {
                      //               return DropdownMenuItem(
                      //                   value:e.name ,
                      //                   child: Text(e.name));
                      //             }).toList(),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                  //  Customer
           
                  
           Container(
                             width: Screens.width(context),
                            child: Padding(
                             padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                
                                children: [
                                Container(
                                  // color:Colors.amber,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                              onTap: (){
                                                setState(() {
                                             context.read<Outstandingcontroller>().     ontapcusname();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Customer Name",
                                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                                              contentPadding: EdgeInsets.all(8.0),
                                              border:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // // UnderlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.grey)
                                              // ), 
                                              suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
                                            ),
                                            
                                            ),
                               context.watch<Outstandingcontroller>(). iscusname ==true &&
                              context.watch<Outstandingcontroller>().customercolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:context.watch<Outstandingcontroller>().customercolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<Outstandingcontroller>().selectedcusname.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<Outstandingcontroller>().itemselectCusname(item.name,ischecked!)
                                           ,
                                    
                                         )
                                         ).toList()
                                      ),
                                    ) ,
                                  ): Container()
                                   
                                    ],
                                  ),
                                ),
                              
                              ],),
                            ),
                          ),
                  //         Container(
                  // width: Screens.width(context),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           child: Text(
                  //         "Customer",
                  //         style: theme.textTheme.bodyMedium!.copyWith(
                  //             color: theme.primaryColor, fontSize: 15),
                  //       )),
                  //       SizedBox(
                  //         height: Screens.padingHeight(context) * 0.01,
                  //       ),
                  //       Container(
                  //         // color: Colors.amber,
                  //         width: Screens.width(context),
                  //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                  //         height: Screens.padingHeight(context) * 0.06,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             border: Border.all(color: Colors.black26)),
                  //         child: DropdownButton(
                  //           isExpanded: true,
                  //           underline: SizedBox.shrink(),
                  //           value: context.watch<Outstandingcontroller>().cusnamevalue,
                  //           icon: Icon(Icons.arrow_drop_down),
                  //           iconSize: 30,
                  //           onChanged: ( val) {
                  //             setState(() {
                  //            context.read<Outstandingcontroller>().selectcusname(val.toString()); 
                                    
                  //             });
                  //           },
                  //           items:context.read<Outstandingcontroller>().customercolumn. map((e) {
                  //             return DropdownMenuItem<String>(
                  //                 value: "${e.name}",
                  //                 child: Container(child: Text("${e.name.toString()}")));
                  //           }).toList(),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  //         ),
                          //Trans Number
                          Container(
                              width: Screens.width(context),
                            child: Padding(
                              padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    // width: Screens.width(context),
                                  
                                    // height: Screens.padingHeight(context) * 0.06,
                                    decoration: BoxDecoration(
                                        border: Border(
                                                bottom: BorderSide(color: Colors.grey)
                                              )
                                        // borderRadius: BorderRadius.circular(8),
                                        // border: Border.all(color: Colors.black26)
                                        
                                        ),
                                    child: TextField(
                                      controller: context.read<Outstandingcontroller>().mycontroller[2],
                                      decoration: InputDecoration(
                                        hintText: "Trans Number",
                                       
                                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
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
                          //Loan number
                          Container(
             width: Screens.width(context),
                            child: Padding(
                               padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),child: Column(
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    // width: Screens.width(context),
                                  
                                    // height: Screens.padingHeight(context) * 0.06,
                                    decoration: BoxDecoration(
                                        border: Border(
                                                  bottom: BorderSide(color: Colors.grey)
                                                )
                                        // borderRadius: BorderRadius.circular(8),
                                        // border: Border.all(color: Colors.black26)
                                        ),
                                    child: TextField(
                                      controller: context.read<Outstandingcontroller>().mycontroller[3],
                                      decoration: InputDecoration(
                                        hintText: "Loan Ref Number",
           
                                         hintStyle:TextStyle(color: Colors.black, fontSize: 15),
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
                          //age Above
                          Container(
                              width: Screens.width(context),
                            child: Padding(
                             padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    // width: Screens.width(context),
                                  
                                    // height: Screens.padingHeight(context) * 0.06,
                                    decoration: BoxDecoration(
                                        border: Border(
                                                  bottom: BorderSide(color: Colors.grey)
                                                )
                                        // borderRadius: BorderRadius.circular(8),
                                        // border: Border.all(color: Colors.black26)
                                        ),
                                    child: TextField(
                                      controller: context.read<Outstandingcontroller>().mycontroller[4],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Age",
                                         hintStyle:TextStyle(color: Colors.black, fontSize: 15),
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
                          //Balance Above
                          Container(
                             width: Screens.width(context),
                            child: Padding(
                               padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ), child: Column(
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    // width: Screens.width(context),
                                  
                                    // height: Screens.padingHeight(context) * 0.06,
                                    decoration: BoxDecoration(
                                        border: Border(
                                                  bottom: BorderSide(color: Colors.grey)
                                                )
                                        // borderRadius: BorderRadius.circular(8),
                                        // border: Border.all(color: Colors.black26)
                                        ),
                                    child: TextField(
                                      controller: context.read<Outstandingcontroller>().mycontroller[5],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Balance To Pay" ,
                                         hintStyle:TextStyle(color: Colors.black, fontSize: 15),
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
                  
                    ],
                  ),
                ),
              ),
              // SizedBox(height: Screens.padingHeight(context)*0.001,),
              
                    
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                     Container
                     
                     (
              width: Screens.width(context)*0.3,
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              },
              
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                  )
                ),
               child: Text("Cancel"))),
              Container(
                width: Screens.width(context)*0.3,
                
                child: ElevatedButton(onPressed: (){
                 setState(() {
                    Navigator.pop(context);
           
                  context.read<Outstandingcontroller>().  onfilterapply();
                 });
                 
                },
                     
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
               ),
           )
    
          ],
      ),

    );
  }
}