import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/services/image_service.dart';
import 'package:informa/widgets/pick_image_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class PremiumFatPercent extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback goToFatsImages;
  final VoidCallback onNext;
  final bool selectFromPhotos;
  const PremiumFatPercent(
      {Key? key,
      required this.onBack,
      required this.goToFatsImages,
      required this.onNext,
      this.selectFromPhotos = false})
      : super(key: key);

  @override
  _PremiumFatPercentState createState() => _PremiumFatPercentState();
}

class _PremiumFatPercentState extends State<PremiumFatPercent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageOffset;
  int _selected = 0;
  File? _image;
  bool _isLoading = false;

  pickImageAndGoNext(ImageSource source) async {
    ImageService imageService = new ImageService();
    _image = await imageService.pickImage(source);
    if (_image != null) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      setState(() {
        _isLoading = true;
      });
      bool uploaded =
          await imageService.uploadImageToFirebase(_image!, id, "inBody");
      setState(() {
        _isLoading = false;
      });
      if (uploaded) {
        Provider.of<ActiveUserProvider>(context, listen: false).setInBody(true);
        widget.onNext();
        return;
      }
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('حدث خطأ')));
  }

  showPickImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return PickImageBottomSheet(
          onCamera: () {
            pickImageAndGoNext(ImageSource.camera);
          },
          onPhotos: () {
            pickImageAndGoNext(ImageSource.gallery);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _imageOffset = Tween<Offset>(
      begin: Offset(0, -1.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    Timer(Duration(milliseconds: 400), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
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
                  SizedBox(
                    height: 5,
                  ),
                  SlideTransition(
                    position: _imageOffset,
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: primaryColor),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/coach_face.jpg'),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'أول حاجة نتأكد من نسبة وزنك و دهونك',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'قولنا نسبة وزنك و دهونك',
                    style: TextStyle(fontSize: 16, fontFamily: 'CairoBold'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الوزن',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Text(
                            activeUserProvider.user!.weight.toString() + ' كجم',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: activeUserProvider.user!.weight.toDouble(),
                    min: 20,
                    max: 220,
                    divisions: 200,
                    label: activeUserProvider.user!.weight.toString(),
                    onChanged: (double value) {
                      activeUserProvider.setWeight(value.round());
                    },
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey[300],
                  ),
                  //SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الدهون',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Text(
                            activeUserProvider.user!.fatsPercent.toString() +
                                ' %',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: activeUserProvider.user!.fatsPercent.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: activeUserProvider.user!.fatsPercent.toString(),
                    onChanged: (double value) {
                      activeUserProvider.setFatPercent(value.round());
                    },
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey[300],
                  ),
                  //SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عرفت نسبة الدهون منين؟',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: _selected == 1
                              ? primaryColor
                              : Colors.grey.shade300,
                          width: _selected == 1 ? 2 : 1,
                        )),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        if (this.mounted)
                          setState(() {
                            _selected = 1;
                          });
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Inbody',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(height: 5,),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: _selected == 2
                              ? primaryColor
                              : Colors.grey.shade300,
                          width: _selected == 2 ? 2 : 1,
                        )),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        if (this.mounted)
                          setState(() {
                            _selected = 2;
                          });
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'جهاز اخر',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    text: 'معرفش نسبة دهوني',
                    onClick: widget.goToFatsImages,
                    iconExist: false,
                  )
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            bgColor: _selected != 0 || widget.selectFromPhotos
                ? primaryColor
                : Colors.grey.shade400,
            onClick: _selected != 0 || widget.selectFromPhotos
                ? () {
                    if (widget.selectFromPhotos) {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setInBody(false);
                      widget.onNext();
                    } else
                      showPickImageBottomSheet(context);
                  }
                : () {},
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
