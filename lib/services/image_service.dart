import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageService{
  final ImagePicker _picker = ImagePicker();
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<File?> pickImage(ImageSource source) async{
    try{
      final XFile? image = await _picker.pickImage(source: source);
      return File(image!.path);

    } on PlatformException catch(e){
      print('image pick error: ' + e.message!);
      return null;
    }
  }


  Future pickMultiImages() async{
    try{
      final List<XFile>? images = await _picker.pickMultiImage();
      return images;
    } on PlatformException catch(e){
      print('image pick error: ' + e.message!);
      return null;
    }
  }

  Future<bool> uploadImageToFirebase(File image, String id) async {
    bool uploaded = false;
    Reference ref = _storage.ref().child("Inbody/" + id);
    var uploadTask = ref.putFile(image);
    await uploadTask.whenComplete(() {
      uploaded = true;
    });
    return uploaded;
  }

}