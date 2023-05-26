import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'message_component_model.dart';
export 'message_component_model.dart';

class MessageComponentWidget extends StatefulWidget {
  const MessageComponentWidget({
    Key? key,
    this.messageData,
  }) : super(key: key);

  final MessagesStruct? messageData;

  @override
  _MessageComponentWidgetState createState() => _MessageComponentWidgetState();
}

class _MessageComponentWidgetState extends State<MessageComponentWidget> {
  late MessageComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageComponentModel());

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

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.messageData!.from!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
          );
        }
        final commentUsersRecord = snapshot.data!;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x41000000),
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        commentUsersRecord.photoUrl != null &&
                                commentUsersRecord.photoUrl != ''
                            ? commentUsersRecord.photoUrl
                            : FFAppState().defaultUserPic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                commentUsersRecord.displayName != null &&
                                        commentUsersRecord.displayName != ''
                                    ? commentUsersRecord.displayName
                                    : 'User',
                                'User',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Text(
                                widget.messageData!.topic,
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 4, 0),
                                    child: Text(
                                      'Posted',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    dateTimeFormat('d/M h:mm a',
                                        widget.messageData!.createdOn!),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 290,
                    child: custom_widgets.MarkdownRenderer(
                      width: double.infinity,
                      height: 290,
                      data: widget.messageData!.message,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
