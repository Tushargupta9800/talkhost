import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import '/pages/widgets/create_message_component/create_message_component_widget.dart';
import '/pages/widgets/message_component/message_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'inbox_page_model.dart';
export 'inbox_page_model.dart';

class InboxPageWidget extends StatefulWidget {
  const InboxPageWidget({Key? key}) : super(key: key);

  @override
  _InboxPageWidgetState createState() => _InboxPageWidgetState();
}

class _InboxPageWidgetState extends State<InboxPageWidget> {
  late InboxPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InboxPageModel());

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
      child: StreamBuilder<List<InboxRecord>>(
        stream: queryInboxRecord(
          queryBuilder: (inboxRecord) =>
              inboxRecord.where('user', isEqualTo: currentUserEmail),
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
          List<InboxRecord> containerInboxRecordList = snapshot.data!;
          // Return an empty Container when the item does not exist.
          if (snapshot.data!.isEmpty) {
            return Container();
          }
          final containerInboxRecord = containerInboxRecordList.isNotEmpty
              ? containerInboxRecordList.first
              : null;
          return Container(
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            setState(() {
                              _model.editMode = true;
                            });
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              barrierColor: Color(0x40000000),
                              enableDrag: false,
                              context: context,
                              builder: (bottomSheetContext) {
                                return Padding(
                                  padding: MediaQuery.of(bottomSheetContext)
                                      .viewInsets,
                                  child: Container(
                                    height: 500,
                                    child: CreateMessageComponentWidget(),
                                  ),
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          child: Icon(
                            Icons.add_circle_sharp,
                            color: Colors.black,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final messageItem =
                          containerInboxRecord!.messages.toList();
                      if (messageItem.isEmpty) {
                        return Image.network(
                          FFAppState().emptyState,
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(messageItem.length,
                              (messageItemIndex) {
                            final messageItemItem =
                                messageItem[messageItemIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: MessageComponentWidget(
                                key: Key(
                                    'Key4ly_${messageItemIndex}_of_${messageItem.length}'),
                                messageData: messageItemItem,
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
