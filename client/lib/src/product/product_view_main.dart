import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

class ProductViewMain extends StatelessWidget {
  const ProductViewMain({Key? key}) : super(key: key);

  _onLoad() {
    Rot.productDefaultGet().then(
      (res) {
        // debugPrint(res.body);
        if (res.statusCode == 200) {
          ProductVal.listSelectProduct.assignAll(jsonDecode(res.body));
          // ProductVal.listSelectProduct.refresh();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // _onLoad();

    return ResponsiveBuilder(
      builder: (context, media) => ListView(
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
                        future: Rot.productListCompanyGet(),
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
                                    // ProductVal.selectCompany.refresh();

                                    Rot.lgnListOutletByCompanyGet(query: "companyId=${value['id']}").then(
                                      (res) {
                                        if (res.statusCode == 200) {
                                          ProductVal.listSelectOutlet.assignAll(jsonDecode(res.body));
                                          // ProductVal.listSelectOutlet.refresh();
                                        }
                                      },
                                    );

                                    Rot.productListCategoryByCompanyIdGet(query: "companyId=${value['id']}").then(
                                      (res) {
                                        if (res.statusCode == 200) {
                                          ProductVal.listSelectCategory.assignAll(jsonDecode(res.body));
                                          // ProductVal.listSelectCategory.refresh();
                                        }
                                      },
                                    );
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
                                      hintText: "select outlet"),
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
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            // isDense: true,
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Search",
                            suffixIcon: Icon(Icons.close)),
                      ),
                    )
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
                    ProductVal.isReloadProduct.value;
                    return FutureBuilder<http.Response>(
                      future: Rot.productDefaultGet(),
                      builder: (ctx, snap) {
                        if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                        if (snap.data!.statusCode == 200) {
                          () async {
                            await 0.1.delay();
                            ProductVal.listSelectProduct.assignAll(jsonDecode(snap.data!.body));
                          }();
                        }

                        return SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
              Obx(
                () {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.grey.shade200,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: Text("No"),
                                    ),
                                    SizedBox(
                                      width: 600,
                                      child: Text(
                                        "Product Name",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "Price",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        "Action",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ...ProductVal.listSelectProduct
                                  .map(
                                    (e) => Row(
                                      children: [
                                        SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text((ProductVal.listSelectProduct.indexOf(e) + 1).toString()),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 600,
                                          child: Text(e['name']),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            NumberFormat.currency(decimalDigits: 0, locale: "id_ID", symbol: "")
                                                .format(e['price']),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: PopupMenuButton(
                                            onSelected: (value) async {
                                              if (value == 'del') {
                                                final dataDel = await Rot.productRemoveDelete(query: "id=${e['id']}");
                                                if (dataDel.statusCode == 201) {
                                                  debugPrint("dataah berhasil dihapus");
                                                } else {
                                                  debugPrint("dataa gagal dihapus");
                                                }
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                value: "del",
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete,
                                                      size: 16,
                                                    ),
                                                    Expanded(child: Text("Delete")),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: "edit",
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      size: 16,
                                                    ),
                                                    Expanded(child: Text("Edit")),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
