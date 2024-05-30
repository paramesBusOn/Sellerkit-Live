// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryMngController.dart';


class LostToDialogManager extends StatefulWidget {
  LostToDialogManager({Key? key, required this.i}) : super(key: key);
  final int i;
  @override
  State<LostToDialogManager> createState() => LostToDialogUserState();
}

class LostToDialogUserState extends State<LostToDialogManager> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
            content:   enqDetailsPage(context, theme) ,
              actions: 
               [
                 enqDetailsPageBtn(context, theme),                  
              ],
            );
  }

  Center enqDetailsPageBtn(BuildContext context, ThemeData theme) {
    return Center(
      child: TextButton(
         onPressed: () {
       
          context.read<EnquiryMangerContoller>().makePhoneCall( context.read<EnquiryMangerContoller>().assignedEnqData[widget.i].CardCode!);
         },
         child:
         Icon(Icons.call,color: Colors.white,size: Screens.bodyheight(context)*0.03,),
        
         style: ButtonStyle(
             backgroundColor:
                 MaterialStateProperty.all<Color>(Colors.green)),
       ),
    );
  }

  Container statusUpdateApiRespPage(BuildContext context, ThemeData theme) {
    return Container(
                  width: Screens.width(context) * 0.9,
               height: Screens.bodyheight(context) * 0.3,
               child: Center(child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                 children: [
                   Text( context.watch<EnquiryMangerContoller>().getstatusUpdateApiResp,
                   style:
                   context.watch<EnquiryMangerContoller>()
                   .getstatusUpdateApiResp.contains("Success")?
                    theme.textTheme.headline6?.copyWith(color: Colors.green):
                    theme.textTheme.headline6?.copyWith(color: Colors.red)
                    ,
                   ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),
                  Text( context.watch<EnquiryMangerContoller>().getstatusUpdateApiRespMsg,
                   style: theme.textTheme.bodyText1,
                   ),
                 ],
               ),),
             );
  }

  Container statusRespPage(BuildContext context, ThemeData theme) {
    return Container(
               width: Screens.width(context) * 0.9,
              // height: Screens.bodyheight(context) * 0.4,
               child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                 children: [
                   Text("Status Update",style: theme.textTheme.headline6,),
                    SizedBox(height: Screens.bodyheight(context)*0.02,),
                  
                   Container(
                  width: Screens.width(context),
                  padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton(
                    hint: Text("Select Reason: "),
                    value: context.read<EnquiryMangerContoller>(). valueChosedReason,
                    //dropdownColor:Colors.green,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    isExpanded: true,
                    onChanged: (val) {
                      // setState(() {
                      //   valueChosedReason = val.toString();
                      //   print(val.toString());
                      //   print("valavalaa: .........." +
                      //       valueChosedReason.toString());
                      // });
                       context.read<EnquiryMangerContoller>().resonChoosed(val.toString());
                    },
                    items:context.read<EnquiryMangerContoller>().resonData .map((e) {
                      return DropdownMenuItem(
                          value: "${e.CODE}",
                          child: Text(e.CODE.toString()));
                    }).toList(),
                  ),
                ),
                  SizedBox(height: Screens.bodyheight(context)*0.02,),
                 Stack(children: [
                    SizedBox(
                      child: TextFormField(
                        onTap: (){
                          context.read<EnquiryMangerContoller>().showDate(context);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter FollowUP Date";
                          }
                          return null;
                        },
                        readOnly: true,
                        controller:context.read<EnquiryMangerContoller>(). mycontroller[0],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          labelText: "Next follow up Date",
                          labelStyle: TextStyle(
                            color:theme.primaryColor,
                          ),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          //   borderSide: BorderSide(color: Colors.green),
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color:theme.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: theme.primaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        cursorColor:theme.primaryColor,
                      ),
                    ),
                    Positioned(
                        top: 10,
                        left: Screens.width(context)*0.5,
                        child: InkWell(
                            onTap: () {
                              context.read<EnquiryMangerContoller>().showDate(context);
                            },
                            child: Icon(Icons.calendar_today,color: Colors.black,)))
                  ]),

                 ],
               ),
            );
  }

  Container assignedToApiRespPage(BuildContext context, ThemeData theme) {
    return Container(
                  width: Screens.width(context) * 0.9,
               height: Screens.bodyheight(context) * 0.3,
               child: Center(child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                 children: [
                   Text( context.watch<EnquiryMangerContoller>().getassignedToApiActResp,
                   style:
                   context.watch<EnquiryMangerContoller>()
                   .getassignedToApiActResp.contains("Success")?
                    theme.textTheme.headline6?.copyWith(color: Colors.green):
                    theme.textTheme.headline6?.copyWith(color: Colors.red)
                    ,
                   ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),
                   Text( context.watch<EnquiryMangerContoller>().getassignedToApiActRespMsg,
                   style: theme.textTheme.bodyText1,
                   ),
                 ],
               ),),
             );
  }

  Container LoadingPage(BuildContext context) {
    return Container(
                 width: Screens.width(context) * 0.9,
               height: Screens.bodyheight(context)  * 0.3,
              child: Center(child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            ),));
  }

  Container assignedTOPage(BuildContext context, ThemeData theme) {
    return Container(
               width: Screens.width(context) * 0.9,
               height: Screens.bodyheight(context) * 0.4,
               child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                 children: [
                   Expanded(
                    //  child:ListView.builder(
                    //  itemCount: 1,
                    //  // context.watch<EnquiryMangerContoller>().getuserLtData.length,
                    //  itemBuilder: (BuildContext context, int index) {
                    //    return InkWell(
                        //  onTap: (){
                        // context.read<EnquiryMangerContoller>() .selectedIdxFUser = index;
                        //   context.read<EnquiryMangerContoller>().selectUser(index);
                        //  },
                         child: Wrap(
                          spacing: 10.0, // gap between adjacent chips
                          runSpacing: 10.0, // gap between lines
                          children:
                              listContainersProduct(theme, 
                               )),
                  //      );
                  //    },
                  //  ),
                   )
                 ],
               ),
            );
  }

  Container enqDetailsPage(BuildContext context, ThemeData theme) {
    return Container(
              //  color: Colors.black12,
             // height: Screens.bodyheight(context) * 0.4,
              width: Screens.width(context) * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,

                          //     width: Screens.width(context) * 0.4,
                          child: Text(
                            "Customer",
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,

                          //    width: Screens.width(context) * 0.4,
                          child: Text(
                            "Date",
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,

                          //    width: Screens.width(context) * 0.4,
                          child: Text("${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].CardName}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                //  fontWeight: FontWeight.bold
                                  )),
                        ),
                        Container(
                          alignment: Alignment.centerRight,

                          //    width: Screens.width(context) * 0.4,
                          child: Text(
                               context.read<EnquiryMangerContoller>().config.alignDate("${ context.watch<EnquiryMangerContoller>()
                               .assignedEnqData[widget.i].EnqDate}"),
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                  //fontWeight: FontWeight.bold
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,

                          // width: Screens.width(context) * 0.4,
                          child: Text(
                            "Product",
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,

                          //   width: Screens.width(context) * 0.4,
                          child: Text(
                            "Potential Value",
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,

                          width: Screens.width(context) * 0.4,
                          child:
                              Text("Looking for ${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].Lookingfor}",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      //color:theme.primaryColor,
                                    //  fontWeight: FontWeight.bold
                                      )),
                        ),
                        Container(
                          alignment: Alignment.centerRight,

                          width: Screens.width(context) * 0.2,
                          child: Text("₹ ${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].PotentialValue}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  //color:theme.primaryColor,
                                 // fontWeight: FontWeight.bold
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,

                          //color: Colors.red,
                          width: Screens.width(context) * 0.4,
                          child: Text(
                              "Call assigned to ${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].AssignedTo_UserName}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: Colors.grey,
                                 // fontWeight: FontWeight.bold
                                  )),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          //color: Colors.red,
                          width: Screens.width(context) * 0.2,
                          child: Text("${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].Status}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: Colors.grey,
                                //  fontWeight: FontWeight.bold
                                  )),
                        ),
                      ],
                    ),
                     SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,

                          //color: Colors.red,
                          width: Screens.width(context) * 0.2,
                          child: Text(
                              "Follow Up Date",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: Colors.grey,
                                 // fontWeight: FontWeight.bold
                                  )),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          //color: Colors.red,
                          width: Screens.width(context) * 0.4,
                          child: Text("Enq type",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: Colors.grey,
                               //   fontWeight: FontWeight.bold
                                  )),
                        ),
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //color: Colors.red,
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: Text(
                             context.read<EnquiryMangerContoller>(). config.alignDate("${ context.watch<EnquiryMangerContoller>()
                             .assignedEnqData[widget.i].Followup}"),
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                  //fontWeight: FontWeight.bold
                                  )),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          //color: Colors.red,
                          width: Screens.width(context) * 0.3,
                          child: Text("${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].EnqType}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                //  fontWeight: FontWeight.bold
                                  )),
                        ),
                      ],
                    ),
                     SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Column(
                      children:[
                         Container(
                          alignment: Alignment.centerLeft,
                          //color: Colors.red,
                          child: Text("Address",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: Colors.grey,
                                  //fontWeight: FontWeight.bold
                                  )),
                        ),
                          Container(
                          alignment: Alignment.centerLeft,
                          //color: Colors.red,
                          child: Text("${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].Address_Line_1}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                //  fontWeight: FontWeight.bold
                                  )),
                        ),
                          Container(
                          alignment: Alignment.centerLeft,
                          //color: Colors.red,
                          child: Text("${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].Address_Line_2}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                // fontWeight: FontWeight.bold
                                  )),
                        ),
                            Container(
                          alignment: Alignment.centerLeft,
                          //color: Colors.red,
                          child: Text("${ context.watch<EnquiryMangerContoller>().
                          assignedEnqData[widget.i].City} - ${ context.watch<EnquiryMangerContoller>().assignedEnqData[widget.i].Pincode}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                  //fontWeight: FontWeight.bold
                                  )),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            );
  }

    List<Widget> listContainersProduct(ThemeData theme,) {

      return List.generate(
        context.watch<EnquiryMangerContoller>().getuserLtData.length,
        (ind) => GestureDetector(
          onTap: () {
           context.read<EnquiryMangerContoller>() .selectedIdxFUser = ind;
           context.read<EnquiryMangerContoller>().selectUser(ind);
          },
          child: Container(
            // alignment: Alignment.center,
            // width: Screens.width(context) * 0.2,
           // height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: 
                context.watch<EnquiryMangerContoller>().getuserLtData[ind].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              context.watch<EnquiryMangerContoller>().getuserLtData[ind].UserName!,
               // maxLines: 1,
                //overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: 
                  context.watch<EnquiryMangerContoller>().getuserLtData[ind].color == 1
                  //content[index].isselected == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
   
  }
}