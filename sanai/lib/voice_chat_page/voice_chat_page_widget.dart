import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoiceChatPageWidget extends StatefulWidget {
  const VoiceChatPageWidget({super.key});

  static String routeName = 'VoiceChatPage';
  static String routePath = '/voiceChatPage';

  @override
  State<VoiceChatPageWidget> createState() => _VoiceChatPageWidgetState();
}

class _VoiceChatPageWidgetState extends State<VoiceChatPageWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;
  bool _isRecording = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1FCFF),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Top bar with back button and title
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9F0F9),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF105A4A),
                        size: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: Text(
                'Voice Chat',
                style: GoogleFonts.interTight(
                  color: const Color(0xFF105A4A),
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.0,
                ),
              ),
            ),

            const Spacer(),

            // Glowing pulsing circle
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow ring 3
                    Container(
                      width: 260.0 * _pulseAnimation.value,
                      height: 260.0 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x158BC6D7),
                      ),
                    ),
                    // Outer glow ring 2
                    Container(
                      width: 220.0 * _pulseAnimation.value,
                      height: 220.0 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x258BC6D7),
                      ),
                    ),
                    // Outer glow ring 1
                    Container(
                      width: 180.0 * _pulseAnimation.value,
                      height: 180.0 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x408BC6D7),
                      ),
                    ),
                    // Main circle
                    Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFF8BC6D7),
                          ],
                          stops: [0.2, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x608BC6D7),
                            blurRadius: 30.0,
                            spreadRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 40.0),

            // Sound wave bars
            AnimatedBuilder(
              animation: _waveAnimation,
              builder: (context, child) {
                final List<double> heights = [
                  20.0,
                  35.0 * _waveAnimation.value,
                  50.0 * _waveAnimation.value,
                  35.0 * _waveAnimation.value,
                  20.0,
                  35.0 * _waveAnimation.value,
                  50.0 * _waveAnimation.value,
                  35.0 * _waveAnimation.value,
                  20.0,
                ];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: heights.map((h) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 5.0,
                        height: h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8BC6D7),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const Spacer(),

            // Bottom buttons
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cancel button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9F0F9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8BC6D7).withOpacity(0.3),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF105A4A),
                        size: 24.0,
                      ),
                    ),
                  ),

                  const SizedBox(width: 24.0),

                  // Main mic button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isRecording = !_isRecording;
                        if (_isRecording) {
                          _pulseController.repeat(reverse: true);
                          _waveController.repeat(reverse: true);
                        } else {
                          _pulseController.stop();
                          _waveController.stop();
                        }
                      });
                    },
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8BC6D7),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8BC6D7).withOpacity(0.5),
                            blurRadius: 20.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isRecording ? Icons.mic : Icons.mic_none,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                  ),

                  const SizedBox(width: 24.0),

                  // Confirm button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9F0F9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8BC6D7).withOpacity(0.3),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFF105A4A),
                        size: 24.0,
                      ),
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