import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'create_talk_page_model.dart';
export 'create_talk_page_model.dart';

class CreateTalkPageWidget extends StatefulWidget {
  const CreateTalkPageWidget({Key? key}) : super(key: key);

  @override
  _CreateTalkPageWidgetState createState() => _CreateTalkPageWidgetState();
}

class _CreateTalkPageWidgetState extends State<CreateTalkPageWidget> {
  late CreateTalkPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateTalkPageModel());

    _model.agendaController ??= TextEditingController();
    _model.roomNameController ??= TextEditingController();
    _model.guestEmailsController ??= TextEditingController();
    _model.invitationsController ??= TextEditingController();
    _model.meetingIdController ??= TextEditingController();
    _model.meetingPasswordController ??= TextEditingController();
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: wrapWithModel(
                  model: _model.appBarModel,
                  updateCallback: () => setState(() {}),
                  child: AppBarWidget(),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
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
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              _model.uploadedFileUrl != null &&
                                      _model.uploadedFileUrl != ''
                                  ? _model.uploadedFileUrl
                                  : FFAppState().defaulltAgendaBanner,
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await actions.openAndSaveData(
                            currentUserEmail,
                          );
                        },
                        child: Text(
                          'Upload Csv',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await launchURL(
                              'https://docs.google.com/spreadsheets/d/1WUHT_C2Ze30cklJMX7tOBNwGBJvupD_7c-bL9kQZ6BY/edit#gid=0');
                        },
                        child: Text(
                          'Example Csv',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: TextFormField(
                        controller: _model.agendaController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Agenda',
                          labelStyle: FlutterFlowTheme.of(context).bodySmall,
                          hintText: 'This is an Agenda',
                          hintStyle: FlutterFlowTheme.of(context).bodySmall,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF010710),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3C3737),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: null,
                        validator: _model.agendaControllerValidator
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: TextFormField(
                        controller: _model.roomNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Room Name',
                          labelStyle: FlutterFlowTheme.of(context).bodySmall,
                          hintText: 'Global Warming...',
                          hintStyle: FlutterFlowTheme.of(context).bodySmall,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF010710),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3C3737),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: null,
                        validator: _model.roomNameControllerValidator
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: TextFormField(
                        controller: _model.guestEmailsController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Guest Emails',
                          labelStyle: FlutterFlowTheme.of(context).bodySmall,
                          hintText: 'email1@domain.com, email2@gmail.com',
                          hintStyle: FlutterFlowTheme.of(context).bodySmall,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF010710),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3C3737),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: null,
                        validator: _model.guestEmailsControllerValidator
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: TextFormField(
                        controller: _model.invitationsController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Invitation Emails',
                          labelStyle: FlutterFlowTheme.of(context).bodySmall,
                          hintText: 'email1@domain.com, email2@gmail.com',
                          hintStyle: FlutterFlowTheme.of(context).bodySmall,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF010710),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3C3737),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEF0D0D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: null,
                        validator: _model.invitationsControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                        final _datePicked1Date = await showDatePicker(
                          context: context,
                          initialDate: getCurrentTimestamp,
                          firstDate: getCurrentTimestamp,
                          lastDate: DateTime(2050),
                        );

                        TimeOfDay? _datePicked1Time;
                        if (_datePicked1Date != null) {
                          _datePicked1Time = await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(getCurrentTimestamp),
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
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Text(
                        dateTimeFormat('d/M h:mm a', _model.startTime) !=
                                    null &&
                                dateTimeFormat(
                                        'd/M h:mm a', _model.startTime) !=
                                    ''
                            ? dateTimeFormat('d/M h:mm a', _model.startTime)
                            : 'Choose Start Time',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final _datePicked2Date = await showDatePicker(
                            context: context,
                            initialDate: getCurrentTimestamp,
                            firstDate: getCurrentTimestamp,
                            lastDate: DateTime(2050),
                          );

                          TimeOfDay? _datePicked2Time;
                          if (_datePicked2Date != null) {
                            _datePicked2Time = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(getCurrentTimestamp),
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
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Text(
                        dateTimeFormat('d/M h:mm a', _model.endTime) != null &&
                                dateTimeFormat('d/M h:mm a', _model.endTime) !=
                                    ''
                            ? dateTimeFormat('d/M h:mm a', _model.endTime)
                            : 'Choose End Time',
                        style: FlutterFlowTheme.of(context).bodyMedium,
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
                      'Do You Already Have A Meet Link?',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Switch(
                      value: _model.meetLinkSwitchValue ??= false,
                      onChanged: (newValue) async {
                        setState(() => _model.meetLinkSwitchValue = newValue!);
                      },
                    ),
                  ],
                ),
              ),
              if (_model.meetLinkSwitchValue == true)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Container(
                            width: 1,
                            child: TextFormField(
                              controller: _model.meetingIdController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Meeting Id',
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                hintText: 'zoom.us/...',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF010710),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF010710),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                              validator: _model.meetingIdControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Container(
                            width: 1,
                            child: TextFormField(
                              controller: _model.meetingPasswordController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Meeting Password',
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                hintText: 'Password If Any',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF010710),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF010710),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Enable Notifications',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Switch(
                      value: _model.notificationSwitchValue ??= false,
                      onChanged: (newValue) async {
                        setState(
                            () => _model.notificationSwitchValue = newValue!);
                      },
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
                      'Wants to Make Talk Public?',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Switch(
                      value: _model.makingTalkPublicSwitchValue ??= false,
                      onChanged: (newValue) async {
                        setState(() =>
                            _model.makingTalkPublicSwitchValue = newValue!);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: Text(
                  _model.errorString,
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        setState(() {
                          _model.startTime = null;
                          _model.endTime = null;
                          _model.errorString = ' ';
                        });
                        setState(() {
                          _model.agendaController?.clear();
                          _model.roomNameController?.clear();
                          _model.guestEmailsController?.clear();
                          _model.invitationsController?.clear();
                          _model.meetingIdController?.clear();
                          _model.meetingPasswordController?.clear();
                        });
                      },
                      text: 'Reset',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
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
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        var _shouldSetState = false;
                        if (functions.formValidator(
                                    _model.agendaController.text,
                                    _model.roomNameController.text,
                                    _model.guestEmailsController.text,
                                    _model.invitationsController.text,
                                    _model.startTime,
                                    _model.endTime,
                                    _model.meetLinkSwitchValue!,
                                    _model.meetingIdController.text,
                                    _model.meetingPasswordController.text,
                                    _model.notificationSwitchValue!,
                                    _model.makingTalkPublicSwitchValue!,
                                    true) ==
                                'Success'
                            ? true
                            : false) {
                          final postsCreateData = {
                            ...createPostsRecordData(
                              agenda: _model.agendaController.text,
                              agedaBannerPic: _model.uploadedFileUrl != null &&
                                      _model.uploadedFileUrl != ''
                                  ? _model.uploadedFileUrl
                                  : FFAppState().defaulltAgendaBanner,
                              alreadyHaveMeetLink: _model.meetLinkSwitchValue,
                              startTime: _model.startTime,
                              endTime: _model.endTime,
                              hostEmail: currentUserEmail,
                              makeTalkPublic:
                                  _model.makingTalkPublicSwitchValue,
                              meetingId: _model.meetLinkSwitchValue!
                                  ? _model.meetingIdController.text
                                  : functions.createJitsiMeetLink(),
                              meetingPassword:
                                  _model.meetingPasswordController.text,
                              enableNotification:
                                  _model.notificationSwitchValue,
                              roomName: _model.roomNameController.text,
                            ),
                            'attendees': functions.stringToEmail(
                                _model.invitationsController.text),
                            'guests': functions.stringToEmail(
                                _model.guestEmailsController.text),
                            'invitations': functions.stringToEmail(
                                _model.invitationsController.text),
                          };
                          var postsRecordReference =
                              PostsRecord.collection.doc();
                          await postsRecordReference.set(postsCreateData);
                          _model.postDocRef = PostsRecord.getDocumentFromData(
                              postsCreateData, postsRecordReference);
                          _shouldSetState = true;
                          setState(() {
                            _model.errorString = ' ';
                          });
                          await actions.sendNotificationForPost(
                            _model.postDocRef!.guests.toList(),
                            _model.postDocRef!.invitations.toList(),
                            _model.postDocRef!.enableNotification,
                            _model.postDocRef!.reference,
                            true,
                          );
                          FFAppState().update(() {
                            FFAppState().homeOpenedDrawerPage =
                                FFAppState().MyHostedTalksPageKey;
                          });
                          FFAppState().update(() {
                            FFAppState().homePageAppBarText =
                                FFAppState().MyHostedTalksPageKey;
                          });
                        } else {
                          _model.updatePage(() {
                            _model.errorString = functions.formValidator(
                                _model.agendaController.text,
                                _model.roomNameController.text,
                                _model.guestEmailsController.text,
                                _model.invitationsController.text,
                                _model.startTime,
                                _model.endTime,
                                _model.meetLinkSwitchValue!,
                                _model.meetingIdController.text,
                                _model.meetingPasswordController.text,
                                _model.notificationSwitchValue!,
                                _model.makingTalkPublicSwitchValue!,
                                true);
                          });
                          if (_shouldSetState) setState(() {});
                          return;
                        }

                        if (_shouldSetState) setState(() {});
                      },
                      text: 'Submit',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
