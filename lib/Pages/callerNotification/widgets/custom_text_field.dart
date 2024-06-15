
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/callNotificationController/callNotificationController.dart';
import 'package:sellerkit/Pages/callerNotification/widgets/assigndata.dart';
import 'package:sellerkit/Pages/callerNotification/widgets/custom_keyboard_handler.dart';
import 'package:sellerkit/Pages/callerNotification/widgets/showsearchdialog.dart';
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final bool isUseCustomKeyBoard;
   final bool? isreadonly;
    final bool? islookingfor;
    final bool? isassignto;
  final String? hintText;
final int? maxlines;
 final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
    final GestureTapCallback? onTap;

  const CustomTextField({
    this.isreadonly,
    this.isassignto,
    this.islookingfor,
    this.maxlines,
    this.controller,
    this.focusNode,
    this.inputType,
    this.isUseCustomKeyBoard = false,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onTap,
    super.key,
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController controller;
  late final FocusNode _focusNode;
 static String? lookingfor;
  static String? assigntofor;
// bool? readonly;
  @override
  void initState() {
    // readonly=widget.isreadonly??false;
    controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _handleCustomKeyboard();
    super.initState();
  }

  void _handleCustomKeyboard() {
    if (widget.isUseCustomKeyBoard) {
      _focusNode.addListener(() {
        CustomKeyboardHandler.onFocusChangeHandler(
          CustomKeyboardHandlerData(
            isKeyboardShowing: _focusNode.hasFocus,
            controller: controller,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
     if (widget.controller == null) {
      controller.text='';
        controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
  
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        TextFormField(
          onTap:(){
            if(widget.islookingfor ==true){
        showDialog<dynamic>(
                                                                  context: context,
                                                                  builder: (_) {
                                                                    return ShowSearchDialog(
                                                                    );
                                                                  }).then((value) {
                                                                   
                                                                   controller.text=lookingfor.toString();
                                                                   _focusNode.unfocus();
                                                                    // context.read<CallNotificationController>()
                                                                    // .lookingfor.toString();
                                                                   context.read<CallNotificationController>()
                                                                    .setcatagorydata();    
                                                                    });
                                                  }
                                                  else if(widget.isassignto ==true){
                                                       showDialog<dynamic>(
                                                                  context: context,
                                                                  builder: (_) {
                                                                    return EnqAssignUserDialog(
                                                                    );
                                                                  }).then((value) {
                                                                     controller.text=assigntofor.toString();
                                                                 _focusNode.unfocus();
                                                                 context.read<CallNotificationController>()
                                                                    .setUserdata();
                                                              });
                                                      
        
                                                  }
            
             
          } ,
          validator:widget.validator,
          onChanged: widget.onChanged,
          maxLines:widget.maxlines,
          controller: controller,
          focusNode: _focusNode,
          readOnly:widget.isreadonly ??false,
          keyboardType:
              widget.isUseCustomKeyBoard ? TextInputType.none : widget.inputType,
               inputFormatters:widget.inputType== TextInputType.number ?[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                new LengthLimitingTextInputFormatter(
                                                    10),
                                              ]:[],
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey
              )
            ),
             contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                  vertical: 0
                                                )
            // contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(16),
            // ),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(16),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(16),
            //   borderSide: const BorderSide(color: Colors.green),
            // ),
          ),
        ),
      
   widget.islookingfor ==true||widget.isassignto ==true?    Positioned(
                                                    top: 0,
                                                    left: Screens.width(context) *
                                                        0.5,
                                                    child: InkWell(
                                                        onTap: () {
                                                          if(widget.islookingfor ==true){
        showDialog<dynamic>(
                                                                  context: context,
                                                                  builder: (_) {
                                                                    return ShowSearchDialog(
                                                                    );
                                                                  }).then((value) {
                                                                   
                                                                   controller.text=lookingfor.toString();
                                                                    // context.read<CallNotificationController>()
                                                                    // .lookingfor.toString();
                                                                   context.read<CallNotificationController>()
                                                                    .setcatagorydata();    
                                                                    });
                                                  }
                                                  else if(widget.isassignto ==true){
                                                       showDialog<dynamic>(
                                                                  context: context,
                                                                  builder: (_) {
                                                                    return EnqAssignUserDialog(
                                                                    );
                                                                  }).then((value) {
                                                                     controller.text=assigntofor.toString();
                                                                 
                                                                 context.read<CallNotificationController>()
                                                                    .setUserdata();
                                                              });
                                                      
        
                                                  }
                                                  },
                                                        child: Container(
                                                            width: Screens.width(
                                                                    context) *
                                                                0.1,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 08,
                                                                    horizontal:
                                                                        10),
                                                            height: Screens.bodyheight(
                                                                    context) *
                                                                0.1,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: theme
                                                                        .primaryColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight: Radius
                                                                          .circular(
                                                                              8),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8),
                                                                    )),
                                                            child: Icon(
                                                                Icons.search)))):Container()
      ],
    );
  }
}
