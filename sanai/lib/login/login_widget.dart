import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
export 'login_model.dart';

// ✅ Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';

// ✅ (اختياري) لو تبين تنادين الباكند بالتوكن
import 'package:http/http.dart' as http;

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'loginCopy';
  static String routePath = '/loginCopy';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> with TickerProviderStateMixin {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(milliseconds: 3000)),
    );
  }

  String _authErrorMessage(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          return 'Invalid email format.';
        case 'user-not-found':
          return 'No account found for this email. Please sign up first.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-credential':
          return 'Incorrect email or password.';
        case 'user-disabled':
          return 'This account is disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Try again later.';
        default:
          return e.message ?? 'Login failed. Please try again.';
      }
    }
    return 'Login failed. Please try again.';
  }

  // ✅ تسجيل دخول Firebase + (اختياري) اتصال باكند
  Future<void> _signIn() async {
    final email = (_model.textController1?.text ?? '').trim();
    final password = (_model.textController2?.text ?? '').trim();

    if (email.isEmpty || password.isEmpty) {
      _snack('Please enter email and password.');
      return;
    }

    try {
      // 1) Firebase Sign In
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        _snack('Login failed. Please try again.');
        return;
      }

      // 2) Get ID Token (عشان الباكند)
      final idToken = await user.getIdToken();

      // 3) (اختياري) نداء بسيط للباكند للتأكد انه شغال + التوكن يوصل
      // ⚠️ عدلي الرابط حسب جهازك:
      // - Android Emulator: http://10.0.2.2:8000/health
      // - iOS Simulator: http://127.0.0.1:8000/health
      // - جهاز حقيقي: حطي IP جهاز الكمبيوتر على نفس الشبكة
      const backendHealthUrl = 'http://10.0.2.2:8000/health';

      try {
        await http.get(
          Uri.parse(backendHealthUrl),
          headers: {'Authorization': 'Bearer $idToken'},
        );
      } catch (_) {
        // ما نوقف تسجيل الدخول لو الباكند ما رد (بس للتجربة)
      }

      // 4) Success → Home
      context.goNamed(HomeWidget.routeName);
    } catch (e) {
      _snack(_authErrorMessage(e));
    }
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
            Container(
              width: double.infinity,
              height: 280.0,
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
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/8d101295fd4686c898afb265561d05c0.png',
                      width: double.infinity,
                      height: 208.88,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 1.0),
              child: Container(
                width: double.infinity,
                height: 650.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                  border: Border.all(
                    color: const Color(0xFFC9F0F9),
                  ),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(AboutWidget.routeName);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                              child: Text(
                                'Welcome Back',
                                style: FlutterFlowTheme.of(context).headlineLarge.override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 30.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                  shadows: [
                                    const Shadow(
                                      color: Color(0xFF8BC6D7),
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 1.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                            child: SizedBox(
                              width: 300.0,
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                autofocus: false,
                                enabled: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Email',
                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF8BC6D7),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                    ),
                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model.textController1Validator.asValidator(context),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                            child: SizedBox(
                              width: 300.0,
                              child: TextFormField(
                                controller: _model.textController2,
                                focusNode: _model.textFieldFocusNode2,
                                autofocus: false,
                                enabled: true,
                                obscureText: !_model.passwordVisibility,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Password',
                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF8BC6D7),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  suffixIcon: InkWell(
                                    onTap: () async {
                                      safeSetState(() => _model.passwordVisibility = !_model.passwordVisibility);
                                    },
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      _model.passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                    ),
                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model.textController2Validator.asValidator(context),
                              ),
                            ),
                          ),

                          Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 0.0),
                              child: Text(
                                'Forgot Password ?',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      ),
                                      color: const Color(0xFF8BC6D7),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ),

                          Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(1.0, 0.0),
                                    child: Text(
                                      'Don\'t have account ?',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            ),
                                            color: const Color(0xFF8BC6D7),
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(1.0, 0.0),
                                    child: Text(
                                      'Create account',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            ),
                                            color: const Color(0xFF1F94BA),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            decoration: TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ✅ هنا التعديل الوحيد: زر Sign in صار يسوي Firebase Login + Errors
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await _signIn();
                              },
                              text: 'Sign in',
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: const Color(0xFFC9F0F9),
                                textStyle: FlutterFlowTheme.of(context).headlineSmall.override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                      ),
                                      color: const Color(0xFF105A4A),
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation']!),
                          ),

                          Text(
                            'OR',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                ),
                          ),

                          Align(
                            alignment: const AlignmentDirectional(-1.0, 1.0),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
  context.pushNamed('quickAccessPin');
},
                                    text: 'Quick Access',
                                    options: FFButtonOptions(
                                      width: 300.0,
                                      height: 40.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                            ),
                                            color: const Color(0xFF105A4A),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderSide: const BorderSide(
                                        color: Color(0xFF8BC6D7),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                            child: Container(
                              width: 300.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: const Color(0xFF8BC6D7),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.hearing_disabled,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.zoom_in,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.zoom_out,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.volume_up_outlined,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                  Icon(
                                    Icons.mic,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                ].divide(const SizedBox(width: 10.0)),
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(height: 10.0)),
                      ),
                    ),
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