import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'drawer_model.dart';
export 'drawer_model.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late DrawerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrawerModel());

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

    return Visibility(
      visible: responsiveVisibility(
        context: context,
        phone: false,
        tablet: false,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 450),
          curve: Curves.easeIn,
          width: 270,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/talkhost-62326.appspot.com/o/talkhost_logo.png?alt=media&token=3e58e6f0-50a5-4f22-a10b-ceb1db852df2',
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/talkhost-62326.appspot.com/o/talkhost_text.png?alt=media&token=c0463ef8-8d15-4e81-bae5-c8963fcb3a8d',
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 12,
                  thickness: 2,
                  color: FlutterFlowTheme.of(context).lineColor,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
                  child: StreamBuilder<List<InboxRecord>>(
                    stream: queryInboxRecord(
                      queryBuilder: (inboxRecord) => inboxRecord.where('user',
                          isEqualTo: currentUserEmail),
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
                      List<InboxRecord> contentView1InboxRecordList =
                          snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final contentView1InboxRecord =
                          contentView1InboxRecordList.isNotEmpty
                              ? contentView1InboxRecordList.first
                              : null;
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().update(() {
                            FFAppState().homePageAppBarText =
                                FFAppState().InboxPageKey;
                          });
                          setState(() {
                            FFAppState().homeOpenedDrawerPage =
                                FFAppState().InboxPageKey;
                          });
                          await actions.updateMessageCount(
                            contentView1InboxRecord!.reference,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FFAppState().homeOpenedDrawerPage ==
                                    FFAppState().InboxPageKey
                                ? FlutterFlowTheme.of(context).grayIcon
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.inbox_rounded,
                                  color: FFAppState().homeOpenedDrawerPage ==
                                          FFAppState().InboxPageKey
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBtnText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(
                                    'Inbox',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FFAppState()
                                                      .homeOpenedDrawerPage ==
                                                  FFAppState().InboxPageKey
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryBtnText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                        ),
                                  ),
                                ),
                                Text(
                                  functions.messageCount(
                                      contentView1InboxRecord!.messages.length,
                                      contentView1InboxRecord!.count),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                ))
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().update(() {
                          FFAppState().homePageAppBarText =
                              FFAppState().todayPageKey;
                        });
                        setState(() {
                          FFAppState().homeOpenedDrawerPage =
                              FFAppState().todayPageKey;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FFAppState().homeOpenedDrawerPage ==
                                  FFAppState().todayPageKey
                              ? FlutterFlowTheme.of(context).grayIcon
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.date_range_rounded,
                                color: FFAppState().homeOpenedDrawerPage ==
                                        FFAppState().todayPageKey
                                    ? FlutterFlowTheme.of(context)
                                        .primaryBtnText
                                    : FlutterFlowTheme.of(context)
                                        .secondaryText,
                                size: 20,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Calendar',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color:
                                            FFAppState().homeOpenedDrawerPage ==
                                                    FFAppState().todayPageKey
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBtnText
                                                : FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                Divider(
                  height: 12,
                  thickness: 2,
                  color: FlutterFlowTheme.of(context).lineColor,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                  child: Text(
                    'All Channel',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().update(() {
                      FFAppState().homePageAppBarText =
                          FFAppState().DashBoardPageKey;
                    });
                    setState(() {
                      FFAppState().homeOpenedDrawerPage =
                          FFAppState().DashBoardPageKey;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FFAppState().homeOpenedDrawerPage ==
                              FFAppState().DashBoardPageKey
                          ? FlutterFlowTheme.of(context).grayIcon
                          : FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Dashboard',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FFAppState().homeOpenedDrawerPage ==
                                          FFAppState().DashBoardPageKey
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBtnText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                StreamBuilder<List<NotificationsRecord>>(
                  stream: queryNotificationsRecord(
                    queryBuilder: (notificationsRecord) => notificationsRecord
                        .where('userRef', isEqualTo: currentUserEmail),
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
                    List<NotificationsRecord>
                        contentView1NotificationsRecordList = snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final contentView1NotificationsRecord =
                        contentView1NotificationsRecordList.isNotEmpty
                            ? contentView1NotificationsRecordList.first
                            : null;
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().update(() {
                          FFAppState().homePageAppBarText =
                              FFAppState().notificationPageKey;
                        });
                        setState(() {
                          FFAppState().homeOpenedDrawerPage =
                              FFAppState().notificationPageKey;
                        });
                        await actions.updateNotifications(
                          contentView1NotificationsRecord!.reference,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FFAppState().homeOpenedDrawerPage ==
                                  FFAppState().notificationPageKey
                              ? FlutterFlowTheme.of(context).grayIcon
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Notifications',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FFAppState()
                                                  .homeOpenedDrawerPage ==
                                              FFAppState().notificationPageKey
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBtnText
                                          : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                    ),
                              ),
                              if (contentView1NotificationsRecord!
                                      .notifications.length >
                                  contentView1NotificationsRecord!.count)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Icon(
                                    Icons.notifications_active_outlined,
                                    color: FFAppState().homeOpenedDrawerPage ==
                                            FFAppState().notificationPageKey
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBtnText
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().update(() {
                      FFAppState().homePageAppBarText =
                          FFAppState().AllTalksPageKey;
                    });
                    setState(() {
                      FFAppState().homeOpenedDrawerPage =
                          FFAppState().AllTalksPageKey;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FFAppState().homeOpenedDrawerPage ==
                              FFAppState().AllTalksPageKey
                          ? FlutterFlowTheme.of(context).grayIcon
                          : FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'All Talks',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FFAppState().homeOpenedDrawerPage ==
                                          FFAppState().AllTalksPageKey
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBtnText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().update(() {
                      FFAppState().homePageAppBarText =
                          FFAppState().SearhPersonPageKey;
                    });
                    setState(() {
                      FFAppState().homeOpenedDrawerPage =
                          FFAppState().SearhPersonPageKey;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FFAppState().homeOpenedDrawerPage ==
                              FFAppState().SearhPersonPageKey
                          ? FlutterFlowTheme.of(context).grayIcon
                          : FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Search Someone',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FFAppState().homeOpenedDrawerPage ==
                                          FFAppState().SearhPersonPageKey
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBtnText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().update(() {
                      FFAppState().homePageAppBarText =
                          FFAppState().AboutUsPageKey;
                    });
                    setState(() {
                      FFAppState().homeOpenedDrawerPage =
                          FFAppState().AboutUsPageKey;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FFAppState().homeOpenedDrawerPage ==
                              FFAppState().AboutUsPageKey
                          ? FlutterFlowTheme.of(context).grayIcon
                          : FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'About',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FFAppState().homeOpenedDrawerPage ==
                                          FFAppState().AboutUsPageKey
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBtnText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (valueOrDefault<bool>(currentUserDocument?.isHost, false))
                  AuthUserStreamWidget(
                    builder: (context) => Divider(
                      height: 12,
                      thickness: 2,
                      color: FlutterFlowTheme.of(context).lineColor,
                    ),
                  ),
                if (valueOrDefault<bool>(currentUserDocument?.isHost, false))
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                    child: AuthUserStreamWidget(
                      builder: (context) => Text(
                        'My Channel',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                if (valueOrDefault<bool>(currentUserDocument?.isHost, false))
                  AuthUserStreamWidget(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().update(() {
                          FFAppState().homePageAppBarText =
                              FFAppState().createtalkpagekey;
                        });
                        FFAppState().update(() {
                          FFAppState().homeOpenedDrawerPage =
                              FFAppState().createtalkpagekey;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FFAppState().homeOpenedDrawerPage ==
                                  FFAppState().createtalkpagekey
                              ? FlutterFlowTheme.of(context).grayIcon
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Create Talk',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color:
                                          FFAppState().homeOpenedDrawerPage ==
                                                  FFAppState().createtalkpagekey
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryBtnText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (valueOrDefault<bool>(currentUserDocument?.isHost, false))
                  AuthUserStreamWidget(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().update(() {
                          FFAppState().homePageAppBarText =
                              FFAppState().MyHostedTalksPageKey;
                        });
                        setState(() {
                          FFAppState().homeOpenedDrawerPage =
                              FFAppState().MyHostedTalksPageKey;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FFAppState().homeOpenedDrawerPage ==
                                  FFAppState().MyHostedTalksPageKey
                              ? FlutterFlowTheme.of(context).grayIcon
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'My Hosted Talks',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FFAppState()
                                                  .homeOpenedDrawerPage ==
                                              FFAppState().MyHostedTalksPageKey
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBtnText
                                          : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                Divider(
                  height: 12,
                  thickness: 2,
                  color: FlutterFlowTheme.of(context).lineColor,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      FFAppState().update(() {
                        FFAppState().homePageAppBarText =
                            FFAppState().editprofilepagekey;
                      });
                      FFAppState().update(() {
                        FFAppState().homeOpenedDrawerPage =
                            FFAppState().editprofilepagekey;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                          child: AuthUserStreamWidget(
                            builder: (context) => ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: currentUserPhoto != null &&
                                        currentUserPhoto != ''
                                    ? currentUserPhoto
                                    : FFAppState().defaultUserPic,
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    valueOrDefault<String>(
                                      currentUserDisplayName,
                                      'User',
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ),
                                Text(
                                  currentUserEmail,
                                  maxLines: 1,
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
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              context.goNamedAuth(
                                  'login_page', context.mounted);
                            },
                            child: Icon(
                              Icons.logout,
                              color: Colors.black,
                              size: 24,
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
        ),
      ),
    );
  }
}
