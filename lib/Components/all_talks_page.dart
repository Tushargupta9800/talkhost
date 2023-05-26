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

import 'all_talks_page_model.dart';
export 'all_talks_page_model.dart';

class AllTalksPageWidget extends StatefulWidget {
  const AllTalksPageWidget({Key? key}) : super(key: key);

  @override
  _AllTalksPageWidgetState createState() => _AllTalksPageWidgetState();
}

class _AllTalksPageWidgetState extends State<AllTalksPageWidget> {
  late AllTalksPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllTalksPageModel());

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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Wrap(
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
                        _model.asGuest = false;
                        _model.asInvitee = true;
                        _model.isPublic = false;
                      });
                    },
                    text: 'As Invitee',
                    options: FFButtonOptions(
                      width: 150,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: _model.asInvitee
                          ? Color(0xFF06A5F4)
                          : Color(0xFF0662F4),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
                        _model.asGuest = true;
                        _model.asInvitee = false;
                        _model.isPublic = false;
                      });
                    },
                    text: 'As Guest',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: _model.asGuest
                          ? Color(0xFF06A5F4)
                          : Color(0xFF0662F4),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
                        _model.asGuest = false;
                        _model.asInvitee = false;
                        _model.isPublic = true;
                      });
                    },
                    text: 'Public',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: _model.isPublic
                          ? Color(0xFF06A5F4)
                          : Color(0xFF0662F4),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Stack(
                  children: [
                    if (_model.allTalks && _model.asGuest)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('guests', arrayContains: currentUserEmail),
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
                          List<PostsRecord> allTalksGuestPostsRecordList =
                              snapshot.data!;
                          if (allTalksGuestPostsRecordList.isEmpty) {
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
                            itemCount: allTalksGuestPostsRecordList.length,
                            itemBuilder: (context, allTalksGuestIndex) {
                              final allTalksGuestPostsRecord =
                                  allTalksGuestPostsRecordList[
                                      allTalksGuestIndex];
                              return wrapWithModel(
                                model: _model.postModels1.getModel(
                                  allTalksGuestIndex.toString(),
                                  allTalksGuestIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Key8gj_${allTalksGuestIndex.toString()}',
                                  ),
                                  postData: allTalksGuestPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.upcomingTalks && _model.asGuest)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('end_time',
                                  isGreaterThan: functions.timeNow())
                              .where('guests', arrayContains: currentUserEmail),
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
                          List<PostsRecord> upcomingTalksGuestPostsRecordList =
                              snapshot.data!;
                          if (upcomingTalksGuestPostsRecordList.isEmpty) {
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
                            itemCount: upcomingTalksGuestPostsRecordList.length,
                            itemBuilder: (context, upcomingTalksGuestIndex) {
                              final upcomingTalksGuestPostsRecord =
                                  upcomingTalksGuestPostsRecordList[
                                      upcomingTalksGuestIndex];
                              return wrapWithModel(
                                model: _model.postModels2.getModel(
                                  upcomingTalksGuestIndex.toString(),
                                  upcomingTalksGuestIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Key5cn_${upcomingTalksGuestIndex.toString()}',
                                  ),
                                  postData: upcomingTalksGuestPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.previousTalks && _model.asGuest)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('end_time',
                                  isLessThanOrEqualTo: functions.timeNow())
                              .where('guests', arrayContains: currentUserEmail),
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
                          List<PostsRecord> previousTalksGuestPostsRecordList =
                              snapshot.data!;
                          if (previousTalksGuestPostsRecordList.isEmpty) {
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
                            itemCount: previousTalksGuestPostsRecordList.length,
                            itemBuilder: (context, previousTalksGuestIndex) {
                              final previousTalksGuestPostsRecord =
                                  previousTalksGuestPostsRecordList[
                                      previousTalksGuestIndex];
                              return wrapWithModel(
                                model: _model.postModels3.getModel(
                                  previousTalksGuestIndex.toString(),
                                  previousTalksGuestIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keytnn_${previousTalksGuestIndex.toString()}',
                                  ),
                                  postData: previousTalksGuestPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.allTalks && _model.asInvitee)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord.where(
                              'invitations',
                              arrayContains: currentUserEmail),
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
                          List<PostsRecord> allTalksInviteePostsRecordList =
                              snapshot.data!;
                          if (allTalksInviteePostsRecordList.isEmpty) {
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
                            itemCount: allTalksInviteePostsRecordList.length,
                            itemBuilder: (context, allTalksInviteeIndex) {
                              final allTalksInviteePostsRecord =
                                  allTalksInviteePostsRecordList[
                                      allTalksInviteeIndex];
                              return wrapWithModel(
                                model: _model.postModels4.getModel(
                                  allTalksInviteeIndex.toString(),
                                  allTalksInviteeIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keybko_${allTalksInviteeIndex.toString()}',
                                  ),
                                  postData: allTalksInviteePostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.upcomingTalks && _model.asInvitee)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('invitations',
                                  arrayContains: currentUserEmail)
                              .where('end_time',
                                  isGreaterThanOrEqualTo: functions.timeNow()),
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
                          List<PostsRecord>
                              upcomingTalksInviteePostsRecordList =
                              snapshot.data!;
                          if (upcomingTalksInviteePostsRecordList.isEmpty) {
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
                            itemCount:
                                upcomingTalksInviteePostsRecordList.length,
                            itemBuilder: (context, upcomingTalksInviteeIndex) {
                              final upcomingTalksInviteePostsRecord =
                                  upcomingTalksInviteePostsRecordList[
                                      upcomingTalksInviteeIndex];
                              return wrapWithModel(
                                model: _model.postModels5.getModel(
                                  upcomingTalksInviteeIndex.toString(),
                                  upcomingTalksInviteeIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Key23w_${upcomingTalksInviteeIndex.toString()}',
                                  ),
                                  postData: upcomingTalksInviteePostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.previousTalks && _model.asInvitee)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('invitations',
                                  arrayContains: currentUserEmail)
                              .where('end_time',
                                  isLessThan: functions.timeNow()),
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
                          List<PostsRecord>
                              previousTalksInviteePostsRecordList =
                              snapshot.data!;
                          if (previousTalksInviteePostsRecordList.isEmpty) {
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
                            itemCount:
                                previousTalksInviteePostsRecordList.length,
                            itemBuilder: (context, previousTalksInviteeIndex) {
                              final previousTalksInviteePostsRecord =
                                  previousTalksInviteePostsRecordList[
                                      previousTalksInviteeIndex];
                              return wrapWithModel(
                                model: _model.postModels6.getModel(
                                  previousTalksInviteeIndex.toString(),
                                  previousTalksInviteeIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keyist_${previousTalksInviteeIndex.toString()}',
                                  ),
                                  postData: previousTalksInviteePostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.allTalks && _model.isPublic)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('make_talk_public', isEqualTo: true),
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
                          List<PostsRecord> allTalksPublicPostsRecordList =
                              snapshot.data!;
                          if (allTalksPublicPostsRecordList.isEmpty) {
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
                            itemCount: allTalksPublicPostsRecordList.length,
                            itemBuilder: (context, allTalksPublicIndex) {
                              final allTalksPublicPostsRecord =
                                  allTalksPublicPostsRecordList[
                                      allTalksPublicIndex];
                              return wrapWithModel(
                                model: _model.postModels7.getModel(
                                  allTalksPublicIndex.toString(),
                                  allTalksPublicIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keyh4m_${allTalksPublicIndex.toString()}',
                                  ),
                                  postData: allTalksPublicPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.previousTalks && _model.isPublic)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('end_time',
                                  isLessThan: functions.timeNow())
                              .where('make_talk_public', isEqualTo: true),
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
                          List<PostsRecord> previousTalksPublicPostsRecordList =
                              snapshot.data!;
                          if (previousTalksPublicPostsRecordList.isEmpty) {
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
                            itemCount:
                                previousTalksPublicPostsRecordList.length,
                            itemBuilder: (context, previousTalksPublicIndex) {
                              final previousTalksPublicPostsRecord =
                                  previousTalksPublicPostsRecordList[
                                      previousTalksPublicIndex];
                              return wrapWithModel(
                                model: _model.postModels8.getModel(
                                  previousTalksPublicIndex.toString(),
                                  previousTalksPublicIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Keyjbv_${previousTalksPublicIndex.toString()}',
                                  ),
                                  postData: previousTalksPublicPostsRecord,
                                  canUserClick: true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (_model.upcomingTalks && _model.isPublic)
                      StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where('make_talk_public', isEqualTo: true)
                              .where('end_time',
                                  isGreaterThanOrEqualTo: functions.timeNow()),
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
                          List<PostsRecord> upcomingTalksPublicPostsRecordList =
                              snapshot.data!;
                          if (upcomingTalksPublicPostsRecordList.isEmpty) {
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
                            itemCount:
                                upcomingTalksPublicPostsRecordList.length,
                            itemBuilder: (context, upcomingTalksPublicIndex) {
                              final upcomingTalksPublicPostsRecord =
                                  upcomingTalksPublicPostsRecordList[
                                      upcomingTalksPublicIndex];
                              return wrapWithModel(
                                model: _model.postModels9.getModel(
                                  upcomingTalksPublicIndex.toString(),
                                  upcomingTalksPublicIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: PostWidget(
                                  key: Key(
                                    'Key7qz_${upcomingTalksPublicIndex.toString()}',
                                  ),
                                  postData: upcomingTalksPublicPostsRecord,
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
