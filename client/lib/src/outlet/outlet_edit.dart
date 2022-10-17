import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/outlet/outlet_val.dart';
import 'package:get/get.dart';

class OutletEdit extends StatelessWidget {
  const OutletEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          Container(
            color: Colors.grey.shade100,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [BackButton(), Text("Edit Outlet")],
            ),
          ),
          ...OutletVal.mapData.keys.map(
            (el) => !['name', 'address', 'email', 'phone', 'logoUrl', 'isActive'].contains(el)
                ? SizedBox.shrink()
                : el.toString() == 'isActive'
                    ? Obx(
                        () => ListTile(
                          title: CheckboxListTile(
                            title: Text("Is Active ?"),
                            onChanged: (val) {
                              OutletVal.mapData[el] = val;
                            },
                            value: OutletVal.mapData[el],
                          ),
                        ),
                      )
                    : ListTile(
                        title: TextFormField(
                          onChanged: (val) => OutletVal.mapData[el] = val,
                          controller: TextEditingController(text: OutletVal.mapData[el] ?? ""),
                          decoration: InputDecoration(
                            labelText: el,
                            filled: true,
                            border: InputBorder.none,
                          ),
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
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
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
                      final res = await Rot.outletUpdatePost(body: {"data": jsonEncode(OutletVal.mapData)});
                      if (res.statusCode == 201) {
                        SmartDialog.showToast("success");
                        OutletVal.reload.toggle();
                        Get.back();
                      } else {
                        SmartDialog.showToast(res.body);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
