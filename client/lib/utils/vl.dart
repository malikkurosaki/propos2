import 'package:get_storage/get_storage.dart';

class Vl {
  static final userId = "".val('Vl.userId');
  static final companyId = "".val('Vl.companyId');
  static final outletId = "".val('Vl.outletId');
  static final employeeId = "".val("Vl.employeeId");

  static final defUser = {}.val('Vl.defUser');
  static final defCompany = {}.val('Vl.defCompany');
  static final defOutlet = {}.val('Vl.defOutlet');

  static final listPrinter = [].val("Vl.listPrinter");
  static final selectedPrinter = {}.val("Vl.selectedPrinter");

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
