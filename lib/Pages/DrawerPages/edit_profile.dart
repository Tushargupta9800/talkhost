import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/buttons.dart';
import 'package:talkhost/models/user.dart';

import '../../BLoCandLogic/DrawerPagesLogic/edit_profile_cubit.dart';
import '../../BLoCandLogic/Firestore/firestore_user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void dispose() {
    getEditProfileState(context: context).addressController.dispose();
    getEditProfileState(context: context).nameController.dispose();
    getEditProfileState(context: context).phoneNumberController.dispose();
    super.dispose();
  }

  Widget display(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return StreamBuilder<User>(
          stream: readUser(User.email),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {}

            return Scaffold(
              body: SizedBox(
                width: 4 * MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Stack(
                              children: [
                                Image.network(
                                  User.bannerPic,
                                  height: 250,
                                  width:
                                      4 * MediaQuery.of(context).size.width / 5,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 15,
                                  child: mouseButton(
                                    onPressed: () =>
                                        getEditProfileState(context: context)
                                            .onClickEditBannerPicButton(
                                      User.email,
                                    ),
                                    child: const CircleAvatar(
                                      radius: 20,
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 80,
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 80,
                                      backgroundImage: NetworkImage(
                                        User.profilePic,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: mouseButton(
                                        onPressed: () => getEditProfileState(
                                                context: context)
                                            .onClickEditProfilePicButton(
                                          User.email,
                                        ),
                                        child: const CircleAvatar(
                                          radius: 20,
                                          child: Icon(Icons.edit),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    display(User.name),
                                    display(User.email),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
