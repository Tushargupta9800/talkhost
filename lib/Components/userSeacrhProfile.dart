import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'user_search_profile_model.dart';
export 'user_search_profile_model.dart';

class UserSearchProfileWidget extends StatefulWidget {
  const UserSearchProfileWidget({
    Key? key,
    this.user,
  }) : super(key: key);

  final UsersRecord? user;

  @override
  _UserSearchProfileWidgetState createState() =>
      _UserSearchProfileWidgetState();
}

class _UserSearchProfileWidgetState extends State<UserSearchProfileWidget>
    with TickerProviderStateMixin {
  late UserSearchProfileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserSearchProfileModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          context.pushNamed(
            'userProfile',
            queryParams: {
              'userRef': serializeParam(
                widget.user!.reference,
                ParamType.DocumentReference,
              ),
            }.withoutNulls,
          );
        },
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 500,
            height: 80,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  color: FlutterFlowTheme.of(context).lineColor,
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      widget.user!.photoUrl != null &&
                              widget.user!.photoUrl != ''
                          ? widget.user!.photoUrl
                          : FFAppState().defaultUserPic,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            valueOrDefault<String>(
                              widget.user!.displayName != null &&
                                      widget.user!.displayName != ''
                                  ? widget.user!.displayName
                                  : 'User',
                              'User',
                            ),
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context).titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            widget.user!.email,
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context).titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
