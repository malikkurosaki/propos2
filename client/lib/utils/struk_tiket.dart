import 'package:blue_thermal_printer/blue_thermal_printer.dart' as bt;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as besc;
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart' as bd;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/val_def.dart';
import 'package:propos/utils/vl.dart';

class StrukTiket {
  List<int> textCenter(Generator generator, String text) => generator.text(text,
      styles: const PosStyles(width: PosTextSize.size1, height: PosTextSize.size1, align: PosAlign.center));
  List<int> textLeft(Generator generator, String text) => generator.text(text,
      styles: const PosStyles(width: PosTextSize.size1, height: PosTextSize.size1, align: PosAlign.left));
  List<int> textRight(Generator generator, String text) => generator.text(text,
      styles: const PosStyles(width: PosTextSize.size1, height: PosTextSize.size1, align: PosAlign.right));

  Future<List<int>> tiket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += textCenter(generator, Vl.defCompany.val['name'].toString());
    bytes += textCenter(generator, Vl.defOutlet.val['name'].toString());
    bytes += textCenter(generator, "Jalan Hasanudin No 38 Denpasar - Bali");
    bytes += textCenter(generator, "Telp: 089697338821");
    bytes += generator.hr();
    bytes += textLeft(generator, "ID#    : ${Val.billId.value.val}");
    bytes += textLeft(generator, "Kasir  : ${Val.cashier.value.val['name']}");
    bytes += textLeft(generator,
        "Tgl:   : ${DateTime.now().toString().substring(0, 10)} ${DateTime.now().toString().substring(11, 19)}");
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(text: "qty", width: 2, styles: PosStyles(align: PosAlign.left)),
      PosColumn(text: "item", width: 3, styles: PosStyles(align: PosAlign.left)),
      PosColumn(text: "price", width: 4, styles: PosStyles(align: PosAlign.right)),
      PosColumn(text: "total", width: 3, styles: PosStyles(align: PosAlign.right))
    ]);
    bytes += generator.hr();
    for (final itm in CashierVal.listorder.value.val) {
      bytes += generator.row([
        PosColumn(text: itm['qty'].toString(), width: 2, styles: PosStyles(align: PosAlign.left)),
        PosColumn(text: itm['name'].toString(), width: 3, styles: PosStyles(align: PosAlign.left)),
        PosColumn(text: itm['price'].toString(), width: 4, styles: PosStyles(align: PosAlign.right)),
        PosColumn(text: itm['total'].toString(), width: 3, styles: PosStyles(align: PosAlign.right))
      ]);
    }
    bytes += generator.hr();
    bytes += textLeft(generator, "Total  : ${Val.totalOrder.toString()}");
    bytes += textLeft(generator, "Kembali: ${Val.change.value.val}");
    bytes += generator.hr();
    bytes += textCenter(generator, "Terima Kasih telah berbelanja di ${Vl.defOutlet.val['name']}");
    bytes += textCenter(generator, "Selamat berbelanja kembali");
    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }

  toPrint() async {
    SmartDialog.showLoading();
    if (Vl.selectedPrinter.val.isEmpty) {
      SmartDialog.showToast("Printer belum dipilih");
      return;
    }
    final printerManager = besc.PrinterBluetoothManager();
    final printer = besc.PrinterBluetooth(bd.BluetoothDevice.fromJson({
      "id": Vl.selectedPrinter.val['id'],
      "name": Vl.selectedPrinter.val['name'],
      "address": Vl.selectedPrinter.val['address'],
    }));
    printerManager.selectPrinter(printer);
    final besc.PosPrintResult res = await printerManager.printTicket(await tiket());
    SmartDialog.dismiss();
    SmartDialog.showToast("Print ${res.msg}");
  }
}
