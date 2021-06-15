import 'package:ble_scanner/modules/scanner_view_model_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


class DiscoveredDevices extends StatelessWidget {
  DiscoveredDevices({Key? key}) : super(key: key);
  ScannerViewModelImpl _scannerViewModelImpl = ScannerViewModelImpl();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
      initialData: BluetoothState.off,
      builder: (context, snapshot) {
        print(snapshot.data);
        if(snapshot.data == BluetoothState.on)
        return Scaffold(
          appBar: AppBar(
            title: Text("Discovered Devices"),
            centerTitle: false,
          ),
          floatingActionButton: StreamBuilder<bool>(
            stream: _scannerViewModelImpl.isScanning,
            initialData: false,
            builder: (context, snapshot) {
              return FloatingActionButton(
                onPressed: () {
                  if(snapshot.data!) _scannerViewModelImpl.stopScan();
                  else _scannerViewModelImpl.startScan();
                },
                child: Icon(snapshot.data! ? Icons.stop : Icons.search),
              );
            }
          ),
          body: StreamBuilder(
            stream: _scannerViewModelImpl.discoveredDevices,
            initialData: <ScanResult>[],
            builder: (context, snapshot) {
              List<ScanResult> items = snapshot.data as List<ScanResult>;
              return Container(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(items[index].device.name),
                      subtitle: Text(items[index].device.id.id),
                    )),
              );
            },
          ),
        );
        else return _bluetoothDisabled(snapshot.data!);
      }
    );
  }

  Widget _bluetoothDisabled(BluetoothState state) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Bluetooth state is $state"),
        ),
      ),
    );

  }
}
