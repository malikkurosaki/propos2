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
        debugPrint(res.body);
        if (res.statusCode == 200) {
          ProductVal.listSelectProduct.assignAll(jsonDecode(res.body));
          // ProductVal.listSelectProduct.refresh();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return ResponsiveBuilder(
      builder: (context, media) => ListView(
        children: [
          // select Company
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.business),
                  title: FutureBuilder<http.Response>(
                    future: Rot.productListCompanyGet(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) return Text("loading ...");
                      if (snapshot.data!.statusCode == 200) {
                        ProductVal.listSelectCompany.assignAll(jsonDecode(snapshot.data!.body));
                      }
                      return ProductVal.listSelectCompany.isEmpty
                          ? Text("empty")
                          : DropdownSearch<Map>(
                              items: [...ProductVal.listSelectCompany],
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    isDense: false, filled: true, border: InputBorder.none, hintText: "select company"),
                              ),
                              itemAsString: (value) => value['name'],
                              onChanged: (value) {
                                ProductVal.selectCompany.assignAll(value!);
                                // ProductVal.selectCompany.refresh();
          
                                Rot.loginListOutletByCompanyGet(query: "companyId=${value['id']}").then(
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
                                  isDense: false, filled: true, border: InputBorder.none, hintText: "select outlet"),
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
                                  isDense: false, filled: true, border: InputBorder.none, hintText: "select outlet"),
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
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(16),
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
                                  width: 300,
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
                                  width: 200,
                                  child: Text(
                                    "Stock",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "Sale",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "Action",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ...ProductVal.listSelectProduct.map(
                            (e) => Row(
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e['name']),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      NumberFormat.currency(decimalDigits: 0, locale: "id_ID", symbol: "")
                                          .format(e['price']),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("0"),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
