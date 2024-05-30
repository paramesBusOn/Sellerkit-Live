// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/SiteInController/newcreatesitein.dart';
import '../../../../Constant/Screen.dart';
// import '../../../Controller/createSiteInController/createSiteInController.dart';
// import '../../../Controller/VisitplanController/NewVisitController.dart';

class SiteInShowDialog extends StatefulWidget {
  SiteInShowDialog({Key? key}) : super(key: key);
  @override
  State<SiteInShowDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<SiteInShowDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.5,
        child: Column(
          children: [
            TextFormField(
                controller:  context.read<createSiteInController>().mycontroller[12],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required *";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    context
                        .read<createSiteInController>()
                        .filterListPurposeOfVisit(value);
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search here',
                    border: UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(),
                    errorBorder: UnderlineInputBorder(),
                    focusedErrorBorder: UnderlineInputBorder(),
                    // suffixIcon: InkWell(
                    //     onTap: () {},
                    //     child: Icon(Icons.search, color: theme.primaryColor)
                    //     )
                        )),
            Expanded(
              child: ListView.builder(
                itemCount: context
                    .watch<createSiteInController>()
                    .filterpurposeofVisitList
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      context.read<createSiteInController>().iscateSeleted(
                          context,
                          context
                              .read<createSiteInController>()
                              .filterpurposeofVisitList[index].description!,context
                              .read<createSiteInController>()
                              .filterpurposeofVisitList[index].code!);
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
                            Text("${context
                                .watch<createSiteInController>()
                                .filterpurposeofVisitList[index].description}"),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
