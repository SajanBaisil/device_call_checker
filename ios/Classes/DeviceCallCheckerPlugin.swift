import Flutter
import UIKit
import CallKit

public class SwiftDeviceCallCheckerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "device_call_checker", binaryMessenger: registrar.messenger())
        let instance = SwiftDeviceCallCheckerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "isDeviceInCall" {
            result(isDeviceInCall())
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func isDeviceInCall() -> Bool {
        let callObserver = CXCallObserver()
        let calls = callObserver.calls
        return calls.contains { $0.hasEnded == false }
    }
}
