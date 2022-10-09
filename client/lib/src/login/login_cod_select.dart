import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/pages.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/login/login_val.dart';
import 'package:get/get.dart';
import 'package:propos/utils/vl.dart';

class LoginCodSelect extends StatelessWidget {
  const LoginCodSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Please Completer This Action First",
              style: TextStyle(fontSize: 24),
            ),
          ),
          ListTile(
            title: DropdownSearch<Map>(
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    InputDecoration(
                      filled: true, border: InputBorder.none, hintText: "Select Company", labelText: 'Company' ),
              ),
              items: [...LoginVal.listCompany],
              itemAsString: (value) => value['name'].toString(),
              onChanged: (value) async {
                LoginVal.selectedCompany.assignAll(value!);
                LoginVal.listoutlet.assignAll(value['Outlet']);
                // final listOutlet = await Rot.lgnListOutletByCompanyGet(
                //   query: "companyId=${value['id']}",
                // );

                // if (listOutlet.statusCode == 200) {
                //   LoginVal.listoutlet.assignAll(jsonDecode(listOutlet.body));
                // }
              },
            ),
          ),
          Obx(
            () => ListTile(
              title: LoginVal.listoutlet.isEmpty
                  ? Text("Select Outlet")
                  : DropdownSearch<Map>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration:
                            InputDecoration(filled: true, border: InputBorder.none, hintText: "Select outlet", labelText: 'Outlet'),
                      ),
                      items: [...LoginVal.listoutlet],
                      itemAsString: (value) => value['name'].toString(),
                      onChanged: (value) {
                        LoginVal.selectedOutlet.assignAll(value!);
                        LoginVal.listDevice.assignAll(value['Device']);
                        // Rot.lgnListDeviceByOutletGet(query: "outletId=${value['id']}").then(
                        //   (value) {
                        //     // debugPrint(value.body.toString());
                        //     if (value.statusCode == 200) {
                        //       LoginVal.listDevice.assignAll(jsonDecode(value.body));
                        //     }
                        //   },
                        // );
                      },
                    ),
            ),
          ),
          Obx(
            () => ListTile(
              title: LoginVal.listDevice.isEmpty
                  ? Text("Select Device")
                  : DropdownSearch<Map>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration:
                            InputDecoration(filled: true, border: InputBorder.none, hintText: "Select outlet", labelText: 'Device'),
                      ),
                      items: [...LoginVal.listDevice],
                      itemAsString: (value) => value['name'].toString(),
                      onChanged: (value) {
                        LoginVal.selectedDevice.assignAll(value!);
                      },
                    ),
            ),
          ),
          Obx(
            () => LoginVal.selectedCompany.isEmpty || LoginVal.selectedOutlet.isEmpty || LoginVal.selectedDevice.isEmpty
                ? SizedBox.shrink()
                : ListTile(
                    title: MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        final modelData = {
                          // "token": Vl.token.val,
                          "deviceId": LoginVal.selectedDevice['id'],
                          "userId": Vl.userId.val,
                          "companyId": LoginVal.selectedCompany['id'],
                          "outletId": LoginVal.selectedOutlet['id']
                        };

                        final data = await Rot.loginSetDefaultPrefPost(body: {"data": jsonEncode(modelData)});
                        if (data.statusCode == 201) {
                          SmartDialog.showToast("success");
                          Vl.deviceId.val = modelData['deviceId'];
                          Get.offNamed(Pages.homePage().route);
                          return;
                        } else {
                          SmartDialog.showToast(data.body);
                        }

                        // final data = await Rot.lgnSetDefaultPost(
                        //   body: {"data": jsonEncode(modelData)},
                        // );

                        // if (data.statusCode == 200) {
                        //   Get.offNamed(Pages.homePage().route);
                        // } else {
                        //   SmartDialog.showToast(data.body.toString());
                        // }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
