import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/components/multi_select_outlet_bycompany.dart';
import 'package:propos/components/search_view_with_checkbox.dart';
import 'package:propos/components/select_company.dart';
import 'package:propos/utils/conf.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/notif.dart';
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
  final _listCompanyProduct = [].obs;

  _loadProduct() async {
    final data = await RouterApi.productByUserId().getData();
    if (data.statusCode == 200) {
      _listCompanyProduct.value = jsonDecode(data.body);
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
                      child: _listDisplay(media),
                    ),
                    // disini
                    Visibility(
                      visible: !media.isMobile,
                      child: Card(
                        child: Column(
                          children: [Flexible(child: _create(media))],
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

  Widget _listDisplay(SizingInformation media) {
    final listSelected = [].obs;
    final isShowChecked = false.obs;

    return Scaffold(
      floatingActionButton: !media.isMobile
          ? null
          : FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Get.dialog(
                  Dialog(
                    insetPadding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [BackButton()],
                          ),
                        ),
                        Flexible(child: _create(media)),
                      ],
                    ),
                  ),
                );
              },
            ),
      body: Card(
        child: Obx(
          () => _listCompanyProduct.isEmpty
              ? ImgDef.empty()
              : ContainedTabBarView(
                  tabs: [
                    ..._listCompanyProduct.map(
                      (e) => ListTile(
                        title: Text(
                          e['name'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                  views: [
                    ..._listCompanyProduct.map(
                      (company) => (company['Product'] as List).isEmpty
                          ? Center(
                              child: ImgDef.empty(width: 100, height: 100, fit: BoxFit.contain),
                            )
                          : Builder(builder: (context) {
                              final lsProduct = company['Product'] as List;
                              final isCheckAll = false.obs;
                              return Column(
                                children: [
                                  SearchViewWithCheckbox(
                                    onChanged: (searchValue) {},
                                    checkValue: isCheckAll,
                                    onCheckChanged: (checkValue) {
                                      if (checkValue!) {
                                        listSelected.assignAll(lsProduct.map((e) => e['id']));
                                        isShowChecked.value = true;
                                      } else {
                                        listSelected.clear();
                                        isShowChecked.value = false;
                                      }
                                      isCheckAll.value = checkValue;
                                    },
                                    subtitle: Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                tooltip: "Hapus Sekaligus",
                                                onPressed: listSelected.isEmpty
                                                    ? null
                                                    : () {
                                                        Get.dialog(
                                                          AlertDialog(
                                                            title: Text("Dihapus Sekaligus"),
                                                            content: Text(
                                                                "Yakin Mau Menghapus ${listSelected.length} Product Yang Dipilih ?"),
                                                            actions: [
                                                              MaterialButton(
                                                                  child: Text("Tidak"),
                                                                  onPressed: () {
                                                                    Get.back();
                                                                  }),
                                                              MaterialButton(
                                                                  child: Text("Ya"),
                                                                  onPressed: () {
                                                                    Get.back();
                                                                  })
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                icon: Icon(
                                                  Icons.delete_sweep,
                                                  color: listSelected.isEmpty ? Colors.grey : Colors.pink,
                                                )),
                                            IconButton(
                                                onPressed: listSelected.isEmpty
                                                    ? null
                                                    : () {
                                                        showBottomSheet(
                                                          backgroundColor: Colors.transparent,
                                                          context: context,
                                                          builder: (c) => Card(
                                                            margin: EdgeInsets.all(16),
                                                            elevation: 5,
                                                            child: SizedBox(
                                                              height: 500,
                                                              width: double.infinity,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [BackButton()],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text("Company : ${company['name']}"),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                        "Product : ${listSelected.length} Selected"),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: MultiSelectOutletBycompany(
                                                                      companyId: company['id'],
                                                                      onSelectOutlet: (value) {},
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                icon: Icon(
                                                  Icons.move_down,
                                                  color: listSelected.isEmpty ? Colors.grey : Colors.orange,
                                                )),
                                          ],
                                        )),
                                  ),
                                  Flexible(
                                    child: Obx(
                                      () => Column(
                                        children: [
                                          Flexible(
                                            child: ListView(
                                              controller: ScrollController(),
                                              children: [
                                                ...lsProduct.map(
                                                  (e) => ListTile(
                                                    onLongPress: () {
                                                      isShowChecked.toggle();
                                                    },
                                                    leading: Visibility(
                                                      visible: isShowChecked.value,
                                                      child: Checkbox(
                                                        value: listSelected.contains(e['id']),
                                                        onChanged: (value) {
                                                          if (value!) {
                                                            listSelected.add(e['id']);
                                                          } else {
                                                            listSelected.remove(e['id']);
                                                          }

                                                          isCheckAll.value =
                                                              listSelected.length.isEqual(lsProduct.length);
                                                        },
                                                      ),
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                                width: media.isMobile ? 50 : 70,
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
                                                                  onSelected: (value) {
                                                                    switch (value) {
                                                                      case 'delete':
                                                                        Get.dialog(
                                                                          AlertDialog(
                                                                            title: Text(
                                                                                "Are you sure you want to delete this item?"),
                                                                            actions: [
                                                                              MaterialButton(
                                                                                  child: Text("Yes"), onPressed: () {}),
                                                                              MaterialButton(
                                                                                  child: Text("No"), onPressed: () {})
                                                                            ],
                                                                          ),
                                                                        );
                                                                        break;
                                                                      default:
                                                                        debugPrint("deleteData");
                                                                    }
                                                                  },
                                                                  itemBuilder: (context) {
                                                                    return [
                                                                      const PopupMenuItem(
                                                                        value: "outlet",
                                                                        child: Text("Outlet"),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value: "edit",
                                                                        child: const Text("Edit"),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value: "available",
                                                                        child: const Text("available"),
                                                                      ),
                                                                      const PopupMenuItem(
                                                                        value: "delete",
                                                                        child: const Text("Delete"),
                                                                      ),
                                                                    ];
                                                                  },
                                                                ),
                                                                title: Text(e['name'].toString()),

                                                                //  Row(
                                                                //   children: [
                                                                //     Visibility(
                                                                //         visible: !media.isMobile,
                                                                //         child: const SizedBox(
                                                                //             width: 100, child:
                                                                //             Text("Name"))),
                                                                //     Expanded(child: Text(e['name'].toString())),
                                                                //   ],
                                                                // ),
                                                                subtitle: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(NumberFormat.currency(
                                                                            locale: 'id_ID',
                                                                            symbol: 'Rp',
                                                                            decimalDigits: 0)
                                                                        .format(e['price'])),
                                                                    Text(e['description'].toString()),
                                                                    Text(e['Category']['name'].toString()),
                                                                    // Row(
                                                                    //   children: [
                                                                    //     SizedBox(
                                                                    //         width: media.isMobile ? 70 : 100,
                                                                    //         child: const Text("Price")),
                                                                    //     Expanded(
                                                                    //         child:
                                                                    //         Text(NumberFormat.currency(
                                                                    //                 locale: 'id_ID',
                                                                    //                 symbol: 'Rp',
                                                                    //                 decimalDigits: 0)
                                                                    //             .format(e['price']))),
                                                                    //   ],
                                                                    // ),
                                                                    // Row(
                                                                    //   children: [
                                                                    //     SizedBox(
                                                                    //         width: media.isMobile ? 70 : 100,
                                                                    //         child: const Text("Description")),
                                                                    //     Expanded(
                                                                    //         child: Text(e['description'].toString())),
                                                                    //   ],
                                                                    // ),
                                                                    // Row(
                                                                    //   children: [
                                                                    //     SizedBox(
                                                                    //         width: media.isMobile ? 70 : 100,
                                                                    //         child: Text("Category")),
                                                                    //     Expanded(
                                                                    //         child:
                                                                    //             Text(e['Category']['name'].toString())),
                                                                    //   ],
                                                                    // ),
                                                                    // Row(
                                                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                    //   children: [
                                                                    //     SizedBox(width: media.isMobile ? 70 : 100, child: Text("Outlet")),
                                                                    //     Expanded(
                                                                    //         child:
                                                                    //         )
                                                                    //   ],
                                                                    // )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Wrap(
                                                            alignment: WrapAlignment.start,
                                                            crossAxisAlignment: WrapCrossAlignment.start,
                                                            children: [
                                                              for (final itm in e['ProductOutlet'])
                                                                Padding(
                                                                  padding: const EdgeInsets.all(4.0),
                                                                  child: Chip(
                                                                      backgroundColor: Colors.cyan,
                                                                      label: Text(
                                                                        itm['Outlet']['name'].toString(),
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                        ),
                                                                      )),
                                                                )
                                                            ],
                                                          ),
                                                        )
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
                                  ),
                                ],
                              );
                            }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

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

  Future<RxList> _collect(RxList data) async => data;

  Widget _create(SizingInformation media) => Builder(builder: (context) {
        // final listOutlet = [].obs;
        // final listCategory = [].obs;

        final selectedCompanyId = "".obs;
        final selectedCategoryId = "".obs;
        final selectedOutletId = "".obs;
        final selectedoutletList = [].obs;

        final conName = TextEditingController();
        final conPrice = TextEditingController();
        final description = TextEditingController();

        final lsCompany = [].obs;
        // final lsOutlet = [].obs;
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
          // height: Get.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create Product",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    SelectCompany(
                      onSelectCompany: (companyId) async {
                        final ctgr = await RouterApi.categoryByCompanyId(query: "cusCompanyId=$companyId").getData();
                        lsCategory.assignAll(jsonDecode(ctgr.body));
                        selectedCompanyId.value = companyId;
                      },
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
                                      decoration: const InputDecoration(
                                          labelStyle: TextStyle(backgroundColor: Colors.white),
                                          labelText: "Select Category",
                                          isDense: true,
                                          border: const OutlineInputBorder(borderSide: BorderSide.none),
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
                        onSelectOutlet: (value) {
                          selectedoutletList.assignAll(value);
                        },
                      ),
                    ),
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
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
                                labelText: "Product Description",
                                labelStyle: const TextStyle(backgroundColor: Colors.white),
                                filled: true,
                                border: const OutlineInputBorder(
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
                                  const Text("product image (* optional)"),
                                  MaterialButton(
                                    child: SizedBox(
                                        width: 100,
                                        child: CachedNetworkImage(
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                            placeholder: (context, url) => const CircularProgressIndicator(),
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
                                  if (selectedoutletList.isEmpty) {
                                    Notif.error(message: "Please select outlet");
                                    return;
                                  }

                                  final body = {
                                    'name': conName.text,
                                    'price': conPrice.text,
                                    'description': description.text,
                                    'categoryId': selectedCategoryId.value,
                                    'outletList': jsonEncode(selectedoutletList.toJson()),
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
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: const Center(
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
