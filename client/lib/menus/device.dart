import 'dart:convert';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/components/select_company.dart';
import 'package:propos/components/select_outlet_by_company.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Device extends StatelessWidget {
  Device({Key? key}) : super(key: key);

  final listDevice = [].obs;
  _loadListDevice() {
    RouterApi.deviceByUser().getData().then((value) {
      if (value.statusCode == 200) listDevice.assignAll(jsonDecode(value.body));
    });
  }

  _onLoad() async {
    _loadListDevice();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, media) {
        return Material(
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: _listDevice(media),
                ),
                _create(media)
              ],
            ),
          ),
        );
      },
    );
  }

  

  Widget _listDevice(SizingInformation media) {
    return Obx(
      () => listDevice.isEmpty
          ? Center(child: Text("Device empty ...?"))
          : ContainedTabBarView(
              tabs: [
                ...listDevice.map(
                  (e) => ListTile(
                    title: Text(e['name'].toString()),
                  ),
                ),
              ],
              views: [
                ...listDevice.map(
                  (e) => (e['Outlet'] as List).isEmpty
                      ? Text("empty")
                      : ContainedTabBarView(tabs: [
                          ...(e['Outlet'] as List).map(
                            (e) => ListTile(
                              title: Text(e['name'].toString()),
                            ),
                          ),
                        ], views: [
                          ...(e['Outlet'] as List).map(
                            (e) => Column(children: [
                              ListTile(
                                leading: Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      border: OutlineInputBorder(borderSide: BorderSide.none),
                                      hintText: "Search",
                                      prefixIcon: Icon(Icons.search),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                  child: ListView(
                                controller: ScrollController(),
                                children: [
                                  ...(e['Device'] as List).map(
                                    (e) => ListTile(
                                      leading: Checkbox(
                                        value: false,
                                        onChanged: (value) {},
                                      ),
                                      title: Text(e['name'].toString()),
                                      subtitle: Text(e['deviceId'].toString()),
                                      trailing: PopupMenuButton(
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 1,
                                            child: Text("share"),
                                          ),
                                          PopupMenuItem(
                                            value: 1,
                                            child: Text("edit"),
                                          ),
                                          PopupMenuItem(
                                            value: 2,
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            ]),
                          ),
                        ]),
                ),
              ],
            ),
    );
  }

  Widget _create(SizingInformation media) {
    final selectedCompanyId = "".obs;
    final body = <String, dynamic>{
      "name": TextEditingController(),
      "outletId": "",
      "companyId": "",
    };
    return Visibility(
      visible: media.isDesktop,
      child: SizedBox(
        width: media.isMobile ? Get.width : 360,
        child: Card(
          child: ListView(
            controller: ScrollController(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Create Device', style: TextStyle(fontSize: 24)),
              ),
              SelectCompany(onSelectCompany: (value) {
                selectedCompanyId.value = value;
                body['companyId'] = value;
              }),
              Obx(
                () => SelectOoutletByCompany(
                    companyId: selectedCompanyId.value,
                    onSelectOutlet: (value) {
                      body['outletId'] = value;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: body['name'],
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.devices),
                    hintText: "device name",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final b = {
                      "name": (body['name'] as TextEditingController).text,
                      "outletId": body['outletId'],
                      "companyId": body['companyId'],
                    };

                    if (b.values.contains("")) {
                      SmartDialog.showToast("Please fill all field");
                      return;
                    }

                    final crt = await RouterApi.deviceCreate().postData(b);
                    await _loadListDevice();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
