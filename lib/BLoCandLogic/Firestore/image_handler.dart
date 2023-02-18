import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreImage {

  static Future<XFile?> _getImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static Future<String?> uploadImage({required String collectionWithPath}) async {
    XFile? imageFile = await _getImage();
    String? downloadUrl;
    if (imageFile != null) {
      var reference =
          FirebaseStorage.instance.ref().child(collectionWithPath);

      await reference
          .putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        downloadUrl = await reference.getDownloadURL();
      });
    }
    return downloadUrl;
  }

  static Future<String> getImage(String fireStorageImageUrl) async {
    var imageUrl = await FirebaseStorage.instance
        .ref()
        .child(fireStorageImageUrl)
        .getDownloadURL();
    return imageUrl;
  }
}
