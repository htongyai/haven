import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/check_in_provider.dart';
import '../providers/user_provider.dart';
import 'daily_check_in_screen.dart';
import 'journal_screen.dart';
import 'breathe_screen.dart';
import 'support_circle_screen.dart';
import 'manifesto_screen.dart';
import 'settings_screen.dart';
import 'self_awareness_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestCheckIn =
        ref.watch(checkInsProvider).isNotEmpty
            ? ref.read(checkInsProvider.notifier).getLatestCheckIn()
            : null;
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Haven'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Haven',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Your safe space for reflection',
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Theme.of(
                      context,
                    ).colorScheme.onBackground.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _buildManifestoButton(context),
                const SizedBox(height: 24),
                _buildDailyCheckIn(
                  context,
                  ref,
                  latestCheckIn,
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
                const SizedBox(height: 24),
                Text(
                  'Your Progress',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 8),
                _buildGlowMeter(
                  context,
                  user?.glowScore ?? 0,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                const SizedBox(height: 24),
                Text(
                  'Explore',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 8),
                _buildNavigationGrid(
                  context,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildManifestoButton(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ManifestoScreen()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Manifesto',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Discover our core values and mission',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyCheckIn(
    BuildContext context,
    WidgetRef ref,
    latestCheckIn,
  ) {
    final hasCheckedInToday =
        latestCheckIn != null &&
        latestCheckIn.date.year == DateTime.now().year &&
        latestCheckIn.date.month == DateTime.now().month &&
        latestCheckIn.date.day == DateTime.now().day;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: MediaQuery.of(context).size.width * 0.06,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Daily Check-in',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildCheckInBox(
                    context,
                    hasCheckedInToday
                        ? 'Update your mood 😊'
                        : 'How are you feeling? 😊',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DailyCheckInScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCheckInBox(
                    context,
                    'What\'s on your mind? 💭',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JournalScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildCheckInBox(
    BuildContext context,
    String text, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildGlowMeter(BuildContext context, int glowScore) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: MediaQuery.of(context).size.width * 0.06,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  'Your Glow',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (glowScore % 100) / 100,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                minHeight: 8,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              '$glowScore points',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        _buildNavigationCard(
          context,
          'Journal',
          Icons.book,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JournalScreen()),
          ),
        ),
        _buildNavigationCard(
          context,
          'Breathe & Reset',
          Icons.self_improvement,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BreatheScreen()),
          ),
        ),
        _buildNavigationCard(
          context,
          'Support Circle',
          Icons.favorite,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SupportCircleScreen(),
            ),
          ),
        ),
        _buildNavigationCard(
          context,
          'Self-Awareness Guide',
          Icons.psychology,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelfAwarenessScreen(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    String subtitle = '';
    switch (title) {
      case 'Journal':
        subtitle = 'Record your thoughts and feelings';
        break;
      case 'Breathe & Reset':
        subtitle = 'Guided breathing exercises';
        break;
      case 'Support Circle':
        subtitle = 'Share and connect with others';
        break;
      case 'Self-Awareness Guide':
        subtitle = 'Learn to understand yourself';
        break;
    }

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: MediaQuery.of(context).size.width * 0.06,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.002),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.6),
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
