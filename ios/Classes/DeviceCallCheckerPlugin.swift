
/// Import necessary modules
import Flutter
import UIKit
import CallKit

/// Public class that implements the FlutterPlugin protocol
public class DeviceCallCheckerPlugin: NSObject, FlutterPlugin {
  
  /// Registers the plugin with the Flutter plugin registrar
  /// - Parameter registrar: The Flutter plugin registrar
  public static func register(with registrar: FlutterPluginRegistrar) {
    /// Creates a Flutter method channel with the specified name and binary messenger
    let channel = FlutterMethodChannel(name: "device_call_checker", binaryMessenger: registrar.messenger())
    /// Creates an instance of the plugin
    let instance = DeviceCallCheckerPlugin()
    /// Adds the method call delegate to the registrar
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  /// Handles method calls from the Flutter side
  /// - Parameters:
  ///   - call: The Flutter method call
  ///   - result: The Flutter result callback
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    /// Checks if the method called is "isDeviceInCall"
    if call.method == "isDeviceInCall" {
      /// Calls the checkCallState method and returns the result
      let isInCall = self.checkCallState()
      result(isInCall)
    } else {
      /// Returns not implemented for other methods
      result(FlutterMethodNotImplemented)
    }
  }

  /// Checks the current call state of the device
  /// - Returns: A boolean indicating whether the device is currently in a call
  private func checkCallState() -> Bool {
    /// Creates a call observer
    let callObserver = CXCallObserver()
    /// Gets the current calls
    let calls = callObserver.calls
    /// Returns true if there is at least one call that has not ended
    return calls.contains { $0.hasEnded == false }
  }
}
