import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propos/src/printers/print_struk_model.dart';

class PrinterVal {
  static final device = {}.val("PrinterVal.device").obs;
  static final listPrinter = [].val("PrinterVal.listPrinter").obs;
  static final selectedPrinter = {}.val("PrinterVal.selectedPrinter").obs;
  static final printerStruk = PrinterStrukModel().val("PrinterVal.printerStruk").obs;
}





