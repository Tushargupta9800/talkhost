import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'date_selector_model.dart';
export 'date_selector_model.dart';

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({Key? key}) : super(key: key);

  @override
  _DateSelectorWidgetState createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  late DateSelectorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DateSelectorModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFCFD4DB),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _model.datePicked1 != null
                          ? dateTimeFormat('yMMMd', _model.datePicked1)
                          : 'Start Date',
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF57636C),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final _datePicked1Date = await showDatePicker(
                          context: context,
                          initialDate: getCurrentTimestamp,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050),
                        );

                        if (_datePicked1Date != null) {
                          setState(() {
                            _model.datePicked1 = DateTime(
                              _datePicked1Date.year,
                              _datePicked1Date.month,
                              _datePicked1Date.day,
                            );
                          });
                        }
                      },
                      child: Icon(
                        Icons.date_range_outlined,
                        color: Color(0xFF57636C),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 20,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFCFD4DB),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _model.datePicked2 != null
                          ? dateTimeFormat('MMMEd', _model.datePicked2)
                          : 'End Date',
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF57636C),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final _datePicked2Date = await showDatePicker(
                          context: context,
                          initialDate: getCurrentTimestamp,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050),
                        );

                        if (_datePicked2Date != null) {
                          setState(() {
                            _model.datePicked2 = DateTime(
                              _datePicked2Date.year,
                              _datePicked2Date.month,
                              _datePicked2Date.day,
                            );
                          });
                        }
                      },
                      child: Icon(
                        Icons.date_range_outlined,
                        color: Color(0xFF57636C),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
