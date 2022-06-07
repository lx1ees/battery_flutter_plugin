import 'package:flutter/material.dart';

import 'package:battery_indicator_plugin/battery_indicator_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? _batteryLevel;

  @override
  void initState() {
    super.initState();
    BatteryIndicatorPlugin(onBatteryPowerCallback: _onBatteryPowerChanged)
        .getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battery indicator'),
        ),
        body: Center(
          child: Text('Battery level: ${_batteryLevel ?? 'unknown'} %'),
        ),
      ),
    );
  }

  void _onBatteryPowerChanged(int value) {
    if ((_batteryLevel ?? 0) > value) {
      _showWarningSnakbar();
    }
    setState(() {
      _batteryLevel = value;
    });
  }

  void _showWarningSnakbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Уровень заряда снизился'),
      ),
    );
  }
}
