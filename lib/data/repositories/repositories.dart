import 'dart:convert';
import 'package:drift/drift.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/api_service.dart';

class AppointmentRepository {
  final AppDatabase db;
  final MockApiService api;
  AppointmentRepository(this.db, this.api);

  Future<void> createAppointment({
    required int customerId,
    required int staffId,
    required int serviceId,
    required DateTime start,
    required DateTime end,
  }) async {
    await db.into(db.appointments).insert(AppointmentsCompanion.insert(
      customerId: customerId, staffId: staffId, serviceId: serviceId, start: start, end: end,
    ));
    await db.enqueue('appointments', 'create', jsonEncode({
      'customerId': customerId, 'staffId': staffId, 'serviceId': serviceId, 'start': start.toIso8601String(), 'end': end.toIso8601String(),
    }));
  }

  Stream<List<Appointment>> watchAll() => db.watchAppointments();
}

class SyncService {
  final AppDatabase db;
  final MockApiService api;
  SyncService(this.db, this.api);

  Future<int> flush() async {
    final all = await db.select(db.syncQueue).get();
    int done = 0;
    for (final item in all) {
      try {
        await api.push(item.entity, jsonDecode(item.payload) as Map<String, dynamic>);
        await (db.delete(db.syncQueue)..where((t) => t.id.equals(item.id))).go();
        done++;
      } catch (e) {
        await db.update(db.syncQueue).write(SyncQueueCompanion(needsReview: const Value(true)));
      }
    }
    return done;
  }
}
