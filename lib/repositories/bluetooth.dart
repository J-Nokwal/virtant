import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart' as ScanBlue;

class Bluetooth {
  // FlutterBluetoothSerial? bInstance;
  // Bluetooth() {
  //   bInstance = FlutterBluetoothSerial.instance;
  // }
  // Future<String> getAddres() async {
  //   return await this.bInstance!.address;
  // }

  // Future<String> getName() async {
  //   return await this.bInstance!.name;
  // }

  Future<bool> isNearBy(
      {@required String? bluetoothName,
      @required String? bluetoothAddress}) async {
    //may have problems
    ScanBlue.BluetoothDevice bd;
    bd = ScanBlue.BluetoothDevice(bluetoothName!, bluetoothAddress!);
    return bd.nearby;
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _data = '';
//   bool _scanning = false;
//   FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();

//   @override
//   void initState() {
//     super.initState();
    

//     _bluetooth.devices.listen((device) {
      // setState(() {
  //       _data += device.name + ' (${device.address})\n';
  //       print(
  //           "${device.name} : ${device.address} : ${device.paired} : ${device.nearby} ");
  //     });
  //   });
  //   _bluetooth.scanStopped.listen((device) {
  //     setState(() {
  //       _scanning = false;
  //       _data += 'scan stopped\n';
  //     });
  //   });
  // }


  // @override
  // Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[

//             Expanded(child: Text(_data)),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: Row(
//                   children: [
//                     ElevatedButton(
//                         onPressed: () async {
//                           FlutterBluetoothSerial a =
//                               FlutterBluetoothSerial.instance;
//                           String b = await a.address;
//                           print(b);
//                           print(await a.isEnabled);
//                           print(await a.isDiscoverable);
//                           print(await a.state);
//                           Future<BluetoothBondState> as =
//                               a.getBondStateForAddress('00:00:AB:CE:32:7F');
//                           as.asStream().listen((event) {
//                             print("aaaaa");
//                             print(event.toString());
//                           });
//                           a.requestEnable();
//                           a.startDiscovery().listen((event) {
//                             debugPrint(event.device.name);
//                             // print(event);
//                           });
//                         },
//                         child: Text("Get adress")),
//                     ElevatedButton(
//                         child: Text(_scanning ? 'Stop scan' : 'Start scan'),
//                         onPressed: () async {
//                           try {
//                             if (_scanning) {
//                               await _bluetooth.stopScan();
//                               debugPrint("scanning stoped");
//                               setState(() {
//                                 _data = '';
//                               });
//                             } else {
//                               await _bluetooth.startScan(pairedDevices: false);
//                               debugPrint("scanning started");
//                               setState(() {
//                                 _scanning = true;
//                               });
//                             }
//                           } on PlatformException catch (e) {
//                             debugPrint(e.toString());
//                           }
//                         }),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
