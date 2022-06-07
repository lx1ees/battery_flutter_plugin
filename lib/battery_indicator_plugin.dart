import 'package:flutter/services.dart';

typedef OnBatteryPowerCallback = Function(int value);

class BatteryIndicatorPlugin {
  static const String _getBatteryPowerMethod = 'get_battery_power';
  static const String _onBatteryPowerChangedMethod = 'on_battery_power_changed';
  static const MethodChannel _channel = MethodChannel('battery_indicator');
  final OnBatteryPowerCallback _onBatteryPowerChanged;

  BatteryIndicatorPlugin({
    required OnBatteryPowerCallback onBatteryPowerCallback,
  }) : _onBatteryPowerChanged = onBatteryPowerCallback {
    _initBatteryIndicatorPlugin();
  }

  void _initBatteryIndicatorPlugin() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case _onBatteryPowerChangedMethod:
          _onBatteryPowerChanged(call.arguments);
          break;
      }
    });
  }

  Future<int> getBatteryLevel() async =>
      await _channel.invokeMethod(_getBatteryPowerMethod);
}
