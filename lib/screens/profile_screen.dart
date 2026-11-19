import 'package:flutter/material.dart';

import 'account_widgets.dart';
import '../models/my_activity.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.onMyAnnouncements});
  final VoidCallback? onMyAnnouncements;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 440,
                  minHeight: constraints.maxHeight > 48
                      ? constraints.maxHeight - 48
                      : 0,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: colors.surfaceContainerHighest,
                          child: Icon(
                            Icons.person_outline,
                            size: 64,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        DemoAccount.fullName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DemoAccount.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Account Information',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colors.outlineVariant),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            _information(
                              context,
                              'Full Name',
                              DemoAccount.fullName,
                            ),
                            Divider(height: 1, color: colors.outlineVariant),
                            _information(
                              context,
                              'Student ID',
                              DemoAccount.studentId,
                            ),
                            Divider(height: 1, color: colors.outlineVariant),
                            _information(
                              context,
                              'University Email',
                              DemoAccount.email,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'My Activity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _activity(
                              context,
                              DemoAccount.created,
                              'Created',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _activity(
                              context,
                              MyActivity.joinedIds.value.length,
                              'Joined',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Spacer(),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          DemoAccount.reset();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (_) => false,
                          );
                        },
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _information(BuildContext context, String label, String value) =>
      Padding(
        padding: const EdgeInsets.all(14),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

  Widget _activity(BuildContext context, int count, String label) => Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
    ),
    child: InkWell(
      onTap: onMyAnnouncements,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    ),
  );
}
