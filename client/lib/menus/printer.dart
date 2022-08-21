import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:propos/components/select_printer_android.dart';
import 'package:propos/components/select_printer_web.dart';

class Printer extends StatelessWidget {
  const Printer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      
      GetPlatform.isAndroid ? SelectPrinterAndroid() : SelectPrinterWeb(),

    ]);
  }
}


// class Printer extends StatelessWidget {
//   Printer({Key? key}) : super(key: key);
//   final _connected = false.obs;
//   final _info = "".obs;
//   BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
//   final _devices = <BluetoothDevice>[].obs;
//   final _device = <String, BluetoothDevice>{}.obs;
//   TestPrint testPrint = TestPrint();

  

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ListView(
//         children: [
//           Text(_connected.value.toString()),
//           Text(_info.value),
//           // Text((_device['bt']!.name??"").toString()),
//           // Text(_device['bt']!.address.toString()),
//           // Text(_device['bt']!.connected.toString()),
//           MaterialButton(
//             child: Text("load"),
//             onPressed: () async {
//               PrinterBluetoothManager printerManager = PrinterBluetoothManager();

//               printerManager.scanResults.listen((printers) async {
//                 // store found printers
//                 debugPrint("found printers: ${printers.length}");
//               });
//               printerManager.startScan(Duration(seconds: 4));

//               // ...

//               // printerManager.selectPrinter(printer);
//               // final PosPrintResult res = await printerManager.printTicket(testTicket());

//               // print('Print result: ${res.msg}');
//             },
//           ),
//           MaterialButton(
//             onPressed: () {
//               _connect();
//             },
//             child: Text("connect"),
//           ),
//           MaterialButton(
//             onPressed: () {
//               testPrint.sample();
//             },
//             child: Text("print"),
//           ),
//           MaterialButton(
//             child: Text("disconnect"),
//             onPressed: () async {
//               final dis = await bluetooth.disconnect();
//               debugPrint("disconnect $dis");
//             },
//           ),
//           Column(
//             children: [
//               for (final dc in _devices)
//                 ListTile(
//                   onTap: () async {
//                     bluetooth.isConnected.then((isConnected) {
//                       debugPrint("isConnected: $isConnected");
//                       if (isConnected == true) {
//                         bluetooth.connect(dc).catchError((error) {
//                           debugPrint(error.toString());
//                         });
//                         debugPrint("connected");
//                         testPrint.sample();
//                       }
//                     }).catchError((error) {
//                       debugPrint(error.toString());
//                     }).onError((error, stackTrace) {
//                       debugPrint(error.toString());
//                       debugPrint(stackTrace.toString());
//                     });
//                   },
//                   title: Text(dc.name.toString()),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(dc.address.toString()),
//                       Text(dc.connected.toString()),
//                     ],
//                   ),
//                 )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> initPlatformState() async {
//     debugPrint("load bluetoth");
//     bool? isConnected = await bluetooth.isConnected;

//     try {
//       final ls = await bluetooth.getBondedDevices();
//       _devices.value = ls;
//       _devices.refresh();
//     } on PlatformException {
//       debugPrint("error");
//     }

//     bluetooth.onStateChanged().listen((state) {
//       switch (state) {
//         case BlueThermalPrinter.CONNECTED:
//           _connected.value = true;
//           debugPrint("conneted");
//           _info.value = "connected";
//           break;
//         case BlueThermalPrinter.DISCONNECTED:
//           _connected.value = false;
//           debugPrint("disconnect");
//           _info.value = "disconect";
//           break;
//         case BlueThermalPrinter.DISCONNECT_REQUESTED:
//           _connected.value = false;
//           debugPrint("disconect request");
//           _info.value = "disconect request";
//           break;
//         case BlueThermalPrinter.STATE_TURNING_OFF:
//           _connected.value = false;
//           debugPrint("state turning off");
//           _info.value = "state turning off";
//           break;
//         case BlueThermalPrinter.STATE_OFF:
//           _connected.value = false;
//           debugPrint("state off");
//           _info.value = "state off";
//           break;
//         case BlueThermalPrinter.STATE_ON:
//           _connected.value = false;
//           debugPrint("state on");
//           _info.value = "state on";
//           break;
//         case BlueThermalPrinter.STATE_TURNING_ON:
//           _connected.value = false;
//           debugPrint("state turning on");
//           _info.value = "state turning on";
//           break;
//         case BlueThermalPrinter.ERROR:
//           _connected.value = false;
//           debugPrint("error");
//           _info.value = "error";
//           break;
//         default:
//           print(state);
//           break;
//       }
//     });
//   }

//   void _connect() {
//     if (_device['bt'] != null) {
//       debugPrint(_device['bt']!.name);
//       bluetooth.isConnected.then((isConnected) {
//         debugPrint(isConnected.toString());
//         if (isConnected == true) {
//           bluetooth.connect(_device['bt']!).catchError((error) {
//             _connected.value = false;
//           });
//           _connected.value = true;
//         }
//       });
//     } else {
//       Get.snackbar("info", "device null");
//     }
//   }

//   void _disconnect() {
//     bluetooth.disconnect();
//     _connected.value = false;
//   }

//   // Future show(
//   //   String message, {
//   //   Duration duration: const Duration(seconds: 3),
//   // }) async {
//   //   await new Future.delayed(new Duration(milliseconds: 100));
//   //   Get.snackbar("info", message);
//   // }
// }
