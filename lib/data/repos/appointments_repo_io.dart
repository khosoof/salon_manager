import '../datasources/local/app_database.dart';
import 'appointments_repo_interface.dart';

class _DbAppt implements AppointmentEntity {
  _DbAppt(this.row);
  final Appointment row;
  @override int get id => row.id;
  @override DateTime get start => row.start;
  @override DateTime get end => row.end;
  @override String get status => row.status;
  @override String get branch => row.branch;
}

class AppointmentsRepoImpl implements AppointmentsRepo {
  final _db = AppDatabase();

  @override
  Future<List<AppointmentEntity>> list() async {
    final rows = await _db.select(_db.appointments).get();
    return rows.map(_DbAppt.new).toList();
  }

  @override
  Future<int> quickCreate() => _db.createQuickAppointment();
}
