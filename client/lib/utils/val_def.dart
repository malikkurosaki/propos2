import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ValDef {
  static final companyList = [].val('ValDef.listCompany').obs;
  static final outletList = [].val('ValDef.listOutlet').obs;
  static final employeeList = [].val('ValDef.listEmployee').obs;
  static final productList = [].val('Val.DeflistProduct').obs;
  static final categoryList = [].val("ValDef.listCategory").obs;
  static final paymentMethodList = [].val("ValDef.paymentMethodList").obs;
  static final deviceList = [].val("ValDef.deviceList").obs;
  static final userMap = {}.val('ValDef.user').obs;
  static final companyDefMap = {}.val('ValDef.defCompany').obs;
  static final outletDefMap = {}.val('ValDef.defOutlet').obs;
  static final userDefMap = {}.val('ValDef.defUser').obs;

  static clear() {
    ValDef.companyList.value.val = [];
    ValDef.outletList.value.val = [];
    ValDef.employeeList.value.val = [];
    ValDef.productList.value.val = [];
    ValDef.categoryList.value.val = [];
    ValDef.paymentMethodList.value.val = [];
    ValDef.deviceList.value.val = [];
    ValDef.userMap.value.val = {};
    ValDef.companyDefMap.value.val = {};
    ValDef.outletDefMap.value.val = {};
    ValDef.userDefMap.value.val = {};
  }
}
