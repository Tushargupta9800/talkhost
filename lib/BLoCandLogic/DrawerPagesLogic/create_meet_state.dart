part of 'create_meet_cubit.dart';

class CreateMeetState {
  TextEditingController agendaController = TextEditingController();
  TextEditingController roomNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController guestEmailController = TextEditingController();
  TextEditingController meetingIdController = TextEditingController();
  TextEditingController meetingPasswordController = TextEditingController();

  bool notificationsOn = false;
  bool alreadyHaveMeetingLink = false;
  bool makeTalkPublic = false;

  String errorString = "";
  String? imageAddress;

  CreateMeetState copyWith(CreateMeetState state) {
    return CreateMeetState.withParam(
        agendaController: state.agendaController,
        roomNameController: state.roomNameController,
        userEmailController: state.userEmailController,
        guestEmailController: state.guestEmailController,
        meetingIdController: state.meetingIdController,
        meetingPasswordController: state.meetingPasswordController,
        notificationsOn: state.notificationsOn,
        alreadyHaveMeetingLink: state.alreadyHaveMeetingLink,
        makeTalkPublic: state.makeTalkPublic,
        errorString: state.errorString,
        imageAddress: state.imageAddress);
  }

  CreateMeetState();

  CreateMeetState.withParam({
    required this.agendaController,
    required this.roomNameController,
    required this.userEmailController,
    required this.guestEmailController,
    required this.meetingIdController,
    required this.meetingPasswordController,
    required this.notificationsOn,
    required this.alreadyHaveMeetingLink,
    required this.makeTalkPublic,
    required this.errorString,
    required this.imageAddress,
  });

  String getImageAddress() {
    return imageAddress ?? "";
  }

  void listenChange() {
    guestEmailController.text = guestEmailController.text.replaceAll(' ', '');
    userEmailController.text = userEmailController.text.replaceAll(' ', '');
    errorString = "";

    if (agendaController.text.isEmpty) {
      errorString = "Agenda String Should not be empty";
      return;
    }

    if (roomNameController.text.isEmpty) {
      errorString = "Room Name Should not be empty";
      return;
    }

    List<String> guestEmails = guestEmailController.text.getAllEmails();
    for (String email in guestEmails) {
      if (!email.isValidEmail() && email.isNotEmpty) {
        errorString =
            "Error in Guest Emails Check again!!!\nCheck Validation of Emails\nCheck if you forget to add comma(',') after each email.";
        return;
      }
    }

    List<String> attendeesEmails = userEmailController.text.getAllEmails();
    for (String email in attendeesEmails) {
      if (!email.isValidEmail() && email.isNotEmpty) {
        errorString =
            "Error in Attendees Emails Check again!!!\nCheck Validation of Emails\nCheck if you forget to add comma(',') after each email.";
        return;
      }
    }
  }

  Future chooseImage(BuildContext context) async {
    getDrawerPageCubit(context: context).changeLoadingStatus();
    String imageKey = fireStorageAgendaImagesKey +
        AuthState.userEmail! +
        DateTime.now().toString();
    imageAddress = await FirestoreImage.uploadImage(
      collectionWithPath: imageKey,
    );
    log(imageAddress.toString());
    getDrawerPageCubit(context: context).changeLoadingStatus();
  }

  void clickOnSubmit(BuildContext context) {
    getDrawerPageCubit(context: context).changeLoadingStatus();
    Post newPost = Post(
        agenda: agendaController.text,
        agendaBannerPic: imageAddress ?? imageTalkHostDrawerBackgroundKey,
        roomName: roomNameController.text,
        id: AuthState.userEmail! + DateTime.now().toString(),
        hostName: User.name,
        hostEmail: AuthState.userEmail!,
        hostImage: User.profilePic,
        website: User.website,
        notificationsOn: notificationsOn,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        attendees: userEmailController.text.getAllEmails(),
        guests: guestEmailController.text.getAllEmails(),
        alreadyHadLink: alreadyHaveMeetingLink,
        meetingId: meetingIdController.text,
        meetingPassword: meetingPasswordController.text,
        makePublic: makeTalkPublic,
        registeredAttendees: []);
    MeetingHandler.createMeet(newPost);
    getDrawerPageCubit(context: context).changeLoadingStatus();
    getDrawerPageCubit(context: context).changePage(drawerPageMyHostedMeetKey);
    showAlertDialog(
      context,
      title: "Your Talk Has been Created",
      error: "Congratulations!!! Your Talk Post will be live in few Moments",
    );
  }
}
