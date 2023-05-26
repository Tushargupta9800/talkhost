import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'about_us_page_model.dart';
export 'about_us_page_model.dart';

class AboutUsPageWidget extends StatefulWidget {
  const AboutUsPageWidget({Key? key}) : super(key: key);

  @override
  _AboutUsPageWidgetState createState() => _AboutUsPageWidgetState();
}

class _AboutUsPageWidgetState extends State<AboutUsPageWidget> {
  late AboutUsPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutUsPageModel());

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
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.appBarModel,
                updateCallback: () => setState(() {}),
                child: AppBarWidget(),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        'Introduction:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Text(
                        '* TalkHost is a software platform for managing virtual conferences.\n* It helps event organizers to create events and manage the entire event process from registration to post-event follow-up.\n* The project aims to make virtual events more engaging, efficient, and cost-effective by providing a platform that is user-friendly and accessible to all.\n',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        'Features:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Text(
                        '* Proper authentication and role based access control.\n* Create user profile and business card.\n* Create and modify public/private events.\n* Creating events from excel file.\n* Platform integrated event meeting.\n* Efficiently track attendance of registered and attending users.\n* Engage attendees through group and one-to-one chats.\n* Features like poll and posts.\n',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        'Benefits:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Text(
                        '* Easy-to-use platform for event organizers and attendees.\n* Cost-effective alternative to in-person events.\n* Efficient event management and potential platform for communication and networking.\n* The interactive post feed page on TalkHost allows users to view and interact with posts from other attendees and organizers.\n* Creates a sense of community and engagement around the event.\n',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
