import 'package:get_storage/get_storage.dart';

class Vl {
  static final userId = "".val('Vl.userId');
  static final companyId = "".val('Vl.companyId');
  static final outletId = "".val('Vl.outletId');
  static final employeeId = "".val("Vl.employeeId");
  static final deviceId = "".val("Vl.deviceId");

  static final defUser = {}.val('Vl.defUser');
  static final defCompany = {}.val('Vl.defCompany');
  static final defOutlet = {}.val('Vl.defOutlet');
  static final defDevice = {}.val("Vl.device");

  static final listPrinter = [].val("Vl.listPrinter");
  static final selectedPrinter = {}.val("Vl.selectedPrinter");

  static final headers = {'userId': Vl.userId.val, 'companyId': companyId.val, 'outletId': outletId.val};

  static void clear() {
    userId.val = "";
    companyId.val = "";
    outletId.val = "";
    employeeId.val = "";

    defUser.val = {};
    defCompany.val = {};
    defOutlet.val = {};
  }
}
