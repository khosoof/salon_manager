import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/api_service.dart';
import '../../data/repositories/repositories.dart';

final dbProvider = Provider<AppDatabase>((ref) => AppDatabase());
final apiProvider = Provider<MockApiService>((ref) => MockApiService());
final syncServiceProvider = Provider<SyncService>((ref) => SyncService(ref.read(dbProvider), ref.read(apiProvider)));
final appointmentRepoProvider = Provider<AppointmentRepository>((ref) => AppointmentRepository(ref.read(dbProvider), ref.read(apiProvider)));

final queueCountProvider = StreamProvider<int>((ref) => ref.read(dbProvider).watchQueueCount());
