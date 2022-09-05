import 'package:flutter/material.dart';
import 'package:propos/src/product/product_create.dart';
import 'package:propos/src/product/product_display.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

// class _ProductPrimary {
//   final conName = TextEditingController();
//   final conPrice = TextEditingController();
// }

// class _ProductStock {
//   final isInclude = false.obs;
//   TextEditingController stock = TextEditingController(text: "1");
//   TextEditingController minStock = TextEditingController(text: "0");
// }

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

// class _ProductImage {
//   final isInclude = false.obs;
//   final imageId = "".obs;
//   String imageName = "";
// }

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  // final _keyForm = GlobalKey<FormState>();
  // final _productImage = <String, dynamic>{"id": "null", "name": "null"}.obs;
  // // final _productImageId = "".val("Product.productImageId").obs;
  // final _editVal = "".obs;
  // final _listPropertyCreate = [].obs;
  // final _listCompanyProduct = [].obs;

  // // final _selectedCompanyId = "".obs;
  // // final _selectedCategoryId = "".obs;
  // // final _selectedOutletId = "".obs;
  // // final _selectedoutletList = [].obs;

  // // final _conName = TextEditingController();
  // // final _conPrice = TextEditingController();

  // // final _description = TextEditingController();

  // final _lsCompany = [].obs;
  // // final lsOutlet = [].obs;
  // final _lsCategory = [].obs;

  // final _isCustomPrice = false.obs;
  // final _dataCustomPrice = {}.obs;
  // final _listCustomPriwce = [].obs;

  // // final _isIncludeImage = false.obs;
  // // final _isIncludeStock = false.obs;
  // // final _isDetail = false.obs;
  // final _isLoadingCreateButton = false.obs;
  // final _dataStock = ProductModelStock();
  // final _dataImage = ProductModelImage();
  // final _primary = ProductModelPrimary();
  // final _dataDetail =ProductModelDetail();

  // _loadProduct() async {
  //   final data = await RouterApi.productByUserId().getData();
  //   if (data.statusCode == 200) {
  //     ProductVal.listCompanyProduct.value = jsonDecode(data.body);
  //   }
  // }

  // _onLoad() async {
  //   _loadProduct();
  //   // final data = await RouterApi.productMenuGetPropertyByCompany().getData();
  //   // if (data.statusCode == 200) _listPropertyCreate.assignAll(jsonDecode(data.body));
  // }

  @override
  Widget build(BuildContext context) {
    ProductVal.onLoad();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      // child: _listDisplay(media),
                      child: ProductDisplay(),
                    ),
                    // disini
                    Visibility(
                      visible: !media.isMobile,
                      child: Card(
                        child: Column(
                          // children: [Flexible(child: _create(media))],
                          children: [Flexible(child: ProductCreate())],
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

  // Widget _searchBox(
  //     BuildContext context, RxList listSelected, RxBool isCheckAll, List lsProduct, company, RxBool isShowChecked) {
  //   return
  //   SearchViewWithCheckbox(
  //     onChanged: (searchValue) {},
  //     checkValue: isCheckAll,
  //     onCheckChanged: (checkValue) {
  //       if (checkValue!) {
  //         listSelected.assignAll(lsProduct.map((e) => e['id']));
  //         isShowChecked.value = true;
  //       } else {
  //         listSelected.clear();
  //         isShowChecked.value = false;
  //       }
  //       isCheckAll.value = checkValue;
  //     },
  //     subtitle: Obx(() => Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             IconButton(
  //                 tooltip: "Hapus Sekaligus",
  //                 onPressed: listSelected.isEmpty
  //                     ? null
  //                     : () {
  //                         Get.dialog(
  //                           AlertDialog(
  //                             title: const Text("Dihapus Sekaligus"),
  //                             content: Text("Yakin Mau Menghapus ${listSelected.length} Product Yang Dipilih ?"),
  //                             actions: [
  //                               MaterialButton(
  //                                   child: const Text("Tidak"),
  //                                   onPressed: () {
  //                                     Get.back();
  //                                   }),
  //                               MaterialButton(
  //                                   child: const Text("Ya"),
  //                                   onPressed: () {
  //                                     Get.back();
  //                                   })
  //                             ],
  //                           ),
  //                         );
  //                       },
  //                 icon: Icon(
  //                   Icons.delete_sweep,
  //                   color: listSelected.isEmpty ? Colors.grey : Colors.pink,
  //                 )),
  //             IconButton(
  //               onPressed: listSelected.isEmpty
  //                   ? null
  //                   : () {
  //                       showBottomSheet(
  //                         backgroundColor: Colors.transparent,
  //                         context: context,
  //                         builder: (c) => Card(
  //                           margin: const EdgeInsets.all(16),
  //                           elevation: 5,
  //                           child: SizedBox(
  //                             height: 500,
  //                             width: double.infinity,
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: Row(
  //                                     children: [const BackButton()],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: Text("Company : ${company['name']}"),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: Text("Product : ${listSelected.length} Selected"),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: OutletMultiSelectByCompany(
  //                                     companyId: company['id'],
  //                                     onSelectOutlet: (value) {},
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //               icon: Icon(
  //                 Icons.move_down,
  //                 color: listSelected.isEmpty ? Colors.grey : Colors.orange,
  //               ),
  //             ),
  //           ],
  //         )),
  //   );
  // }

  // Widget _listDisplay(SizingInformation media) {
  //   final listSelected = [].obs;
  //   final isShowChecked = false.obs;

  //   return Scaffold(
  //     floatingActionButton: !media.isMobile
  //         ? null
  //         : FloatingActionButton(
  //             child: const Icon(
  //               Icons.add,
  //               color: Colors.white,
  //             ),
  //             onPressed: () {
  //               Get.dialog(
  //                 Dialog(
  //                   insetPadding: const EdgeInsets.all(8),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Row(
  //                           children: [const BackButton()],
  //                         ),
  //                       ),
  //                       Flexible(child: _create(media)),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //     body: Card(
  //       child: Obx(
  //         () => _listCompanyProduct.isEmpty
  //             ? ImgDef.empty()
  //             : ContainedTabBarView(
  //                 tabs: [
  //                   ..._listCompanyProduct.map(
  //                     (e) => ListTile(
  //                       leading: Icon(Icons.business),
  //                       title: Text(
  //                         e['name'].toString(),
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //                 views: [
  //                   ..._listCompanyProduct.map(
  //                     (company) => (company['Product'] as List).isEmpty
  //                         ? Center(
  //                             child: ImgDef.empty(width: 100, height: 100, fit: BoxFit.contain),
  //                           )
  //                         : Builder(
  //                             builder: (context) {
  //                               final lsProduct = company['Product'] as List;
  //                               final isCheckAll = false.obs;
  //                               return Column(
  //                                 children: [
  //                                   // ProductDisplay(_searchBox(context, listSelected, isCheckAll, lsProduct, company, isShowChecked), create: _create, listCompanyProduct: _listCompanyProduct, media: media)
  //                                   // _searchBox(context, listSelected, isCheckAll, lsProduct, company, isShowChecked),
  //                                   ProductSearchBox(
  //                                       lsProduct: lsProduct,
  //                                       isCheckAll: isCheckAll,
  //                                       listSelected: listSelected,
  //                                       isShowChecked: isShowChecked,
  //                                       company: company),
  //                                   Flexible(
  //                                     child: Obx(
  //                                       () => Column(
  //                                         children: [
  //                                           Flexible(
  //                                             child: ListView(
  //                                               controller: ScrollController(),
  //                                               children: [
  //                                                 ...lsProduct.map(
  //                                                   (e) => ListTile(
  //                                                     onLongPress: () {
  //                                                       isShowChecked.toggle();
  //                                                     },
  //                                                     leading: !isShowChecked.value
  //                                                         ? null
  //                                                         : Checkbox(
  //                                                             value: listSelected.contains(e['id']),
  //                                                             onChanged: (value) {
  //                                                               if (value!) {
  //                                                                 listSelected.add(e['id']);
  //                                                               } else {
  //                                                                 listSelected.remove(e['id']);
  //                                                               }

  //                                                               isCheckAll.value =
  //                                                                   listSelected.length.isEqual(lsProduct.length);
  //                                                             },
  //                                                           ),
  //                                                     title: Column(
  //                                                       crossAxisAlignment: CrossAxisAlignment.start,
  //                                                       children: [
  //                                                         Row(
  //                                                           crossAxisAlignment: CrossAxisAlignment.start,
  //                                                           children: [
  //                                                             SizedBox(
  //                                                                 width: media.isMobile ? 50 : 70,
  //                                                                 child: Column(
  //                                                                   children: [
  //                                                                     CachedNetworkImage(
  //                                                                       imageUrl:
  //                                                                           "${Conf.host}/product-image/${(e['ProductImage']?['name'] ?? "null").toString()}",
  //                                                                       fit: BoxFit.cover,
  //                                                                     )
  //                                                                   ],
  //                                                                 )),
  //                                                             Expanded(
  //                                                               child: ListTile(
  //                                                                 trailing: PopupMenuButton(
  //                                                                   onSelected: (value) {
  //                                                                     switch (value) {
  //                                                                       case 'delete':
  //                                                                         Get.dialog(
  //                                                                           AlertDialog(
  //                                                                             title: const Text(
  //                                                                                 "Are you sure you want to delete this item?"),
  //                                                                             actions: [
  //                                                                               MaterialButton(
  //                                                                                   child: const Text("Yes"),
  //                                                                                   onPressed: () {}),
  //                                                                               MaterialButton(
  //                                                                                   child: const Text("No"),
  //                                                                                   onPressed: () {})
  //                                                                             ],
  //                                                                           ),
  //                                                                         );
  //                                                                         break;
  //                                                                       default:
  //                                                                         debugPrint("deleteData");
  //                                                                     }
  //                                                                   },
  //                                                                   itemBuilder: (context) {
  //                                                                     return [
  //                                                                       const PopupMenuItem(
  //                                                                         value: "outlet",
  //                                                                         child: Text("Outlet"),
  //                                                                       ),
  //                                                                       const PopupMenuItem(
  //                                                                         value: "edit",
  //                                                                         child: Text("Edit"),
  //                                                                       ),
  //                                                                       const PopupMenuItem(
  //                                                                         value: "available",
  //                                                                         child: Text("available"),
  //                                                                       ),
  //                                                                       const PopupMenuItem(
  //                                                                         value: "delete",
  //                                                                         child: Text("Delete"),
  //                                                                       ),
  //                                                                     ];
  //                                                                   },
  //                                                                 ),
  //                                                                 title: Text(e['name'].toString()),

  //                                                                 //  Row(
  //                                                                 //   children: [
  //                                                                 //     Visibility(
  //                                                                 //         visible: !media.isMobile,
  //                                                                 //         child: const SizedBox(
  //                                                                 //             width: 100, child:
  //                                                                 //             Text("Name"))),
  //                                                                 //     Expanded(child: Text(e['name'].toString())),
  //                                                                 //   ],
  //                                                                 // ),
  //                                                                 subtitle: Column(
  //                                                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                                                   children: [
  //                                                                     Text(NumberFormat.currency(
  //                                                                             locale: 'id_ID',
  //                                                                             symbol: 'Rp',
  //                                                                             decimalDigits: 0)
  //                                                                         .format(e['price'])),
  //                                                                     Text(e['description'] ?? ""),
  //                                                                     Ink(
  //                                                                       child: Text((() {
  //                                                                         try {
  //                                                                           return e['Category']['name'];
  //                                                                         } catch (e) {
  //                                                                           return "";
  //                                                                         }
  //                                                                       })()),
  //                                                                     ),
  //                                                                     // Row(
  //                                                                     //   children: [
  //                                                                     //     SizedBox(
  //                                                                     //         width: media.isMobile ? 70 : 100,
  //                                                                     //         child: const Text("Price")),
  //                                                                     //     Expanded(
  //                                                                     //         child:
  //                                                                     //         Text(NumberFormat.currency(
  //                                                                     //                 locale: 'id_ID',
  //                                                                     //                 symbol: 'Rp',
  //                                                                     //                 decimalDigits: 0)
  //                                                                     //             .format(e['price']))),
  //                                                                     //   ],
  //                                                                     // ),
  //                                                                     // Row(
  //                                                                     //   children: [
  //                                                                     //     SizedBox(
  //                                                                     //         width: media.isMobile ? 70 : 100,
  //                                                                     //         child: const Text("Description")),
  //                                                                     //     Expanded(
  //                                                                     //         child: Text(e['description'].toString())),
  //                                                                     //   ],
  //                                                                     // ),
  //                                                                     // Row(
  //                                                                     //   children: [
  //                                                                     //     SizedBox(
  //                                                                     //         width: media.isMobile ? 70 : 100,
  //                                                                     //         child: Text("Category")),
  //                                                                     //     Expanded(
  //                                                                     //         child:
  //                                                                     //             Text(e['Category']['name'].toString())),
  //                                                                     //   ],
  //                                                                     // ),
  //                                                                     // Row(
  //                                                                     //   crossAxisAlignment: CrossAxisAlignment.start,
  //                                                                     //   children: [
  //                                                                     //     SizedBox(width: media.isMobile ? 70 : 100, child: Text("Outlet")),
  //                                                                     //     Expanded(
  //                                                                     //         child:
  //                                                                     //         )
  //                                                                     //   ],
  //                                                                     // )
  //                                                                   ],
  //                                                                 ),
  //                                                               ),
  //                                                             ),
  //                                                           ],
  //                                                         ),
  //                                                         Padding(
  //                                                           padding: const EdgeInsets.all(8.0),
  //                                                           child: Wrap(
  //                                                             alignment: WrapAlignment.start,
  //                                                             crossAxisAlignment: WrapCrossAlignment.start,
  //                                                             children: [
  //                                                               for (final itm in e['ProductOutlet'])
  //                                                                 Padding(
  //                                                                   padding: const EdgeInsets.all(4.0),
  //                                                                   child: Chip(
  //                                                                       backgroundColor: Colors.cyan,
  //                                                                       label: Text(
  //                                                                         itm['Outlet']['name'].toString(),
  //                                                                         style: const TextStyle(
  //                                                                           color: Colors.white,
  //                                                                         ),
  //                                                                       )),
  //                                                                 )
  //                                                             ],
  //                                                           ),
  //                                                         )
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 )
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               );
  //                             },
  //                           ),
  //                   ),
  //                 ],
  //               ),
  //       ),
  //     ),
  //   );
  // }

//   Widget _temSelect(String lable) => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextField(
//           enabled: false,
//           decoration: InputDecoration(
//               labelText: lable,
//               labelStyle: const TextStyle(backgroundColor: Colors.white),
//               filled: true,
//               border: const OutlineInputBorder(borderSide: BorderSide.none)),
//         ),
//       );

//   // Future<RxList> _collect(RxList data) async => data;

//   Widget _primaryWidget() {
//     return ListView(
//       controller: ScrollController(),
//       children: [
//         Form(
//           key: _keyForm,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   validator: (value) => value!.isEmpty || value.length < 3
//                       ? "Name is required and should be at least 3 characters long"
//                       : null,
//                   textInputAction: TextInputAction.next,
//                   controller: _primary.conName,
//                   decoration: const InputDecoration(
//                     labelText: 'Product Name',
//                     labelStyle: TextStyle(backgroundColor: Colors.white),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//               _primaryPrice()
//             ],
//           ),
//         ),
//         Divider(),
//         _primaryDetail()
//       ],
//     );
//   }

//   Widget _primaryPrice() {
//     return Obx(
//       () => Container(
//         margin: EdgeInsets.all(_isCustomPrice.value ? 16 : 0),
//         padding: EdgeInsets.all(_isCustomPrice.value ? 8 : 0),
//         decoration: BoxDecoration(border: !_isCustomPrice.value ? null : Border.all()),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.number,
//                 controller: _primary.conPrice,
//                 validator: (value) {
//                   return value!.isEmpty || int.tryParse(value) == null ? "price is required ar number only" : null;
//                 },
//                 onChanged: (value) {
//                   if (int.tryParse(value).toString() == "null") {
//                     _primary.conPrice.clear();
//                   }
//                 },
//                 decoration: const InputDecoration(
//                   labelText: "Product Price",
//                   labelStyle: TextStyle(backgroundColor: Colors.white),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Use Custom Price"),
//                     ),
//                     Checkbox(
//                       value: _isCustomPrice.value,
//                       onChanged: (value) {
//                         if (_primary.conPrice.text.isEmpty) {
//                           Notif.error(message: "isi harga terlebih dahulu");
//                           return;
//                         }

//                         _isCustomPrice.toggle();
//                       },
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Memungkinkan Anda Menggunakan Harga Berbeda Seperti Untuk Gojek , Grab Atau Lainnya",
//                     textAlign: TextAlign.end,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 )
//               ],
//             ),
//             Builder(
//               builder: (c) {
//                 RouterApi.customPriceGetDataSelect().getData().then(
//                   (res) {
//                     if (res.statusCode == 200) {
//                       _listCustomPriwce.assignAll(jsonDecode(res.body));
//                       _listCustomPriwce.refresh();
//                     }
//                   },
//                 );
//                 return Visibility(
//                   visible: _isCustomPrice.value,
//                   child: Column(
//                     children: [
//                       ..._listCustomPriwce.map(
//                         (e) => Builder(
//                           builder: (context) {
//                             _dataCustomPrice[e['id']] = {
//                               "id": e['id'],
//                               "name": e['name'].toString(),
//                               "con": TextEditingController()
//                             };
//                             return ListTile(
//                               title: Text(e['name'].toString()),
//                               subtitle: TextField(
//                                 onChanged: (value) {
//                                   if (int.tryParse(value) == null) {
//                                     (_dataCustomPrice[e['id']]['con'] as TextEditingController).clear();
//                                   }
//                                 },
//                                 controller: (_dataCustomPrice[e['id']]['con'] as TextEditingController),
//                                 decoration: InputDecoration(filled: true, border: InputBorder.none, prefixText: "Rp "),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//             )
//             // Visibility(
//             //   visible: _isCustomPrice.value,
//             //   child: FutureBuilder<http.Response>(
//             //     future: RouterApi.customPriceGetDataSelect().getData(),
//             //     builder: (c, s) {
//             //       if (s.connectionState != ConnectionState.done) {
//             //         return const Center(
//             //           child: CircularProgressIndicator(),
//             //         );
//             //       }
//             //       final List listData = jsonDecode(s.data!.body);
//             //       return Column(
//             //         children: [
//             //           ...listData.map(
//             //             (e) => Builder(
//             //               builder: (context) {

//             //                 return ListTile(
//             //                   title: Text(e['name'].toString()),
//             //                   subtitle: const TextField(
//             //                     decoration: InputDecoration(filled: true, border: InputBorder.none, prefixText: "Rp "),
//             //                   ),
//             //                 );
//             //               }
//             //             ),
//             //           )
//             //         ],
//             //       );
//             //     },
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _primaryDetail() {
//     return Obx(
//       () => Container(
//         padding: EdgeInsets.all(_dataDetail.isInclude.value ? 8 : 0),
//         margin: EdgeInsets.all(_dataDetail.isInclude.value ? 16 : 0),
//         decoration: BoxDecoration(border: !_dataDetail.isInclude.value ? null : Border.all()),
//         child: Column(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text("Include Detail"),
//                     Checkbox(
//                       value: _dataDetail.isInclude.value,
//                       onChanged: (value) {
//                         _dataDetail.isInclude.value = value!;
//                       },
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "jika tidak menggunakan detail akan menggunakan default detail pada saat ini yang tersedia",
//                     textAlign: TextAlign.end,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 )
//               ],
//             ),
//             Visibility(
//               visible: _dataDetail.isInclude.value,
//               child: Column(
//                 children: [
//                   CompanySelect(
//                     onSelectCompany: (companyId) async {
//                       final ctgr = await RouterApi.categoryByCompanyId(query: "cusCompanyId=$companyId").getData();
//                       _lsCategory.assignAll(jsonDecode(ctgr.body));
//                       _dataDetail.companyId.value = companyId;
//                     },
//                   ),
//                   Column(
//                     children: [
//                       Visibility(visible: false, child: Text(_lsCategory.toString())),
//                       FutureBuilder<RxList>(
//                         future: (() async => _lsCategory)(),
//                         builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
//                             ? _temSelect("Select Category")
//                             : Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: DropdownButtonFormField(
//                                   decoration: const InputDecoration(
//                                       labelStyle: TextStyle(backgroundColor: Colors.white),
//                                       labelText: "Select Category",
//                                       isDense: true,
//                                       border: OutlineInputBorder(borderSide: BorderSide.none),
//                                       filled: true),
//                                   items: [
//                                     ..._lsCategory.map(
//                                       (element) => DropdownMenuItem(
//                                         value: element,
//                                         child: Text(element['name'].toString()),
//                                       ),
//                                     )
//                                   ],
//                                   onChanged: (value) {
//                                     _dataDetail.categoryId.value = (value as Map)['id'];
//                                   },
//                                 ),
//                               ),
//                       ),
//                     ],
//                   ),
//                   OutletMultiSelectByCompany(
//                     companyId: _dataDetail.companyId.value,
//                     onSelectOutlet: (value) {
//                       // debugPrint(value.toString());
//                       // _selectedoutletList.assignAll(value);
//                       final hasil = value.map(
//                         (e) => {
//                           "outletId": e,
//                           "companyId": _dataDetail.companyId.value,
//                           "userId": Vl.userId.val,
//                         },
//                       );
//                       _dataDetail.listoutlet.assignAll(hasil);
//                     },
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: TextFormField(
//                   //     textInputAction: TextInputAction.next,
//                   //     keyboardType: TextInputType.number,
//                   //     controller: _detail.des,
//                   //     decoration: const InputDecoration(
//                   //       labelText: "Product Description",
//                   //       labelStyle: TextStyle(backgroundColor: Colors.white),
//                   //       filled: true,
//                   //       border: OutlineInputBorder(
//                   //         borderSide: BorderSide.none,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   Input(
//                     controller: _dataDetail.des,
//                     hint: "keterangan",
//                   ),
//                   Input(
//                     onChanged: (value) {
//                       if (int.tryParse(value) == null) _dataDetail.modal.clear();
//                     },
//                     controller: _dataDetail.modal,
//                     hint: "Harga Modal",
//                   ),
//                   Input(
//                     controller: _dataDetail.sku,
//                     hint: "SKU",
//                   ),
//                   Input(
//                     controller: _dataDetail.barcodeId,
//                     hint: "Barcode Id",
//                   ),
//                   Input(
//                     controller: _dataDetail.berat,
//                     hint: "Berat",
//                     onChanged: (value) {
//                       if (int.tryParse(value) == null) _dataDetail.berat.clear();
//                     },
//                   ),
//                   Input(
//                     controller: _dataDetail.dimensi,
//                     hint: "Dimensi",
//                     info: "P x L x T, contoh 120, 120, 10",
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _withImage() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Obx(
//         () => Column(
//           children: [
//             CheckboxListTile(
//               title: Text("Include With Image ?"),
//               value: _dataImage.isInclude.value,
//               onChanged: (value) {
//                 _dataImage.isInclude.value = value!;
//               },
//               subtitle: Text("tab pada gambar dibawah untuk memulai upload gambar"),
//             ),
//             Visibility(
//               visible: _dataImage.isInclude.value,
//               child: InkWell(
//                 child: SizedBox(
//                     width: double.infinity,
//                     child: CachedNetworkImage(
//                         errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
//                         placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                         imageUrl: "${Conf.host}/product-image/${_productImage['name']}")),
//                 onTap: () async {
//                   await _uploadImage();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _withStock() {
//     return Obx(
//       () => Column(
//         children: [
//           CheckboxListTile(
//             title: Text("Include Stock"),
//             value: _dataStock.isInclude.value,
//             onChanged: (value) {
//               _dataStock.isInclude.value = value!;
//             },
//           ),
//           Visibility(
//             visible: _dataStock.isInclude.value,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text("New Stock"),
//                   subtitle: TextField(
//                     controller: _dataStock.stock,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       filled: true,
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text("Minimal Stock"),
//                   subtitle: TextField(
//                     controller: _dataStock.minStock,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       filled: true,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

// // id
// // name
// // price
// // description
// // isCustomPrice
// // User
// // userId
// // Outlet
// // createdAt
// // updatedAt
// // outletId
// // Category
// // categoryId
// // Favorite
// // Company
// // companyId
// // Order
// // ProductImage
// // productImageId
// // ProductOutlet
// // Discount
// // discountId
// // ProductCustomPrice
// // //
// // costOfCapital
// // sku
// // barcodeId
// // //
// // productWeight
// // productDimention
// // stock
// // minStock
// // //
// // StockHistory
// // img

//   Widget _create(SizingInformation media) => Builder(
//         builder: (context) {
//           final menu = [
//             {"title": "Primary", "widget": _primaryWidget()},
//             {"title": "Include Image", "widget": _withImage()},
//             {"title": "Include Stock", "widget": _withStock()}
//           ];

//           RouterApi.productCreateSelect().getData().then(
//             (value) {
//               if (value.statusCode == 200) {
//                 _lsCompany.assignAll(jsonDecode(value.body));
//               }
//             },
//           );

//           // final selectedoutlet = "".obs;
//           return SizedBox(
//             width: media.isMobile ? Get.width : 360,
//             // height: Get.height * 0.8,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Create Product",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   child: Column(
//                     children: [
//                       Flexible(
//                         child: ContainedTabBarView(
//                           tabs: [...menu.map((e) => ListTile(title: Text(e['title'].toString())))],
//                           views: [
//                             ...menu.map(
//                               (e) => (e['widget'] as Widget),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 _submit(media)
//               ],
//             ),
//           );
//         },
//       );

//   Widget _submit(SizingInformation media) {
//     return Obx(
//       () => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: _isLoadingCreateButton.value
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : MaterialButton(
//                 color: Colors.blue,
//                 onPressed: () async {
//                   _isLoadingCreateButton.value = true;
//                   Future.delayed(Duration(seconds: 2), () => _isLoadingCreateButton.value = false);

//                   if (_primary.conPrice.text.isEmpty || _primary.conName.text.isEmpty) {
//                     SmartDialog.showToast("nama dan harga tidak diijinkan kosong");
//                     return;
//                   }

//                   final body = <String, dynamic>{
//                     "name": _primary.conName.text,
//                     "price": int.parse(_primary.conPrice.text),
//                   };

//                   if (_isCustomPrice.value) {
//                     final listCustomePrice = _dataCustomPrice.values
//                         .where((element) => (element['con'] as TextEditingController).text.isNotEmpty)
//                         .map((e) =>
//                             {"customPriceId": e['id'], "price": int.parse((e['con'] as TextEditingController).text)})
//                         .toList();

//                     if (listCustomePrice.isEmpty) {
//                       Notif.error(message: "custom price kosong");
//                       return;
//                     }
//                     body['listCustomPrice'] = listCustomePrice;
//                   }

//                   if (_dataImage.isInclude.value) {
//                     if (_dataImage.imageId.value.isEmpty || _dataImage.imageName.isEmpty) {
//                       Notif.error(message: "gambar kosong");
//                       return;
//                     }

//                     if (_dataImage.imageId.value.isNotEmpty) body['productImageId'] = _dataImage.imageId.value;
//                     if (_dataImage.imageName.isNotEmpty) body['productImageName'] = _dataImage.imageName;
//                   }

//                   // if (_dataStock.isInclude.value) {
//                   //   body['stock'] = _dataStock.stock.text;
//                   //   body['nin_stock'] = _dataStock.minStock.text;
//                   // }

//                   if (_dataStock.stock.text.isNotEmpty) body['stock'] = int.parse(_dataStock.stock.text);
//                   if (_dataStock.minStock.text.isNotEmpty) body['ninStock'] = int.parse(_dataStock.minStock.text);

//                   if (_dataDetail.isInclude.value) {
//                     if (_dataDetail.companyId.value.isNotEmpty) body['companyId'] = _dataDetail.companyId.value;
//                     if (_dataDetail.listoutlet.isNotEmpty) body['listOutlet'] = _dataDetail.listoutlet;
//                     if (_dataDetail.des.text.isNotEmpty) body['des'] = _dataDetail.des.text;
//                     if (_dataDetail.modal.text.isNotEmpty) body['modal'] = int.parse(_dataDetail.modal.text);
//                     if (_dataDetail.barcodeId.text.isNotEmpty) body['barcodeId'] = _dataDetail.barcodeId.text;
//                     if (_dataDetail.sku.text.isNotEmpty) body['sku'] = _dataDetail.sku.text;
//                     if (_dataDetail.berat.text.isNotEmpty) body['berat'] = int.parse(_dataDetail.berat.text);
//                     if (_dataDetail.categoryId.value.isNotEmpty) body['categoryId'] = _dataDetail.categoryId.value;
//                     if (_dataDetail.dimensi.text.isNotEmpty) {
//                       final dimensi = _dataDetail.dimensi.text.split(",");
//                       try {
//                         int.parse(dimensi[0]);
//                         int.parse(dimensi[1]);
//                         int.parse(dimensi[2]);
//                         body['dimensi'] = _dataDetail.dimensi.text;
//                       } catch (e) {
//                         Notif.error(message: "format dimensi salah");
//                       }
//                     }
//                   } else {
//                     body['companyId'] = Vl.companyId.val;
//                     body['listOutlet'] = [
//                       {
//                         "outletId": Vl.outletId.val,
//                         "companyId": Vl.companyId.val,
//                         "userId": Vl.userId.val,
//                       }
//                     ];
//                     body['userId'] = Vl.userId.val;
//                   }

//                   body['isImage'] = _dataImage.isInclude.value;
//                   body['isStock'] = _dataStock.isInclude.value;
//                   body['isDetail'] = _dataDetail.isInclude.value;
//                   body['isCustomPrice'] = _isCustomPrice.value;

//                   // print(JsonEncoder.withIndent("   ").convert(body));

//                   final kirim = await RouterApi.productCreate().postData({"data": jsonEncode(body)});
//                   if (kirim.statusCode == 201) {
//                     await _onLoad();

//                     if (media.isMobile) {
//                       Get.back();
//                     }
//                   }
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Center(
//                     child: Text(
//                       "Create",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   _uploadImage() async {
//     final upload = http.MultipartRequest(
//       'POST',
//       Uri.parse("${Conf.host}/img/upload?userId=${Vl.userId.val}"),
//     );
//     final image = await ImagePicker().pickImage(maxHeight: 500, maxWidth: 500, source: ImageSource.gallery);
//     if (image != null) {
//       upload.files.add(http.MultipartFile.fromBytes("image", await image.readAsBytes(), filename: "${image.name}.png"));
//       final res = await upload.send().then((value) => value.stream.bytesToString());
//       final result = jsonDecode(res);
//       _productImage.assignAll(result);
//       _productImage.refresh();
//       _dataImage.imageId.value = _productImage['id'];
//       _dataImage.imageName = result['name'];

//       debugPrint(result.toString());

//       // debugPrint(result.toString());
//     } else {
//       SmartDialog.showToast("No image selected");
//     }
  // }
}
