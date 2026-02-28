import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signosuccessful_model.dart';
export 'signosuccessful_model.dart';

class SignosuccessfulWidget extends StatefulWidget {
  const SignosuccessfulWidget({super.key});

  static String routeName = 'signosuccessful';
  static String routePath = '/signosuccessful';

  @override
  State<SignosuccessfulWidget> createState() => _SignosuccessfulWidgetState();
}

class _SignosuccessfulWidgetState extends State<SignosuccessfulWidget> {
  late SignosuccessfulModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignosuccessfulModel());

    // ✅ يرجع تلقائي لصفحة registerCopy بعد ثانيتين
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      context.goNamed('registerCopy');
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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0, 1.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8BC6D7), Color(0x218CF4E7)],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/0ebae5f50cbd4dfb0f12a27256994043-removebg-preview.png',
                          width: 300.0,
                          height: 292.87,
                          fit: BoxFit.cover,
                          alignment: const Alignment(1.0, 1.0),
                        ),
                      ),
                      Text(
                        'Successfully Sign out ',
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.inter(),
                          color: const Color(0xFF105A4A),
                          fontSize: 30.0,
                          shadows: const [
                            Shadow(
                              color: Color(0xFF8BC6D7),
                              offset: Offset(1.0, 1.0),
                              blurRadius: 1.0,
                            )
                          ],
                        ),
                      ),
                    ].divide(const SizedBox(height: 50.0)),
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