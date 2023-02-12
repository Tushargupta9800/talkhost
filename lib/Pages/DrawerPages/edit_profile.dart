import 'dart:developer';

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
  bool visible = true;
  bool firstTime = true;

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

  Widget editable(
    String title,
    TextEditingController controller,
    String hintText,
    double width,
    String value,
  ) {
    if (visible == false && firstTime == true) {
      firstTime = false;
      getEditProfileState(context: context)
          .listen(User.name, User.phoneNumber, User.address);
    }

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          (visible)
              ? Text(
                  value,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: hintText,
                  ),
                ),
        ],
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.grey[400],
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Personal Information",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            mouseButton(
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              child: const CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.edit),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        spacing: 20.0,
                        children: [
                          editable(
                              "Name",
                              getEditProfileState(context: context)
                                  .nameController,
                              "Write your name here",
                              4 * MediaQuery.of(context).size.width / 12,
                              User.name),
                          editable(
                              "Phone Number",
                              getEditProfileState(context: context)
                                  .phoneNumberController,
                              "Write your phone number here",
                              4 * MediaQuery.of(context).size.width / 12,
                              User.phoneNumber),
                          editable(
                              "Address",
                              getEditProfileState(context: context)
                                  .addressController,
                              "Write your Address here",
                              4 * MediaQuery.of(context).size.width / 12,
                              User.address),
                        ],
                      ),
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
