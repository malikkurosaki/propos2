import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectPrinterAndroid extends StatelessWidget {
  SelectPrinterAndroid({Key? key}) : super(key: key);
  final _printerManager = PrinterBluetoothManager();

  _onLoad() async {
    await 1.delay();
    SmartDialog.showLoading();
    _printerManager.scanResults.listen((event) async {
      Val.listPrinter.value.val = event
          .map((e) => {
                'name': e.name,
                'address': e.address,
                'type': e.type,
              })
          .toList();
      Val.listPrinter.refresh();

      // _printers.value.val = event;
      // _printers.refresh();
    }).onError((error) {
      debugPrint(error.toString());
    });

    _printerManager.startScan(const Duration(seconds: 4));

    await 4.delay();
    debugPrint('stop scan');
    SmartDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    // _onLoad();
    return Material(
      child: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, media) {
            return Obx(
              () => Column(
                children: [
                  Val.printerDevice.value.val.isEmpty
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
                                        Val.printerDevice.value.val['name'].toString(),
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
                              _onLoad();
                            },
                            icon: Icon(Icons.refresh)),
                      ],
                    ),
                  ),
                  for (final itm in Val.listPrinter.value.val)
                    Column(
                      children: [
                        ListTile(
                          leading: Val.printerDevice.value.val.isNotEmpty &&
                                  Val.printerDevice.value.val['address'] == itm['address']
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(Icons.check_circle),
                          title: Text(itm['name']),
                          // subtitle: Text(itm.address!),
                          onTap: () async {
                            Val.printerDevice.value.val.assignAll(itm);
                            Val.printerDevice.refresh();
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
