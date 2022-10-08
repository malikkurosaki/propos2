import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmployeeVal {
  static final listCompany = [].obs;
  static final selectedCompany = {}.obs;

  static final listOutlet = [].obs;
  static final selectedOutlet = {}.obs;

  // static final name = "".obs;
  static final listEmployee = [].val("EmployeeVal.listEmployee").obs;

  static final bodyCreate = EmployeeModel().obs;
  static final reload = false.obs;

  static final bodyEdit = EmployeeModel().obs;
  static final mapData = {}.obs;
}

class EmployeeModel {
  String? name;
  String? companyId;
  String? deviceId;
  String? outletId;
  String? password;
  String? userId;
  bool? isActive;

  EmployeeModel({
    this.name,
    this.companyId,
    this.deviceId,
    this.outletId,
    this.password,
    this.userId,
    this.isActive
  });

  EmployeeModel.fromJson(Map json) {
    name = json['name'];
    companyId = json['companyId'];
    deviceId = json['deviceId'];
    outletId = json['outletId'];
    password = json['password'];
    userId = json['userId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "companyId": companyId,
      "deviceId": deviceId,
      "outletId": outletId,
      "password": password,
      "userId": userId,
      "isActive": isActive
    };

    data.removeWhere((key, value) => value.toString().isEmpty || value == null);
    return data;
  }
}
