part of 'my_hosted_meet_cubit.dart';

class MyHostedMeetState {
  int gridNumber(double screenWidth) {
    double minWidth = 300;
    double oneThirdWidth = screenWidth / 3;
    double halfWidth = screenWidth / 2;

    if (oneThirdWidth > minWidth) {
      return 3;
    } else if (halfWidth > minWidth) {
      return 2;
    }
    return 1;
  }

}
