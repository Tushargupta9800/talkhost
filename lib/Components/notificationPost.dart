import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'notification_post_model.dart';
export 'notification_post_model.dart';

class NotificationPostWidget extends StatefulWidget {
  const NotificationPostWidget({
    Key? key,
    this.postDataRef,
    this.isPostNew,
  }) : super(key: key);

  final DocumentReference? postDataRef;
  final bool? isPostNew;

  @override
  _NotificationPostWidgetState createState() => _NotificationPostWidgetState();
}

class _NotificationPostWidgetState extends State<NotificationPostWidget> {
  late NotificationPostModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationPostModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
      child: StreamBuilder<PostsRecord>(
        stream: PostsRecord.getDocument(widget.postDataRef!),
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
          final socialCardPostsRecord = snapshot.data!;
          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pushNamed(
                'FullPostPage',
                queryParams: {
                  'postDetails': serializeParam(
                    socialCardPostsRecord,
                    ParamType.Document,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  'postDetails': socialCardPostsRecord,
                },
              );
            },
            child: Material(
              color: Colors.transparent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Text(
                          widget.isPostNew! ? '• Invitation' : '• Talk Update',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Container(
                        height: 160,
                        child: Stack(
                          alignment: AlignmentDirectional(0, 1),
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, -1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: Image.network(
                                  socialCardPostsRecord.agedaBannerPic,
                                  width: double.infinity,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 1),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 24, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.grid_on_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 12),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                              FlutterFlowTheme.of(context)
                                                  .alternate
                                            ],
                                            stops: [0, 0.3, 1],
                                            begin:
                                                AlignmentDirectional(1, 0.98),
                                            end:
                                                AlignmentDirectional(-1, -0.98),
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2, 2, 2, 2),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Stack(
                                              children: [
                                                if ((socialCardPostsRecord
                                                            .endTime! <=
                                                        functions.timeNow()) ||
                                                    (socialCardPostsRecord
                                                            .startTime! >=
                                                        functions.timeNow()))
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Icon(
                                                      Icons
                                                          .videocam_off_outlined,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                if ((socialCardPostsRecord
                                                            .startTime! <=
                                                        functions.timeNow()) &&
                                                    (socialCardPostsRecord
                                                            .endTime! >=
                                                        functions.timeNow()))
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.05, 0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await actions
                                                            .updateAttendedMeets(
                                                          currentUserReference!,
                                                          widget.postDataRef!,
                                                        );
                                                        await launchURL(
                                                            socialCardPostsRecord
                                                                .meetingId);
                                                      },
                                                      child: Icon(
                                                        Icons.videocam_outlined,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
                        child: StreamBuilder<List<UsersRecord>>(
                          stream: queryUsersRecord(
                            queryBuilder: (usersRecord) => usersRecord.where(
                                'email',
                                isEqualTo: socialCardPostsRecord.hostEmail),
                            singleRecord: true,
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
                            List<UsersRecord> rowUsersRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final rowUsersRecord = rowUsersRecordList.isNotEmpty
                                ? rowUsersRecordList.first
                                : null;
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.of(context).secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2, 2, 2, 2),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                        rowUsersRecord!.photoUrl != null &&
                                                rowUsersRecord!.photoUrl != ''
                                            ? rowUsersRecord!.photoUrl
                                            : FFAppState().defaultUserPic,
                                        width: 32,
                                        height: 32,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          rowUsersRecord!.displayName != null &&
                                                  rowUsersRecord!.displayName !=
                                                      ''
                                              ? rowUsersRecord!.displayName
                                              : 'User',
                                          'User',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                      Text(
                                        rowUsersRecord!.email,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                        child: Text(
                          functions.shortenString(
                              socialCardPostsRecord.roomName, 50),
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context).secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(
                                    FFAppState().defaultUserPic,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${socialCardPostsRecord.guests.length.toString()} Guest(s) Joining the Talk',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Text(
                          'Starting Time: ${dateTimeFormat('d/M h:mm a', socialCardPostsRecord.startTime)}',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Text(
                          'End Time: ${dateTimeFormat('d/M h:mm a', socialCardPostsRecord.endTime)}',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                        child: Text(
                          functions.shortenString(
                              socialCardPostsRecord.agenda, 200),
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
