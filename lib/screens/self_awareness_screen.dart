import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SelfAwarenessScreen extends ConsumerWidget {
  const SelfAwarenessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Self-Awareness Guide',
          style: GoogleFonts.playfairDisplay(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                'Understanding Yourself',
                style: GoogleFonts.playfairDisplay(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _buildSection(
                context,
                'Understanding Your Emotions',
                'Start by recognizing and naming your emotions. Ask yourself: "What am I feeling right now?" and "Why am I feeling this way?"',
                Icons.psychology,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildSection(
                context,
                'Journaling Tips',
                'Write freely without judgment. Focus on your thoughts, feelings, and experiences. Use prompts like "Today I felt..." or "I noticed..."',
                Icons.edit_note,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildSection(
                context,
                'Mindful Breathing',
                'Take deep breaths to center yourself. Notice how your body feels with each breath. This helps you stay present and aware.',
                Icons.self_improvement,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildSection(
                context,
                'Creating Meaningful Content',
                'Share your journey authentically. Focus on your experiences, learnings, and growth. Remember, vulnerability can inspire others.',
                Icons.lightbulb,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildSection(
                context,
                'Supporting Others',
                'Listen actively and offer empathy. Share your experiences when relevant, but always prioritize understanding others\' perspectives.',
                Icons.favorite,
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
    String content,
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
                    content,
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
