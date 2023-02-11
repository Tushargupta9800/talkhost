import '../Utilities/strings.dart';

class User {

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    status = json['status'];
    phoneNumber = json['phone_number'];
  }

  static String name = "";
  static String email = "";
  static String profilePic = defaultUserProfileImage;
  static String status = "user";
  static String phoneNumber = "";

  static Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['profile_pic'] = profilePic;
    map['status'] = status;
    map['phone_number'] = phoneNumber;
    return map;
  }
}
