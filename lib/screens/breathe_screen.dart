import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/breathwork_session.dart';
import '../providers/breathwork_provider.dart';
import '../providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manifesto_screen.dart';

class BreatheScreen extends ConsumerStatefulWidget {
  const BreatheScreen({super.key});

  @override
  ConsumerState<BreatheScreen> createState() => _BreatheScreenState();
}

class _BreatheScreenState extends ConsumerState<BreatheScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  int _countdown = 5;
  bool _isInhale = true;
  bool _isBreathing = false;
  int _breathCount = 0;
  Timer? _breathingTimer;
  int _remainingSeconds = 0;
  int _sessionsCompleted = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isInhale = !_isInhale;
          _countdown = 5;
          if (!_isInhale) {
            _breathCount++;
          }
        });
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _isInhale = !_isInhale;
          _countdown = 5;
        });
        _controller.forward();
      }
    });

    _controller.addListener(() {
      if (_isInhale) {
        setState(() {
          _countdown = 5 - (_controller.value * 5).floor();
        });
      } else {
        setState(() {
          _countdown = 5 - ((1 - _controller.value) * 5).floor();
        });
      }
    });

    _remainingSeconds = 60;
    _sessionsCompleted = 0;
  }

  void _startBreathing() {
    setState(() {
      _isBreathing = true;
      _breathCount = 0;
    });
    _controller.forward();
    _breathingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _stopBreathing();
          _sessionsCompleted++;
        }
      });
    });
  }

  void _stopBreathing() {
    _breathingTimer?.cancel();
    _controller.stop();
    setState(() {
      _isBreathing = false;
      _remainingSeconds = 60;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _breathingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Breathe & Reset'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManifestoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isBreathing) ...[
              Text(
                'Ready to begin',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ] else ...[
              // Text(
              //   _isInhale ? 'Inhale' : 'Exhale',
              //   style: GoogleFonts.playfairDisplay(
              //     fontSize: 32,
              //     fontWeight: FontWeight.w600,
              //     color: Theme.of(context).colorScheme.primary,
              //   ),
              // ),
            ],
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isBreathing ? _scaleAnimation.value : 1.0,
                  child: Opacity(
                    opacity: _isBreathing ? _opacityAnimation.value : 1.0,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.2),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isBreathing
                                  ? (_isInhale
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward)
                                  : Icons.self_improvement,
                              size: 48,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            if (_isBreathing) ...[
                              const SizedBox(height: 8),
                              Text(
                                _isInhale ? 'Inhale' : 'Exhale',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (_isBreathing) ...[
              const SizedBox(height: 20),
              Text(
                '$_countdown',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Breath Count: $_breathCount',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Time Remaining: $_remainingSeconds seconds',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.8),
                ),
              ),
            ] else ...[
              const SizedBox(height: 40),
              Text(
                'Take a moment to breathe and reset',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.8),
                ),
              ),
            ],
            const SizedBox(height: 32),
            if (!_isBreathing)
              ElevatedButton(
                onPressed: _startBreathing,
                child: const Text('Start Breathing'),
              )
            else
              ElevatedButton(
                onPressed: _stopBreathing,
                child: const Text('Stop'),
              ),
          ],
        ),
      ),
    );
  }
}
