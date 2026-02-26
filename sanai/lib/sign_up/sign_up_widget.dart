

// sign_up_widget.dart
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
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
import 'sign_up_model.dart';
export 'sign_up_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  static String routeName = 'sign_up';
  static String routePath = '/signUp';

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget>
    with TickerProviderStateMixin {
  late SignUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = <String, AnimationInfo>{};

  final List<String> _genderOptions = const [
    'Female',
    'Male',
    'Prefer not to say'
  ];

  bool _showPasswordRules = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signOut();

    _model = createModel(context, () => SignUpModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController();
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.selectedGender ??= _genderOptions.first;

    // show rules only when password field focused
    _model.textFieldFocusNode5!.addListener(() {
      if (!mounted) return;
      setState(() => _showPasswordRules = _model.textFieldFocusNode5!.hasFocus);
    });

    // refresh rule checks while typing
    _model.textController5!.addListener(() {
      if (!mounted) return;
      if (_showPasswordRules) setState(() {});
    });

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

  bool _isValidEmail(String email) {
    final r = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
    return r.hasMatch(email);
  }

  String _normalizePhone(String phone) {
    var p = phone.replaceAll(RegExp(r'[^0-9\+]'), '');
    if (p.startsWith('05') && p.length == 10) {
      p = '+966${p.substring(1)}';
    }
    return p;
  }

  bool _isValidPhone(String phone) {
    final p = _normalizePhone(phone);
    final r = RegExp(r'^\+?[0-9]{10,15}$');
    return r.hasMatch(p);
  }

  String? _passwordRuleError(String pass) {
    if (pass.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(pass)) return 'Add 1 uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(pass)) return 'Add 1 lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(pass)) return 'Add 1 number';
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\\]').hasMatch(pass)) {
      return 'Add 1 special character';
    }
    return null;
  }

  String _firebaseMsg(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email already in use';
        case 'invalid-email':
          return 'Invalid email';
        case 'weak-password':
          return 'Password is too weak';
        case 'operation-not-allowed':
          return 'Email/Password auth is not enabled';
        default:
          return e.message ?? e.code;
      }
    }
    return e.toString();
  }

  Widget _passwordRulesUI(String pass) {
    final hasUpper = RegExp(r'[A-Z]').hasMatch(pass);
    final hasLower = RegExp(r'[a-z]').hasMatch(pass);
    final hasNumber = RegExp(r'[0-9]').hasMatch(pass);
    final hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\\]').hasMatch(pass);
    final hasLength = pass.length >= 8;

    Widget rule(String text, bool ok) {
      return Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Row(
          children: [
            Icon(
              ok ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 16,
              color: ok ? const Color(0xFF105A4A) : Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.roboto(fontSize: 12.5),
              ),
            ),
          ],
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      margin: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 10.0, 12.0, 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6FBFC),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0x338BC6D7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password requirements',
            style: GoogleFonts.roboto(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF105A4A),
            ),
          ),
          rule('At least 8 characters', hasLength),
          rule('One uppercase letter', hasUpper),
          rule('One lowercase letter', hasLower),
          rule('One number', hasNumber),
          rule('One special character', hasSpecial),
        ],
      ),
    );
  }

  Future<void> _createAccount() async {
    final name = (_model.textController1?.text ?? '').trim();
    final phoneRaw = (_model.textController2?.text ?? '').trim();
    final email = (_model.textController3?.text ?? '').trim();
    final gender = (_model.selectedGender ?? '').trim();
    final pass = (_model.textController5?.text ?? '');
    final pass2 = (_model.textController6?.text ?? '');

    if (name.isEmpty ||
        phoneRaw.isEmpty ||
        email.isEmpty ||
        gender.isEmpty ||
        pass.isEmpty ||
        pass2.isEmpty) {
      _snack('Please fill all fields');
      return;
    }

    if (!_isValidEmail(email)) {
      _snack('Enter a valid email مثل: name@email.com');
      return;
    }

    final phone = _normalizePhone(phoneRaw);
    if (!_isValidPhone(phone)) {
      _snack('Enter a valid phone مثل: +9665xxxxxxxx أو 05xxxxxxxx');
      return;
    }

    final passErr = _passwordRuleError(pass.trim());
    if (passErr != null) {
      _snack(passErr);
      return;
    }

    if (pass.trim() != pass2.trim()) {
      _snack('Passwords do not match');
      return;
    }

    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass.trim(),
      );

      final uid = cred.user?.uid;
      if (uid == null) {
        _snack('Failed to create user');
        return;
      }

      await cred.user!.updateDisplayName(name);

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (!mounted) return;
      context.goNamed(HomeWidget.routeName);
    } catch (e) {
      _snack(_firebaseMsg(e));
    }
  }

  InputDecoration _decor(String label, {String? hint}) {
    return InputDecoration(
      isDense: true,
      labelText: label,
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8BC6D7), width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8BC6D7), width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    final passLive = _model.textController5?.text ?? '';

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
              alignment: const AlignmentDirectional(0.0, -1.14),
              child: Container(
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
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, -1.47),
              child: IgnorePointer(
                ignoring: true,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/9fa7d16884e735090cab5e4fa90515cf-removebg-preview.png',
                      width: 539.5,
                      height: 309.6,
                      fit: BoxFit.fitHeight,
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
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                  border: Border.all(color: const Color(0x4400FFE4)),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 50.0, 0.0, 0.0),
                          child: Text(
                            'Create Account',
                            style: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .override(
                              font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600),
                              fontSize: 30.0,
                              shadows: const [
                                Shadow(
                                  color: Color(0x7236CBB3),
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 1.0,
                                )
                              ],
                            ),
                          ),
                        ),

                        // Name
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.textController1,
                              focusNode: _model.textFieldFocusNode1,
                              textInputAction: TextInputAction.next,
                              decoration: _decor('Your name'),
                            ),
                          ),
                        ),

                        // Phone
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.textController2,
                              focusNode: _model.textFieldFocusNode2,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9\+\-\s]')),
                              ],
                              decoration: _decor(
                                'Phone number',
                                hint: '+9665xxxxxxxx or 05xxxxxxxx',
                              ),
                            ),
                          ),
                        ),

                        // Email
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.textController3,
                              focusNode: _model.textFieldFocusNode3,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: _decor('Email', hint: 'name@email.com'),
                            ),
                          ),
                        ),

                        // Gender (same size)
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: 300.0,
                            child: DropdownButtonFormField<String>(
                              value: _model.selectedGender,
                              items: _genderOptions
                                  .map((g) => DropdownMenuItem(
                                        value: g,
                                        child: Text(g),
                                      ))
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _model.selectedGender = v),
                              decoration: _decor('Gender'),
                            ),
                          ),
                        ),

                        // Password
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.textController5,
                              focusNode: _model.textFieldFocusNode5,
                              obscureText: !_model.passwordVisibility1,
                              textInputAction: TextInputAction.next,
                              onChanged: (_) => setState(() {}),
                              decoration: _decor(
                                'Password',
                                hint: 'Create a strong password',
                              ).copyWith(
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    safeSetState(() => _model
                                            .passwordVisibility1 =
                                        !_model.passwordVisibility1);
                                  },
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _model.passwordVisibility1
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 22,
                                  ),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        // Rules (show only when focused)
                        if (_showPasswordRules)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            child: SizedBox(
                              width: 300.0,
                              child: _passwordRulesUI(passLive),
                            ),
                          ),

                        // Confirm password
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.textController6,
                              focusNode: _model.textFieldFocusNode6,
                              obscureText: !_model.passwordVisibility2,
                              textInputAction: TextInputAction.done,
                              decoration: _decor('Confirm Password').copyWith(
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    safeSetState(() => _model
                                            .passwordVisibility2 =
                                        !_model.passwordVisibility2);
                                  },
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _model.passwordVisibility2
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Button
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: _createAccount,
                            text: 'Sign up',
                            options: FFButtonOptions(
                              width: 300.0,
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              color: const Color(0xFFC9F0F9),
                              textStyle: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(),
                                    color: const Color(0xFF105A4A),
                                    fontSize: 20.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['buttonOnPageLoadAnimation']!),
                        ),

                        // Sign in
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 20.0),
                          child: InkWell(
                            onTap: () async {
                              context.pushNamed(LoginWidget.routeName);
                            },
                            child: Text(
                              'Already have an account? Sign in',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold),
                                    color: const Color(0xFF105A4A),
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Back
            Align(
              alignment: const AlignmentDirectional(-1.0, -1.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0, 30.0, 0.0, 0.0),
                child: FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 40.0,
                  icon: Icon(Icons.arrow_back,
                      color: FlutterFlowTheme.of(context).info, size: 30.0),
                  onPressed: () async {
                    context.pushNamed(RegisterCopyWidget.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}