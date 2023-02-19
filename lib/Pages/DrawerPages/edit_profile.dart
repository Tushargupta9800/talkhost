import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/BLoCandLogic/get_bloc.dart';
import 'package:talkhost/Utilities/alertbox.dart';
import 'package:talkhost/Utilities/buttons.dart';
import 'package:talkhost/Utilities/loding_screen.dart';
import 'package:talkhost/models/user.dart';

import '../../BLoCandLogic/DrawerPagesLogic/edit_profile_cubit.dart';
import '../../BLoCandLogic/Firestore/firestore_user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

bool visible = true;
bool firstTime = true;
bool loading = false;

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

  Widget dividerBanner(String title, Function onTap, bool editVisibility) {
    return Column(
      children: [
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              (editVisibility)
                  ? mouseButton(
                onPressed: () => onTap(),
                child: const CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.edit),
                ),
              )
                  : Container(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget editable(String title,
      TextEditingController controller,
      String hintText,
      double width,
      String value,) {
    if (visible == false && firstTime == true) {
      firstTime = false;
      getEditProfileState(context: context)
          .listen(thisUser.name, thisUser.phoneNumber, thisUser.address,
        thisUser.occupation,);
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
          stream: readUser(thisUser.email),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {}

            return Stack(
              children: [
                Scaffold(
                  body: Container(
                    color: Colors.grey[200],
                    width: 4 * MediaQuery
                        .of(context)
                        .size
                        .width / 5,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 45),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      thisUser.bannerPic,
                                      height: 250,
                                      width: 4 *
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width /
                                          5,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 15,
                                      child: mouseButton(
                                        onPressed: () =>
                                            getEditProfileState(
                                                context: context)
                                                .onClickEditBannerPicButton(
                                              thisUser.email,
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
                                            thisUser.profilePic,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: mouseButton(
                                            onPressed: () =>
                                                getEditProfileState(
                                                    context: context)
                                                    .onClickEditProfilePicButton(
                                                  thisUser.email,
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        display(thisUser.name),
                                        display(thisUser.email),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          dividerBanner(
                            "Personal Information",
                                () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            true,
                          ),
                          Wrap(
                            spacing: 20.0,
                            children: [
                              editable(
                                "Name",
                                getEditProfileState(context: context)
                                    .nameController,
                                "Write your name here",
                                4 * MediaQuery
                                    .of(context)
                                    .size
                                    .width / 12,
                                thisUser.name,
                              ),
                              editable(
                                "Phone Number",
                                getEditProfileState(context: context)
                                    .phoneNumberController,
                                "Write your phone number here",
                                4 * MediaQuery
                                    .of(context)
                                    .size
                                    .width / 12,
                                thisUser.phoneNumber,
                              ),
                              editable(
                                "Address",
                                getEditProfileState(context: context)
                                    .addressController,
                                "Write your Address here",
                                4 * MediaQuery
                                    .of(context)
                                    .size
                                    .width / 12,
                                thisUser.address,
                              ),
                              editable(
                                "Occupation",
                                getEditProfileState(context: context)
                                    .occupationController,
                                "Your Occupation",
                                4 * MediaQuery
                                    .of(context)
                                    .size
                                    .width / 12,
                                thisUser.occupation,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FutureBuilder(
                                future: AuthState.isUserEmailVerified(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                      snapshot.hasError) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    if (snapshot.data == false) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          dividerBanner(
                                            "Make me Host",
                                                () {},
                                            false,
                                          ),
                                          mouseButton(
                                            child: const Text(
                                                "Verify Your Email  First"),
                                            onPressed: () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              AuthState state = AuthState();
                                              await state
                                                  .sendUserVerificationEmail()
                                                  .then((value) {
                                                if (mounted) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  showAlertDialog(
                                                    context,
                                                    title: "Email Sent",
                                                    error:
                                                    "Kindly Check Your email and re-login to talkhost to reflect changes",
                                                  );
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                    if (thisUser.status != "host") {
                                      updateUserParticularInfo(
                                          value: "host", key: "status");
                                    }
                                    return const Text("Your Email is Verified");
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                (loading) ? const LoadingScreen() : Container(),
              ],
            );
          },
        );
      },
    );
  }
}
