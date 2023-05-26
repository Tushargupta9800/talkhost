import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/widgets/app_bar/app_bar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'edit_profile_page_model.dart';
export 'edit_profile_page_model.dart';

class EditProfilePageWidget extends StatefulWidget {
  const EditProfilePageWidget({Key? key}) : super(key: key);

  @override
  _EditProfilePageWidgetState createState() => _EditProfilePageWidgetState();
}

class _EditProfilePageWidgetState extends State<EditProfilePageWidget> {
  late EditProfilePageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfilePageModel());

    _model.displayNameController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.phoneNumberController ??=
        TextEditingController(text: currentPhoneNumber);
    _model.addressController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.address, ''));
    _model.websiteController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.website, ''));
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
              AuthUserStreamWidget(
                builder: (context) => InkWell(
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
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          () {
                            if (_model.uploadedFileUrl != null &&
                                _model.uploadedFileUrl != '') {
                              return _model.uploadedFileUrl;
                            } else if (currentUserPhoto != null &&
                                currentUserPhoto != '') {
                              return currentUserPhoto;
                            } else {
                              return FFAppState().defaultUserPic;
                            }
                          }(),
                        ),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: AuthUserStreamWidget(
                        builder: (context) => TextFormField(
                          controller: _model.displayNameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Display Name',
                            labelStyle: FlutterFlowTheme.of(context).bodySmall,
                            hintText: currentUserDisplayName,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          maxLines: null,
                          validator: _model.displayNameControllerValidator
                              .asValidator(context),
                        ),
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
                      child: AuthUserStreamWidget(
                        builder: (context) => TextFormField(
                          controller: _model.phoneNumberController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: FlutterFlowTheme.of(context).bodySmall,
                            hintText: currentPhoneNumber,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          maxLines: null,
                          validator: _model.phoneNumberControllerValidator
                              .asValidator(context),
                        ),
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
                      child: AuthUserStreamWidget(
                        builder: (context) => TextFormField(
                          controller: _model.addressController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: FlutterFlowTheme.of(context).bodySmall,
                            hintText: valueOrDefault(
                                currentUserDocument?.address, ''),
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          maxLines: null,
                          validator: _model.addressControllerValidator
                              .asValidator(context),
                        ),
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
                      child: AuthUserStreamWidget(
                        builder: (context) => TextFormField(
                          controller: _model.websiteController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'website',
                            labelStyle: FlutterFlowTheme.of(context).bodySmall,
                            hintText: valueOrDefault(
                                currentUserDocument?.website, ''),
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          maxLines: null,
                          validator: _model.websiteControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final usersUpdateData = createUsersRecordData(
                          displayName:
                              _model.displayNameController.text == null ||
                                      _model.displayNameController.text == ''
                                  ? currentUserDisplayName
                                  : _model.displayNameController.text,
                          photoUrl: _model.uploadedFileUrl != null &&
                                  _model.uploadedFileUrl != ''
                              ? _model.uploadedFileUrl
                              : currentUserPhoto,
                          phoneNumber:
                              _model.phoneNumberController.text != null &&
                                      _model.phoneNumberController.text != ''
                                  ? _model.phoneNumberController.text
                                  : currentPhoneNumber,
                          address: _model.addressController.text != null &&
                                  _model.addressController.text != ''
                              ? _model.addressController.text
                              : valueOrDefault(
                                  currentUserDocument?.address, ''),
                          website: _model.websiteController.text != null &&
                                  _model.websiteController.text != ''
                              ? _model.websiteController.text
                              : valueOrDefault(
                                  currentUserDocument?.website, ''),
                        );
                        await currentUserReference!.update(usersUpdateData);
                        FFAppState().update(() {});
                      },
                      text: 'I\'m Done',
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
              if (!currentUserEmailVerified)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: AuthUserStreamWidget(
                    builder: (context) => Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            'Wanna Be a Host? Verify your Email by ',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await authManager.sendEmailVerification();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Verification Email Has been sent!!!',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: Color(0x00000000),
                              ),
                            );
                          },
                          child: Text(
                            'Click Here',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF0662F4),
                                ),
                          ),
                        ),
                        Text(
                          ' And Login again!!!',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
