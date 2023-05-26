import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import '/pages/widgets/post/post_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dashboard_page_model.dart';
export 'dashboard_page_model.dart';

class DashboardPageWidget extends StatefulWidget {
  const DashboardPageWidget({Key? key}) : super(key: key);

  @override
  _DashboardPageWidgetState createState() => _DashboardPageWidgetState();
}

class _DashboardPageWidgetState extends State<DashboardPageWidget> {
  late DashboardPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardPageModel());

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
      child: StreamBuilder<List<DashboardRecord>>(
        stream: queryDashboardRecord(
          queryBuilder: (dashboardRecord) =>
              dashboardRecord.where('user', isEqualTo: currentUserReference),
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
          List<DashboardRecord> containerDashboardRecordList = snapshot.data!;
          // Return an empty Container when the item does not exist.
          if (snapshot.data!.isEmpty) {
            return Container();
          }
          final containerDashboardRecord =
              containerDashboardRecordList.isNotEmpty
                  ? containerDashboardRecordList.first
                  : null;
          return Container(
            width: MediaQuery.of(context).size.width,
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          setState(() {
                            _model.previewMode = false;
                          });
                        },
                        text: 'Edit',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: !_model.previewMode
                              ? Color(0xFF06A5F4)
                              : Color(0xFF0662F4),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            setState(() {
                              _model.previewMode = true;
                            });
                          },
                          text: 'Preview',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: _model.previewMode
                                ? Color(0xFF06A5F4)
                                : Color(0xFF0662F4),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final dashboardUpdateData =
                                createDashboardRecordData(
                              about: _model.textController.text != null &&
                                      _model.textController.text != ''
                                  ? _model.textController.text
                                  : FFAppState().defaultAboutMe,
                              businessCard: _model.uploadedFileUrl != null &&
                                      _model.uploadedFileUrl != ''
                                  ? _model.uploadedFileUrl
                                  : FFAppState().defaulltAgendaBanner,
                            );
                            await containerDashboardRecord!.reference
                                .update(dashboardUpdateData);
                          },
                          text: 'Save',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Stack(
                      children: [
                        if (!_model.previewMode)
                          TextFormField(
                            controller: _model.textController ??=
                                TextEditingController(
                              text: containerDashboardRecord!.about != null &&
                                      containerDashboardRecord!.about != ''
                                  ? containerDashboardRecord!.about
                                  : FFAppState().defaultAboutMe,
                            ),
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'About Me... (Markdown Supported)',
                              hintStyle: FlutterFlowTheme.of(context).bodySmall,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                            maxLines: 15,
                            keyboardType: TextInputType.multiline,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        if (_model.previewMode)
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: custom_widgets.MarkdownRenderer(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.65,
                              data: () {
                                if (_model.textController.text != null &&
                                    _model.textController.text != '') {
                                  return _model.textController.text;
                                } else if (containerDashboardRecord!.about !=
                                        null &&
                                    containerDashboardRecord!.about != '') {
                                  return containerDashboardRecord!.about;
                                } else {
                                  return FFAppState().defaultAboutMe;
                                }
                              }(),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Business Card:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          allowPhoto: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => _model.isDataUploading = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];
                          var downloadUrls = <String>[];
                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                (m) async =>
                                    await uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((u) => u != null)
                                .map((u) => u!)
                                .toList();
                          } finally {
                            _model.isDataUploading = false;
                          }
                          if (selectedUploadedFiles.length ==
                                  selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            setState(() {
                              _model.uploadedLocalFile =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl = downloadUrls.first;
                            });
                          } else {
                            setState(() {});
                            return;
                          }
                        }
                      },
                      child: Container(
                        width: 800,
                        height: 350,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              () {
                                if (_model.uploadedFileUrl != null &&
                                    _model.uploadedFileUrl != '') {
                                  return _model.uploadedFileUrl;
                                } else if (containerDashboardRecord!
                                            .businessCard !=
                                        null &&
                                    containerDashboardRecord!.businessCard !=
                                        '') {
                                  return containerDashboardRecord!.businessCard;
                                } else {
                                  return FFAppState().defaulltAgendaBanner;
                                }
                              }(),
                            ).image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Attended Talks:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final attendedPostItem =
                          containerDashboardRecord!.attendedTalk.toList();
                      if (attendedPostItem.isEmpty) {
                        return Image.network(
                          FFAppState().emptyState,
                          fit: BoxFit.cover,
                        );
                      }
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: attendedPostItem.length,
                        itemBuilder: (context, attendedPostItemIndex) {
                          final attendedPostItemItem =
                              attendedPostItem[attendedPostItemIndex];
                          return StreamBuilder<PostsRecord>(
                            stream:
                                PostsRecord.getDocument(attendedPostItemItem),
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
                              final postPostsRecord = snapshot.data!;
                              return PostWidget(
                                key: Key(
                                    'Key752_${attendedPostItemIndex}_of_${attendedPostItem.length}'),
                                postData: postPostsRecord,
                                canUserClick: true,
                              );
                            },
                          );
                        },
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
