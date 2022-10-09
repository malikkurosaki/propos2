import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/device/device_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeviceCreate extends StatelessWidget {
  const DeviceCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => SizedBox(
        width: media.isMobile ? Get.width : 460,
        child: Card(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Create Device",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 4,
                child: FutureBuilder<http.Response>(
                  future: Rot.globalCodGet(),
                  builder: (con, snap) {
                    if (!snap.hasData) return LinearProgressIndicator();
                    () async {
                      if (snap.data!.statusCode == 200) {
                        await 0.1.delay();
                        DeviceVal.lisCompanyCreate.assignAll(jsonDecode(snap.data!.body));
                      }
                    }();
                    return Container();
                  },
                ),
              ),
              Obx(
                () => ListTile(
                  title: DropdownSearch<Map>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            filled: true, border: InputBorder.none, hintText: 'select company', labelText: 'company')),
                    items: [...DeviceVal.lisCompanyCreate],
                    itemAsString: (val) => val['name'].toString(),
                    onChanged: (val) {
                      DeviceVal.listOutletCreate.assignAll(val!['Outlet']);
                      DeviceVal.bodyCreate['companyId'] = val['id'];
                    },
                  ),
                ),
              ),
              Obx(
                () => ListTile(
                  title: DeviceVal.listOutletCreate.isEmpty
                      ? Text("Select Outlet ...")
                      : DropdownSearch<Map>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: 'select outlet',
                                  labelText: 'outlet')),
                          items: [...DeviceVal.listOutletCreate],
                          itemAsString: (val) => val['name'],
                          onChanged: (val) {
                            DeviceVal.bodyCreate['outletId'] = val!['id'];
                          },
                        ),
                ),
              ),
              ListTile(
                title: TextFormField(
                  onChanged: (val) => DeviceVal.bodyCreate['name'] = val,
                  controller: TextEditingController(text: DeviceVal.bodyCreate['name']),
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Device Name',
                    labelText: 'name',
                  ),
                ),
              ),
              ListTile(
                title: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (DeviceVal.bodyCreate.values.contains("")) {
                      SmartDialog.showToast("No Empty Allowed");
                      return;
                    }

                    final res = await Rot.deviceCreatePost(body: {"data": jsonEncode(DeviceVal.bodyCreate)});
                    if (res.statusCode == 201) {
                      SmartDialog.showToast('success');
                    } else {
                      SmartDialog.showToast(res.body);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
