import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/create_meet_cubit.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/app_bar.dart';
import 'package:talkhost/Utilities/buttons.dart';

import '../../Utilities/strings.dart';
import '../../Utilities/theme.dart';

class CreateMeetPage extends StatefulWidget {
  const CreateMeetPage({Key? key}) : super(key: key);

  @override
  State<CreateMeetPage> createState() => _CreateMeetPageState();
}

class _CreateMeetPageState extends State<CreateMeetPage> {
  Widget editable(
    String title,
    TextEditingController controller,
    String hintText,
  ) {
    return SizedBox(
      width: max(MediaQuery.of(context).size.width / 3, 250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetCubit, CreateMeetState>(
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBarUtil(title: "Create Talk Link"),
                  Wrap(
                    spacing: 40.0,
                    children: [
                      editable(
                        "Agenda",
                        getCreateMeetPageState(context: context)
                            .agendaController,
                        "How to stop Global Warming",
                      ),
                      editable(
                        "Room Name",
                        getCreateMeetPageState(context: context)
                            .roomNameController,
                        "Environment Saviours",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Guest Emails"),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: getCreateMeetPageState(context: context)
                        .guestEmailController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          "Enter the guest Emails Separated by commas Eg: abcd@gmail.com, xyz@gmail.com",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Attendees Emails"),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: getCreateMeetPageState(context: context)
                        .userEmailController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          "Enter the Attendees Emails Separated by commas Eg: abcd@gmail.com, xyz@gmail.com",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  mouseButton(
                    child: Row(
                      children: [
                        const Text("Choose the file to upload      "),
                        Image.network(
                          (getCreateMeetPageState(context: context)
                                      .getImageAddress() ==
                                  "")
                              ? imageTalkHostDrawerBackgroundKey
                              : getCreateMeetPageState(context: context)
                                  .getImageAddress(),
                          height: 40,
                          width: 40,
                        ),

                      ],
                    ),
                    onPressed: () => getCreateMeetPageCubit(
                      context: context,
                    ).onChoosingImageFile(
                      context,
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Do You already Have a meet link?     "),
                      Switch(
                        value: getCreateMeetPageState(context: context)
                            .alreadyHaveMeetingLink,
                        onChanged: (bool val) =>
                            getCreateMeetPageCubit(context: context)
                                .changeAlreadyHaveMeetLink(val),
                      ),
                    ],
                  ),
                  (getCreateMeetPageState(context: context)
                          .alreadyHaveMeetingLink)
                      ? Wrap(
                          spacing: 40.0,
                          children: [
                            editable(
                              "Meeting Link",
                              getCreateMeetPageState(context: context)
                                  .meetingIdController,
                              "zoom.us/.....",
                            ),
                            editable(
                              "Meeting Password",
                              getCreateMeetPageState(context: context)
                                  .meetingPasswordController,
                              "Password",
                            ),
                          ],
                        )
                      : Container(),
                  Row(
                    children: [
                      const Text(
                          "Do You Want to send Notifications to all?     "),
                      Switch(
                        value: getCreateMeetPageState(context: context)
                            .notificationsOn,
                        onChanged: (bool val) =>
                            getCreateMeetPageCubit(context: context)
                                .changeNotificationAccess(val),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Make Talk public?     "),
                      Switch(
                        value: getCreateMeetPageState(context: context)
                            .makeTalkPublic,
                        onChanged: (bool val) =>
                            getCreateMeetPageCubit(context: context)
                                .changePublicTalkOption(val),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getCreateMeetPageState(context: context).errorString,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        mouseButton(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: ThemeD.primaryColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 15.0, color: Colors.grey[300]!),
                              ],
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onPressed: () =>
                              getCreateMeetPageCubit(context: context)
                                  .clickOnSubmitButton(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
