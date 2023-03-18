
class Post {
  Post({
    required this.agenda,
    required this.agendaBannerPic,
    required this.roomName,
    required this.id,
    required this.hostName,
    required this.hostEmail,
    required this.hostImage,
    required this.website,
    required this.notificationsOn,
    required this.startTime,
    required this.endTime,
    required this.attendees,
    required this.guests,
    required this.alreadyHadLink,
    required this.meetingId,
    required this.meetingPassword,
    required this.makePublic,
    required this.registeredAttendees
  });

  Post.fromJson(Map<String, dynamic> json) {
    agenda = json['agenda'];
    agendaBannerPic = json['agenda_banner_pic'];
    roomName = json['room_name'];
    id = json['id'];
    hostName = json['host_name'];
    hostEmail = json['host_email'];
    hostImage = json['host_image'];
    website = json['website'];
    notificationsOn = json['notifications_on'];
    startTime =  json['start_time'].toDate();
    endTime =  json['end_time'].toDate();
    attendees =
        json['attendees'] != null ? json['attendees'].cast<String>() : [];
    guests = json['guests'] != null ? json['guests'].cast<String>() : [];
    alreadyHadLink = json['already_had_link'];
    meetingId = json['meeting_id'];
    meetingPassword = json['meeting_password'];
    makePublic = json['make_talk_public'];
    registeredAttendees = json['registered_attendees'] != null ? json['registered_attendees'].cast<String>() : [];
  }

  late String agenda;
  late String agendaBannerPic;
  late String roomName;
  late String id;
  late String hostName;
  late String hostEmail;
  late String hostImage;
  late String website;
  late bool notificationsOn;
  late DateTime startTime;
  late DateTime endTime;
  late List<String> attendees;
  late List<String> guests;
  late bool alreadyHadLink;
  late String meetingId;
  late String meetingPassword;
  late bool makePublic;
  List<String> registeredAttendees = [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['agenda'] = agenda;
    map['agenda_banner_pic'] = agendaBannerPic;
    map['room_name'] = roomName;
    map['id'] = id;
    map['host_name'] = hostName;
    map['host_email'] = hostEmail;
    map['host_image'] = hostImage;
    map['website'] = website;
    map['notifications_on'] = notificationsOn;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['attendees'] = attendees;
    map['guests'] = guests;
    map['already_had_link'] = alreadyHadLink;
    map['meeting_id'] = meetingId;
    map['meeting_password'] = meetingPassword;
    map['make_talk_public'] = makePublic;
    map['registered_attendees'] = registeredAttendees;
    return map;
  }

  int compareToWithTime(Post b){

    if(startTime == b.startTime){
      if(endTime.isBefore(b.endTime)) return 0;
      return 1;
    }
    if(startTime.isBefore(b.startTime)) return 0;
    return 1;
  }
}
