import 'package:device_call_checker/device_call_checker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// The main entry point of the application.
void main() {
  runApp(const MyApp());
}

/// A stateless widget that represents the main application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CallCheckerScreen(),
    );
  }
}

/// A stateful widget that represents the screen for checking the device's call status.
class CallCheckerScreen extends StatefulWidget {
  const CallCheckerScreen({super.key});

  @override
  _CallCheckerScreenState createState() => _CallCheckerScreenState();
}

/// The state class for [CallCheckerScreen].
class _CallCheckerScreenState extends State<CallCheckerScreen> {
  /// The current call status of the device.
  String callStatus = "Unknown";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Call Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Call Status: $callStatus',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkCallState,
                child: const Text('Check Call State'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Checks the current call state of the device.
  ///
  /// Requests phone permission if not already granted. If permission is denied,
  /// updates the call status to "Permission Denied". If permission is granted,
  /// checks if the device is currently in a call and updates the call status accordingly.
  Future<void> _checkCallState() async {
    PermissionStatus status = await _requestPhonePermission();
    if (status == PermissionStatus.denied) {
      _updateCallStatus("Permission Denied");
      return;
    }

    try {
      final isInCall = await DeviceCallChecker.isDeviceInCall();
      _updateCallStatus(
          isInCall ? "Device is in a call" : "Device is not in a call");
    } catch (e) {
      _updateCallStatus("Error: ${e.toString()}");
    }
  }

  /// Requests phone permission from the user.
  ///
  /// If the permission is denied, requests the permission again. If the permission
  /// is permanently denied, opens the app settings.
  ///
  /// Returns the current [PermissionStatus].
  Future<PermissionStatus> _requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.phone.request();
    }
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }

    return status;
  }

  /// Updates the call status and refreshes the UI.
  ///
  /// Takes a [String] [status] which represents the new call status.
  void _updateCallStatus(String status) {
    setState(() {
      callStatus = status;
    });
  }
}
