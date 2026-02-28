import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'camer_i_n_t_model.dart';
export 'camer_i_n_t_model.dart';

class CamerINTWidget extends StatefulWidget {
  const CamerINTWidget({super.key});

  static String routeName = 'camerINT';
  static String routePath = '/camerINT';

  @override
  State<CamerINTWidget> createState() => _CamerINTWidgetState();
}

class _CamerINTWidgetState extends State<CamerINTWidget> {
  late CamerINTModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CamerINTModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.pushNamed(AboutWidget.routeName);
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
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0, -1.22),
              child: Container(
                width: double.infinity,
                height: 190.24,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8BC6D7), Color(0x218CF4E7)],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                ),
                alignment: const AlignmentDirectional(-1.0, -1.0),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 1.74),
              child: Container(
                width: double.infinity,
                height: 720.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(70.0),
                    topRight: Radius.circular(70.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.02, -0.53),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/Download_Free_Vectors__Images__Photos___Videos___Vecteezy-removebg-preview.png',
                  width: 336.0,
                  height: 277.6,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 40.0,
              fillColor: const Color(0x0008DCC6),
              icon: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).info,
                size: 30.0,
              ),
              onPressed: () async {
                context.pushNamed(CameraWidget.routeName);
              },
            ),
            Align(
              alignment: const AlignmentDirectional(0.68, 0.48),
              child: FlutterFlowIconButton(
                borderRadius: 50.0,
                buttonSize: 65.13,
                fillColor: const Color(0xFFC9F0F9),
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
              alignment: const AlignmentDirectional(-0.03, 0.47),
              child: FlutterFlowIconButton(
                borderRadius: 50.0,
                buttonSize: 65.1,
                fillColor: const Color(0xFFC9F0F9),
                icon: Icon(
                  Icons.info_outline_sharp,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.73, 0.47),
              child: FlutterFlowIconButton(
                borderRadius: 50.0,
                buttonSize: 65.1,
                fillColor: const Color(0xFFC9F0F9),
                icon: Icon(
                  Icons.sync,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
