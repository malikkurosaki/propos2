import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeviceVal {
  static final lisCompanyCreate = [].obs;
  static final listCompanyDisplay = [].obs;

  static final bodyCreate = {"companyId": "", "outletId": "", "name": ""}.obs;

  static final listOutletCreate = [].obs;
  static final listDevice = [].val('DeviceVal.listDevice').obs;

  static final mapData = {}.obs;
  static final reload = false.obs;
}
