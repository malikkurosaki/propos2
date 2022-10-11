import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/components/company_select.dart';
import 'package:propos/components/input.dart';
import 'package:propos/components/search_view_with_checkbox.dart';
import 'package:propos/src/discount/discount_create.dart';
import 'package:propos/src/discount/discount_display.dart';
import 'package:propos/utils/notif.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class Discount extends StatelessWidget {
  Discount({Key? key}) : super(key: key);
  final _listDiscount = [].obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(child: DiscountDisplay()),
                    ),
                    Visibility(
                      visible: !media.isMobile,
                      child: SizedBox(
                        width: 460,
                        child: Card(
                          child: DiscountCreate(),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _loadDiscount() {
    RouterApi.discountList().getData().then((res) {
      if (res.statusCode == 200) _listDiscount.assignAll(jsonDecode(res.body));
    });
  }

  Widget _listDisplay() {
    _loadDiscount();
    final listSelected = [].obs;
    final isSelectedAll = false.obs;

    return Column(
      children: [
        SearchViewWithCheckbox(
          onChanged: (val) {},
          checkValue: isSelectedAll,
          onCheckChanged: (value) {
            if (value!) {
              listSelected.assignAll(_listDiscount.map((element) => element['id']));
            } else {
              listSelected.clear();
            }

            isSelectedAll.value = listSelected.isNotEmpty && listSelected.length.isEqual(_listDiscount.length);
          },
        ),
        Obx(
          () => Flexible(
            child: ListView(
              children: [
                ..._listDiscount.map(
                  (element) => ListTile(
                    leading: Checkbox(
                      value: listSelected.contains(element['id']),
                      onChanged: (value) {
                        if (value!) {
                          listSelected.add(element['id']);
                          listSelected.refresh();
                        } else {
                          listSelected.removeWhere((el) => el == element['id']);
                        }

                        isSelectedAll.value =
                            listSelected.isNotEmpty && listSelected.length.isEqual(_listDiscount.length);
                      },
                    ),
                    title: Text(
                      element['name'],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "edit",
                          child: Text("Edit"),
                        ),
                        PopupMenuItem(
                          value: "del",
                          child: Text("Delet"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

// id
// name
// des
// isPercentage
// percentage
// value
// min
// max
// start
// end
// createdAt
// updatedAt
// User
// userId
// Company
// companyId
// Outlet
// outletId
// Product
// Bill

  Widget _create() {
    final isPercentage = true.obs;
    final companyId = "".obs;
    final conName = TextEditingController();
    final conDes = TextEditingController();
    final conVal = TextEditingController();
    final saveLoading = false.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.add_card_sharp,
                color: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create Discount",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView(
            children: [
              CompanySelect(
                onSelectCompany: (value) {
                  companyId.value = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: conName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    isDense: true,
                    label: Text("Name"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: conDes,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    isDense: true,
                    label: Text("Description"),
                  ),
                ),
              ),
              Obx(
                () => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Is Precentage"),
                          Checkbox(
                            value: isPercentage.value,
                            onChanged: (value) {
                              isPercentage.toggle();
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: conVal,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          isDense: true,
                          label: Text("value"),
                          prefix: isPercentage.value ? null : Text("Rp "),
                          suffixIcon: !isPercentage.value
                              ? null
                              : Icon(
                                  Icons.percent,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: saveLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : MaterialButton(
                              color: Colors.cyan,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                saveLoading.value = true;
                                // id
                                // name
                                // des
                                // isPercentage
                                // percentage
                                // value
                                // min
                                // max
                                // start
                                // end
                                // createdAt
                                // updatedAt
                                // User
                                // userId
                                // Company
                                // companyId
                                // Outlet
                                // outletId
                                // Product
                                // Bill

                                final body = <String, dynamic>{
                                  "userId": Vl.userId.val,
                                  "companyId": companyId.value,
                                  "name": conName.text,
                                  "des": conDes.text,
                                  "value": conVal.text,
                                  "isPercentage": isPercentage.value.toString()
                                };

                                // debugPrint(body.toString());

                                if (body.values.contains("")) {
                                  Notif.error(message: "mohon diisi semuanya");
                                  return;
                                }

                                if (int.tryParse(conVal.text) == null) {
                                  Notif.error(message: "value number only");
                                  return;
                                }

                                if (isPercentage.value && int.parse(conVal.text).isGreaterThan(100)) {
                                  Notif.error(message: "percen tidak lebih dari 100");
                                  return;
                                }

                                final res = await RouterApi.discountCrete().postData(body);
                                if (res.statusCode == 201) {
                                  Notif.success();
                                  conVal.clear();
                                  conDes.clear();
                                  conName.clear();
                                  isPercentage.value = true;

                                  _loadDiscount();
                                } else {
                                  Notif.error(message: res.body);
                                }

                                saveLoading.value = false;
                              },
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
