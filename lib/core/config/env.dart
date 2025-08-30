// lib/core/config/env.dart
class AppEnv {
  final String appName;
  final String apiBaseUrl;
  const AppEnv({required this.appName, required this.apiBaseUrl});

  factory AppEnv.dev() => const AppEnv(
        appName: 'Salon Manager (Dev)',
        apiBaseUrl: 'http://localhost:8000',
      );

  factory AppEnv.stage() => const AppEnv(
        appName: 'Salon Manager (Stage)',
        apiBaseUrl: 'https://stage.example.com',
      );

  factory AppEnv.prod() => const AppEnv(
        appName: 'Salon Manager',
        apiBaseUrl: 'https://api.example.com',
      );
}
