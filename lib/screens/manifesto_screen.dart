import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ManifestoScreen extends ConsumerWidget {
  const ManifestoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Haven Manifesto'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Core Values',
                style: GoogleFonts.playfairDisplay(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _buildManifestoCard(
                context,
                'We grow, not compare',
                'Your journey is unique. Focus on your own growth and celebrate your progress.',
                Icons.trending_up,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildManifestoCard(
                context,
                'We hold space, not pressure',
                'This is a safe space to be yourself, without judgment or expectations.',
                Icons.self_improvement,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildManifestoCard(
                context,
                'We are the light we seek',
                'Your presence and support make this community shine brighter.',
                Icons.lightbulb,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildManifestoCard(
                context,
                'Haven is 100% free',
                'No ads. No subscriptions. No data collection.',
                Icons.favorite,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildManifestoCard(
                context,
                'Your privacy matters',
                'Your thoughts and feelings are private. We never share your data with third parties.',
                Icons.lock,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildManifestoCard(
                context,
                'Community support',
                'Connect with others who understand. Share your journey and support others in theirs.',
                Icons.people,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildManifestoCard(
                context,
                'Continuous growth',
                'We\'re constantly improving to better serve your mental health needs.',
                Icons.trending_up,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Card(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Thank you for being part of our community',
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'Thank you for being part of our community',
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManifestoCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
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
                icon,
                size: MediaQuery.of(context).size.width * 0.06,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Theme.of(
                        context,
                      ).colorScheme.onBackground.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
