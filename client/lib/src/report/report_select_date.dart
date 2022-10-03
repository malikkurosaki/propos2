import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/report/report_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ReportSelectDate extends StatelessWidget {
  const ReportSelectDate({Key? key}) : super(key: key);

  // final ReportVal.dateData = {
  //   "start": DateTime.now().toLocal().toString().split(" ")[0],
  //   "end": DateTime.now().toLocal().toString().split(" ")[0]
  // }.val("ReportSelectDate.ReportVal.dateData").obs;

  _loadData() async {
    final start = ReportVal.dateData.value.val['start'];
    final end = ReportVal.dateData.value.val['end'];

    final data = await Rot.reportRangeDateGet(query: "start=$start&end=$end");
    ReportVal.listBill.value.val = jsonDecode(data.body);
    ReportVal.listBill.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Column(
        children: [
          Wrap(
            children: [
              SizedBox(
                width: media.isMobile ? Get.width : 300,
                child: Obx(
                  () => ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text(ReportVal.dateData.value.val['start'].toString()),
                    trailing: Icon(Icons.arrow_drop_down),
                    subtitle: Text("First Date"),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(ReportVal.dateData.value.val['start'].toString()),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.parse(ReportVal.dateData.value.val['end'].toString()),
                      ).then(
                        (value) {
                          if (value != null) {
                            ReportVal.dateData.value.val['start'] = value.toLocal().toString().split(" ")[0];
                            ReportVal.dateData.refresh();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: media.isMobile ? Get.width : 300,
                child: Obx(
                  () => ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text(ReportVal.dateData.value.val['end'].toString()),
                    trailing: Icon(Icons.arrow_drop_down),
                    subtitle: Text("Last Date"),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(ReportVal.dateData.value.val['end'].toString()),
                        firstDate: DateTime.parse(ReportVal.dateData.value.val['start'].toString()),
                        lastDate: DateTime.now(),
                      ).then(
                        (value) {
                          if (value != null) {
                            ReportVal.dateData.value.val['end'] = value.toLocal().toString().split(" ")[0];
                            ReportVal.dateData.refresh();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              Wrap(
                children: [
                  SizedBox(
                    width: media.isMobile ? Get.width / 2.1 : 100,
                    child: MaterialButton(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        _loadData();
                      },
                    ),
                  ),
                  SizedBox(
                    width: media.isMobile ? Get.width / 2.1 : 100,
                    child: MaterialButton(
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        ReportVal.dateData.value.val = <String, dynamic>{
                          "start": DateTime.now().toLocal().toString().split(" ")[0],
                          "end": DateTime.now().toLocal().toString().split(" ")[0]
                        };

                        ReportVal.dateData.refresh();
                        await _loadData();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
