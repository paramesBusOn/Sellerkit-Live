// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../Constant/Screen.dart';
import '../../../Models/GridContainerModels/GridContainerModel.dart';

class GridContaiers extends StatelessWidget {
  const GridContaiers({
    Key? key,
    required this.data,
    required this.theme,  this.height,
  }) : super(key: key);

  final List<GridConValue> data;
  final ThemeData theme;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      child: 
            GridView.builder(
               shrinkWrap: true, 
              primary: false,
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.3, 
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 8), 
                itemBuilder: (BuildContext ctx, i) {
                  return Card(
                     elevation: 2,shadowColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                            color:data[i].color=='fcedee'?Color(0xFFfcedee):
                            data[i].color=='ebf4fa'?Color(0xFFebf4fa):
                             data[i].color=='ebfaef'?Color(0xFFebfaef):
                             Colors.red,
                          borderRadius: BorderRadius.circular(6),
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text("${data[i].num}",
                                  style: theme.textTheme.headline6 
                                      ?.copyWith(color:theme.primaryColor))),//
                          Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "${data[i].contect}",
                                style: theme.textTheme.bodyText2?.copyWith(
                                  fontSize: 12
                                  )
                              )),
                        ],
                      ),
                    ),
                  );
                }),
    );
  }
}
