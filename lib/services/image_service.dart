import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 550,
        imageQuality: 70,
      );
      return File(image!.path);
    } on PlatformException catch (e) {
      print('image pick error: ' + e.message!);
      return null;
    }
  }

  Future<List<XFile>?> pickMultiImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(
        maxWidth: 550,
        imageQuality: 70,
      );
      return images;
    } on PlatformException catch (e) {
      print('image pick error: ' + e.message!);
      return null;
    }
  }

  Future<bool> uploadImageToFirebase(File image, String id, String name,
      {bool? isSupplment, BuildContext? ctx}) async {
    bool uploaded = false;
    if (isSupplment == true) {
      Reference ref = _storage.ref().child("Images/Supplments/$id/$name");
      var uploadTask = ref.putFile(image);
      await uploadTask.whenComplete(() {
        uploaded = true;
      });
    } else {
      Reference ref = _storage.ref().child("Images/$id/$name");
      var uploadTask = ref.putFile(image);
      await uploadTask.whenComplete(() {
        uploaded = true;
      });
    }
    return uploaded;
  }
}
