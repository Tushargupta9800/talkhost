import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import '/pages/widgets/date_selector/date_selector_widget.dart';
import '/pages/widgets/post/post_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'calender_page_model.dart';
export 'calender_page_model.dart';

class CalenderPageWidget extends StatefulWidget {
  const CalenderPageWidget({Key? key}) : super(key: key);

  @override
  _CalenderPageWidgetState createState() => _CalenderPageWidgetState();
}

class _CalenderPageWidgetState extends State<CalenderPageWidget> {
  late CalenderPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalenderPageModel());

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
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: wrapWithModel(
                  model: _model.dateSelectorModel,
                  updateCallback: () => setState(() {}),
                  child: DateSelectorWidget(),
                ),
              ),
              StreamBuilder<List<PostsRecord>>(
                stream: queryPostsRecord(),
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
                  List<PostsRecord> containerPostsRecordList = snapshot.data!;
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Builder(
                      builder: (context) {
                        final postData = functions
                            .getCalenderData(
                                containerPostsRecordList.toList(),
                                _model.dateSelectorModel.datePicked1,
                                _model.dateSelectorModel.datePicked2)
                            .toList();
                        if (postData.isEmpty) {
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
                          itemCount: postData.length,
                          itemBuilder: (context, postDataIndex) {
                            final postDataItem = postData[postDataIndex];
                            return wrapWithModel(
                              model: _model.postModels.getModel(
                                postDataIndex.toString(),
                                postDataIndex,
                              ),
                              updateCallback: () => setState(() {}),
                              child: PostWidget(
                                key: Key(
                                  'Keydfn_${postDataIndex.toString()}',
                                ),
                                postData: postDataItem,
                                canUserClick: true,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
