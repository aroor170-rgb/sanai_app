import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'voice_chat_page_model.dart';
export 'voice_chat_page_model.dart';

class VoiceChatPageWidget extends StatefulWidget {
  const VoiceChatPageWidget({super.key});

  static String routeName = 'voice_chat_page';
  static String routePath = '/voiceChatPage';

  @override
  State<VoiceChatPageWidget> createState() => _VoiceChatPageWidgetState();
}

class _VoiceChatPageWidgetState extends State<VoiceChatPageWidget> {
  late VoiceChatPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceChatPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1FCFF),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0, 1.74),
              child: Container(
                width: double.infinity,
                height: 720.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1FCFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(70.0),
                    topRight: Radius.circular(70.0),
                  ),
                ),
                child: const Icon(
                  Icons.graphic_eq_outlined,
                  color: Color(0xFF8BC6D7),
                  size: 100.0,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.05, -0.79),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/Screenshot_1447-09-02_at_4.55.44_AM.png',
                  width: 299.2,
                  height: 335.4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.54, 0.84),
              child: FlutterFlowIconButton(
                borderRadius: 50.0,
                buttonSize: 65.1,
                fillColor: const Color(0xFF8BC6D7),
                icon: Icon(
                  Icons.check,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pushNamed(Result1Widget.routeName);
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.03, 0.65),
              child: FlutterFlowIconButton(
                borderRadius: 50.0,
                buttonSize: 94.85,
                fillColor: const Color(0xFF8BC6D7),
                icon: Icon(
                  Icons.mic,
                  color: FlutterFlowTheme.of(context).info,
                  size: 50.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.42, 0.85),
              child: FlutterFlowIconButton(
                borderRadius: 50.0,
                buttonSize: 65.1,
                fillColor: const Color(0xFF8BC6D7),
                icon: Icon(
                  Icons.clear_sharp,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.05, -1.0),
              child: Text(
                'Voice Chat',
                style: FlutterFlowTheme.of(context).displayMedium.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FlutterFlowTheme.of(context)
                            .displayMedium
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .displayMedium
                            .fontStyle,
                      ),
                      color: const Color(0xFF105A4A),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).displayMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).displayMedium.fontStyle,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
