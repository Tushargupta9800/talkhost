part of 'my_hosted_meet_cubit.dart';

class MyHostedMeetState {

  List<Post> allPost = [];
  List<Post> upcomingPosts = [];
  List<Post> shownPost = [];
  int dummyDataEmit = 0;

  void getAllPosts(List<Post>? posts){
    allPost = [];
    allPost.addAll(posts!);
    allPost.sort((a, b) => a.compareToWithTime(b));



  }

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
