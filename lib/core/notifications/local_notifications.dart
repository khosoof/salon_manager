// هر پلتفرمی فایل خودش را پیاده‌سازی می‌کند:
import 'local_notifications_mobile.dart'
  if (dart.library.html) 'local_notifications_web.dart' as impl;

class LocalNotifications {
  static Future<void> init() => impl.init();
  static Future<void> notify(int id, String title, String body) =>
      impl.notify(id, title, body);
}
