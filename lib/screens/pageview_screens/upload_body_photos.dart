import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/services/image_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class UploadBodyPhotos extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const UploadBodyPhotos({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _UploadBodyPhotosState createState() => _UploadBodyPhotosState();
}

class _UploadBodyPhotosState extends State<UploadBodyPhotos> {
  ImageService _imageService = new ImageService();
  bool _isLoading = false;

  onNext(BuildContext context) async{
    bool allUploaded = true;
    var photos = await _imageService.pickMultiImages();
    if(photos != null){
      if(photos.length != 3){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('أختار 3 صور من فضلك'),)
        );
        return;
      }
      String id = FirebaseAuth.instance.currentUser!.uid;
      setState(() {_isLoading = true;});
      for(int i=0; i<photos.length; i++){
        File imageFile = File(photos[i].path);
        allUploaded = await _imageService
            .uploadImageToFirebase(imageFile, id, 'body/${i+1}');
      }
      setState(() {_isLoading = false;});
      widget.onClick();
    }
    else allUploaded = false;
    if(!allUploaded)
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ فرفع الصور'),)
      );
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.onBack,
                        icon: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: primaryColor),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/coach_face.jpg'),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'محتاجين صور لجسمك',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'صور نفسك 3 صور بالوضعيات دي',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  Image.asset(
                    'assets/images/shirtlessGroup.png',
                  )
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'أختار ال3 صور',
            onClick: (){
              onNext(context);
            },
            isLoading: _isLoading,
          )
        ],
      ),
    );
  }
}
