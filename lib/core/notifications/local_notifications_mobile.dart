import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _plugin = FlutterLocalNotificationsPlugin();

Future<void> init() async {
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const settings = InitializationSettings(android: android);
  await _plugin.initialize(settings);
}

Future<void> notify(int id, String title, String body) async {
  const details = NotificationDetails(
    android: AndroidNotificationDetails('general', 'General'),
  );
  await _plugin.show(id, title, body, details);
}
