import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/src/payment_method/payment_method_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PaymentMethodEdit extends StatelessWidget {
  const PaymentMethodEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: BackButton(),
                ),
                ListTile(
                  leading: media.isMobile ? BackButton() : null,
                  title: Text("Edit Payent method"),
                ),
                ...PaymentMethodVal.mapData.value.val.keys.map(
                  (e) => !['name', 'isActive'].contains(e)
                      ? Container()
                      : e == 'isActive'
                          ? Obx(
                              () => ListTile(
                                title: CheckboxListTile(
                                  title: Text("Is Active ?"),
                                  value: PaymentMethodVal.mapData.value.val['isActive'],
                                  onChanged: (val) {
                                    PaymentMethodVal.mapData.value.val['isActive'] = val;
                                  },
                                ),
                              ),
                            )
                          : ListTile(
                              title: TextFormField(
                                controller: TextEditingController(text: PaymentMethodVal.mapData.value.val['name']),
                                decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: 'name',
                                ),
                              ),
                            ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: MaterialButton(
                          color: Colors.pink,
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: MaterialButton(
                          color: Colors.orange,
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
