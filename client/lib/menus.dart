import 'package:flutter/material.dart';
import 'package:propos/menus/Daily%20schedule.dart';
import 'package:propos/menus/cashier.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:propos/menus/company.dart';
import 'package:propos/menus/custom_price.dart';
import 'package:propos/menus/customer.dart';
import 'package:propos/menus/device.dart';
import 'package:propos/components/test_print.dart';
import 'package:propos/menus/discount.dart';
import 'package:propos/menus/report.dart';
import 'package:propos/menus/store%20online.dart';
import 'package:propos/menus/tax_and_service.dart';
import 'package:propos/menus/work%20shift.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'menus/category.dart';
import 'menus/employee.dart';
import 'menus/outlet.dart';
import 'menus/payment method.dart';
import 'menus/printer.dart';
import 'menus/product.dart';

class Menus {
    static final visible = "Cashier".val('Menus.visible').obs;
    static final listMenu = [{
            "title": "Cashier",
            "display": Cashier(),
            "icon": Icons.shopping_basket_rounded,
        },
        {
            "title": "Company",
            "display": Company(),
            "icon": Icons.home_work,
        },
        {
            "title": "Outlet",
            "display": Outlet(),
            "icon": Icons.store,
        },
        {
            "title": "Category",
            "display": Category(),
            "icon": Icons.category,
        },
        {
            "title": "Product",
            "display": Product(),
            "icon": Icons.storage,
        },
        {
            "title": "Employee",
            "display": Employee(),
            "icon": Icons.people,
        },
        {
            "title": "Device",
            "display": Device(),
            "icon": Icons.devices,
        },
        {
            "title": "Discount",
            "display": Discount(),
            "icon": Icons.pix_rounded,
        },
        {
            "title": "Tax And Service",
            "display": TaxAndService(),
            "icon": Icons.pix_rounded,
        },
        {
            "title": "Report",
            "display": Report(),
            "icon": Icons.pix_rounded,
        },
        {
            "title": "DailySchedule",
            "display": DailySchedule(),
            "icon": Icons.date_range,
        },
        {
            "title": "PaymentMethod",
            "display": PaymentMethod(),
            "icon": Icons.monetization_on,
        },
        {
            "title": "Printer",
            "display": Printer(),
            "icon": Icons.print,
        },
        {
            "title": "WorkShift",
            "display": WorkShift(),
            "icon": Icons.timer,
        },
        {
            "title": "Customer",
            "display": Customer(),
            "icon": Icons.pix_rounded,
        },
        {
            "title": "StoreOnline",
            "display": StoreOnline(),
            "icon": Icons.pix_rounded,
        }, 
        {
            "title": "CustomPrice",
            "display": CustomPrice(),
            "icon": Icons.pix_rounded,
        },
        
    ];

    static Widget display() => Obx(
        () => Stack(
            children: [
                for (final itm in listMenu)
                    Visibility(
                        visible: visible.value.val == itm['title'],
                        child: itm['display'] as Widget,
                    ),
            ],
        ),
    );

    static Widget listButton(SizingInformation media) => Obx(
        () => Column(
            children: [
                for (final itm in listMenu)
                    Visibility(
                        child: ListTile(
                            leading: Icon(
                                itm['icon'] as IconData,
                                color: Colors.blue,
                            ),
                            title: Text(itm['title'].toString()),
                            selected: visible.value.val == itm['title'],
                            onTap: () {
                                visible.value.val = itm['title'].toString();
                                visible.refresh();
                                if (media.isMobile) Get.back();
                            },
                        ),
                    )
            ],
        ),
    );
}