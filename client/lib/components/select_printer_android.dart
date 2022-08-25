import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectPrinterAndroid extends StatelessWidget {
  SelectPrinterAndroid({Key? key}) : super(key: key);
  final _printerManager = PrinterBluetoothManager();
  final _listPrinter = [].obs;
  final _selectedPrinter = {}.obs;

  _onLoad() async {
    await 1.delay();

    if (Vl.selectedPrinter.val.isNotEmpty) {
      _selectedPrinter.assignAll(Vl.selectedPrinter.val);
    }

    if(Vl.listPrinter.val.isNotEmpty){
      _listPrinter.assignAll(Vl.listPrinter.val);
    }

    SmartDialog.showLoading();
    _printerManager.scanResults.listen((event) async {
      final printers = event
          .map((e) => {
                'name': e.name,
                'address': e.address,
                'type': e.type,
              })
          .toList();
      _listPrinter.assignAll(printers);
      Vl.listPrinter.val = printers;
      // Val.listPrinter.value.val = event
      //     .map((e) => {
      //           'name': e.name,
      //           'address': e.address,
      //           'type': e.type,
      //         })
      //     .toList();
      // Val.listPrinter.refresh();

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
    _onLoad();
    return Material(
      child: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, media) {
            return Obx(
              () => Column(
                children: [
                  _selectedPrinter.isEmpty
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
                                        _selectedPrinter['name'].toString(),
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
                  for (final itm in _listPrinter)
                    Column(
                      children: [
                        ListTile(
                          leading: _selectedPrinter.isNotEmpty && _selectedPrinter['address'] == itm['address']
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(Icons.check_circle),
                          title: Text(itm['name']),
                          // subtitle: Text(itm.address!),
                          onTap: () async {
                            _selectedPrinter.assignAll(itm);
                            Vl.selectedPrinter.val = itm;
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
