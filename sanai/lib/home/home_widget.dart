import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';
import '../utils/mood_storage.dart';
import '../widgets/mood_bar.dart';
import '../pagess/check_in_page.dart';
import '../../api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

 


@override
void initState() {
  super.initState();
  _model = createModel(context, () => HomeModel());

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final loggedIn = GoRouter.of(context).appState.loggedIn;
    if (!loggedIn) {
      debugPrint('Not logged in - skip calling backend');
      return;
    }

    try {
      final items = await ApiService.getItems();
      debugPrint('Items from backend: $items');
    } catch (e) {
      debugPrint('Error from backend: $e');
    }
  });
}

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -1.10),
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF8BC6D7), Color(0x218CF4E7)],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello....!',
                      style: GoogleFonts.ptSans(
                        color: const Color(0xFF105A4A),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(
                            color: Color(0xFF8BC6D7),
                            offset: Offset(2.0, 2.0),
                            blurRadius: 2.0,
                          )
                        ],
                      ),
                    ),
                    badges.Badge(
                      badgeContent: const Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      badgeColor: const Color(0xFFDC0808),
                      child: const Icon(
                        Icons.chat_bubble_outline_outlined,
                        color: Color(0xFF57636C),
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 110),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Here's how your mood has been this week",
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF606A85),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 14),
                      FutureBuilder<Map<MoodType, int>>(
                        future: MoodStorage.last7DaysCounts(),
                        builder: (context, snapshot) {
                          final counts = snapshot.data ??
                              {
                                MoodType.great: 0,
                                MoodType.good: 0,
                                MoodType.neutral: 0,
                                MoodType.sad: 0,
                                MoodType.awful: 0,
                              };

                          return MoodBar(
                            counts: counts,
                            onOpen: () async {
                              final changed = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CheckInPage()),
                              );

                              if (changed == true && context.mounted) {
                                setState(() {});
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      _buildCard(
                        context,
                        'Test',
                        'assets/images/WhatsApp_Image_2026-02-11_at_11.22.56_PM-removebg-preview.png',
                        () => context.pushNamed(TestWidget.routeName),
                        const [Color(0xB916C9FF), Color(0x0008DCC6)],
                      ),
                      const SizedBox(height: 18),
                      _buildCard(
                        context,
                        'Drawing',
                        'assets/images/WhatsApp_Image_2026-02-11_at_11.18.55_PM-removebg-preview.png',
                        () => context.pushNamed(DrawingWidget.routeName),
                        const [Color(0x67FF6AA4), Color(0x19FFA0F8)],
                      ),
                      const SizedBox(height: 18),
                      _buildCard(
                        context,
                        'Emotion detections',
                        'assets/images/WhatsApp_Image_2026-02-11_at_11.34.47_PM-removebg-preview.png',
                        () => context.pushNamed(CameraWidget.routeName),
                        const [Color(0x8BFCFF56), Color(0x20FFFFC6)],
                      ),
                      const SizedBox(height: 18),
                      _buildCard(
                        context,
                        'Daily Reminders',
                        'assets/images/WhatsApp_Image_2026-02-11_at_11.26.26_PM-removebg-preview.png',
                        () => context.pushNamed(RemindersWidget.routeName),
                        const [Color(0x4D5D39D2), Color(0x13B6A7EB)],
                      ),
                      const SizedBox(height: 18),
                      _buildCard(
                        context,
                        'Mental & Social guide',
                        'assets/images/WhatsApp_Image_2026-02-11_at_11.13.51_PM-removebg-preview.png',
                        () =>
                            context.pushNamed(MentalHealthGuidesWidget.routeName),
                        const [Color(0x9C56F7DD), Color(0x17FDE2CD)],
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

  Widget _buildCard(BuildContext context, String title, String image,
      VoidCallback onTap, List<Color> colors) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF287968),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}