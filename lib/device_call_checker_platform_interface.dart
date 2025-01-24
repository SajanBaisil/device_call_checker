import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_call_checker_method_channel.dart';

abstract class DeviceCallCheckerPlatform extends PlatformInterface {
  /// Constructs a DeviceCallCheckerPlatform.
  DeviceCallCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceCallCheckerPlatform _instance = MethodChannelDeviceCallChecker();

  /// The default instance of [DeviceCallCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceCallChecker].
  static DeviceCallCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceCallCheckerPlatform] when
  /// they register themselves.
  static set instance(DeviceCallCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
