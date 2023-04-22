import 'dart:math';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension EmailExtractor on String {
  List<String> getAllEmails() {
    List<String> emails = split(',');
    emails.removeWhere((element) => element.isEmpty);
    return emails;
  }
}

extension GetMeetingId on String {
  String getMeetingId(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    String getRandomString(int length) => String.fromCharCodes(
          Iterable.generate(
            length,
            (_) => chars.codeUnitAt(
              rnd.nextInt(chars.length),
            ),
          ),
        );

    return getRandomString(length);
  }
}
