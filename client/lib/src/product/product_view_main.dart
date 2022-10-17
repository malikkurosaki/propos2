import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/developer/developer_val.dart';
import 'package:propos/src/product/product_create.dart';
import 'package:propos/src/product/product_edit.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

class ProductViewMain extends StatelessWidget {
  const ProductViewMain({Key? key}) : super(key: key);

  // final _listWidth = [
  //   {"title": "No", "width": 70, "field": "no"},
  //   {"title": "Product Name", "width": 400, "field": "name"},
  //   {"title": "Price", "width": 100, "field": "price"},
  //   // {"title": "Action", "width": 100, "field": "act"}
  // ];

  // _onLoad() {
  //   Rot.productDefaultGet().then(
  //     (res) {
  //       // debugPrint(res.body);
  //       if (res.statusCode == 200) {
  //         ProductVal.listSelectProduct.assignAll(jsonDecode(res.body));
  //         // ProductVal.listSelectProduct.refresh();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // _onLoad();

    return ResponsiveBuilder(
      builder: (context, media) => Scaffold(
        floatingActionButton: !media.isMobile
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showBottomSheet(context: context, builder: (context) => ProductCreate());
                },
                child: Icon(Icons.add),
              ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                // select Company
                Card(
                  child: ExpansionTile(
                    title: Text("Details"),
                    children: [
                      Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.business),
                            title: FutureBuilder<http.Response>(
                              future: Rot.globalListCompanyGet(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState != ConnectionState.done) return Text("loading ...");
                                debugPrint(snapshot.data!.body);
                                if (snapshot.data!.statusCode == 200) {
                                  ProductVal.listSelectCompany.assignAll(jsonDecode(snapshot.data!.body));
                                }
                                return ProductVal.listSelectCompany.isEmpty
                                    ? Text("empty")
                                    : DropdownSearch<Map>(
                                        items: [...ProductVal.listSelectCompany],
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                              isDense: false,
                                              filled: true,
                                              border: InputBorder.none,
                                              hintText: "select company"),
                                        ),
                                        itemAsString: (value) => value['name'],
                                        onChanged: (value) {
                                          ProductVal.selectCompany.assignAll(value!);
                                          ProductVal.listSelectOutlet.assignAll(value['Outlet']);
                                          ProductVal.listSelectCategory.assignAll(value['Category']);
                                          // ProductVal.selectCompany.refresh();

                                          // Rot.lgnListOutletByCompanyGet(query: "companyId=${value['id']}").then(
                                          //   (res) {
                                          //     if (res.statusCode == 200) {
                                          //       ProductVal.listSelectOutlet.assignAll(jsonDecode(res.body));
                                          //       // ProductVal.listSelectOutlet.refresh();
                                          //     }
                                          //   },
                                          // );

                                          // Rot.productListCategoryByCompanyIdGet(query: "companyId=${value['id']}").then(
                                          //   (res) {
                                          //     if (res.statusCode == 200) {
                                          //       ProductVal.listSelectCategory.assignAll(jsonDecode(res.body));
                                          //       // ProductVal.listSelectCategory.refresh();
                                          //     }
                                          //   },
                                          // );
                                        },
                                      );
                              },
                            ),
                          ),

                          // select outlet
                          Obx(
                            () => ListTile(
                              leading: Icon(Icons.store),
                              title: ProductVal.listSelectOutlet.isEmpty
                                  ? Text("Select Outlet")
                                  : DropdownSearch<Map>(
                                      items: [...ProductVal.listSelectOutlet],
                                      enabled: ProductVal.selectCompany.isNotEmpty,
                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            isDense: false,
                                            filled: true,
                                            border: InputBorder.none,
                                            hintText: "select outlet"),
                                      ),
                                      itemAsString: (value) => value['name'],
                                      onChanged: (value) {
                                        ProductVal.selectOutlet.assignAll(value!);
                                        // ProductVal.selectOutlet.refresh();
                                      },
                                    ),
                            ),
                          ),
                          // select category
                          Obx(
                            () => ListTile(
                              leading: Icon(Icons.store),
                              title: ProductVal.listSelectCategory.isEmpty
                                  ? Text("Select Category")
                                  : DropdownSearch<Map>(
                                      items: [...ProductVal.listSelectCategory],
                                      enabled: ProductVal.selectCompany.isNotEmpty,
                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            isDense: false,
                                            filled: true,
                                            border: InputBorder.none,
                                            hintText: "select Category"),
                                      ),
                                      itemAsString: (value) => value['name'],
                                      onChanged: (value) {
                                        ProductVal.selectedCategory.assignAll(value!);
                                        // ProductVal.selectedCategory.refresh();
                                      },
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  color: Colors.blue,
                                  child: Text(
                                    "Cari",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                MaterialButton(
                                  color: Colors.orange,
                                  child: Text(
                                    "Atur Ulang",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    ProductVal.listSelectOutlet.assignAll([]);
                                    ProductVal.listSelectCategory.assignAll([]);
                                  },
                                )
                              ],
                            ),
                          ),
                          Builder(builder: (context) {
                            String searchVal = "";
                            return ListTile(
                              title: TextFormField(
                                onChanged: (val) async {
                                  searchVal = val;
                                },
                                controller: TextEditingController(text: searchVal),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  // isDense: true,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  suffixIcon: InkWell(
                                    onTap: () async {
                                      final data = await Rot.productDefaultGet();
                                      ProductVal.listProduct.value.val = jsonDecode(data.body);
                                      ProductVal.listProduct.refresh();
                                    },
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              trailing: MaterialButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  SmartDialog.showLoading();
                                  Future.delayed(Duration(seconds: 1), () => SmartDialog.dismiss());
                                  final data = await Rot.productSearchByCompanyGet(query: "name=$searchVal");
                                  if (data.statusCode == 200) {
                                    ProductVal.listProduct.value.val = jsonDecode(data.body);
                                    ProductVal.listProduct.refresh();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                ),

                Column(
                  children: [
                    SizedBox(
                      height: 4,
                      child: Obx(
                        () {
                          ProductVal.reloadProduct.value;

                          return FutureBuilder<http.Response>(
                            future: Rot.productDefaultGet(),
                            builder: (ctx, snap) {
                              if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                              if (snap.data!.statusCode == 200) {
                                () async {
                                  await 0.1.delay();
                                  ProductVal.listProduct.value.val = jsonDecode(snap.data!.body);
                                  ProductVal.listProduct.refresh();
                                }();
                              }

                              return SizedBox.shrink();
                            },
                          );
                        },
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: [
                          ...ProductVal.listProduct.value.val.map(
                            (e) => ListTile(
                              leading: Text((ProductVal.listProduct.value.val.indexOf(e) + 1).toString()),
                              title: Text(e['name'].toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  !DeveloperVal.showId.value.val ? Container() : Text(e['id'].toString()),
                                  Text(NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'id_ID', name: "")
                                      .format(e['price'])),
                                  Builder(
                                    builder: (context) {
                                      try {
                                        final stk = e['ProductStock'][0]['stock'].toString();
                                        return Text(stk.toString());
                                      } catch (e) {
                                        return Text("");
                                      }
                                    },
                                  ),
                                ],
                              ),
                              // trailing: Icon(
                              //   Icons.check_box,
                              //   color: e['ProductOutlet'][0]['isActive'] ? Colors.green : Colors.grey,
                              // ),
                              onTap: () {
                                ProductVal.mapData.value.val = e;

                                showBottomSheet(context: context, builder: (context) => ProductEdit());
                              },
                            ),
                          )
                        ],
                      ),
                    )
                    // Obx(
                    //   () {
                    //     return Padding(
                    //       padding: const EdgeInsets.all(8),
                    //       child: Card(
                    //         margin: EdgeInsets.zero,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               color: Colors.grey.shade100,
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Row(children: [
                    //                 ..._listWidth.map(
                    //                   (e) => SizedBox(
                    //                     width: e['width'] as double,
                    //                     child: Text(e['title'] as String),
                    //                   ),
                    //                 )
                    //               ]),
                    //             ),
                    //             ...ProductVal.listSelectProduct.value.val
                    //                 .map(
                    //                   (e) => ListTile(
                    //                     onTap: () {
                    //                       showBottomSheet(
                    //                         context: context,
                    //                         builder: (context) => Material(
                    //                           child: Column(
                    //                             children: [
                    //                               Container(
                    //                                 color: Colors.grey.shade100,
                    //                                 padding: EdgeInsets.all(8),
                    //                                 child: Row(
                    //                                   children: [BackButton(), Text("Edit Product")],
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       );
                    //                     },
                    //                     title: Row(
                    //                       children: [
                    //                         ..._listWidth.map(
                    //                           (el) => SizedBox(
                    //                             width: el['width'] as double,
                    //                             child: el['field'].toString() == "no"
                    //                                 ? Text(
                    //                                     (ProductVal.listSelectProduct.value.val.indexOf(e) + 1)
                    //                                         .toString(),
                    //                                   )
                    //                                 : Text(
                    //                                     e[el['field']].toString(),
                    //                                     textAlign: el['field'].toString() == 'price'
                    //                                         ? TextAlign.end
                    //                                         : TextAlign.start,
                    //                                   ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 )
                    //                 .toList()
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
