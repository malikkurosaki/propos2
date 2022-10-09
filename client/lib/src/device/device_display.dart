import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/device/device_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeviceDisplay extends StatelessWidget {
  const DeviceDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Scaffold(
        body: Builder(builder: (context) {
          return Card(
            child: ListView(
              children: [
                Obx(() {
                  DeviceVal.reload.value;
                  return SizedBox(
                    height: 4,
                    child: FutureBuilder<http.Response>(
                        future: Rot.deviceListGet(),
                        builder: (con, snap) {
                          if (!snap.hasData) return LinearProgressIndicator();
                          if (snap.data!.statusCode == 200) {
                            () async {
                              await 0.1.delay();
                              DeviceVal.listDevice.value.val = jsonDecode(snap.data!.body);
                              DeviceVal.listDevice.refresh();
                            }();
                          }
                          return Container();
                        }),
                  );
                }),
                Obx(
                  () => Column(
                    children: [
                      ...DeviceVal.listDevice.value.val.map(
                        (e) => ListTile(
                          leading: Text((DeviceVal.listDevice.value.val.indexOf(e) + 1).toString()),
                          title: Text(e['name'].toString()),
                          trailing: Icon(
                            Icons.check_box,
                            color: e['isActive'] ? Colors.green : Colors.grey,
                          ),
                          onTap: () {
                            DeviceVal.mapData.assignAll(e);
                            showBottomSheet(
                              context: context,
                              builder: (context) => Material(
                                child: ListView(
                                  children: [
                                    Container(
                                      color: Colors.grey.shade100,
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [BackButton(), Text("EditDevice")],
                                      ),
                                    ),
                                    ...DeviceVal.mapData.keys.map(
                                      (el) => !['name', 'isActive'].contains(el)
                                          ? Container()
                                          : el == 'isActive'
                                              ? Obx(
                                                  () {
                                                    return ListTile(
                                                      title: CheckboxListTile(
                                                          title: Text("Is Aactive ?"),
                                                          value: DeviceVal.mapData['isActive'],
                                                          onChanged: (val) => DeviceVal.mapData['isActive'] = val),
                                                    );
                                                  },
                                                )
                                              : ListTile(
                                                  title: TextFormField(
                                                    onChanged: (val) => DeviceVal.mapData[el] = val,
                                                    controller:
                                                        TextEditingController(text: DeviceVal.mapData[el].toString()),
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        border: InputBorder.none,
                                                        hintText: 'Device Name',
                                                        labelText: 'name'),
                                                  ),
                                                ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: MaterialButton(
                                              color: Colors.pink,
                                              onPressed: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Center(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: MaterialButton(
                                              color: Colors.orange,
                                              onPressed: () async {
                                                final res = await Rot.deviceUpdatePost(
                                                    body: {"data": jsonEncode(DeviceVal.mapData)});
                                                if (res.statusCode == 201) {
                                                  DeviceVal.reload.toggle();
                                                  SmartDialog.showToast("success ");
                                                  Get.back();
                                                } else {
                                                  SmartDialog.showToast(res.body);
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Center(
                                                  child: Text(
                                                    "Update",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
