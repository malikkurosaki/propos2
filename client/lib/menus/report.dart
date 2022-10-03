import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/report/report_select_date.dart';
import 'package:propos/src/report/report_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class Report extends StatelessWidget {
  Report({Key? key}) : super(key: key);

  final _listBill = [].obs;
  final Map _listLebar = {
    "number": {
      "title": 'Number',
      "key": 'number',
      "width": 80,
    },
    "id": {
      "title": 'Id',
      "key": 'id',
      "width": 200,
    },
    "totalQty": {
      "title": 'Qty',
      "key": 'totalQty',
      "width": 80,
    },
    "totalPrice": {
      "title": 'Total',
      "key": 'totalQty',
      "width": 200,
    }
  };

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReportSelectDate(),
            ),
            FutureBuilder<http.Response>(
              future: Rot.reportListGet(),
              builder: (con, snap) {
                if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                Future.delayed(
                  Duration(milliseconds: 1),
                  () {
                    ReportVal.listBill.value.val = jsonDecode(snap.data!.body);
                    ReportVal.listBill.refresh();
                  },
                );

                return SizedBox.shrink();
              },
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => SingleChildScrollView(
                    controller: ScrollController(),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey.shade200,
                            child: Row(
                              children: [
                                ..._listLebar.keys.map(
                                  (e) => SizedBox(
                                    width: _listLebar[e]['width'],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _listLebar[e]['title'].toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              ...ReportVal.listBill.value.val.map(
                                (element) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ..._listLebar.keys.map(
                                          (e) => Container(
                                            decoration:
                                                BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
                                            width: _listLebar[e]['width'],
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  // Text((e == "totalPrice").toString()),
                                                  e.toString() == "totalPrice"
                                                      ? Text(
                                                          NumberFormat.simpleCurrency(
                                                                  locale: "id_ID", decimalDigits: 0, name: "")
                                                              .format(int.parse(element[e].toString())),
                                                        )
                                                      : Text(
                                                          element[e].toString(),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // DottedLine(
                                    //   dashColor: Colors.grey,
                                    // )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
