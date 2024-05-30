import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color? lodingcolor;
  final Color? containerColor;
  final bool? loading;
  final double? size;
  final double? width;
  final double? height;
  const CustomLoadingIndicator({Key? key,required this.lodingcolor, required this.size, this.width, this.height, this.containerColor,required this.loading, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading!,
      child: Container(
        width: width ?? width,
        height: height ?? height,
        color: containerColor,
        child: SpinKitCircle(
          color: lodingcolor == null? Colors.amber: lodingcolor!,
          size: size!,
        ),
      ),
    );
  }
}
