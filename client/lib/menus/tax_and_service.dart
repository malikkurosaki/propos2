import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/components/company_select.dart';
import 'package:propos/components/input.dart';
import 'package:propos/components/select_outlet_by_company.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class TaxAndService extends StatelessWidget {
  TaxAndService({Key? key}) : super(key: key);
  final _companyId = "".obs;
  final _outletId = "".obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(child: _listDisplay()),
                    ),
                    Visibility(
                      visible: !media.isMobile,
                      child: SizedBox(
                        width: 360,
                        child: Column(
                          children: [
                            Flexible(
                              child: Card(
                                child: _create(),
                              ),
                            )
                          ],
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

  Widget _listDisplay() {
    return Column(
      children: [
        Flexible(
          child: ListView(
            children: [],
          ),
        )
      ],
    );
  }

  Widget _create() {
    final isService = false.obs;
    final isTax = false.obs;
    final isInclude = false.obs;
    final isLoadingSave = false.obs;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          color: Colors.blueGrey.shade100,
          child: Text("Sesuaikan Pengaturan"),
        ),
        Flexible(
          child: ListView(
            children: [
              CompanySelect(onSelectCompany: (value) {
                _companyId.value = value;
              }),
              Obx(
                () => OutletSelectByCompany(
                    onSelectOutlet: (value) {
                      _outletId.value = value;
                    },
                    companyId: _companyId.value),
              ),
              Obx(
                () => Visibility(
                  visible: _outletId.isNotEmpty,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          title: Text("Service Charge"),
                          value: isService.value,
                          onChanged: (value) {
                            isService.toggle();
                          },
                          subtitle: !isService.value
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        label: Text("Value Service"),
                                        suffixIcon: Icon(Icons.percent),
                                        border: OutlineInputBorder(borderSide: BorderSide.none)),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          title: Text("Tax Charge"),
                          value: isTax.value,
                          onChanged: (value) {
                            isTax.toggle();
                          },
                          subtitle: !isTax.value
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        label: Text("Value Tax"),
                                        suffixIcon: Icon(Icons.percent),
                                        border: OutlineInputBorder(borderSide: BorderSide.none)),
                                  ),
                                ),
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.blueGrey.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text("Pengaturan Perhitungan"),
                                  ),
                                ),
                                CheckboxListTile(
                                  title: Text("Harga Tidak Termasuk Pajak Dan Service"),
                                  value: !isInclude.value,
                                  onChanged: (value) {
                                    isInclude.value = false;
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text("Harga Termasuk Pajak Dan Service"),
                                  value: isInclude.value,
                                  onChanged: (value) {
                                    isInclude.value = true;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Obx(
                () => isLoadingSave.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            isLoadingSave.value = true;
                            await 2.delay();
                            isLoadingSave.value = false;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        )
        // ListTile(
        //   leading: Icon(Icons.home_repair_service_sharp),
        //   title: Text("Service Charge"),
        //   trailing: Checkbox(
        //     value: false,
        //     onChanged: (value) {},
        //   ),
        //   subtitle:
        //   ,
        // ),
      ],
    );
  }
}
