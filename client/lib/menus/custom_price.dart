import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/src/custom_price/custom_price_display.dart';
import 'package:propos/src/custom_price/custom_price_create.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomPrice extends StatelessWidget {
  CustomPrice({Key? key}) : super(key: key);
  final _listCustomPrice = [].obs;

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
                      child: CustomPriceDisplay()
                    ),
                    SizedBox(
                      width: 360,
                      child: Card(
                        child: CustomPriceCreate(),
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

  // void _loadCustomPrice() {
  //   RouterApi.customPriceGetList().getData().then(
  //     (res) {
  //       if (res.statusCode == 200) {
  //         _listCustomPrice.assignAll(jsonDecode(res.body));
  //       }
  //     },
  //   );
  // }

  // Widget _kiri() {
  //   _loadCustomPrice();
  //   return Column(
  //     children: [
  //       FutureBuilder<http.Response>(
  //           future: Rot.customPriceListGet(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState != ConnectionState.done) return LinearProgressIndicator();
  //             return Text(snapshot.data!.body);
  //           })
  //       // Flexible(
  //       //   child: Obx(
  //       //     () => _listCustomPrice.isEmpty
  //       //         ? Center(
  //       //             child: Text("Empty Data"),
  //       //           )
  //       //         : ContainedTabBarView(
  //       //             tabs: [
  //       //               ..._listCustomPrice.map((element) => ListTile(
  //       //                     title: Text(element['name'].toString()),
  //       //                   ))
  //       //             ],
  //       //             views: [
  //       //               ..._listCustomPrice.map(
  //       //                 (element) => Column(
  //       //                   children: [
  //       //                     Flexible(
  //       //                       child: Builder(
  //       //                         builder: (context) {
  //       //                           final List listData = element['CustomPrice'];
  //       //                           return ListView(
  //       //                             children: [
  //       //                               ...listData.map(
  //       //                                 (e) => ListTile(
  //       //                                   leading: Checkbox(
  //       //                                     value: false,
  //       //                                     onChanged: (value) {},
  //       //                                   ),
  //       //                                   title: Text(e['name'].toString()),
  //       //                                   trailing: PopupMenuButton(
  //       //                                     itemBuilder: (context) {
  //       //                                       return [
  //       //                                         PopupMenuItem(
  //       //                                           value: Text("edit"),
  //       //                                           child: Text("Edit"),
  //       //                                         ),
  //       //                                         PopupMenuItem(
  //       //                                           value: Text("delete"),
  //       //                                           child: Text("Delete"),
  //       //                                         )
  //       //                                       ];
  //       //                                     },
  //       //                                   ),
  //       //                                 ),
  //       //                               )
  //       //                             ],
  //       //                           );
  //       //                         },
  //       //                       ),
  //       //                     )
  //       //                   ],
  //       //                 ),
  //       //               )
  //       //             ],
  //       //           ),
  //       //   ),
  //       // )
  //     ],
  //   );
  // }

  // Widget _kanan() {
  //   final conName = TextEditingController();
  //   final loadingbutton = false.obs;
  //   return 
  //   Column(
  //     children: [
  //       Flexible(
  //         child: ListView(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text("Create Custom Price"),
  //             ),
  //             Input(
  //               controller: conName,
  //               label: "name",
  //             ),
  //             Obx(
  //               () => Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: loadingbutton.value
  //                     ? Center(
  //                         child: CircularProgressIndicator(),
  //                       )
  //                     : MaterialButton(
  //                         color: Colors.blue,
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(12.0),
  //                           child: Center(
  //                             child: Text(
  //                               "Create",
  //                               style: TextStyle(color: Colors.white),
  //                             ),
  //                           ),
  //                         ),
  //                         onPressed: () async {
  //                           loadingbutton.value = true;
  //                           Future.delayed(Duration(seconds: 5), () {
  //                             loadingbutton.value = false;
  //                           });

  //                           final body = {"name": conName.text};

  //                           if (body.values.contains("")) {
  //                             Notif.error(message: "name tidak boleh kosong");
  //                             return;
  //                           }

  //                           // final data = await RouterApi.customPriceCreate().postData(body);
  //                           final data = await Rot.customPriceCreatePost(body: {"data": jsonEncode(body)});

  //                           if (data.statusCode == 201) {
  //                             Notif.success();
  //                             _loadCustomPrice();
  //                             conName.clear();
  //                             return;
  //                           }

  //                           Notif.error(message: data.body.toString());
  //                         },
  //                       ),
  //               ),
  //             )
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }
}
