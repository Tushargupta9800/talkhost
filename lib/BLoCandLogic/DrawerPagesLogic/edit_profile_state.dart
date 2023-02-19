part of 'edit_profile_cubit.dart';

class EditProfileState {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  void listen(String name, String number, String address, String occupation) {
    nameController.text = name;
    addressController.text = address;
    phoneNumberController.text = number;
    occupationController.text = occupation;

    nameController.addListener(() {
      updateUserParticularInfo(
        value: nameController.text,
        key: "name",
      );
    });
    addressController.addListener(() {
      updateUserParticularInfo(
        value: addressController.text,
        key: "address",
      );
    });
    phoneNumberController.addListener(() {
      if (phoneNumberController.text.isNotEmpty &&
          phoneNumberController.text.length == 10) {
        updateUserParticularInfo(
          value: phoneNumberController.text,
          key: "phone_number",
        );
      }
    });
    occupationController.addListener(() {
      updateUserParticularInfo(
        value: occupationController.text,
        key: "occupation",
      );
    });
  }

  void onClickEditProfilePicButton(String email) async {
    String key = "_profile";
    String fileName = email.replaceAll("@", "at").replaceAll(".", "dot") + key;
    String? newProfileLink = await FirestoreImage.uploadImage(
      collectionWithPath: fireStorageUserProfileImagesKey + fileName,
    );
    if (newProfileLink != null) {
      updateUserParticularInfo(
        value: newProfileLink,
        key: "profile_pic",
      );
    }
  }

  void onClickEditBannerPicButton(String email) async {
    String key = "_banner";
    String fileName = email.replaceAll("@", "at").replaceAll(".", "dot") + key;
    String? newBannerLink = await FirestoreImage.uploadImage(
      collectionWithPath: fireStorageUserProfileImagesKey + fileName,
    );
    if (newBannerLink != null) {
      updateUserParticularInfo(
        value: newBannerLink,
        key: "banner_pic",
      );
    }
  }
}
