import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'faq_a3_model.dart';
export 'faq_a3_model.dart';

class FaqA3Widget extends StatefulWidget {
  const FaqA3Widget({super.key});

  static String routeName = 'FAQ_A3';
  static String routePath = '/faqA3';

  @override
  State<FaqA3Widget> createState() => _FaqA3WidgetState();
}

class _FaqA3WidgetState extends State<FaqA3Widget> {
  late FaqA3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FaqA3Model());

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
                        'How is the drawing determine\n my psychological state?',
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
                      alignment: const AlignmentDirectional(-1.01, -0.97),
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                  child: Container(
                    width: 350.0,
                    height: 339.4,
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
                            'In this test, we ask you to draw something simple that expresses your current feelings, such as a face, a color, or symbols that represent your state.\n\n After you submit the drawing, the system analyzes it based on the colors, lines, and style of expression, then links it to your previous responses in the application.\n',
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
