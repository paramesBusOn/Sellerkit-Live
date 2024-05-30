import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';

class OPLViewALL extends StatefulWidget {
   OPLViewALL({
    Key? key,
    // required this.prdFUP
  }) : super(key: key);

  @override
  State<OPLViewALL> createState() => _OPLViewALLState();
}

class _OPLViewALLState extends State<OPLViewALL> {
  // OpenLeadController prdFUP;
  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return Container(
       width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.01,
                      vertical: Screens.bodyheight(context) * 0.01),
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
                          children: [
                             Expanded(
                                        child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Wrap(
                              spacing: 10.0, 
                              runSpacing: 10.0, 
                              children:
                                  listViewAll(theme, 
                                 context.watch<OpenLeadController>()
                                   )),
                        );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context),
                                        child: ElevatedButton(
                                          onPressed: () {
                           context.read<OpenLeadController>().viewAllSelected();
                                          },
                                          child: Text("Ok"),
                                        ),
                                      )
                          ],
                        ),
                      ),
    );
  }

    List<Widget> listViewAll(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
      return List.generate(
        openLeadController.getviewData.length,
        (index) => GestureDetector(
          onTap: () {
            // openLeadController.isselectedBrand(index);
           openLeadController.isselectedViewAll(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getviewData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(openLeadController.getviewData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getviewData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } 
}