import 'dart:convert';
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/components/multi_select_outlet_bycompany.dart';
import 'package:propos/utils/conf.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/val_def.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class Product extends StatelessWidget {
  Product({Key? key}) : super(key: key);
  final _keyForm = GlobalKey<FormState>();
  final _productImage = <String, dynamic>{"id": "null", "name": "null"}.obs;
  final _productImageId = "".val("Product.productImageId").obs;
  final _editVal = "".obs;
  final _listPropertyCreate = [].obs;
  final _lisProduct = [].obs;

  _loadProduct() async {
    final data = await RouterApi.productByUserId().getData();
    if (data.statusCode == 200) {
      _lisProduct.value = jsonDecode(data.body);
    }
  }

  _onLoad() async {
    _loadProduct();
    // final data = await RouterApi.productMenuGetPropertyByCompany().getData();
    // if (data.statusCode == 200) _listPropertyCreate.assignAll(jsonDecode(data.body));
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Visibility(
                                  visible: media.isMobile,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Get.dialog(
                                          SimpleDialog(
                                            children: [_create(media)],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Flexible(
                              child: Obx(
                                () => _lisProduct.isEmpty
                                    ? Text("loading")
                                    : ContainedTabBarView(
                                        tabs: [
                                          ..._lisProduct.value.map(
                                            (e) => ListTile(
                                              title: Text(e['name']),
                                            ),
                                          ),
                                        ],
                                        views: [
                                          ..._lisProduct.map(
                                            (e) => (e['Product'] as List).isEmpty
                                                ? Center(
                                                    child: Text("product is empty"),
                                                  )
                                                : Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Checkbox(
                                                          value: false,
                                                          onChanged: (value) {},
                                                        ),
                                                        title: TextField(
                                                          decoration: InputDecoration(
                                                            hintText: "search",
                                                            border: OutlineInputBorder(borderSide: BorderSide.none),
                                                            filled: true,
                                                            prefixIcon: Icon(Icons.search),
                                                            suffixIcon: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons.close),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: ListView(
                                                          controller: ScrollController(),
                                                          children: [
                                                            ...(e['Product'] as List).map(
                                                              (e) => ListTile(
                                                                leading: Checkbox(
                                                                  value: false,
                                                                  onChanged: (value) {},
                                                                ),
                                                                title: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                        width: 100,
                                                                        child: Column(
                                                                          children: [
                                                                            CachedNetworkImage(
                                                                              imageUrl:
                                                                                  "${Conf.host}/product-image/${(e['ProductImage']?['name'] ?? "null").toString()}",
                                                                              fit: BoxFit.cover,
                                                                            )
                                                                          ],
                                                                        )),
                                                                    Expanded(
                                                                      child: ListTile(
                                                                        trailing: PopupMenuButton(
                                                                          itemBuilder: (context) {
                                                                            return [
                                                                              PopupMenuItem(
                                                                                value: "edit",
                                                                                child: Text("Edit"),
                                                                              ),
                                                                              PopupMenuItem(
                                                                                value: "available",
                                                                                child: Text("available"),
                                                                              ),
                                                                              PopupMenuItem(
                                                                                value: "delete",
                                                                                child: Text("Delete"),
                                                                              ),
                                                                            ];
                                                                          },
                                                                        ),
                                                                        title: Row(
                                                                          children: [
                                                                            SizedBox(width: 100, child: Text("Name")),
                                                                            Expanded(child: Text(e['name'].toString())),
                                                                          ],
                                                                        ),
                                                                        subtitle: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                    width: 100, child: Text("Price")),
                                                                                Expanded(
                                                                                    child: Text(NumberFormat.currency(
                                                                                            locale: 'id_ID',
                                                                                            symbol: 'Rp',
                                                                                            decimalDigits: 0)
                                                                                        .format(e['price']))),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                    width: 100,
                                                                                    child: Text("Description")),
                                                                                Expanded(
                                                                                    child: Text(
                                                                                        e['description'].toString())),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                    width: 100,
                                                                                    child: Text("Category")),
                                                                                Expanded(
                                                                                    child: Text(e['Category']['name']
                                                                                        .toString())),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                    width: 100, child: Text("Outlet")),
                                                                                Expanded(
                                                                                    child: Wrap(
                                                                                  children: [
                                                                                    for (final itm
                                                                                        in e['ProductOutlet'])
                                                                                      Padding(
                                                                                        padding:
                                                                                            const EdgeInsets.all(4.0),
                                                                                        child: Chip(
                                                                                            label: Text(itm['Outlet']
                                                                                                    ['name']
                                                                                                .toString())),
                                                                                      )
                                                                                  ],
                                                                                ))
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // disini
                    Visibility(visible: !media.isMobile, child: Card(child: _create(media)))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _temSelect(String lable) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              labelText: lable,
              labelStyle: TextStyle(backgroundColor: Colors.white),
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      );

  Future<RxList> _collect(RxList data) async => data;

  Widget _create(SizingInformation media) => Builder(builder: (context) {
        final listOutlet = [].obs;
        // final listCategory = [].obs;

        final selectedCompanyId = "".obs;
        final selectedCategoryId = "".obs;
        final selectedOutletId = "".obs;
        final selectedoutletList = [].obs;

        final conName = TextEditingController();
        final conPrice = TextEditingController();
        final description = TextEditingController();

        // final _conCategoryId = TextEditingController();
        // final _conOutletId = TextEditingController();
        // final _conCompanyId = TextEditingController();

        final lsCompany = [].obs;
        final lsOutlet = [].obs;
        final lsCategory = [].obs;

        RouterApi.productCreateSelect().getData().then(
          (value) {
            if (value.statusCode == 200) {
              lsCompany.assignAll(jsonDecode(value.body));
            }
          },
        );

        // final selectedoutlet = "".obs;
        return SizedBox(
          width: media.isMobile ? Get.width : 360,
          height: media.isMobile ? 360 : Get.height * 0.92,
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    Obx(
                      () => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "Select Company",
                                  labelStyle: TextStyle(backgroundColor: Colors.white),
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  filled: true),
                              items: [
                                ...lsCompany.map(
                                  (element) => DropdownMenuItem(
                                    value: element,
                                    child: Text(element['name']),
                                  ),
                                )
                              ],
                              onChanged: (value) {
                                lsOutlet.assignAll((value as Map)['Outlet']);
                                lsCategory.assignAll((value)['Category']);
                                selectedCompanyId.value = value['id'];
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: [
                          Visibility(visible: false, child: Text(lsCategory.toString())),
                          FutureBuilder<RxList>(
                            future: _collect(lsCategory),
                            builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                                ? _temSelect("Select Category")
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(backgroundColor: Colors.white),
                                          labelText: "Select Category",
                                          isDense: true,
                                          border: OutlineInputBorder(borderSide: BorderSide.none),
                                          filled: true),
                                      items: [
                                        ...lsCategory.map(
                                          (element) => DropdownMenuItem(
                                            value: element,
                                            child: Text(element['name']),
                                          ),
                                        )
                                      ],
                                      onChanged: (value) {
                                        selectedCategoryId.value = (value as Map)['id'];
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => MultiSelectOutletBycompany(
                        companyId: selectedCompanyId.value,
                        onSelectOutlet: (value) {},
                      ),
                    ),
                    // Obx(() => Card(
                    //   child: Column(
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Ink(
                    //                   color: Colors.grey.shade100,
                    //                   child: ListTile(
                    //                     leading: Checkbox(
                    //                       value: false,
                    //                       onChanged: (value) {

                    //                       },
                    //                     ),
                    //                     title: Text("Select Outlet", style: TextStyle(
                    //                       color: Colors.grey
                    //                     ),),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   children: [
                    //                     ...lsOutlet.map(
                    //                       (element) => CheckboxListTile(
                    //                         controlAffinity: ListTileControlAffinity.leading,
                    //                         title: Text(element['name']),
                    //                         value: selectedoutletList.contains(element['id']),
                    //                         onChanged: (value) {
                    //                           if (value!) {
                    //                             selectedoutletList.add(element['id']);
                    //                           } else {
                    //                             selectedoutletList.remove(element['id']);
                    //                           }
                    //                         },
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    // )
                    //     // Column(
                    //     //   children: [
                    //     //     // Padding(
                    //     //     //   padding: const EdgeInsets.all(8.0),
                    //     //     //   child: ListTile(
                    //     //     //     leading: IconButton(
                    //     //     //       icon: selectedoutletList.length == lsOutlet.length
                    //     //     //           ? Icon(Icons.check_box)
                    //     //     //           : Icon(Icons.check_box_outline_blank),
                    //     //     //       onPressed: () {
                    //     //     //         if (selectedoutletList.length == lsOutlet.length) {
                    //     //     //           selectedoutletList.clear();
                    //     //     //         } else {
                    //     //     //           selectedoutletList.assignAll(lsOutlet.map((element) => element['id']));
                    //     //     //         }
                    //     //     //       },
                    //     //     //     ),
                    //     //     //     initiallyExpanded: true,
                    //     //     //     title: Text("Select Outlet"),
                    //     //     //     ,
                    //     //     //   ),
                    //     //     // ),
                    //     //     // Column(
                    //     //     //   children: [
                    //     //     //   ...lsOutlet.map(
                    //     //     //     (element) => CheckboxListTile(
                    //     //     //       title: Text(element['name']),
                    //     //     //       value: selectedoutletList.contains(element['id']),
                    //     //     //       onChanged: (value) {
                    //     //     //         if (value!) {
                    //     //     //           selectedoutletList.add(element['id']);
                    //     //     //         } else {
                    //     //     //           selectedoutletList.remove(element['id']);
                    //     //     //         }
                    //     //     //       },
                    //     //     //     ),
                    //     //     //   )
                    //     //     // ]
                    //     //     // )
                    //     //   ],
                    //     // ),
                    //     ),

                    // FutureBuilder<http.Response>(
                    //   future: RouterApi.productCreateSelect().getData(),
                    //   builder: (context, snapshot) {
                    //     // if (snapshot.connectionState != ConnectionState.done) return _temSelect("Select Company");
                    //     if (snapshot.hasError) {
                    //       return _temSelect("failed connect server");
                    //     }else{
                    //       if (snapshot.data!.statusCode != 200) return _temSelect("failed to load");
                    //       final List company = jsonDecode(snapshot.data!.body);
                    //       return Text("apa");
                    //     }

                    //     // Padding(
                    //     //   padding: const EdgeInsets.all(8.0),
                    //     //   child: DropdownButtonFormField(
                    //     //     decoration: InputDecoration(
                    //     //       labelText: 'Select Company',
                    //     //       labelStyle: TextStyle(backgroundColor: Colors.white),
                    //     //       border: OutlineInputBorder(borderSide: BorderSide.none),
                    //     //       isDense: true,
                    //     //       filled: true,
                    //     //     ),
                    //     //     items: [
                    //     //       ...company.map(
                    //     //         (e) => DropdownMenuItem(
                    //     //           value: e,
                    //     //           child: Text(e['name']),
                    //     //         ),
                    //     //       ),
                    //     //     ],
                    //     //     onChanged: (value) async {
                    //     //       final dataNya = (value as Map);
                    //     //       if (dataNya.isNotEmpty) selectedCompanyId.value = dataNya['id'];
                    //     //     },
                    //     //   ),
                    //     // );
                    //   },
                    // ),
                    // Obx(
                    //   () => FutureBuilder<http.Response>(
                    //     future: RouterApi.outletByCompanyId(query: "cusCompanyId=${selectedCompanyId.value}").getData(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState != ConnectionState.done) return _temSelect("Select Outlet");
                    //       if (snapshot.data!.statusCode != 200) return _temSelect("Select Company");
                    //       final List data = jsonDecode(snapshot.data!.body);
                    //       if (data.isNotEmpty) data.add({'name': "All Outlet", "id": "all"});
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: DropdownButtonFormField(
                    //           decoration: InputDecoration(
                    //             labelText: 'Select Outlet',
                    //             labelStyle: TextStyle(backgroundColor: Colors.white),
                    //             border: OutlineInputBorder(borderSide: BorderSide.none),
                    //             isDense: true,
                    //             filled: true,
                    //           ),
                    //           items: [
                    //             ...data.map(
                    //               (e) => DropdownMenuItem(
                    //                 value: e,
                    //                 child: Text(e['name']),
                    //               ),
                    //             ),
                    //           ],
                    //           onChanged: (value) {
                    //             final dataNya = (value as Map);
                    //             if (dataNya.isNotEmpty) selectedOutletId.value = dataNya['id'];
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Obx(
                    //   () => FutureBuilder<http.Response>(
                    //     future:
                    //         RouterApi.categoryByCompanyId(query: "cusCompanyId=${selectedCompanyId.value}").getData(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState != ConnectionState.done) return _temSelect("Select Category");
                    //       if (snapshot.data!.statusCode != 200) return _temSelect("Select Company");
                    //       final List data = jsonDecode(snapshot.data!.body);
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: DropdownButtonFormField(
                    //           decoration: InputDecoration(
                    //             labelText: 'Select Category',
                    //             labelStyle: TextStyle(backgroundColor: Colors.white),
                    //             border: OutlineInputBorder(borderSide: BorderSide.none),
                    //             isDense: true,
                    //             filled: true,
                    //           ),
                    //           items: [
                    //             ...data.map(
                    //               (e) => DropdownMenuItem(
                    //                 value: e,
                    //                 child: Text(e['name']),
                    //               ),
                    //             ),
                    //           ],
                    //           onChanged: (value) {
                    //             final dataNya = (value as Map);
                    //             if (dataNya.isNotEmpty) selectedCategoryId.value = dataNya['id'];
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    Form(
                      key: _keyForm,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) => value!.isEmpty || value.length < 3
                                  ? "Name is required and should be at least 3 characters long"
                                  : null,
                              textInputAction: TextInputAction.next,
                              controller: conName,
                              decoration: InputDecoration(
                                labelText: 'Product Name',
                                labelStyle: TextStyle(backgroundColor: Colors.white),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              controller: conPrice,
                              validator: (value) {
                                return value!.isEmpty || int.tryParse(value) == null
                                    ? "price is required ar number only"
                                    : null;
                              },
                              decoration: InputDecoration(
                                labelText: "Product Price",
                                labelStyle: TextStyle(backgroundColor: Colors.white),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              controller: description,
                              decoration: InputDecoration(
                                labelText: "Product Description",
                                labelStyle: TextStyle(backgroundColor: Colors.white),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Obx(
                              () => Column(
                                children: [
                                  Text("product image (* optional)"),
                                  MaterialButton(
                                    child: SizedBox(
                                        width: 100,
                                        child: CachedNetworkImage(
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                            placeholder: (context, url) => CircularProgressIndicator(),
                                            imageUrl: "${Conf.host}/product-image/${_productImage['name']}")),
                                    onPressed: () async {
                                      await _uploadImage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: () async {
                                if (_keyForm.currentState!.validate()) {
                                  final body = {
                                    'name': conName.text,
                                    'price': conPrice.text,
                                    'description': description.text,
                                    'categoryId': selectedCategoryId.value,
                                    'outletList': jsonEncode(lsOutlet.toJson()),
                                    'companyId': selectedCompanyId.value,
                                    'productImageId': _productImage['id'] ?? "null",
                                  };

                                  final kirim = await RouterApi.productCreate().postData(body);
                                  if (kirim.statusCode == 201) {
                                    await _onLoad();
                                    _productImage.assignAll({});
                                    _productImageId.value.val = "";

                                    conName.clear();
                                    conPrice.clear();
                                    selectedCategoryId.value = "";
                                    selectedOutletId.value = "";
                                    selectedCompanyId.value = "";

                                    _productImage.refresh();
                                    _productImageId.refresh();

                                    SmartDialog.showToast("success");

                                    if (media.isMobile) {
                                      Get.back();
                                    }
                                  } else {
                                    SmartDialog.showToast("failed to create product");
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    "Create",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Flexible(
              //   child: Builder(
              //     builder: (context) {
              //       final _conName = TextEditingController();
              //       final _conPrice = TextEditingController();
              //       final _description = TextEditingController();
              //       final _conCategoryId = TextEditingController();
              //       final _conOutletId = TextEditingController();
              //       final _conCompanyId = TextEditingController();

              //       return ListView(
              //         controller: ScrollController(),
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text(
              //               "Create Product",
              //               style: TextStyle(
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //           Builder(
              //             builder: (context) {
              //               final listOutletnya = [].obs;
              //               final listCategorynya = [].obs;
              //               return Obx(
              //                 () => Column(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: DropdownButtonFormField(
              //                         hint: Text("Select Company"),
              //                         decoration: InputDecoration(
              //                           border: OutlineInputBorder(borderSide: BorderSide.none),
              //                           filled: true,
              //                         ),
              //                         items: [
              //                           for (final e in _listPropertyCreate)
              //                             DropdownMenuItem(
              //                               child: Text(e['name'].toString()),
              //                               value: e,
              //                             )
              //                         ],
              //                         onChanged: (value) {
              //                           listOutletnya.value = (value as Map)['Outlet'];
              //                         },
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: DropdownButtonFormField(
              //                         hint: Text("Select Outlet"),
              //                         decoration: InputDecoration(
              //                           border: OutlineInputBorder(borderSide: BorderSide.none),
              //                           filled: true,
              //                         ),
              //                         items: [
              //                           for (final e in listOutletnya)
              //                             DropdownMenuItem(
              //                               child: Text(e['name'].toString()),
              //                               value: e,
              //                             )
              //                         ],
              //                         onChanged: (value) {
              //                           listCategorynya.value = (value as Map)['Category'];
              //                         },
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: DropdownButtonFormField(
              //                         hint: Text("Select Category"),
              //                         decoration: InputDecoration(
              //                           border: OutlineInputBorder(borderSide: BorderSide.none),
              //                           filled: true,
              //                         ),
              //                         items: [
              //                           for (final e in listCategorynya)
              //                             DropdownMenuItem(
              //                               child: Text(e['name'].toString()),
              //                               value: e,
              //                             )
              //                         ],
              //                         onChanged: (value) {},
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               );
              //             },
              //           ),
              //           Form(
              //             key: _keyForm,
              //             child: Column(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: DropdownButtonFormField(
              //                     decoration: InputDecoration(
              //                       hintText: "product Company",
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderSide: BorderSide.none,
              //                       ),
              //                     ),
              //                     items: [
              //                       // DropdownMenuItem(
              //                       //   value: "",
              //                       //   child: Text("all"),
              //                       // ),
              //                       for (final outlet in ValDef.companyList.value.val)
              //                         DropdownMenuItem(
              //                           value: outlet,
              //                           child: Text(outlet['name'].toString()),
              //                         ),
              //                     ],
              //                     onChanged: (value) {
              //                       if (value.toString().isNotEmpty) {
              //                         _conCompanyId.text = (value as Map<String, dynamic>)['id'].toString();
              //                       }
              //                     },
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: DropdownButtonFormField(
              //                     decoration: InputDecoration(
              //                       hintText: "product outlet",
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderSide: BorderSide.none,
              //                       ),
              //                     ),
              //                     items: [
              //                       DropdownMenuItem(
              //                         value: "",
              //                         child: Text("all"),
              //                       ),
              //                       for (final outlet in ValDef.outletList.value.val)
              //                         DropdownMenuItem(
              //                           value: outlet,
              //                           child: Text(outlet['name'].toString()),
              //                         ),
              //                     ],
              //                     onChanged: (value) {
              //                       if (value.toString().isNotEmpty) {
              //                         _conOutletId.text = (value as Map<String, dynamic>)['id'].toString();
              //                       }
              //                     },
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: DropdownButtonFormField(
              //                     validator: (value) => (value.toString() == "null") ? "category is required" : null,
              //                     decoration: InputDecoration(
              //                       hintText: "product category",
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderSide: BorderSide.none,
              //                       ),
              //                     ),
              //                     items: [
              //                       for (final cat in ValDef.categoryList.value.val)
              //                         DropdownMenuItem(
              //                           value: cat,
              //                           child: Text(cat['name'].toString()),
              //                         ),
              //                     ],
              //                     onChanged: (value) {
              //                       final val = value as Map<String, dynamic>;
              //                       _conCategoryId.text = val['id'].toString();
              //                     },
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: TextFormField(
              //                     validator: (value) => value!.isEmpty || value.length < 3
              //                         ? "Name is required and should be at least 3 characters long"
              //                         : null,
              //                     textInputAction: TextInputAction.next,
              //                     controller: _conName,
              //                     decoration: InputDecoration(
              //                       hintText: "product name",
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderSide: BorderSide.none,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: TextFormField(
              //                     textInputAction: TextInputAction.next,
              //                     keyboardType: TextInputType.number,
              //                     controller: _conPrice,
              //                     validator: (value) {
              //                       return value!.isEmpty || int.tryParse(value) == null
              //                           ? "price is required ar number only"
              //                           : null;
              //                     },
              //                     decoration: InputDecoration(
              //                       hintText: "product price",
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderSide: BorderSide.none,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: TextFormField(
              //                     textInputAction: TextInputAction.next,
              //                     keyboardType: TextInputType.number,
              //                     controller: _description,
              //                     decoration: InputDecoration(
              //                       hintText: "description",
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderSide: BorderSide.none,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(16.0),
              //                   child: Obx(
              //                     () => Column(
              //                       children: [
              //                         Text("product image (* optional)"),
              //                         MaterialButton(
              //                           child: SizedBox(
              //                               width: 100,
              //                               child: CachedNetworkImage(
              //                                   imageUrl:
              //                                       "${Conf.host}/product-image/${_productImage.value.val['name']}")),
              //                           onPressed: () async {
              //                             await _uploadImage();
              //                           },
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: MaterialButton(
              //                     color: Colors.blue,
              //                     onPressed: () async {
              //                       if (_keyForm.currentState!.validate()) {
              //                         final body = {
              //                           'name': _conName.text,
              //                           'price': _conPrice.text,
              //                           'categoryId': _conCategoryId.text,
              //                           'outletId': _conOutletId.text,
              //                           'companyId': _conCompanyId.text,
              //                           'productImageId': _productImage.value.val['id'],
              //                         };

              //                         final kirim = await RouterApi.productCreate().postData(body);
              //                         await _onLoad();
              //                         _productImage.value.val = {};
              //                         _productImageId.value.val = "";

              //                         _conName.clear();
              //                         _conPrice.clear();
              //                         _conCategoryId.clear();
              //                         _conOutletId.clear();
              //                         _description.clear();

              //                         _productImage.refresh();
              //                         _productImageId.refresh();

              //                         if (media.isMobile) {
              //                           Get.back();
              //                         }
              //                       }
              //                     },
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(10.0),
              //                       child: Center(
              //                         child: Text(
              //                           "Create",
              //                           style: TextStyle(color: Colors.white),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        );
      });

  _uploadImage() async {
    final upload = http.MultipartRequest(
      'POST',
      Uri.parse("${Conf.host}/img/upload?userId=${Val.userId.val}"),
    );
    final image = await ImagePicker().pickImage(maxHeight: 500, maxWidth: 500, source: ImageSource.gallery);
    if (image != null) {
      upload.files.add(http.MultipartFile.fromBytes("image", await image.readAsBytes(), filename: "${image.name}.png"));
      final res = await upload.send().then((value) => value.stream.bytesToString());
      final result = jsonDecode(res);
      _productImage.assignAll(result);
      _productImage.refresh();

      debugPrint(result.toString());
    } else {
      SmartDialog.showToast("No image selected");
    }
  }
}
