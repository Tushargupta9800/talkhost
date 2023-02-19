import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talkhost/models/post.dart';

class MeetingHandler {
  static Future createMeet(Post post) async {
    var json = post.toJson();
    final docUser = FirebaseFirestore.instance.collection("posts").doc(post.id);
    await docUser.set(json);
  }

  //getAllLiveMeet
  //getAllUpcomingMeet
  //getAllMyJoinedMeet
  //getAllPreviousMeet
  //getAllMyHostedMeet

  static Stream<List<Post>> getAllMyHostedMeets(String emailId) {
    return FirebaseFirestore.instance
        .collection("posts")
        .where("host_email", isEqualTo: emailId)
        .snapshots()
        .map((event) => event.docs.map((e) {
              Post post = Post.fromJson(
                e.data(),
              );
              return post;
            }).toList());
  }
}
