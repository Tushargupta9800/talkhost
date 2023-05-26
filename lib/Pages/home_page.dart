import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/drawer_pages/about_us_page/about_us_page_widget.dart';
import '/pages/drawer_pages/all_talks_page/all_talks_page_widget.dart';
import '/pages/drawer_pages/calender_page/calender_page_widget.dart';
import '/pages/drawer_pages/create_talk_page/create_talk_page_widget.dart';
import '/pages/drawer_pages/dashboard_page/dashboard_page_widget.dart';
import '/pages/drawer_pages/edit_profile_page/edit_profile_page_widget.dart';
import '/pages/drawer_pages/inbox_page/inbox_page_widget.dart';
import '/pages/drawer_pages/my_hosted_talks_page/my_hosted_talks_page_widget.dart';
import '/pages/drawer_pages/notifications_page/notifications_page_widget.dart';
import '/pages/drawer_pages/search_person_page/search_person_page_widget.dart';
import '/pages/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                wrapWithModel(
                  model: _model.drawerModel,
                  updateCallback: () => setState(() {}),
                  child: DrawerWidget(),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.rectangle,
                    ),
                    child: Stack(
                      children: [
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().editprofilepagekey)
                          wrapWithModel(
                            model: _model.editProfilePageModel,
                            updateCallback: () => setState(() {}),
                            child: EditProfilePageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().createtalkpagekey)
                          wrapWithModel(
                            model: _model.createTalkPageModel,
                            updateCallback: () => setState(() {}),
                            child: CreateTalkPageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().MyHostedTalksPageKey)
                          wrapWithModel(
                            model: _model.myHostedTalksPageModel,
                            updateCallback: () => setState(() {}),
                            child: MyHostedTalksPageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().AboutUsPageKey)
                          wrapWithModel(
                            model: _model.aboutUsPageModel,
                            updateCallback: () => setState(() {}),
                            child: AboutUsPageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().SearhPersonPageKey)
                          wrapWithModel(
                            model: _model.searchPersonPageModel,
                            updateCallback: () => setState(() {}),
                            child: SearchPersonPageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().AllTalksPageKey)
                          wrapWithModel(
                            model: _model.allTalksPageModel,
                            updateCallback: () => setState(() {}),
                            child: AllTalksPageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().notificationPageKey)
                          StreamBuilder<List<NotificationsRecord>>(
                            stream: queryNotificationsRecord(
                              queryBuilder: (notificationsRecord) =>
                                  notificationsRecord.where('userRef',
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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                );
                              }
                              List<NotificationsRecord>
                                  notificationsPageNotificationsRecordList =
                                  snapshot.data!;
                              final notificationsPageNotificationsRecord =
                                  notificationsPageNotificationsRecordList
                                          .isNotEmpty
                                      ? notificationsPageNotificationsRecordList
                                          .first
                                      : null;
                              return wrapWithModel(
                                model: _model.notificationsPageModel,
                                updateCallback: () => setState(() {}),
                                child: NotificationsPageWidget(
                                  allNotifications:
                                      notificationsPageNotificationsRecord,
                                ),
                              );
                            },
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().DashBoardPageKey)
                          wrapWithModel(
                            model: _model.dashboardPageModel,
                            updateCallback: () => setState(() {}),
                            child: DashboardPageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().InboxPageKey)
                          wrapWithModel(
                            model: _model.inboxPageModel,
                            updateCallback: () => setState(() {}),
                            child: InboxPageWidget(),
                          ),
                        if (FFAppState().homeOpenedDrawerPage ==
                            FFAppState().todayPageKey)
                          wrapWithModel(
                            model: _model.calenderPageModel,
                            updateCallback: () => setState(() {}),
                            child: CalenderPageWidget(),
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
