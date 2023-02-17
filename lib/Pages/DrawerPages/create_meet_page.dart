import 'dart:math';

import 'package:flutter/material.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/app_bar.dart';
import 'package:talkhost/Utilities/buttons.dart';

import '../../Utilities/theme.dart';

class CreateMeetPage extends StatefulWidget {
  const CreateMeetPage({Key? key}) : super(key: key);

  @override
  State<CreateMeetPage> createState() => _CreateMeetPageState();
}

class _CreateMeetPageState extends State<CreateMeetPage> {
  bool notificationsOn = false;
  bool alreadyHaveMeetingLink = false;
  bool makeTalkPublic = false;

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
                    getCreateMeetPageState(context: context).agendaController,
                    "How to stop Global Warming",
                  ),
                  editable(
                    "Room Name",
                    getCreateMeetPageState(context: context).roomNameController,
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
                    .userEmailController,
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
                    .guestEmailController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      "Enter the Attendees Emails Separated by commas Eg: abcd@gmail.com, xyz@gmail.com",
                ),
              ),
              Row(
                children: [
                  const Text("Do You already Have a meet link?     "),
                  Switch(
                      value: alreadyHaveMeetingLink,
                      onChanged: (bool val) {
                        setState(() {
                          alreadyHaveMeetingLink = val;
                        });
                      }),
                ],
              ),
              (alreadyHaveMeetingLink)
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
                  const Text("Do You Want to send Notifications to all?     "),
                  Switch(
                      value: notificationsOn,
                      onChanged: (bool val) {
                        setState(() {
                          notificationsOn = val;
                        });
                      }),
                ],
              ),
              Row(
                children: [
                  const Text("Make Talk public?     "),
                  Switch(
                      value: makeTalkPublic,
                      onChanged: (bool val) {
                        setState(() {
                          makeTalkPublic = val;
                        });
                      }),
                ],
              ),
              Center(
                child: mouseButton(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: ThemeD.primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15.0,
                          color: Colors.grey[300]!
                        ),
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
