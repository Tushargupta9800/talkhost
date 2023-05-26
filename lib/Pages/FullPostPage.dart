import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/widgets/user_search_no_profile/user_search_no_profile_widget.dart';
import '/pages/widgets/user_search_profile/user_search_profile_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'full_post_page_model.dart';
export 'full_post_page_model.dart';

class FullPostPageWidget extends StatefulWidget {
  const FullPostPageWidget({
    Key? key,
    this.postDetails,
  }) : super(key: key);

  final PostsRecord? postDetails;

  @override
  _FullPostPageWidgetState createState() => _FullPostPageWidgetState();
}

class _FullPostPageWidgetState extends State<FullPostPageWidget> {
  late FullPostPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FullPostPageModel());

    _model.agendaController ??=
        TextEditingController(text: widget.postDetails!.agenda);
    _model.roomNameController ??=
        TextEditingController(text: widget.postDetails!.roomName);
    _model.guestEmailsController ??= TextEditingController();
    _model.invitationsController ??= TextEditingController();
    _model.meetingIdController ??=
        TextEditingController(text: widget.postDetails!.meetingId);
    _model.meetingPasswordController ??=
        TextEditingController(text: widget.postDetails!.meetingPassword);
    _model.searchGuestController ??= TextEditingController();
    _model.inviteeSearchController ??= TextEditingController();
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          iconTheme: IconThemeData(
              color: FlutterFlowTheme.of(context).primaryBackground),
          automaticallyImplyLeading: true,
          title: Text(
            'Post',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (widget.postDetails!.hostEmail == currentUserEmail)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Edit Post?',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          Switch(
                            value: _model.editPostValue ??= false,
                            onChanged: (newValue) async {
                              setState(() => _model.editPostValue = newValue!);
                            },
                          ),
                        ],
                      ),
                    if ((widget.postDetails!.hostEmail == currentUserEmail) &&
                        _model.editPostValue!)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
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
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];
                                    var downloadUrls = <String>[];
                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                                blurHash: m.blurHash,
                                              ))
                                          .toList();

                                      downloadUrls = (await Future.wait(
                                        selectedMedia.map(
                                          (m) async => await uploadData(
                                              m.storagePath, m.bytes),
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
                                        downloadUrls.length ==
                                            selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile =
                                            selectedUploadedFiles.first;
                                        _model.uploadedFileUrl =
                                            downloadUrls.first;
                                      });
                                    } else {
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                          _model.uploadedFileUrl != null &&
                                                  _model.uploadedFileUrl != ''
                                              ? _model.uploadedFileUrl
                                              : widget
                                                  .postDetails!.agedaBannerPic,
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: TextFormField(
                                        controller: _model.agendaController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Agenda',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          hintText: 'This is an Agenda',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF010710),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C3737),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 24, 0, 24),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        maxLines: null,
                                        validator: _model
                                            .agendaControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: TextFormField(
                                        controller: _model.roomNameController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Room Name',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          hintText: 'Global Warming...',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF010710),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C3737),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 24, 0, 24),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        maxLines: null,
                                        validator: _model
                                            .roomNameControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: TextFormField(
                                        controller:
                                            _model.guestEmailsController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Add Guest Emails',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          hintText:
                                              'email1@domain.com, email2@gmail.com',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF010710),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C3737),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 24, 0, 24),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        maxLines: null,
                                        validator: _model
                                            .guestEmailsControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: TextFormField(
                                        controller:
                                            _model.invitationsController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Add Invitation Emails',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          hintText:
                                              'email1@domain.com, email2@gmail.com',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF010710),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C3737),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEF0D0D),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 24, 0, 24),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        maxLines: null,
                                        validator: _model
                                            .invitationsControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final _datePicked1Date =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: getCurrentTimestamp,
                                          firstDate: getCurrentTimestamp,
                                          lastDate: DateTime(2050),
                                        );

                                        TimeOfDay? _datePicked1Time;
                                        if (_datePicked1Date != null) {
                                          _datePicked1Time =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                getCurrentTimestamp),
                                          );
                                        }

                                        if (_datePicked1Date != null &&
                                            _datePicked1Time != null) {
                                          setState(() {
                                            _model.datePicked1 = DateTime(
                                              _datePicked1Date.year,
                                              _datePicked1Date.month,
                                              _datePicked1Date.day,
                                              _datePicked1Time!.hour,
                                              _datePicked1Time.minute,
                                            );
                                          });
                                        }
                                        setState(() {
                                          _model.startTime = _model.datePicked1;
                                        });
                                      },
                                      child: Icon(
                                        Icons.timer_sharp,
                                        color: Colors.black,
                                        size: 50,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        dateTimeFormat('d/M h:mm a',
                                                        _model.startTime) !=
                                                    null &&
                                                dateTimeFormat('d/M h:mm a',
                                                        _model.startTime) !=
                                                    ''
                                            ? dateTimeFormat(
                                                'd/M h:mm a', _model.startTime)
                                            : dateTimeFormat('d/M h:mm a',
                                                widget.postDetails!.startTime!),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          final _datePicked2Date =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: getCurrentTimestamp,
                                            firstDate: getCurrentTimestamp,
                                            lastDate: DateTime(2050),
                                          );

                                          TimeOfDay? _datePicked2Time;
                                          if (_datePicked2Date != null) {
                                            _datePicked2Time =
                                                await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(
                                                      getCurrentTimestamp),
                                            );
                                          }

                                          if (_datePicked2Date != null &&
                                              _datePicked2Time != null) {
                                            setState(() {
                                              _model.datePicked2 = DateTime(
                                                _datePicked2Date.year,
                                                _datePicked2Date.month,
                                                _datePicked2Date.day,
                                                _datePicked2Time!.hour,
                                                _datePicked2Time.minute,
                                              );
                                            });
                                          }
                                          setState(() {
                                            _model.endTime = _model.datePicked2;
                                          });
                                        },
                                        child: Icon(
                                          Icons.timer_rounded,
                                          color: Colors.black,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        dateTimeFormat('d/M h:mm a',
                                                        _model.endTime) !=
                                                    null &&
                                                dateTimeFormat('d/M h:mm a',
                                                        _model.endTime) !=
                                                    ''
                                            ? dateTimeFormat(
                                                'd/M h:mm a', _model.endTime)
                                            : dateTimeFormat('d/M h:mm a',
                                                widget.postDetails!.endTime!),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Do You Already Have A Meet Link?',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                    Switch(
                                      value: _model.meetLinkSwitchValue ??=
                                          widget
                                              .postDetails!.alreadyHaveMeetLink,
                                      onChanged: (newValue) async {
                                        setState(() => _model
                                            .meetLinkSwitchValue = newValue!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (_model.meetLinkSwitchValue == true)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: Container(
                                            width: 1,
                                            child: TextFormField(
                                              controller:
                                                  _model.meetingIdController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Meeting Id',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall,
                                                hintText: 'zoom.us/...',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF010710),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF010710),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .meetingIdControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Container(
                                            width: 1,
                                            child: TextFormField(
                                              controller: _model
                                                  .meetingPasswordController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Meeting Password',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall,
                                                hintText: 'Password If Any',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF010710),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF010710),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .meetingPasswordControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Send Notifications for  Talk Update',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                    Switch(
                                      value: _model.notificationSwitchValue ??=
                                          widget
                                              .postDetails!.enableNotification,
                                      onChanged: (newValue) async {
                                        setState(() =>
                                            _model.notificationSwitchValue =
                                                newValue!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Wants to Make Talk Public?',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                    Switch(
                                      value: _model
                                              .makingTalkPublicSwitchValue ??=
                                          widget.postDetails!.makeTalkPublic,
                                      onChanged: (newValue) async {
                                        setState(() =>
                                            _model.makingTalkPublicSwitchValue =
                                                newValue!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 20),
                                child: Text(
                                  _model.errorString,
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 20),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (functions.formValidator(
                                                    _model
                                                        .agendaController.text,
                                                    _model.roomNameController
                                                        .text,
                                                    _model.guestEmailsController
                                                        .text,
                                                    _model.invitationsController
                                                        .text,
                                                    _model.startTime == null
                                                        ? widget.postDetails!
                                                            .startTime
                                                        : _model.startTime,
                                                    _model.endTime == null
                                                        ? widget.postDetails!
                                                            .endTime
                                                        : _model.endTime,
                                                    _model.meetLinkSwitchValue!,
                                                    _model.meetingIdController
                                                        .text,
                                                    _model
                                                        .meetingPasswordController
                                                        .text,
                                                    _model
                                                        .notificationSwitchValue!,
                                                    _model
                                                        .makingTalkPublicSwitchValue!,
                                                    false) ==
                                                'Success'
                                            ? true
                                            : false) {
                                          setState(() {
                                            _model.errorString = ' ';
                                          });
                                          await actions.updatePost(
                                            _model.agendaController.text,
                                            _model.roomNameController.text,
                                            _model.guestEmailsController.text,
                                            _model.invitationsController.text,
                                            _model.notificationSwitchValue!,
                                            _model.makingTalkPublicSwitchValue!,
                                            _model.meetLinkSwitchValue!,
                                            _model.meetingIdController.text,
                                            _model
                                                .meetingPasswordController.text,
                                            _model.startTime == null
                                                ? widget.postDetails!.startTime!
                                                : _model.startTime!,
                                            _model.endTime == null
                                                ? widget.postDetails!.endTime!
                                                : _model.endTime!,
                                            widget.postDetails!.reference,
                                            _model.uploadedFileUrl == null ||
                                                    _model.uploadedFileUrl == ''
                                                ? widget
                                                    .postDetails!.agedaBannerPic
                                                : _model.uploadedFileUrl,
                                          );
                                          await actions.sendNotificationForPost(
                                            widget.postDetails!.guests.toList(),
                                            widget.postDetails!.invitations
                                                .toList(),
                                            _model.notificationSwitchValue!,
                                            widget.postDetails!.reference,
                                            false,
                                          );
                                          await actions.sendNotificationForPost(
                                            functions
                                                .stringToEmail(_model
                                                    .guestEmailsController.text)
                                                .toList(),
                                            functions
                                                .stringToEmail(_model
                                                    .invitationsController.text)
                                                .toList(),
                                            _model.notificationSwitchValue!,
                                            widget.postDetails!.reference,
                                            true,
                                          );
                                          context.safePop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Post Has been Updated',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                          return;
                                        } else {
                                          setState(() {
                                            _model.errorString =
                                                functions.formValidator(
                                                    _model
                                                        .agendaController.text,
                                                    _model.roomNameController
                                                        .text,
                                                    _model.guestEmailsController
                                                        .text,
                                                    _model.invitationsController
                                                        .text,
                                                    _model.startTime == null
                                                        ? widget.postDetails!
                                                            .startTime
                                                        : _model.startTime,
                                                    _model.endTime == null
                                                        ? widget.postDetails!
                                                            .endTime
                                                        : _model.endTime,
                                                    _model.meetLinkSwitchValue!,
                                                    _model.meetingIdController
                                                        .text,
                                                    _model
                                                        .meetingPasswordController
                                                        .text,
                                                    _model
                                                        .notificationSwitchValue!,
                                                    _model
                                                        .makingTalkPublicSwitchValue!,
                                                    false);
                                          });
                                          return;
                                        }
                                      },
                                      text: 'Update Talk',
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
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
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(
                                  widget.postDetails!.agedaBannerPic,
                                ).image,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 20, 0),
                                  child: Text(
                                    'Host:',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                StreamBuilder<List<UsersRecord>>(
                                  stream: queryUsersRecord(
                                    queryBuilder: (usersRecord) =>
                                        usersRecord.where('email',
                                            isEqualTo:
                                                widget.postDetails!.hostEmail),
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
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      );
                                    }
                                    List<UsersRecord>
                                        userSearchProfileUsersRecordList =
                                        snapshot.data!;
                                    // Return an empty Container when the item does not exist.
                                    if (snapshot.data!.isEmpty) {
                                      return Container();
                                    }
                                    final userSearchProfileUsersRecord =
                                        userSearchProfileUsersRecordList
                                                .isNotEmpty
                                            ? userSearchProfileUsersRecordList
                                                .first
                                            : null;
                                    return wrapWithModel(
                                      model: _model.userSearchProfileModel1,
                                      updateCallback: () => setState(() {}),
                                      child: UserSearchProfileWidget(
                                        user: userSearchProfileUsersRecord,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: Text(
                                  'StartTime:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 100, 0),
                                child: Text(
                                  dateTimeFormat('d/M h:mm a',
                                      widget.postDetails!.startTime!),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: Text(
                                  'End Time:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Text(
                                dateTimeFormat(
                                    'd/M h:mm a', widget.postDetails!.endTime!),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Text(
                            'Room Name:',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SelectionArea(
                              child: Text(
                            widget.postDetails!.roomName,
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          )),
                          Divider(
                            thickness: 1,
                          ),
                          Text(
                            'Agenda:',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SelectionArea(
                              child: Text(
                            widget.postDetails!.agenda,
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          )),
                          Divider(
                            thickness: 1,
                          ),
                          if ((widget.postDetails!.startTime! <=
                                  functions.timeNow()) &&
                              (widget.postDetails!.endTime! >=
                                  functions.timeNow()))
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Meeting Informations:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await launchURL(
                                          widget.postDetails!.meetingId);
                                    },
                                    child: Text(
                                      widget.postDetails!.meetingId,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Text(
                                    '@',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                SelectionArea(
                                    child: Text(
                                  widget.postDetails!.meetingPassword,
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                )),
                              ],
                            ),
                          if ((widget.postDetails!.startTime! <=
                                  functions.timeNow()) &&
                              (widget.postDetails!.endTime! >=
                                  functions.timeNow()))
                            Divider(
                              thickness: 1,
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Guests List:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 500, 0),
                                  child: TextFormField(
                                    controller: _model.searchGuestController,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.searchGuestController',
                                      Duration(milliseconds: 1000),
                                      () => setState(() {}),
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search By Email',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF0662F4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF0662F4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF0662F4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color(0xFF0662F4),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: _model
                                        .searchGuestControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Builder(
                            builder: (context) {
                              final guestEmail = functions
                                  .queryEmails(
                                      widget.postDetails!.guests.toList(),
                                      _model.searchGuestController.text)
                                  .toList();
                              if (guestEmail.isEmpty) {
                                return Image.network(
                                  FFAppState().emptyState,
                                );
                              }
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(guestEmail.length,
                                      (guestEmailIndex) {
                                    final guestEmailItem =
                                        guestEmail[guestEmailIndex];
                                    return StreamBuilder<List<UsersRecord>>(
                                      stream: queryUsersRecord(
                                        queryBuilder: (usersRecord) =>
                                            usersRecord.where('email',
                                                isEqualTo: guestEmailItem),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                            ),
                                          );
                                        }
                                        List<UsersRecord> stackUsersRecordList =
                                            snapshot.data!;
                                        final stackUsersRecord =
                                            stackUsersRecordList.isNotEmpty
                                                ? stackUsersRecordList.first
                                                : null;
                                        return Stack(
                                          children: [
                                            if (!(stackUsersRecord != null))
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 20, 20),
                                                child:
                                                    UserSearchNoProfileWidget(
                                                  key: Key(
                                                      'Key9qz_${guestEmailIndex}_of_${guestEmail.length}'),
                                                  email: guestEmailItem,
                                                ),
                                              ),
                                            if (stackUsersRecord != null)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 20, 20),
                                                child: UserSearchProfileWidget(
                                                  key: Key(
                                                      'Keyyxd_${guestEmailIndex}_of_${guestEmail.length}'),
                                                  user: stackUsersRecord,
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Invitee List:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 500, 0),
                                  child: TextFormField(
                                    controller: _model.inviteeSearchController,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.inviteeSearchController',
                                      Duration(milliseconds: 1000),
                                      () => setState(() {}),
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search By Email',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF0662F4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF0662F4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF0662F4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color(0xFF0662F4),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: _model
                                        .inviteeSearchControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Builder(
                            builder: (context) {
                              final guestEmail = functions
                                  .queryEmails(
                                      widget.postDetails!.guests.toList(),
                                      _model.inviteeSearchController.text)
                                  .toList();
                              if (guestEmail.isEmpty) {
                                return Image.network(
                                  FFAppState().emptyState,
                                );
                              }
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(guestEmail.length,
                                      (guestEmailIndex) {
                                    final guestEmailItem =
                                        guestEmail[guestEmailIndex];
                                    return StreamBuilder<List<UsersRecord>>(
                                      stream: queryUsersRecord(
                                        queryBuilder: (usersRecord) =>
                                            usersRecord.where('email',
                                                isEqualTo: guestEmailItem),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                            ),
                                          );
                                        }
                                        List<UsersRecord> stackUsersRecordList =
                                            snapshot.data!;
                                        final stackUsersRecord =
                                            stackUsersRecordList.isNotEmpty
                                                ? stackUsersRecordList.first
                                                : null;
                                        return Stack(
                                          children: [
                                            if (!(stackUsersRecord != null))
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 20, 20),
                                                child:
                                                    UserSearchNoProfileWidget(
                                                  key: Key(
                                                      'Keyzx8_${guestEmailIndex}_of_${guestEmail.length}'),
                                                  email: guestEmailItem,
                                                ),
                                              ),
                                            if (stackUsersRecord != null)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 20, 20),
                                                child: UserSearchProfileWidget(
                                                  key: Key(
                                                      'Keyll4_${guestEmailIndex}_of_${guestEmail.length}'),
                                                  user: stackUsersRecord,
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Text(
                            'SubEvent:',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SelectionArea(
                              child: Text(
                            widget.postDetails!.subEvent,
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          )),
                          Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
