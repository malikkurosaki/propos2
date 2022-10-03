import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CashierVal {
  static final conSearch = TextEditingController();
  static final restoreOrderName = "".val('Cashier.restoreOrderName').obs;
  // final _listProduct = List.from(ValDef.productList.value.val).val('Cashier.listProduct').obs;
  // final _listCategory = [].obs;
  static final listProduct = [].val("CashierVal.listProduct").obs;
  static final tmpListProduct = [].val("Cashier._tmpListProduct").obs;

  // static final isMultipleSelect = false.obs;
  static final lsTampungan = [].obs;

  // static final listManualProduct = [].val("CashierVal.listManualProduct").obs;

  static final listCustomer = [].obs;
  static final selectedCustomer = {}.val("CashirVal.seletctedCustomer").obs;

  static final pax = 1.val("CashierVal.pax").obs;

  static final totalPrice = 0.val("CashierVal.totalPriwce").obs;
  static final totalQty = 0.obs;

  static final listorder = [].val("CashierVal.listOrder").obs;

  static final listCategory = [].obs;

  // static loadProduct() async {
  //   // final list = await RouterApi.listProduct().getData();
  //   // final listPro = await RouterApi.productCashier().getData();
  //   final listPro = await Rot.cashierListProductGet();

  //   // debugPrint(listPro.body);

  //   if (listPro.statusCode == 200) {
  //     final lsData = jsonDecode(listPro.body);
  //     CashierVal.listProduct.value.val = lsData;
  //     CashierVal.tmpListProduct.value.val = lsData;
  //     CashierVal.listProduct.refresh();
  //   }
  // }
}
