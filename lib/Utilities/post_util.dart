import 'package:flutter/material.dart';
import 'package:talkhost/Utilities/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/post.dart';

class PostUtil extends StatelessWidget {
  final Post post;

  const PostUtil({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mouseButton(
      onPressed: (){
        if(post.alreadyHadLink){
          launchUrl(Uri.parse(post.meetingId));
        }
        else{
          launchUrl(Uri.parse("https://meet.jit.si/${post.meetingId}"));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    post.hostImage,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.hostName,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      post.hostEmail,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              post.agendaBannerPic,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Text(
              post.website,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              post.agenda,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "${post.startTime} - ${post.endTime}",
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            SelectableText(
              "Meeting Id: ${post.meetingId}",
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            if(post.meetingPassword.isNotEmpty)
            SelectableText(
              "Meeting Password: ${post.meetingPassword}",
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
