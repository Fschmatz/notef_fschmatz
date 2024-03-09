import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
      'resource://drawable/res_pin_png',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: '',
            defaultColor: const Color(0xFFFF965b),
            ),
      ],
      debug: true
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(
    EasyDynamicThemeWidget(
      child: const AppTheme(),
    ),
  );
}


