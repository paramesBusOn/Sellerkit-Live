import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../Constant/Screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class SelectionDatePicker extends StatefulWidget {
  const SelectionDatePicker({
    Key? key,
    // required this.reportsCnt,
  }) : super(key: key);
  // final ReportsController reportsCnt;
  @override
  State<SelectionDatePicker> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<SelectionDatePicker> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      //  contentPadding:
      //                                             const EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(Screens.bodyheight(context) * 0.012),
      // contentPadding:EdgeInsets.all(0.01),
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(),
      // clipBehavior:Clip.none,
      content: SizedBox(
          height: Screens.bodyheight(context) * 0.55,
          width: Screens.width(context) * 0.75,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SfDateRangePicker(
              // viewSpacing:20,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              toggleDaySelection: true,
              // selectionRadius:-1,
              headerHeight: Screens.bodyheight(context) * 0.1,
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.left,
                textStyle: theme.textTheme.titleLarge,
                //  backgroundColor: Colors.grey,
              ),
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              // toggleDaySelection:true,
              confirmText: 'OK', cancelText: 'CANCEL',
              onCancel: () {
                Navigator.pop(context);
              },

              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  if (args.value is PickerDateRange) {
                    if (args.value.startDate != null ||
                        args.value.endDate != null) {
                      DateTime? rangeStartDate;
                      DateTime? rangeEndDate;
                      rangeStartDate =
                          args.value.startDate ?? args.value.endDate;
                      rangeEndDate = args.value.endDate ?? args.value.startDate;
                     context.read<ReportsController>().selectedDatePickerValue(
                          rangeStartDate, rangeEndDate);
                    }
                  }
                });
              },
              onSubmit: (p0) {
                setState(() {
                 context.read<ReportsController>().onSubmitDatePicker();
                  Get.back();
                });
                // widget.onChanged?.call(p0);
              },
            ),
          )),
    );
  }
}
