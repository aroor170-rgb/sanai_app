import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'faq_a1_model.dart';
export 'faq_a1_model.dart';

class FaqA1Widget extends StatefulWidget {
  const FaqA1Widget({super.key});

  static String routeName = 'FAQ_A1';
  static String routePath = '/faqA1';

  @override
  State<FaqA1Widget> createState() => _FaqA1WidgetState();
}

class _FaqA1WidgetState extends State<FaqA1Widget> {
  late FaqA1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FaqA1Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.safePop();
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
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(1.26, -1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/5978987448815963208_120-removebg-preview.png',
                          width: 139.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.3, 0.76),
                      child: Container(
                        width: 300.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/IMG_4463_(1).jpeg',
                                  width: 350.0,
                                  height: 554.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.19, -0.89),
                      child: Text(
                        'how dose the mood test work?',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.interTight(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: const Color(0xFF3F5C57),
                              fontSize: 21.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 690.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  100.0, 0.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.hearing_disabled,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                  Icon(
                                    Icons.zoom_in,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                  Icon(
                                    Icons.zoom_out,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                  Icon(
                                    Icons.volume_up_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                  Icon(
                                    Icons.mic,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                ].divide(const SizedBox(width: 10.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1.02, -0.93),
                      child: FlutterFlowIconButton(
                        borderRadius: 29.0,
                        buttonSize: 49.0,
                        icon: Icon(
                          Icons.arrow_back,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 29.0,
                        ),
                        onPressed: () async {
                          context.safePop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-0.13, 0.08),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 155.0),
                  child: Container(
                    width: 350.0,
                    height: 359.85,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFB8DFE7),
                          FlutterFlowTheme.of(context).primaryBackground
                        ],
                        stops: const [0.0, 1.0],
                        begin: const AlignmentDirectional(0.0, -1.0),
                        end: const AlignmentDirectional(0, 1.0),
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, -0.59),
                          child: Text(
                            'The mood test consists of a set of simple questions where you are asked to choose an emoji that expresses your current feeling in different situations.\n\n After you answer the questions, the system analyzes and compiles your choices to determine your overall mood\n\nfor example:\nHappy, Moody, Sad, or Calm.\n\nAt the end, you will see the result along with a short statement and a tip tailored to your mood to help you improve or maintain it!',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: const Color(0xFF3F5C57),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
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
}
