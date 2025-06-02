import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preferences',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 24),
              _buildSection(context, 'Notifications', [
                _buildSwitchTile(
                  context,
                  'Daily Check-in Reminders',
                  'Get gentle reminders to check in with yourself',
                  true,
                  (value) {
                    // TODO: Implement notification settings
                  },
                ),
                _buildSwitchTile(
                  context,
                  'Breathing Session Reminders',
                  'Reminders to take mindful breathing breaks',
                  false,
                  (value) {
                    // TODO: Implement notification settings
                  },
                ),
              ]),
              const SizedBox(height: 32),
              _buildSection(context, 'Privacy', [
                _buildSwitchTile(
                  context,
                  'Anonymous Mode',
                  'Share in Support Circle anonymously by default',
                  true,
                  (value) {
                    // TODO: Implement privacy settings
                  },
                ),
              ]),
              const SizedBox(height: 32),
              _buildSection(context, 'About', [
                _buildListTile(context, 'Version', '1.0.0', onTap: () {}),
                _buildListTile(
                  context,
                  'Terms of Service',
                  '',
                  onTap: () {
                    // TODO: Navigate to Terms of Service
                  },
                ),
                _buildListTile(
                  context,
                  'Privacy Policy',
                  '',
                  onTap: () {
                    // TODO: Navigate to Privacy Policy
                  },
                ),
              ]),
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement sign out
                  },
                  child: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Card(child: Column(children: children)),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    String trailing, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing:
          trailing.isNotEmpty
              ? Text(
                trailing,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.6),
                ),
              )
              : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
