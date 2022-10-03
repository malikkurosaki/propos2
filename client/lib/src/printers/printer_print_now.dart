import 'dart:typed_data';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart' as bl;
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart' as bd;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as besc;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/src/printers/printer_val.dart';
import 'package:http/http.dart' as http;

class PrinterPrintNow {
  static Future<List<int>> ticket() async {
    final gam = await http.get(Uri.parse('https://www.probussystem.com/site/assets/files/1/logo-horizontal-1.png'));
    final gambar = gam.bodyBytes;
    final image = decodeImage(gambar);

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.image(image!);

    bytes += generator.text(
      CheckoutVal.printerModel.value.val.outlet.toString().toUpperCase(),
      styles: const PosStyles(height: PosTextSize.size2, width: PosTextSize.size2, align: PosAlign.center),
    );

    bytes += generator.row(
      [
        PosColumn(
          text: "Bid ",
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: CheckoutVal.printerModel.value.val.billId.toString().toUpperCase(),
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ],
    );
    bytes += generator.row(
      [
        PosColumn(
          text: "Bnm ",
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: CheckoutVal.printerModel.value.val.billNumber.toString().toUpperCase(),
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ],
    );
    bytes += generator.row(
      [
        PosColumn(
          text: "Div ",
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: CheckoutVal.printerModel.value.val.device.toString().toUpperCase(),
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ],
    );

    bytes += generator.row(
      [
        PosColumn(
          text: "Add ",
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: CheckoutVal.printerModel.value.val.address.toString().toUpperCase(),
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ],
    );

    bytes += generator.row(
      [
        PosColumn(
          text: "Pax ",
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: CheckoutVal.printerModel.value.val.pax.toString().toUpperCase(),
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ],
    );

    bytes += generator.row(
      [
        PosColumn(
          text: "Cus ",
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: CheckoutVal.printerModel.value.val.customer.toString().toUpperCase(),
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ],
    );

    bytes += generator.row(
      [
        PosColumn(
          text: "Dat ",
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: DateFormat('EEE, M/d/y').format(DateTime.now()),
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ],
    );

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
        text: "ITEM",
        width: 8,
        styles: const PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: "AMOUNT",
        width: 4,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      )
    ]);
    bytes += generator.hr();

    for (final itm in CheckoutVal.printerModel.value.val.lisProduct!) {
      bytes += generator.text("${itm.name}");
      bytes += generator.row(
        [
          PosColumn(
              text: '${itm.qty}x ${NumberFormat.simpleCurrency(locale: "id_ID", name: "", decimalDigits: 0).format(
                int.parse(
                  itm.price.toString(),
                ),
              )}',
              width: 6,
              styles: const PosStyles(align: PosAlign.left)),
          PosColumn(
            text: NumberFormat.simpleCurrency(locale: "id_ID", name: "", decimalDigits: 0).format(
              int.parse(
                itm.total.toString(),
              ),
            ),
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            ),
          )
        ],
      );
      if (itm.note!.isNotEmpty) {
        bytes += generator.text('+ ${itm.note}');
      }
      bytes += generator.text(" ");
    }
    bytes += generator.hr();
    bytes += generator.row(
      [
        PosColumn(
          text: "Total Bill",
          width: 7,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: NumberFormat.simpleCurrency(locale: "id_ID", name: "", decimalDigits: 0)
              .format(int.parse(CheckoutVal.printerModel.value.val.totalBill.toString())),
          width: 5,
          styles: const PosStyles(align: PosAlign.right),
        )
      ],
    );
    bytes += generator.row(
      [
        PosColumn(
          text: "Total Pay",
          width: 7,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: NumberFormat.simpleCurrency(locale: "id_ID", name: "", decimalDigits: 0)
              .format(int.parse(CheckoutVal.printerModel.value.val.totalPay.toString())),
          width: 5,
          styles: const PosStyles(align: PosAlign.right),
        )
      ],
    );
    for (final itm in CheckoutVal.printerModel.value.val.paymentMethod!) {
      bytes += generator.row(
        [
          PosColumn(
            text: "+ ${itm['method'].toString()}",
            width: 7,
            styles: const PosStyles(align: PosAlign.right),
          ),
          PosColumn(
            text: NumberFormat.simpleCurrency(locale: "id_ID", name: "", decimalDigits: 0)
                .format(int.parse(itm['value'].toString())),
            width: 5,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ],
      );
    }
    bytes += generator.row(
      [
        PosColumn(
          text: "Change",
          width: 7,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: NumberFormat.simpleCurrency(locale: "id_ID", name: "", decimalDigits: 0)
              .format(int.parse(CheckoutVal.printerModel.value.val.change.toString())),
          width: 5,
          styles: const PosStyles(align: PosAlign.right),
        )
      ],
    );
    bytes += generator.hr();
    bytes += generator.qrcode('probussystem.com');
    bytes += generator.feed(2);
    // bytes += generator.cut();

    return bytes;
  }

  static load() async {
    SmartDialog.showLoading();
    
    final printerManager = besc.PrinterBluetoothManager();
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
    final besc.PosPrintResult res = await printerManager.printTicket(await ticket());
    SmartDialog.dismiss();
    SmartDialog.showToast("Print ${res.msg}");
  }

  static printGambar(Uint8List gambar) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

     final image = decodeImage(gambar);
     bytes += generator.image(image!);

    final printerManager = besc.PrinterBluetoothManager();
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
    final besc.PosPrintResult res = await printerManager.printTicket(bytes);
    SmartDialog.dismiss();
    SmartDialog.showToast("Print ${res.msg}");
  }
}
