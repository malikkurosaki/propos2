import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/outlet/outlet_val.dart';

class OutletDisplay extends StatelessWidget {
  const OutletDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Column(
          children: [
            SizedBox(
              height: 4,
              child: FutureBuilder<http.Response>(
                future: Rot.outletListOutletGet(),
                builder: (con, snap) {
                  if (!snap.hasData) return LinearProgressIndicator();
                  if (snap.data!.statusCode == 200) {
                    () async {
                      await 0.1.delay();
                      final ls = List<Map<String, dynamic>>.from(jsonDecode(snap.data!.body));
                      OutletVal.listoutlet.value.val = ls;
                      OutletVal.listoutlet.refresh();
                    }();
                  }
                  return Container();
                },
              ),
            ),
            Flexible(
              child: Obx(
                () => ListView(
                  children: [
                    ...OutletVal.listoutlet.value.val.map(
                      (element) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ...element.keys.map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: e == 'id'
                                      ? SizedBox.shrink()
                                      : Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                e.toString(),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: e == 'id'
                                                  ? SizedBox.shrink()
                                                  : Text(
                                                      element[e] ?? "",
                                                    ),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        final dataUpdate = OutletModel.fromJson(element);

                                        showBottomSheet(
                                          context: context,
                                          builder: (context) => Material(
                                            child: ListView(
                                              children: [
                                                Container(
                                                  color: Colors.grey.shade100,
                                                  padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    children: [BackButton(), Text("Edit Outlet")],
                                                  ),
                                                ),
                                                ...dataUpdate.toJson().keys.map(
                                                      (e) => ['id', 'userId', 'companyId'].contains(e.toString())
                                                          ? Container()
                                                          : ListTile(
                                                              title: TextFormField(
                                                                controller: TextEditingController(text: element[e]),
                                                                decoration: InputDecoration(
                                                                    filled: true,
                                                                    border: InputBorder.none,
                                                                    label: Text(e.toString())),
                                                              ),
                                                            ),
                                                    ),
                                                    ListTile(
                                                      title: MaterialButton(
                                                        color: Colors.orange,
                                                        onPressed: (){}, child: Padding(
                                                        padding: const EdgeInsets.all(10),
                                                        child: Text("Update", style: TextStyle(
                                                          color: Colors.white
                                                        ),),
                                                      ),),
                                                    )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
