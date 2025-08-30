import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/guards.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  UserRole role = UserRole.admin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(tr('login'), style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                TextField(controller: _email, decoration: InputDecoration(labelText: tr('email'))),
                TextField(controller: _pass, decoration: InputDecoration(labelText: tr('password')), obscureText: true),
                const SizedBox(height: 12),
                DropdownButton<UserRole>(value: role, isExpanded: true, items: UserRole.values.map((r) => DropdownMenuItem(value: r, child: Text(r.name))).toList(), onChanged: (v) { setState(() { role = v!; }); }),
                const SizedBox(height: 12),
                FilledButton(onPressed: () {
                  ref.read(authProvider.notifier).login(role: role, token: 'demo-token');
                  context.go('/');
                }, child: Text(tr('login'))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
