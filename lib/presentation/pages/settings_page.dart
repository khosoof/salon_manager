import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr())),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('dark_mode'.tr()),
            value: mode == ThemeMode.dark,
            onChanged: (v) async {
              ref.read(themeModeProvider.notifier)
                 .state = v ? ThemeMode.dark : ThemeMode.light;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('theme_mode', v ? 'dark' : 'light');
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text('language_fa'.tr()),
            trailing: context.locale.languageCode == 'fa'
                ? const Icon(Icons.check)
                : null,
            onTap: () => context.setLocale(const Locale('fa')),
          ),
          ListTile(
            title: Text('language_en'.tr()),
            trailing: context.locale.languageCode == 'en'
                ? const Icon(Icons.check)
                : null,
            onTap: () => context.setLocale(const Locale('en')),
          ),
        ],
      ),
    );
  }
}
