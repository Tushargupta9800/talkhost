import 'dart:developer';

import '../Utilities/strings.dart';

class User {

  User.fromJson(dynamic json) {
    log(json);
    name = json['name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    status = json['status'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    bannerPic = json['banner_pic'];
    occupation = json['occupation'];
    website = json['website'];
  }

  User getDataFrommJson(dynamic json){
    name = json['name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    status = json['status'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    bannerPic = json['banner_pic'];
    occupation = json['occupation'];
    website = json['website'];
    return this;
  }

  User();

  String name = "";
  String email = "";
  String profilePic = defaultUserProfileImage;
  String status = "user";
  String phoneNumber = "";
  String address = "";
  String bannerPic = imageTalkHostDrawerBackgroundKey;
  String occupation = "";
  String website = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['profile_pic'] = profilePic;
    map['status'] = status;
    map['phone_number'] = phoneNumber;
    map['address'] = address;
    map['banner_pic'] = bannerPic;
    map['occupation'] = occupation;
    map['website'] = website;
    return map;
  }
}

User thisUser = User();