import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'user_search_no_profile_model.dart';
export 'user_search_no_profile_model.dart';

class UserSearchNoProfileWidget extends StatefulWidget {
  const UserSearchNoProfileWidget({
    Key? key,
    this.email,
  }) : super(key: key);

  final String? email;

  @override
  _UserSearchNoProfileWidgetState createState() =>
      _UserSearchNoProfileWidgetState();
}

class _UserSearchNoProfileWidgetState extends State<UserSearchNoProfileWidget> {
  late UserSearchNoProfileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserSearchNoProfileModel());

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
                    FFAppState().defaultUserPic,
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
                          'User Not Found',
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context).titleMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          widget.email!,
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
    );
  }
}
