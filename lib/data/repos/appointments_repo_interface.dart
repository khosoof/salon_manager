// تعریف صرفاً قراردادها (هیچ وابستگی به Drift یا Flutter ندارد)
abstract class AppointmentEntity {
  int get id;
  DateTime get start;
  DateTime get end;
  String get status;
  String get branch;
}

abstract class AppointmentsRepo {
  Future<List<AppointmentEntity>> list();
  Future<int> quickCreate();
}
