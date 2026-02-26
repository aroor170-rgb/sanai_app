// sign_up_model.dart
import '/flutter_flow/flutter_flow_util.dart';
import 'sign_up_widget.dart' show SignUpWidget;
import 'package:flutter/material.dart';

class SignUpModel extends FlutterFlowModel<SignUpWidget> {
  // Name
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;

  // Phone
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;

  // Email
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;

  // Gender dropdown
  String? selectedGender;

  // Password
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  late bool passwordVisibility1;

  // Confirm password
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController6;
  late bool passwordVisibility2;

  @override
  void initState(BuildContext context) {
    passwordVisibility1 = false;
    passwordVisibility2 = false;
    selectedGender = 'Female';
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    textFieldFocusNode6?.dispose();
    textController6?.dispose();
  }
}