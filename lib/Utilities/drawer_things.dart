import 'package:flutter/material.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/BLoCandLogic/Firestore/firestore_user.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/debuggin_handler.dart';
import 'package:talkhost/Utilities/decorations.dart';
import 'package:talkhost/Utilities/strings.dart';
import 'package:talkhost/Utilities/theme.dart';
import 'package:talkhost/models/user.dart';

import 'buttons.dart';

class DrawerThings extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressedExit;

  const DrawerThings(
      {Key? key,
      required this.height,
      required this.width,
      required this.onPressedExit})
      : super(key: key);

  Widget displayTab(
      {required String title,
      required Icon icon,
      required BuildContext context}) {
    return Column(
      children: [
        MouseButtonSTF(
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: icon,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          onPressed: () {
            getDrawerPageCubit(context: context).changePage(title);
          },
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }

  Widget display(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (signInDebuggingEnabled) {
      Future.delayed(Duration.zero).then((value) {
        if (AuthState.user == null) {
          AuthState state = AuthState();
          state.logout();
        }
      });
    }

    return StreamBuilder<User>(
        stream: readUser(User.email),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {}

          return Container(
            color: ThemeD.primaryColor,
            width: width,
            height: height,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      User.bannerPic,
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: mouseButton(
                        child: const CircleAvatar(
                          radius: 25,
                          child: Icon(
                            Icons.exit_to_app,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: onPressedExit,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            mouseButton(
                              onPressed: () {
                                getDrawerPageCubit(
                                  context: context,
                                ).changePage(
                                  drawerEditPageKey,
                                );
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  User.profilePic,
                                ),
                              ),
                            ),
                            display(User.name),
                            display(User.email),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: width,
                        height: 10,
                        decoration: BoxDecoration(
                          color: ThemeD.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        (User.status == "host")
                            ? Column(
                                children: hostDrawer.entries
                                    .map(
                                      (entry) => displayTab(
                                        title: entry.key,
                                        icon: entry.value,
                                        context: context,
                                      ),
                                    )
                                    .toList(),
                              )
                            : Container(),
                        Column(
                          children: normalUserDrawer.entries
                              .map(
                                (entry) => displayTab(
                                  title: entry.key,
                                  icon: entry.value,
                                  context: context,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
