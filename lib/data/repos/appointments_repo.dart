// یک نقطه‌ی ورودی واحد: بر اساس پلتفرم، پیاده‌سازی مناسب را برمی‌گرداند.
import 'appointments_repo_interface.dart';
import 'appointments_repo_io.dart'
  if (dart.library.html) 'appointments_repo_web.dart' as impl;

export 'appointments_repo_interface.dart';

AppointmentsRepo makeAppointmentsRepo() => impl.AppointmentsRepoImpl();
