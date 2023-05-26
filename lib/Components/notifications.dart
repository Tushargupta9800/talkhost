import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import '/pages/widgets/notification_post/notification_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'notifications_page_model.dart';
export 'notifications_page_model.dart';

class NotificationsPageWidget extends StatefulWidget {
  const NotificationsPageWidget({
    Key? key,
    this.allNotifications,
  }) : super(key: key);

  final NotificationsRecord? allNotifications;

  @override
  _NotificationsPageWidgetState createState() =>
      _NotificationsPageWidgetState();
}

class _NotificationsPageWidgetState extends State<NotificationsPageWidget> {
  late NotificationsPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsPageModel());

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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Stack(
                  children: [
                    if (_model.isInvitations)
                      Builder(
                        builder: (context) {
                          final invitedNotif =
                              widget.allNotifications!.notifications.toList();
                          if (invitedNotif.isEmpty) {
                            return Image.network(
                              FFAppState().emptyState,
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
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: invitedNotif.length,
                            itemBuilder: (context, invitedNotifIndex) {
                              final invitedNotifItem =
                                  invitedNotif[invitedNotifIndex];
                              return NotificationPostWidget(
                                key: Key(
                                    'Keyn3j_${invitedNotifIndex}_of_${invitedNotif.length}'),
                                postDataRef: invitedNotifItem.postId,
                                isPostNew: invitedNotifItem.isNewPost,
                              );
                            },
                          );
                        },
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
