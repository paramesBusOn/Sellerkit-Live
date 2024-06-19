
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import '../../../../Constant/Screen.dart';


class ShowSearchDialog extends StatefulWidget {
  ShowSearchDialog({Key? key}) : super(key: key);
  @override
  State<ShowSearchDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<ShowSearchDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
            content:  Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context)*0.5,
              child: Column(
                children: [
                   TextFormField(
                           controller:  context.read<LeadNewController>().mycontroller[29],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required *";
                              }
                              return null;
                            },
                             onChanged: (v) {
                                setState(() {
                      context.read<LeadNewController>().filterListrefData(v);
                                });
                              },
                            decoration: InputDecoration(
                              hintText: 'Search here',
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(),
                              suffixIcon:
                               InkWell(
                                 onTap: (){
                                 
                                 },
                                 child: Icon(Icons.search,color: theme.primaryColor))
                            )),

                   Expanded(child: ListView.builder(
                    itemCount:context.watch<LeadNewController>().filterrefpartdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                           context.read<LeadNewController>().iscateSeleted( context.read<LeadNewController>().filterrefpartdata[index].PartnerName.toString(),
                            context.read<LeadNewController>().filterrefpartdata[index].PartnerCode.toString()
                         ,context  );  
                        },
                        child: Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.all(5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                          width: Screens.width(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.watch<LeadNewController>().filterrefpartdata[index].PartnerName.toString()

                                ),
                                Divider()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),)
                ],
              ),
            )
              ,
     );
  }
}