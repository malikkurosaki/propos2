import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:propos/components/company_select.dart';
import 'package:propos/components/input.dart';
import 'package:propos/components/outlet_multi_select_by_company.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/vl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

// class _ProductDetail {
//   final isInclude = false.obs;
//   final companyId = "".obs;
//   final categoryId = "".obs;
//   final listoutlet = [].obs;
//   final des = TextEditingController();
//   final modal = TextEditingController();
//   final sku = TextEditingController();
//   final barcodeId = TextEditingController();
//   final berat = TextEditingController();
//   final dimensi = TextEditingController();
// }

class ProductCreateWithDetail extends StatelessWidget {
  const ProductCreateWithDetail({Key? key}) : super(key: key);

  // ProductCreateWithDetail({Key? key, required this.lsCategory}) : super(key: key);

  // final dataDetail = _ProductDetail();
  // final RxList<dynamic> lsCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: 4,
        //   child: FutureBuilder<http.Response>(
        //     future: Rot.globalListCompanyOutletCategoryGet(),
        //     builder: (context, snap) {
        //       if (!snap.hasData) return LinearProgressIndicator();
        //       if (snap.data!.statusCode == 200) {
        //         () async {
        //           await 0.1.delay();
        //           ProductVal.listCompany.value.val = jsonDecode(snap.data!.body);
        //           ProductVal.listCompany.refresh();
        //         }();
        //       }
        //       return Container();
        //     },
        //   ),
        // ),
        SizedBox(
          height: 4,
          child: FutureBuilder<http.Response>(
            future: Rot.productDetailListOutletCategoryGet(),
            builder: (con, snap) {
              if (!snap.hasData) return LinearProgressIndicator();
              if (snap.data!.statusCode == 200) {
                () async {
                  await 0.1.delay();
                  ProductVal.mapCompanyOutletCategory.assignAll(jsonDecode(snap.data!.body));
                }();
              }
              return Container();
            },
          ),
        ),
        Obx(
          () => ListTile(
            title: CheckboxListTile(
              title: Text(
                "Include Detail",
                textAlign: TextAlign.end,
              ),
              value: ProductVal.mapBodyCreate.value.val['isDetail'] ?? false,
              onChanged: (value) {
                final data = ProductVal.mapBodyCreate.value.val;
                data['isDetail'] = value;

                if (value!) {
                  for (final itm in (data['ProductOutlet']['createMany']['data'] as List)) {
                    itm['isActive'] = true;
                  }
                } else {
                  for (final itm in (data['ProductOutlet']['createMany']['data'] as List)) {
                    itm['isActive'] = false;
                  }
                }
                ProductVal.mapBodyCreate.value.val = data;
                ProductVal.mapBodyCreate.refresh();
                // ProductVal.dataDetail.isInclude.value = value!;
              },
              subtitle: Text(
                "jika tidak menggunakan detail akan menggunakan default detail pada saat ini yang tersedia",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: ProductVal.mapBodyCreate.value.val['isDetail'] ?? false,
            child: ProductVal.mapCompanyOutletCategory.isEmpty
                ? Container()
                : Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.business),
                        title: Text(ProductVal.mapCompanyOutletCategory['name'].toString()),
                      ),

                      ListTile(
                        title: Builder(builder: (context) {
                          final cat = ProductVal.mapBodyCreate.value.val['categoryId'];
                          Map selected = {};
                          if (cat != null) {
                            selected = (ProductVal.mapCompanyOutletCategory['Category'] as List)
                                .where((element) => element['id'] == cat)
                                .toList()[0];
                          }else{
                            selected = (ProductVal.mapCompanyOutletCategory['Category'] as List)[0];
                          }

                          // debugPrint(selected.toString());

                          return DropdownSearch<Map>(
                            selectedItem: selected,
                            popupProps: PopupProps.menu(showSelectedItems: true),
                            compareFn: (a, b) => a['id'] == b['id'],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                labelText: 'category',
                              ),
                            ),
                            items: [...ProductVal.mapCompanyOutletCategory['Category']],
                            itemAsString: (val) => val['name'],
                            onChanged: (val) {
                              // ProductVal.dataDetail.categoryId.value = val!['id'];
                              final data = ProductVal.mapBodyCreate.value.val;
                              data['categoryId'] = val!['id'];
                              ProductVal.mapBodyCreate.value.val = data;
                            },
                          );
                        }),
                      ),
                      // Text(ProductVal.mapBodyCreate.value.val.toString()),
                      ListTile(
                        title: Builder(builder: (context) {
                          final out =
                              (ProductVal.mapBodyCreate.value.val['ProductOutlet']['createMany']['data'] as List)
                                  .where((element) => element['isActive'])
                                  .toList()
                                  .map((e) => e['outletId'])
                                  .toList();

                          final selected = <Map>[];
                          if (out.isNotEmpty) {
                            selected.assignAll([
                              ...List<Map>.from(ProductVal.mapCompanyOutletCategory['Outlet'])
                                  .where((element) => out.contains(element['id']))
                                  .toList()
                            ]);
                          }

                          debugPrint(selected.toString());

                          return DropdownSearch<Map>.multiSelection(
                            selectedItems: selected,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'select outlet',
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                            popupProps: PopupPropsMultiSelection.menu(showSelectedItems: true),
                            compareFn: (a, b) => a['id'].toString() == b['id'].toString(),
                            items: [...ProductVal.mapCompanyOutletCategory['Outlet']],
                            itemAsString: (val) => val['name'],
                            onChanged: (val) {
                              final data = {...ProductVal.mapBodyCreate.value.val};
                              data['ProductOutlet'] = {
                                "createMany": {
                                  "data": val
                                      .map(
                                        (e) => {"outletId": e['id'], "isActive": true},
                                      )
                                      .toList()
                                }
                              };

                              ProductVal.mapBodyCreate.value.val = data;
                            },
                          );
                        }),
                      ),
                      // ListTile(
                      //   title: DropdownButtonFormField(
                      //     decoration: const InputDecoration(
                      //         labelStyle: TextStyle(backgroundColor: Colors.white),
                      //         labelText: "Select Category",
                      //         isDense: true,
                      //         border: OutlineInputBorder(borderSide: BorderSide.none),
                      //         filled: true),
                      //     items: [
                      //       ...ProductVal.lsCategory.map(
                      //         (element) => DropdownMenuItem(
                      //           value: element,
                      //           child: Text(element['name'].toString()),
                      //         ),
                      //       )
                      //     ],
                      //     onChanged: (value) {
                      //       ProductVal.dataDetail.categoryId.value = (value as Map)['id'];
                      //     },
                      //   ),
                      // ),

                      // Column(
                      //   children: [
                      //     Visibility(visible: false, child: Text(ProductVal.lsCategory.toString())),
                      //     FutureBuilder<RxList>(
                      //       future: (() async => ProductVal.lsCategory)(),
                      //       builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                      //           ? _temSelect("Select Category")
                      //           : Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child:
                      //               DropdownButtonFormField(
                      //                 decoration: const InputDecoration(
                      //                     labelStyle: TextStyle(backgroundColor: Colors.white),
                      //                     labelText: "Select Category",
                      //                     isDense: true,
                      //                     border: OutlineInputBorder(borderSide: BorderSide.none),
                      //                     filled: true),
                      //                 items: [
                      //                   ...ProductVal.lsCategory.map(
                      //                     (element) => DropdownMenuItem(
                      //                       value: element,
                      //                       child: Text(element['name'].toString()),
                      //                     ),
                      //                   )
                      //                 ],
                      //                 onChanged: (value) {
                      //                   ProductVal.dataDetail.categoryId.value = (value as Map)['id'];
                      //                 },
                      //               ),

                      //             ),
                      //     ),
                      //   ],
                      // ),

                      // disini
                      // OutletMultiSelectByCompany(
                      //   companyId: ProductVal.dataDetail.companyId.value,
                      //   onSelectOutlet: (value) {
                      //     // debugPrint(value.toString());
                      //     // _selectedoutletList.assignAll(value);
                      //     final hasil = value.map(
                      //       (e) => {
                      //         "outletId": e,
                      //         "companyId": ProductVal.dataDetail.companyId.value,
                      //         "userId": Vl.userId.val,
                      //       },
                      //     );
                      //     ProductVal.dataDetail.listoutlet.assignAll(hasil);
                      //   },
                      // ),
                      _input(
                        value: ProductVal.mapBodyCreate.value.val['description'] ?? "",
                        onChanged: (val) {
                          final data = {...ProductVal.mapBodyCreate.value.val};
                          data['description'] = val;
                          ProductVal.mapBodyCreate.value.val = data;
                        },
                        lableText: "keterangan",
                      ),
                      _input(
                        value: (ProductVal.mapBodyCreate.value.val['costOfCapital'] ?? "").toString(),
                        onChanged: (val) {
                          if (int.tryParse(val) == null) {
                            final data = ProductVal.mapBodyCreate.value.val;
                            data['costOfCapital'] = 0;
                            ProductVal.mapBodyCreate.value.val = data;
                            ProductVal.mapBodyCreate.refresh();
                            return;
                          }

                          final data = ProductVal.mapBodyCreate.value.val;
                          data['costOfCapital'] = int.parse(val);
                          ProductVal.mapBodyCreate.value.val = data;
                        },
                        lableText: 'COC (modal)',
                      ),
                      _input(
                        value: ProductVal.mapBodyCreate.value.val['sku'] ?? "",
                        onChanged: (val) {
                          final data = ProductVal.mapBodyCreate.value.val;
                          data['sku'] = val;
                          ProductVal.mapBodyCreate.value.val = data;
                        },
                        lableText: 'SKU',
                      ),
                      _input(
                          value: ProductVal.mapBodyCreate.value.val['barcodeId'],
                          onChanged: (val) {
                            final data = ProductVal.mapBodyCreate.value.val;
                            data['barcodeId'] = val;
                            ProductVal.mapBodyCreate.value.val = data;
                          },
                          lableText: 'barcode id'),
                      // Input(
                      //   controller: ProductVal.dataDetail.des,
                      //   hint: "keterangan",
                      // ),
                      // Input(
                      //   onChanged: (value) {
                      //     if (int.tryParse(value) == null) ProductVal.dataDetail.modal.clear();
                      //   },
                      //   controller: ProductVal.dataDetail.modal,
                      //   hint: "Harga Modal",
                      // ),
                      // Input(
                      //   controller: ProductVal.dataDetail.sku,
                      //   hint: "SKU",
                      // ),
                      // Input(
                      //   controller: ProductVal.dataDetail.barcodeId,
                      //   hint: "Barcode Id",
                      // ),
                      // Input(
                      //   controller: ProductVal.dataDetail.berat,
                      //   hint: "Berat",
                      //   onChanged: (value) {
                      //     if (int.tryParse(value) == null) ProductVal.dataDetail.berat.clear();
                      //   },
                      // ),
                      // Input(
                      //   controller: ProductVal.dataDetail.dimensi,
                      //   hint: "Dimensi",
                      //   info: "P x L x T, contoh 120, 120, 10",
                      // )
                    ],
                  ),
          ),
        )
      ],
    );
  }

  Widget _input({required String? value, required Function(String value)? onChanged, required String? lableText}) =>
      ListTile(
        title: TextFormField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            border: InputBorder.none,
            labelText: lableText,
          ),
        ),
      );

  Widget _temSelect(String lable) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              labelText: lable,
              labelStyle: const TextStyle(backgroundColor: Colors.white),
              filled: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      );
}
