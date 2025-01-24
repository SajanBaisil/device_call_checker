import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_call_checker_platform_interface.dart';

/// An implementation of [DeviceCallCheckerPlatform] that uses method channels.
class MethodChannelDeviceCallChecker extends DeviceCallCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_call_checker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
