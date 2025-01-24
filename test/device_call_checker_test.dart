import 'package:flutter_test/flutter_test.dart';
import 'package:device_call_checker/device_call_checker.dart';
import 'package:device_call_checker/device_call_checker_platform_interface.dart';
import 'package:device_call_checker/device_call_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceCallCheckerPlatform
    with MockPlatformInterfaceMixin
    implements DeviceCallCheckerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DeviceCallCheckerPlatform initialPlatform =
      DeviceCallCheckerPlatform.instance;

  test('$MethodChannelDeviceCallChecker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceCallChecker>());
  });

  test('getPlatformVersion', () async {
    DeviceCallChecker deviceCallCheckerPlugin = DeviceCallChecker();
    MockDeviceCallCheckerPlatform fakePlatform =
        MockDeviceCallCheckerPlatform();
    DeviceCallCheckerPlatform.instance = fakePlatform;

    // expect(await deviceCallCheckerPlugin.getPlatformVersion(), '42');
  });
}
