import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import '/pages/widgets/user_search_profile/user_search_profile_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'search_person_page_model.dart';
export 'search_person_page_model.dart';

class SearchPersonPageWidget extends StatefulWidget {
  const SearchPersonPageWidget({Key? key}) : super(key: key);

  @override
  _SearchPersonPageWidgetState createState() => _SearchPersonPageWidgetState();
}

class _SearchPersonPageWidgetState extends State<SearchPersonPageWidget> {
  late SearchPersonPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPersonPageModel());

    _model.textController ??= TextEditingController();
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                  child: StreamBuilder<List<UsersRecord>>(
                    stream: queryUsersRecord(),
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
                      List<UsersRecord> textFieldUsersRecordList =
                          snapshot.data!;
                      return Autocomplete<String>(
                        initialValue: TextEditingValue(),
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return textFieldUsersRecordList
                              .where((e) => valueOrDefault<bool>(
                                    e != null,
                                    false,
                                  ))
                              .toList()
                              .map((e) => e.displayName)
                              .toList()
                              .where((option) {
                            final lowercaseOption = option.toLowerCase();
                            return lowercaseOption
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return AutocompleteOptionsList(
                            textFieldKey: _model.textFieldKey,
                            textController: _model.textController!,
                            options: options.toList(),
                            onSelected: onSelected,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium,
                            textHighlightStyle: TextStyle(),
                            elevation: 4,
                            optionBackgroundColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            optionHighlightColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            maxHeight: 200,
                          );
                        },
                        onSelected: (String selection) {
                          setState(
                              () => _model.textFieldSelectedOption = selection);
                          FocusScope.of(context).unfocus();
                        },
                        fieldViewBuilder: (
                          context,
                          textEditingController,
                          focusNode,
                          onEditingComplete,
                        ) {
                          _model.textController = textEditingController;
                          return TextFormField(
                            key: _model.textFieldKey,
                            controller: textEditingController,
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController',
                              Duration(milliseconds: 1000),
                              () => setState(() {}),
                            ),
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
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
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<UsersRecord>>(
                stream: queryUsersRecord(),
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
                  List<UsersRecord> containerUsersRecordList = snapshot.data!;
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Builder(
                        builder: (context) {
                          final users = functions
                              .searchPerson(containerUsersRecordList.toList(),
                                  _model.textController.text)
                              .toList();
                          if (users.isEmpty) {
                            return Image.network(
                              FFAppState().emptyState,
                            );
                          }
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 4,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: users.length,
                            itemBuilder: (context, usersIndex) {
                              final usersItem = users[usersIndex];
                              return UserSearchProfileWidget(
                                key: Key(
                                    'Keydah_${usersIndex}_of_${users.length}'),
                                user: usersItem,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
