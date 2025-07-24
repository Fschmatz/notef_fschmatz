import 'package:async_redux/async_redux.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:notef_fschmatz/redux/actions.dart';
import 'package:notef_fschmatz/redux/app_state.dart';

import 'app_theme.dart';

final Store<AppState> store = Store<AppState>(
  initialState: AppState.initialState(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize('resource://drawable/res_pin_png',
      [NotificationChannel(channelKey: 'basic_channel', channelName: 'Notifications', channelDescription: 'All Notifications', playSound: true)]);

  await store.dispatch(LoadNotesAction());

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: EasyDynamicThemeWidget(
        child: const AppTheme(),
      ),
    ),
  );
}
