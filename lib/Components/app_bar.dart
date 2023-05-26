import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app_bar_model.dart';
export 'app_bar_model.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late AppBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lineColor,
            borderRadius: BorderRadius.circular(40),
            shape: BoxShape.rectangle,
          ),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: AutoSizeText(
              FFAppState().homePageAppBarText,
              maxLines: 1,
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
