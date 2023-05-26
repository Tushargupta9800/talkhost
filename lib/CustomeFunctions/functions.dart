import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String formValidator(
  String? agenda,
  String? roomName,
  String? guestEmails,
  String? invitationEmails,
  DateTime? startTime,
  DateTime? endTime,
  bool alreadyHaveMeetLink,
  String? meetingId,
  String? meetingPassword,
  bool enableNotifications,
  bool makeTalkPublic,
  bool isNewPost,
) {
  if (agenda == null || agenda.isEmpty) return "Agenda Can't be Null";
  if (roomName == null || roomName.isEmpty) return "Room Name Can't be Null";
  if (startTime == null || endTime == null)
    return "Please choose the Talk Timing";
  if (isNewPost && !startTime.isAfter(DateTime.now()))
    return "Choose the Time after DateTime Now";
  if (!endTime.isAfter(startTime))
    return "Endtime Should be after Starting Time";
  if (alreadyHaveMeetLink && (meetingId == null || meetingId.isEmpty))
    return "Add your meeting link or \nclose the have a meet link switch\nto auto create jisti meet link";

  List<String> getAllEmails(String str) {
    List<String> emails = str.split(',');
    emails.removeWhere((element) => element.isEmpty);
    return emails;
  }

  bool isValidEmail(String str) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(str);
  }

  guestEmails = guestEmails!.replaceAll(' ', '');

  List<String> allGuestEmails = getAllEmails(guestEmails ?? "");
  for (String email in allGuestEmails) {
    if (!isValidEmail(email) && email.isNotEmpty) {
      return "Error in Guest Emails Check again!!!\nCheck Validation of Emails\nCheck if you forget to add comma(',') after each email.";
    }
  }

  invitationEmails = invitationEmails!.replaceAll(' ', '');

  List<String> attendeesEmails = getAllEmails(invitationEmails ?? "");
  for (String email in attendeesEmails) {
    if (!isValidEmail(email) && email.isNotEmpty) {
      return "Error in Invitations Emails Check again!!!\nCheck Validation of Emails\nCheck if you forget to add comma(',') after each email.";
    }
  }

  return "Success";
}

List<String> stringToEmail(String str) {
  List<String> emails = str.replaceAll(' ', '').split(',');
  emails.removeWhere((element) => element.isEmpty);
  return emails;
}

String createJitsiMeetLink() {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  math.Random rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => chars.codeUnitAt(
            rnd.nextInt(chars.length),
          ),
        ),
      );

  return "https://meet.jit.si/" + getRandomString(10);
}

String shortenString(
  String str,
  int len,
) {
  if (str.length > len) return str.substring(0, len) + "...";
  return str;
}

DateTime timeNow() {
  return DateTime.now();
}

List<UsersRecord> searchPerson(
  List<UsersRecord> users,
  String query,
) {
  List<UsersRecord> record = [];

  for (UsersRecord user in users) {
    if (user.email!.contains(query) ||
        user.displayName!.contains(query) ||
        user.phoneNumber!.contains(query) ||
        user.address!.contains(query)) {
      record.add(user);
    }
  }

  return record;
}

String listToString(List<String> list) {
  String finalStr = "";

  if (list.isNotEmpty) {
    for (String str in list) {
      finalStr += str + ",";
    }
    finalStr = finalStr.substring(0, finalStr.length - 1);
  }

  return finalStr;
}

List<String> queryEmails(
  List<String> list,
  String query,
) {
  list.sort((a, b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });

  List<String> response = [];

  for (String str in list) {
    if (str.contains(query)) {
      response.add(str);
    }
  }

  return response;
}

String messageFormValodator(
  String topic,
  String emails,
  String message,
) {
  if (topic.isEmpty) return "Please Enter Topic";
  if (emails.isEmpty) return "Please Enter At least one Email";
  if (message.isEmpty) return "Please Enter Something in the Message Field";

  List<String> getAllEmails(String str) {
    List<String> emails = str.split(',');
    emails.removeWhere((element) => element.isEmpty);
    return emails;
  }

  bool isValidEmail(String str) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(str);
  }

  emails = emails.replaceAll(' ', '');

  List<String> allGuestEmails = getAllEmails(emails);
  for (String email in allGuestEmails) {
    if (!isValidEmail(email) && email.isNotEmpty) {
      return "Error in Emails Check again!!!";
    }
  }

  return "Success";
}

String messageCount(
  int totalMessage,
  int count,
) {
  if (count == totalMessage) return "";
  return " +" + (totalMessage - count).toString();
}

List<PostsRecord> getCalenderData(
  List<PostsRecord> allposts,
  DateTime? startTime,
  DateTime? endTime,
) {
  if (startTime == null || endTime == null) return [];
  if (startTime.isAfter(endTime)) return [];
  return allposts.where((post) {
    final postStartTime = post.startTime;
    final postEndTime = post.endTime;
    final postHost = post.hostEmail;
    final postAttendees = post.attendees;
    final postInvitations = post.invitations;
    return postStartTime != null &&
        postEndTime != null &&
        postStartTime.isBefore(endTime) &&
        postEndTime.isAfter(startTime) &&
        (postHost == "tushargupta9800@gmail.com" ||
            postAttendees!.contains("tushargupta9800@gmail.com") ||
            postInvitations!.contains("tushargupta9800@gmail.com"));
  }).toList();
}
