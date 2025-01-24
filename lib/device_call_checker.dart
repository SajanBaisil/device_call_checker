import 'dart:async';

import 'package:flutter/services.dart';

class DeviceCallChecker {
  static const MethodChannel _channel = MethodChannel('device_call_checker');

  static Future<bool> isDeviceInCall() async {
    try {
      final bool isInCall = await _channel.invokeMethod('isDeviceInCall');
      return isInCall;
    } on PlatformException catch (e) {
      // Handle errors, such as missing permissions
      print("Error: ${e.message}");
      return false;
    }
  }
}
