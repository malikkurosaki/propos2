import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReportVal {
  static final dateData = <String, dynamic>{
    "start": DateTime.now().toLocal().toString().split(" ")[0],
    "end": DateTime.now().toLocal().toString().split(" ")[0]
  }.val("ReportSelectDate.dateData4").obs;

  static final listBill = [].val("ReportVal.listBill").obs;
}
