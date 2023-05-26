import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import '/pages/widgets/post/post_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'my_hosted_talks_page_model.dart';
export 'my_hosted_talks_page_model.dart';

class MyHostedTalksPageWidget extends StatefulWidget {
  const MyHostedTalksPageWidget({Key? key}) : super(key: key);

  @override
  _MyHostedTalksPageWidgetState createState() =>
      _MyHostedTalksPageWidgetState();
}

class _MyHostedTalksPageWidgetState extends State<MyHostedTalksPageWidget> {
  late MyHostedTalksPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyHostedTalksPageModel());

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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            wrapWithModel(
              model: _model.appBarModel,
              updateCallback: () => setState(() {}),
              child: AppBarWidget(),
            ),
            Wrap(
              spacing: 20,
              runSpacing: 0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    setState(() {
                      _model.allTalks = true;
                      _model.upcomingTalks = false;
                      _model.previousTalks = false;
                    });
                  },
                  text: 'All Talks',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color:
                        _model.allTalks ? Color(0xFF06A5F4) : Color(0xFF0662F4),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    setState(() {
                      _model.allTalks = false;
                      _model.upcomingTalks = true;
                      _model.previousTalks = false;
                    });
                  },
                  text: 'Upcoming  and Ongoing Talks',
                  options: FFButtonOptions(
                    width: 300,
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: _model.upcomingTalks
                        ? Color(0xFF06A5F4)
                        : Color(0xFF0662F4),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    setState(() {
                      _model.allTalks = false;
                      _model.upcomingTalks = false;
                      _model.previousTalks = true;
                    });
                  },
                  text: 'Previous Talks',
                  options: FFButtonOptions(
                    width: 160,
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: _model.previousTalks
                        ? Color(0xFF06A5F4)
                        : Color(0xFF0662F4),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Stack(
                  children: [
                    if (_model.allTalks)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('host_email', isEqualTo: currentUserEmail),
                        ),
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
                          List<PostsRecord> allTalksPostsRecordList =
                              snapshot.data!;
                          if (allTalksPostsRecordList.isEmpty) {
                            return Image.network(
                              FFAppState().emptyState,
                              fit: BoxFit.cover,
                            );
                          }
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: allTalksPostsRecordList.length,
                            itemBuilder: (context, allTalksIndex) {
                              final allTalksPostsRecord =
                                  allTalksPostsRecordList[allTalksIndex];
                              return wrapWithModel(
                                model: _model.postModels1.getModel(
                                  allTalksIndex.toString(),
                                  allTalksIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keyvjb_${allTalksIndex.toString()}',
                                  ),
                                  postData: allTalksPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.upcomingTalks)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('host_email', isEqualTo: currentUserEmail)
                              .where('end_time',
                                  isGreaterThan: functions.timeNow()),
                        ),
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
                          List<PostsRecord> upcomingTalksPostsRecordList =
                              snapshot.data!;
                          if (upcomingTalksPostsRecordList.isEmpty) {
                            return Image.network(
                              FFAppState().emptyState,
                              fit: BoxFit.cover,
                            );
                          }
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: upcomingTalksPostsRecordList.length,
                            itemBuilder: (context, upcomingTalksIndex) {
                              final upcomingTalksPostsRecord =
                                  upcomingTalksPostsRecordList[
                                      upcomingTalksIndex];
                              return wrapWithModel(
                                model: _model.postModels2.getModel(
                                  upcomingTalksIndex.toString(),
                                  upcomingTalksIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keyv56_${upcomingTalksIndex.toString()}',
                                  ),
                                  postData: upcomingTalksPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.previousTalks)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('host_email', isEqualTo: currentUserEmail)
                              .where('end_time',
                                  isLessThanOrEqualTo: functions.timeNow()),
                        ),
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
                          List<PostsRecord> previousTalksPostsRecordList =
                              snapshot.data!;
                          if (previousTalksPostsRecordList.isEmpty) {
                            return Image.network(
                              FFAppState().emptyState,
                              fit: BoxFit.cover,
                            );
                          }
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: previousTalksPostsRecordList.length,
                            itemBuilder: (context, previousTalksIndex) {
                              final previousTalksPostsRecord =
                                  previousTalksPostsRecordList[
                                      previousTalksIndex];
                              return wrapWithModel(
                                model: _model.postModels3.getModel(
                                  previousTalksIndex.toString(),
                                  previousTalksIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keytip_${previousTalksIndex.toString()}',
                                  ),
                                  postData: previousTalksPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
