part of 'edit_profile_cubit.dart';

class EditProfileState {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void listen(String name, String number, String address) {

    nameController.text = name;
    addressController.text = address;
    phoneNumberController.text = number;

    nameController.addListener(() {
      updateUserName(name: nameController.text);
    });
    addressController.addListener(() {
      updateUserAddress(address: addressController.text);
    });
    phoneNumberController.addListener(() {
      if (phoneNumberController.text.isNotEmpty &&
          phoneNumberController.text.length == 10) {
        updateUserPhoneNumber(number: phoneNumberController.text);
      }
    });
  }

  void onClickEditProfilePicButton(String email) async {
    String key = "_profile";
    String fileName = email.replaceAll("@", "at").replaceAll(".", "dot") + key;
    String? newProfileLink = await FirestoreImage.uploadImage(
      collectionWithPath: fireStorageUserProfileImagesKey + fileName,
    );
    if (newProfileLink != null) {
      updateUserProfilePic(
        fileLink: newProfileLink,
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
      updateUserBannerPic(
        fileLink: newBannerLink,
      );
    }
  }
}