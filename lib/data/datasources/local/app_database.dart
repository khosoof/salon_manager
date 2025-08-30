import 'package:drift/drift.dart';
import 'connection/connection.dart';

part 'app_database.g.dart';

// ---------- Tables ----------
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get loyaltyPoints => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Services extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get durationMin => integer().withDefault(const Constant(30))();
  IntColumn get priceRials => integer().withDefault(const Constant(0))();
  BoolColumn get peakPricing => boolean().withDefault(const Constant(false))();
}

class Staff extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get role => text().withDefault(const Constant('stylist'))();
  RealColumn get commissionPercent => real().withDefault(const Constant(0.0))();
}

class Appointments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get staffId => integer().references(Staff, #id)();
  IntColumn get serviceId => integer().references(Services, #id)();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get branch => text().withDefault(const Constant('main'))();
  TextColumn get changeLog => text().withDefault(const Constant('[]'))();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get appointmentId => integer().references(Appointments, #id)();
  IntColumn get totalRials => integer().withDefault(const Constant(0))();
  TextColumn get paymentStatus => text().withDefault(const Constant('unpaid'))();
  TextColumn get trackingCode => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class OrderItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(Orders, #id)();
  TextColumn get title => text()();
  IntColumn get qty => integer().withDefault(const Constant(1))();
  IntColumn get unitPriceRials => integer().withDefault(const Constant(0))();
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entity => text()(); // appointments/customers/...
  TextColumn get op => text()();     // create/update/delete
  TextColumn get payload => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get needsReview => boolean().withDefault(const Constant(false))();
}

// ---------- Database ----------
@DriftDatabase(
  tables: [Customers, Services, Staff, Appointments, Orders, OrderItems, SyncQueue],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  // CRUD نمونه
  Future<int> addCustomer(CustomersCompanion data) => into(customers).insert(data);
  Future<List<Customer>> allCustomers() => select(customers).get();

  Stream<List<Appointment>> watchAppointments() =>
      (select(appointments)..orderBy([(t) => OrderingTerm(expression: t.start)])).watch();

  Future<int> enqueue(String entity, String op, String payload) =>
      into(syncQueue).insert(
        SyncQueueCompanion.insert(entity: entity, op: op, payload: payload),
      );

  Stream<int> watchQueueCount() => select(syncQueue).watch().map((rows) => rows.length);

  // ---------- Demo seed ----------
  Future<(int customerId, int staffId, int serviceId)> _ensureSeed() async {
    // مشتری
    var c = await (select(customers)..limit(1)).getSingleOrNull();
    final customerId = c?.id ??
        await into(customers).insert(
          CustomersCompanion.insert(name: 'مهمان', phone: const Value('')),
        );

    // کارمند
    var s = await (select(staff)..limit(1)).getSingleOrNull();
    final staffId = s?.id ??
        await into(staff).insert(
          StaffCompanion.insert(name: 'آرایشگر آزمایشی', role: const Value('stylist')),
        );

    // سرویس
    var sv = await (select(services)..limit(1)).getSingleOrNull();
    final serviceId = sv?.id ??
        await into(services).insert(
          ServicesCompanion.insert(
            title: 'اصلاح مردانه',
            durationMin: const Value(30),
            priceRials: const Value(300000),
          ),
        );

    return (customerId, staffId, serviceId);
  }

  Future<void> seedDemo() async {
    await _ensureSeed();
  }

  // ---------- Quick appointment ----------
  Future<int> createQuickAppointment() async {
    final seed = await _ensureSeed();
    final now = DateTime.now();
    final start = now.add(const Duration(minutes: 5));
    final end = start.add(const Duration(minutes: 30));
    return into(appointments).insert(
      AppointmentsCompanion.insert(
        customerId: seed.$1,
        staffId: seed.$2,
        serviceId: seed.$3,
        start: start,
        end: end,
        status: const Value('confirmed'),
        branch: const Value('main'),
      ),
    );
  }
}
