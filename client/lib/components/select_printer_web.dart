// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as btEsc;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/gen/flutterblue.pb.dart';
import 'package:propos/utils/struk_tiket.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart' as bt;
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart' as bw;
import 'package:flutter_web_bluetooth/js_web_bluetooth.dart' as bwjs;
import 'package:propos/utils/struk_tiket.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:propos/utils/val.dart';

class SelectPrinterWeb extends StatelessWidget {
  SelectPrinterWeb({Key? key}) : super(key: key);
  final supported = bw.FlutterWebBluetooth.instance.isBluetoothApiSupported;
  final available = bw.FlutterWebBluetooth.instance.isAvailable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          child: Text("Select Printer"),
          onPressed: () async {
            final requestOptions = bw.RequestOptionsBuilder.acceptAllDevices(
                optionalServices: [bw.BluetoothDefaultServiceUUIDS.DEVICE_INFORMATION.uuid]);
            final device = await bw.FlutterWebBluetooth.instance.requestDevice(requestOptions);
            
            

            
          },
        )
        // Obx(() => Text(Val.deviceWebBt.value.val.length.toString())),
        // MaterialButton(
        //     child: Text("tekan"),
        //     onPressed: () {
        //       Val.deviceWebBt.value.val.first.connected.listen((event) {
        //         debugPrint(event.toString());
        //       });
        //     }),
        // MaterialButton(
        //   child: Text("load"),
        //   onPressed: () async {
        //     final requestOptions = bw.RequestOptionsBuilder.acceptAllDevices(
        //         optionalServices: [bw.BluetoothDefaultServiceUUIDS.DEVICE_INFORMATION.uuid]);
        //     final device = await bw.FlutterWebBluetooth.instance.requestDevice(requestOptions);
        //     await device.connect();
        //     device.connected.listen((event) async {

        //     });
        //     // device.connected.listen((event) {
        //     //   debugPrint(event.toString());
        //     // });

        //     // final a = bwjs.WebBluetoothDevice.fromJSObject(device);
        //     // final dev = bw.BluetoothDevice(a);
        //     // dev.connected.listen(
        //     //   (event) {
        //     //     debugPrint(event.toString());
        //     //   },
        //     // );

        //     // final requestOptions = bw.RequestOptionsBuilder.acceptAllDevices(
        //     //     optionalServices: [bw.BluetoothDefaultServiceUUIDS.DEVICE_INFORMATION.uuid]);

        //     // try {
        //     //   final device = await bw.FlutterWebBluetooth.instance.requestDevice(requestOptions);
        //     //   await device.connect();
        //     //   _device.value.val.assignAll([device]);
        //     //   _device.refresh();

        //     //   // final printerManager = PrinterBluetoothManager();
        //     //   // // final prnt = PrinterBluetooth(bt.BluetoothDevice.fromJson({"id": "4A:3A:71:D9:A6:03", "name": "RPP02N"}));
        //     //   // final prnt = PrinterBluetooth(bt.BluetoothDevice.fromJson({"id": "4A:3A:71:D9:A6:03", "name": "RPP02N"}));
        //     //   // printerManager.selectPrinter(prnt);
        //     //   // final PosPrintResult res = await printerManager.printTicket(await StrukTiket().tiket());
        //     // } on bwjs.UserCancelledDialogError {

        //     // } on bwjs.DeviceNotFoundError {

        //     // }
        //   },
        // )
      ],
    );
  }
}
