import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize(
      'resource://drawable/res_pin_png',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Notifications',
            channelDescription: 'All Notifications',
            playSound: true
        )
      ]);

  runApp(
    EasyDynamicThemeWidget(
      child: const AppTheme(),
    ),
  );
}


