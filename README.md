# Device Call Checker

## Overview

Device Call Checker is a tool designed to monitor and verify device calls within your system. It ensures that all device interactions are logged and validated for accuracy and reliability.

## Features

- **Real-time Monitoring**: Continuously monitors device calls in real-time.
- **Logging**: Keeps a detailed log of all device interactions.
- **Validation**: Verifies the accuracy of each device call.
- **Alerts**: Sends notifications for any anomalies detected.

## Installation
To install Device Call Checker, follow these steps:

1. With Flutter :
    ```bash
    $ flutter pub add device_call_checker
    ```

## Usage

To start using Device Call Checker in your Flutter project, follow these steps:

1. Import the package in your Dart file:
    ```dart
    import 'package:device_call_checker/device_call_checker.dart';
    ```

2. Use the Device Call Checker to monitor device calls:
    ```dart
    Future<bool> someFunction() async{
    return await DeviceCallChecker.isDeviceInCall();
    }
    ```

For more detailed usage and examples, please refer to the official documentation.

## Contributing

We welcome contributions! Please read our [contributing guidelines](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, please reach out to us at [sajanbaisil12@gmail.com](mailto:sajanbaisil12@gmail.com).
