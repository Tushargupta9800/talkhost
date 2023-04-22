import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  final credentials = ServiceAccountCredentials.fromJson({
    "private_key": ENV.KEY,
    "client_email": ENV.C_EMAIL,
    "token_uri": "https://oauth2.googleapis.com/token",
  });
  final scopes = [CalendarApi.calendarScope];

  final client = await clientViaServiceAccount(credentials, scopes);
  final calendarApi = CalendarApi(client);

  final event = Event()
    ..summary = 'My Meet event'
    ..start = EventDateTime()
      ..dateTime = DateTime.now().add(Duration(days: 1))
      ..timeZone = 'America/New_York'
    ..end = EventDateTime()
      ..dateTime = DateTime.now().add(Duration(days: 1, hours: 1))
      ..timeZone = 'America/New_York'
    ..conferenceData = ConferenceData()
      ..createRequest = CreateConferenceRequest()
        ..requestId = 'my-conference'
        ..conferenceSolutionKey = ConferenceSolutionKey()
          ..type = 'hangoutsMeet';

  final createdEvent = await calendarApi.events.insert(event, 'primary',
      conferenceDataVersion: 1);

  final meetLink = createdEvent.conferenceData.entryPoints
      .firstWhere((entryPoint) => entryPoint.entryPointType == 'video')
      .uri;

  if (await canLaunch(meetLink)) {
    await launch(meetLink);
  } else {
    print('Could not launch Meet link.');
  }

  client.close();
}
