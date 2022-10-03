import 'dart:convert';

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/src/printers/printer_val.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectPrinterAndroid extends StatelessWidget {
  const SelectPrinterAndroid({Key? key}) : super(key: key);

  _scanPrinter() async {
    SmartDialog.showLoading();
    FlutterBlue flutterBlue = FlutterBlue.instance;

    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      final printers = results
          .map((e) => {
                'name': e.device.name,
                'address': e.device.id,
                'type': e.device.type,
              })
          .toList();
      PrinterVal.listPrinter.value.val = printers;
      PrinterVal.listPrinter.refresh();
      // _listPrinter.assignAll(printers);
    });

    await 4.delay();
    flutterBlue.stopScan();
    SmartDialog.dismiss();
  }

  _onLoad2() async {
    if (PrinterVal.device.value.val.isEmpty) {
      _scanPrinter();
    }
  }

  @override
  Widget build(BuildContext context) {
    // _onLoad();
    _onLoad2();
    return Material(
      child: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, media) {
            return Obx(
              () => Column(
                children: [
                  PrinterVal.selectedPrinter.value.val.isEmpty
                      ? Text(
                          "Please Select Printer",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("selected printer"),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        PrinterVal.selectedPrinter.value.val['name'].toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Available Printer"),
                        IconButton(
                            onPressed: () {
                              _scanPrinter();
                            },
                            icon: Icon(Icons.refresh)),
                      ],
                    ),
                  ),
                  for (final itm in PrinterVal.listPrinter.value.val)
                    Column(
                      children: [
                        ListTile(
                          leading: PrinterVal.selectedPrinter.value.val.isNotEmpty &&
                                  PrinterVal.selectedPrinter.value.val['address'] == itm['address']
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(Icons.check_circle),
                          title: Text(itm['name']),
                          subtitle: Text(itm['address'].toString()),
                          onTap: () async {
                            PrinterVal.selectedPrinter.value.val.assignAll(itm);
                            PrinterVal.device.value.val = itm;


                            PrinterVal.device.refresh();
                            PrinterVal.selectedPrinter.refresh();
                            // Val.printerDevice.value.val.assignAll(itm);
                            // Val.printerDevice.refresh();
                          },
                        ),
                        Divider()
                      ],
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
