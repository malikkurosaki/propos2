import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart' as bl;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/src/printers/printer_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as besc;
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart' as bd;

class PrinterSelect extends StatelessWidget {
  const PrinterSelect({Key? key}) : super(key: key);

  _scanPrinter() async {
    SmartDialog.showLoading();
    bl.FlutterBlue flutterBlue = bl.FlutterBlue.instance;

    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    flutterBlue.scanResults.listen((results) {

      
      for (final d in results) {
        // final p = besc.PrinterBluetoothManager().selectPrinter(besc.PrinterBluetooth({

        // }));
        debugPrint(d.rssi.toString());

      }

      final printers = results.where((element) => element.device.name.isNotEmpty)
          .map((e) => {
                'id': e.device.id,
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

  Future<List<int>> tiket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(text: "qty", width: 2, styles: PosStyles(align: PosAlign.left)),
      PosColumn(text: "item", width: 3, styles: PosStyles(align: PosAlign.left)),
      PosColumn(text: "price", width: 4, styles: PosStyles(align: PosAlign.right)),
      PosColumn(text: "total", width: 3, styles: PosStyles(align: PosAlign.right))
    ]);

    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
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
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          PrinterVal.selectedPrinter.value.val['name'].toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      color: Colors.blue,
                                      child: Text(
                                        "Tes",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        // besc.PrinterBluetoothManager().scanResults.listen((event) {
                                        //   debugPrint(event.toString());
                                        //   final a = besc.PrinterBluetooth({});
                                        // });
                                        // SmartDialog.showLoading();

                                        final printerManager = besc.PrinterBluetoothManager();
                                        // final printer = besc.PrinterBluetooth(
                                        //   bd.BluetoothDevice.fromJson(
                                        //     <String, dynamic>{
                                        //       "id": PrinterVal.device.value.val['id'],
                                        //       "name": PrinterVal.device.value.val['name'],
                                        //       "address": PrinterVal.device.value.val['address'],
                                        //     },
                                        //   ),
                                        // );

                                        printerManager.selectPrinter(
                                          besc.PrinterBluetooth(
                                            bd.BluetoothDevice.fromJson(
                                              <String, dynamic>{
                                                // "type": PrinterVal.device.value.val['type'].toString(),
                                                "name": PrinterVal.device.value.val['name'].toString(),
                                                "address": PrinterVal.device.value.val['address'].toString(),
                                                "connected": true
                                              },
                                            ),
                                          ),
                                        );
                                        final besc.PosPrintResult res = await printerManager.printTicket(await tiket());
                                        SmartDialog.dismiss();
                                        SmartDialog.showToast("Print ${res.msg}");


                                        // debugPrint( <String, dynamic>{
                                        //         "type": PrinterVal.device.value.val['type'].toString(),
                                        //         "name": PrinterVal.device.value.val['name'].toString(),
                                        //         "address": PrinterVal.device.value.val['address'].toString(),
                                        //         "connected": true
                                        //       }.toString());
                                      },
                                    )
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
                  Flexible(
                      child: ListView(
                    controller: ScrollController(),
                    children: [
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
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
