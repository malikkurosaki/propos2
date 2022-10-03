import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:propos/components/select_printer_web.dart';
import 'package:propos/src/printers/printer_select.dart';

class Printer extends StatelessWidget {
  const Printer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isAndroid ? PrinterSelect(): SelectPrinterWeb();
  }
}
