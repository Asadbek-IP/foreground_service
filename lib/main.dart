import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static const platform = const MethodChannel('service_channel');
  String _serverState = 'Did not make the call yet';

  Future<void> checkServiceRunning() async {
    try {
      final result = await platform.invokeMethod('checkServiceRunning');
      print("Result $result");
      setState(() {
        if (result) {
          _serverState = "Service Running";
        }
      });
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  Future<void> _startService() async {
    try {
      final result = await platform.invokeMethod('startExampleService');
      setState(() {
        _serverState = result;
      });
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  Future<void> _stopService() async {
    try {
      final result = await platform.invokeMethod('stopExampleService');
      setState(() {
        _serverState = result;
      });
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  @override
  void initState() {
    super.initState();
    checkServiceRunning();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(_serverState),
              ElevatedButton(
                child: Text('Start Service'),
                onPressed: _startService,
              ),
              ElevatedButton(
                child: Text('Stop Service'),
                onPressed: _stopService,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
