import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:talkhost/BLoCandLogic/DrawerPagesLogic/my_hosted_meet_cubit.dart';
import 'package:talkhost/BLoCandLogic/Firestore/meeting_handler.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/app_bar.dart';
import 'package:talkhost/Utilities/post_util.dart';
import 'package:talkhost/models/post.dart';
import 'package:talkhost/models/user.dart';

import '../../Utilities/strings.dart';

class MyMeetPage extends StatefulWidget {
  const MyMeetPage({Key? key}) : super(key: key);

  @override
  State<MyMeetPage> createState() => _MyMeetPageState();
}

class _MyMeetPageState extends State<MyMeetPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyHostedMeetCubit, MyHostedMeetState>(
      builder: (context, snapshot) {
        return StreamBuilder<List<Post>>(
          stream: MeetingHandler.getAllMyHostedMeets(
            thisUser.email,
          ),
          builder: (context, postsData) {
            int count = 0;
            if (postsData.hasData) {
              count = postsData.data!.length;
              postsData.data!.sort((a, b) => a.compareToWithTime(b));
            }
            return Scaffold(
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const AppBarUtil(
                      title: "My Hosted Talks",
                    ),
                    if (postsData.connectionState ==
                        ConnectionState.waiting) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ] else if (!postsData.hasData) ...[
                      Image.network(
                        nothingFoundImageKey,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 2,
                      )
                    ] else if (postsData.hasData) ...[
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 170,
                        child: MasonryGridView.count(
                          crossAxisCount: getMyHostedMeetState(
                            context: context,
                          ).gridNumber(
                            MediaQuery.of(context).size.width,
                          ),
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 40,
                          itemCount: count,
                          itemBuilder: (context, index) {
                            return PostUtil(
                              post: postsData.data![index],
                            );
                          },
                        ),
                      )
                    ]
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
