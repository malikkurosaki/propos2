import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerVal {
  static final listCompanyCreate = [].obs;
  static final listCompanyDisplay = [].obs;
  
  static final selectedCompany = {}.obs;
  static final listCustomer = [].val("CustomerVal.listCustomer").obs;
  static final reload = false.obs;

  static final mapData = {}.obs;
}
