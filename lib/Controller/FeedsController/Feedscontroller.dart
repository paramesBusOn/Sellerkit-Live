// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';

class FeedsControoler extends ChangeNotifier {
  String selectedEmoji = '\u{1F44D}';
  List<String> listEmoji = [
    '\u{1F600}',
    '\u{1F606}',
    '\u{1F923}',
    '\u{1F914}',
    '\u{1F910}',
    '\u{1F922}',
    '\u{1F61F}',
    '\u{1F633}',
    '\u{1F621}',
    '\u{1F49B}',
    '\u{1F44C}',
    '\u{1F44D}',
    '\u{1F44F}',
    '\u{1F64f}'
  ];
  String get getSelectedEmoji => selectedEmoji;

  getsselectedEmojies(BuildContext context, int i) {
    Navigator.pop(context);
    selectedEmoji = listEmoji[i];
    notifyListeners();
    notifyListeners();
  }

  showBottomSheet(
    BuildContext context,
  ) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    //nznznz
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
          child: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.35,
                    child: GridView.builder(
                        itemCount: listEmoji.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 2, //heightofcontainer
                            crossAxisSpacing: 0, //width
                            mainAxisSpacing: 4), //spacebeetweenheight,
                        itemBuilder: (BuildContext ctx, i) {
                          return Card(
                            elevation: 2,
                            shadowColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  getsselectedEmojies(context, i);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text("${listEmoji[i]}",
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                                    color: theme
                                                        .primaryColor))), //
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
        // )),
      ),
    );
  }
}
