import 'dart:convert';
import 'dart:js';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'package:propos/src/product/product_create.dart';
import 'package:propos/utils/conf.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';

import 'product_val.dart';

class ProductDisplay extends StatelessWidget {
  const ProductDisplay({Key? key}) : super(key: key);

  Widget _display() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ProductVal.listCompany.value.val.isEmpty
              ? Center(
                  child: Text("Data Is Empty"),
                )
              : !ProductVal.listCompany.value.val.contains(ProductVal.selectedCompany.value.val)
                  ? Center(
                      child: Text("loading ... ..."),
                    )
                  : Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide.none), filled: true),
                          value: ProductVal.selectedCompany.value.val.isEmpty
                              ? ProductVal.listCompany.value.val[0]
                              : ProductVal.selectedCompany.value.val,
                          items: [
                            ...ProductVal.listCompany.value.val.map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e['name'].toString(),
                                ),
                              ),
                            )
                          ],
                          onChanged: (value) async {
                            ProductVal.selectedCompany.value.val = (value as Map);
                            ProductVal.selectedCompany.refresh();
                            await ProductVal.loadProductByCompanyId();
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.close)),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ProductVal.listProduct.isEmpty
                                ? Center(
                                    child: Text("..."),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: JsonTable(
                                      onRowSelect: (index, map) {
                                        debugPrint(map.toString());
                                      },
                                      allowRowHighlight: true,
                                      rowHighlightColor: Colors.green.shade100,
                                      ProductVal.listProduct,
                                      columns: [
                                        ...(ProductVal.listProduct[0] as Map).keys.map(
                                              (element) => JsonTableColumn(element.toString(),
                                                  defaultValue: "",
                                                  label: element.toString().titleCase,
                                                  valueBuilder: (c) =>
                                                      jsonEncode({"field": element.toString(), "value": c.toString()})),
                                            )
                                      ],
                                      tableHeaderBuilder: (value) {
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            value!.toString().titleCase,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      },
                                      tableCellBuilder: (val) {
                                        final datanya = jsonDecode(val);
                                        final field = datanya['field'];
                                        final value = datanya['value'];
                                        return Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              alignment: Alignment.topLeft,
                                              padding: EdgeInsets.all(8),
                                              child: Builder(
                                                builder: (context) {
                                                  if (field == "img" && value.toString().isNotEmpty) {
                                                    return InkWell(
                                                      onTap: () {
                                                        showBottomSheet(
                                                          context: context,
                                                          builder: (c) {
                                                            return SingleChildScrollView(
                                                              controller: ScrollController(),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [BackButton()],
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: SizedBox(
                                                                        width: double.infinity,
                                                                        child: CachedNetworkImage(
                                                                            width: double.infinity,
                                                                            fit: BoxFit.cover,
                                                                            imageUrl:
                                                                                "${Conf.host}/product-image/$value"),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          height: 50,
                                                          imageUrl: "${Conf.host}/product-image/$value"),
                                                    );
                                                  }

                                                  if (value == "true") {
                                                    return Icon(
                                                      Icons.check_box,
                                                      color: Colors.green,
                                                    );
                                                  }

                                                  if (value == "false") {
                                                    return Icon(
                                                      Icons.close,
                                                      color: Colors.orange,
                                                    );
                                                  }

                                                  if (field == "id") return Text("...");

                                                  if (int.tryParse(value.toString()) != null) {
                                                    return Text(NumberFormat.currency(symbol: "", decimalDigits: 0)
                                                        .format(int.parse(value.toString())));
                                                  }

                                                  if (value.toString().isDateTime) {
                                                    return Text(DateFormat('EEE, M/d/y').format(DateTime.parse(value)));
                                                  }

                                                  return Text(value);
                                                },
                                              ),
                                            ),
                                            Divider()
                                          ],
                                        );
                                      },
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

  @override
  Widget build(BuildContext context) {
    ProductVal.loadCompanyProductDisplay();

    return ResponsiveBuilder(
      builder: ((context, media) {
        return Scaffold(
            floatingActionButton: !media.isMobile
                ? null
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          insetPadding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [const BackButton()],
                                ),
                              ),
                              Flexible(child: ProductCreate()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            body: _display());
      }),
    );
  }
}
