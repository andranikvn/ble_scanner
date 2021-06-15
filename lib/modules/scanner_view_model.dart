import 'package:flutter_blue/flutter_blue.dart';

abstract class ScannerViewModel {
  Stream<bool> get isScanning;
  Stream<List<ScanResult>> get discoveredDevices;
  void startScan();
  void stopScan();
}