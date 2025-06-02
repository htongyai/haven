import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/check_in.dart';
import '../providers/check_in_provider.dart';
import '../providers/user_provider.dart';

class DailyCheckInScreen extends ConsumerStatefulWidget {
  const DailyCheckInScreen({super.key});

  @override
  ConsumerState<DailyCheckInScreen> createState() => _DailyCheckInScreenState();
}

class _DailyCheckInScreenState extends ConsumerState<DailyCheckInScreen> {
  String? selectedMood;
  final TextEditingController _reflectionController = TextEditingController();

  final List<String> moods = [
    'Calm 😌',
    'Anxious 😰',
    'Grateful 🙏',
    'Tired 😴',
    'Hopeful 🌟',
    'Overwhelmed 😫',
    'Peaceful 🧘',
    'Excited 🎉',
  ];

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  void _submitCheckIn() {
    if (selectedMood == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a mood')));
      return;
    }

    final checkIn = CheckIn(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      mood: selectedMood!,
      reflectionText: _reflectionController.text,
    );

    ref.read(checkInsProvider.notifier).addCheckIn(checkIn);
    ref
        .read(userProvider.notifier)
        .updateGlowScore((ref.read(userProvider)?.glowScore ?? 0) + 10);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Daily Check-In',
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
                'How are you feeling today?',
                style: GoogleFonts.playfairDisplay(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _buildMoodSelector(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                'Reflection',
                style: GoogleFonts.playfairDisplay(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              TextField(
                controller: _reflectionController,
                maxLines: 5,
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
                decoration: InputDecoration(
                  hintText: 'Share your thoughts...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Theme.of(
                      context,
                    ).colorScheme.onBackground.withOpacity(0.6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitCheckIn,
                  child: Text(
                    'Submit',
                    style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w600,
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

  Widget _buildMoodSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          moods.map((mood) {
            final isSelected = mood == selectedMood;
            return ChoiceChip(
              label: Text(
                mood,
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedMood = selected ? mood : null;
                });
              },
            );
          }).toList(),
    );
  }
}
