import '../Utilities/strings.dart';

class User {

  User.fromJson(dynamic json) {
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

  static String name = "";
  static String email = "";
  static String profilePic = defaultUserProfileImage;
  static String status = "user";
  static String phoneNumber = "";
  static String address = "";
  static String bannerPic = imageTalkHostDrawerBackgroundKey;
  static String occupation = "";
  static String website = "";

  static Map<String, dynamic> toJson() {
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
