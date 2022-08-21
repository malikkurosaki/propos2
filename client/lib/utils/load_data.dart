import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val_def.dart';

class LoadData {
  loadAll() async {
    // await paymentMethod();
    // await outlet();
    // await product();
    // await category();
    // await employee();
    // await product();
  }

  // Future<void> paymentMethod() async {
  //   final data = await RouterApi.paymentMethodList().getData();
  //   ValDef.paymentMethodList.value.val = jsonDecode(data);
  //   await 0.1.delay();
  //   ValDef.paymentMethodList.refresh();

  //   debugPrint("laod payment method");
  // }

  // Future<void> outlet() async {
  //   final outlet = await RouterApi.listOutlet().getData();
  //   ValDef.outletList.value.val = jsonDecode(outlet);
  //   await 0.1.delay();
  //   ValDef.outletList.refresh();
  // }

  // Future<void> category() async {
  //   final data = await RouterApi.listCategory().getData();
  //   ValDef.categoryList.value.val = jsonDecode(data);
  //   await 0.1.delay();
  //   ValDef.categoryList.refresh();
  // }

  // Future<void> employee() async {
  //   final listUser = await RouterApi.listEmployee().getData();
  //   ValDef.employeeList.value.val = jsonDecode(listUser);
  //   await 0.1.delay();
  //   ValDef.employeeList.refresh();
  // }

  // Future<void> product() async {
  //   final data = await RouterApi.productList().getData();
  //   ValDef.productList.value.val = jsonDecode(data);
  //   await 0.1.delay();
  //   ValDef.productList.refresh();
  // }

  // Future<void> deviceList() async {
  //   final data = await RouterApi.deviceList().getData();
  //   ValDef.deviceList.value.val = jsonDecode(data);
  //   await 0.1.delay();
  //   ValDef.deviceList.refresh();
  // }
}
