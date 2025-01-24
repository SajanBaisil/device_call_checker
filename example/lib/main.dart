import 'package:device_call_checker/device_call_checker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CallCheckerScreen(),
    );
  }
}

class CallCheckerScreen extends StatefulWidget {
  const CallCheckerScreen({super.key});

  @override
  _CallCheckerScreenState createState() => _CallCheckerScreenState();
}

class _CallCheckerScreenState extends State<CallCheckerScreen> {
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

  Future<void> _checkCallState() async {
    if (!await _requestPhonePermission()) {
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

  Future<bool> _requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.phone.request();
    }

    return status.isGranted;
  }

  void _updateCallStatus(String status) {
    setState(() {
      callStatus = status;
    });
  }
}
