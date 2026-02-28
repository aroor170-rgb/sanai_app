import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_re_med_widget.dart' show AddReMedWidget;
import 'package:flutter/material.dart';

class AddReMedModel extends FlutterFlowModel<AddReMedWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
