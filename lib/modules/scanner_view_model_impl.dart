import 'package:ble_scanner/modules/scanner_view_model.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScannerViewModelImpl implements ScannerViewModel {
  Stream<bool>? _isScanning;
  Stream<List<ScanResult>>? _discoveredDevices;
  ScannerViewModelImpl() {
    _isScanning = FlutterBlue.instance.isScanning;
    _discoveredDevices = FlutterBlue.instance.scanResults;
  }
  @override
  Stream<bool> get isScanning => _isScanning!;

  @override
  void startScan() {
    FlutterBlue.instance.startScan();
  }

  @override
  void stopScan() {
    FlutterBlue.instance.stopScan();
  }

  @override
  Stream<List<ScanResult>> get discoveredDevices => _discoveredDevices!;

}