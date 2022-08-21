import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:propos/utils/val_def.dart';
import 'package:get_storage/get_storage.dart';

class PrinterAndroid extends StatelessWidget {
  PrinterAndroid({
    Key? key,
    required this.i,
  }) : super(key: key);
  final _printers = <PrinterBluetooth>[].val("PrinterAndroid._printers").obs;
  final _printerManager = PrinterBluetoothManager();
  final img.Image i;
  // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  Future<List<int>> testTicket() async {

    // final List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    final styleCenter = PosStyles(width: PosTextSize.size1, height: PosTextSize.size1, align: PosAlign.center);
    final styleLeft = PosStyles(width: PosTextSize.size1, height: PosTextSize.size1, align: PosAlign.left);
    final styleRight = PosStyles(width: PosTextSize.size1, height: PosTextSize.size1, align: PosAlign.right);

    final garis = () => generator.hr();
    final textLeft = (String text) => generator.text(text, styles: styleLeft);
    final textCenter = (String text) => generator.text(text, styles: styleCenter);
    final textRight = (String text) => generator.text(text, styles: styleRight);

    List<int> bytes = [];

    bytes += textCenter(ValDef.companyDefMap.value.val['name'].toString());
    bytes += textCenter(ValDef.outletDefMap.value.val['name'].toString());
    bytes += textCenter("Jalan Hasanudin No 38 Denpasar - Bali");
    bytes += textCenter("Telp: 089697338821");
    bytes += garis();
    bytes += textLeft("ID#    : tyu6789fghjk56789");
    bytes += textLeft("Kasir  : Owner");
    bytes += textLeft("Tgl:   : 22-01-2015 10:41");
    bytes += garis();

    // generator.image(i);

    // bytes += generator.text('Regular', styles: styleLeft);
    // bytes += generator.image(i);
    // bytes += generator.text('-------------------------------', styles: styleCenter);

    // bytes += generator.text('Item');
    // bytes += generator.text('Qty');
    // bytes += generator.text('Price');
    // bytes += generator.text(
    //   '---------------------------',
    // );

    // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));
    // bytes += generator.text('Special 2: blåbærgrød',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));

    // bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    // bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    // bytes += generator.text('Underlined text', styles: PosStyles(underline: true), linesAfter: 1);
    // bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    // bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    // bytes += generator.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    // bytes += generator.text('Text size 200%',
    //     styles: PosStyles(
    //       height: PosTextSize.size2,
    //       width: PosTextSize.size2,
    //     ));

    bytes += generator.feed(2);
    // bytes += generator.cut();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          MaterialButton(
            child: Text('Print'),
            onPressed: () async {},
          ),
          MaterialButton(
            child: Text('load'),
            onPressed: () async {
              SmartDialog.showLoading();
              _printerManager.scanResults.listen((event) async {
                _printers.value.val = event;
                _printers.refresh();
              }).onError((error) {
                debugPrint(error.toString());
              });

              _printerManager.startScan(const Duration(seconds: 4));

              await 4.delay();
              debugPrint('stop scan');
              SmartDialog.dismiss();
            },
          ),
          Obx(
            () => Column(
              children: [
                for (final itm in _printers.value.val)
                  ListTile(
                    title: Text(itm.name!),
                    subtitle: Text(itm.address!),
                    onTap: () async {
                      _printerManager.selectPrinter(itm);
                      debugPrint('selected printer ${itm.name}');
                      final PosPrintResult res = await _printerManager.printTicket(await testTicket());
                      print('Print result: ${res.msg}');
                    },
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
