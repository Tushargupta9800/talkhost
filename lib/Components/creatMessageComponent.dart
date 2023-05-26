import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'create_message_component_model.dart';
export 'create_message_component_model.dart';

class CreateMessageComponentWidget extends StatefulWidget {
  const CreateMessageComponentWidget({Key? key}) : super(key: key);

  @override
  _CreateMessageComponentWidgetState createState() =>
      _CreateMessageComponentWidgetState();
}

class _CreateMessageComponentWidgetState
    extends State<CreateMessageComponentWidget> {
  late CreateMessageComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateMessageComponentModel());

    _model.topicController ??= TextEditingController();
    _model.toController ??= TextEditingController();
    _model.messageController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    setState(() {
                      _model.editMode = true;
                    });
                  },
                  text: 'Edit',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() {
                        _model.editMode = false;
                      });
                    },
                    text: 'Preview',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (functions.messageFormValodator(
                              _model.topicController.text,
                              _model.toController.text,
                              _model.messageController.text) ==
                          'Success') {
                        setState(() {
                          _model.errorString = ' ';
                        });
                        await actions.createMessage(
                          _model.topicController.text,
                          functions
                              .stringToEmail(_model.toController.text)
                              .toList(),
                          _model.messageController.text,
                          currentUserReference!,
                        );
                        Navigator.pop(context);
                        return;
                      } else {
                        setState(() {
                          _model.errorString = functions.messageFormValodator(
                              _model.topicController.text,
                              _model.toController.text,
                              _model.messageController.text);
                        });
                        return;
                      }
                    },
                    text: 'Send',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    _model.errorString,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).alternate,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            controller: _model.topicController,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Topic',
              hintStyle: FlutterFlowTheme.of(context).bodySmall,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium,
            validator: _model.topicControllerValidator.asValidator(context),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            child: TextFormField(
              controller: _model.toController,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                hintText:
                    'to: [write emails seperated by comma(,)] Ex: abcd1@gmail.com, abcd2@gmail.com',
                hintStyle: FlutterFlowTheme.of(context).bodySmall,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
              validator: _model.toControllerValidator.asValidator(context),
            ),
          ),
          Stack(
            children: [
              if (_model.editMode)
                TextFormField(
                  controller: _model.messageController,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText:
                        'Write your message Here. This Area is Markdown Supported.',
                    hintStyle: FlutterFlowTheme.of(context).bodySmall,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  maxLines: 10,
                  validator:
                      _model.messageControllerValidator.asValidator(context),
                ),
              if (!_model.editMode)
                Container(
                  width: double.infinity,
                  height: 275,
                  child: custom_widgets.MarkdownRenderer(
                    width: double.infinity,
                    height: 275,
                    data: _model.messageController.text,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
