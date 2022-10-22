import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/supplements_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/supplement.dart';
import '../../services/image_service.dart';
import '../../widgets/pick_image_bottom_sheet.dart';

class SelectWhichSupplements extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectWhichSupplements(
      {Key? key, required this.onClick, required this.onBack})
      : super(key: key);

  @override
  _SelectWhichSupplementsState createState() => _SelectWhichSupplementsState();
}

class _SelectWhichSupplementsState extends State<SelectWhichSupplements> {
  File? _image;
  bool _isLoading = false;
  bool isSelected = false;
  double? carbs;
  double? calories;
  double? protien;
  double? fats;
  List<Map<String, dynamic>> userSupplements = [];
  ImageService imageService = new ImageService();
  TextEditingController carbsController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protienController = TextEditingController();
  // pick the iage iunto the file _image
  showPickImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return PickImageBottomSheet(
          isSupplement: true,
          onCamera: () async {
            var image = await imageService.pickImage(ImageSource.camera);
            setState(
              () {
                _image = image;
              },
            );
          },
          onPhotos: () async {
            var image = await imageService.pickImage(ImageSource.gallery);
            setState(
              () {
                _image = image;
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    carbsController.dispose();
    fatsController.dispose();
    protienController.dispose();
    super.dispose();
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'محتاجين نعرف ايه المكملات الي عندك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      //fontFamily: boldFont,
                    ),
                  ),
                  Divider(
                    color: primaryColor,
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'اختار المكملات الي عندك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (int i = 0;
                      i <
                          Provider.of<SupplementsProvider>(context,
                                  listen: false)
                              .supplement
                              .length;
                      i++)
                    Column(
                      children: [
                        ProgramSelectCard(
                          mainText: Provider.of<SupplementsProvider>(context,
                                  listen: false)
                              .supplement[i]
                              .name!,
                          number: i + 1,
                          userChoice: activeUser!.supplements
                                  .contains((i + 1).toString())
                              ? i + 1
                              : 0,
                          onClick: () {
                            Provider.of<ActiveUserProvider>(context,
                                    listen: false)
                                .addOrRemoveSupplement((i + 1).toString());
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  InkWell(
                    borderRadius: BorderRadius.circular(7),
                    onTap: () {
                      setState(() {
                        isSelected = !isSelected;
                      });
                    },
                    child: AnimatedContainer(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color:
                              isSelected ? primaryColor : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      duration: Duration(milliseconds: 400),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'أخرى',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DottedBorder(
                              color: Colors.grey.shade300,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(12),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: InkWell(
                                  onTap: (() {
                                    showPickImageBottomSheet(context);
                                    setState(() {
                                      isSelected = true;
                                    });
                                  }),
                                  child: Container(
                                    color: Color(0xFFF9F9F9),
                                    child: Padding(
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _image == null
                                              ? Icon(
                                                  Icons
                                                      .add_photo_alternate_outlined,
                                                  color: primaryColor,
                                                  size: 50,
                                                )
                                              : Image.file(_image!),
                                          Text(
                                            'أضف صورة للمكمل الغذائي',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'اضغظ هنا لإضافة ضور المكمل الغذائي',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            'وتأكد من وضوح الصورة المرفقة',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: carbsController,
                              onChanged: ((value) {
                                carbs =
                                    value == null ? 0.0 : double.parse(value);
                                print(carbs);
                              }),
                              keyboardType: TextInputType.numberWithOptions(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'أدخل الكاربوهيدرات',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                focusColor: Colors.grey.shade100,
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    //width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    //width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: caloriesController,
                              onChanged: ((value) {
                                calories =
                                    value == null ? 0.0 : double.parse(value);
                                print(calories);
                              }),
                              keyboardType: TextInputType.numberWithOptions(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'أدخل الكالوريز',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                focusColor: Colors.grey.shade100,
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    //width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    //width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: protienController,
                              onChanged: ((value) {
                                protien =
                                    value == null ? 0.0 : double.parse(value);
                                print(protien);
                              }),
                              keyboardType: TextInputType.numberWithOptions(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'أدخل كمية البروتين',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                focusColor: Colors.grey.shade100,
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    //width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    //width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: fatsController,
                              onChanged: ((value) {
                                fats =
                                    value == null ? 0.0 : double.parse(value);
                                print(fats);
                              }),
                              keyboardType: TextInputType.numberWithOptions(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'أدخل كمية الدهون',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                focusColor: Colors.grey.shade100,
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    //width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    //width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    FirebaseStorage _storage =
                                        FirebaseStorage.instance;
                                    if (_image != null) {
                                      String id = FirebaseAuth
                                          .instance.currentUser!.uid;
                                      String basename =
                                          _image!.path.split('/').last;
                                      bool uploaded = false;
                                      Reference ref = _storage.ref().child(
                                          "images/Supplments/$id/$basename");
                                      var uploadTask = ref.putFile(_image!);
                                      String imageUrl =
                                          await ref.getDownloadURL();
                                      //TODo: add multiple photos to the supplements
                                      // Provider.of<ActiveUserProvider>(context,
                                      //         listen: false)
                                      //     .setSupplementsPhotos(
                                      //   imageUrl,
                                      // );
                                      await uploadTask.whenComplete(() {
                                        uploaded = true;
                                      });
                                      if (uploaded) {
                                        // add the path image to user data
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'تم رفع الصورة بنجاح')));
                                      }
                                    } else
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('حدث خطأ'),
                                        ),
                                      );
                                    userSupplements.add(Supplement(
                                      carb: carbs,
                                      fats: fats,
                                      protein: protien,
                                      calories: calories,
                                      imagePath: _image!.path.split('/').last,
                                    ).toMap());

                                    setState(() {
                                      _image = null;
                                    });

                                    carbsController.clear();
                                    fatsController.clear();
                                    protienController.clear();
                                    caloriesController.clear();
                                  },
                                  child: Text('اضف مكمل غذائي اخر +'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      _image = null;
                                    });

                                    carbsController.clear();
                                    fatsController.clear();
                                    caloriesController.clear();
                                    protienController.clear();
                                  },
                                  child: Text(
                                    'الغاء -',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.red[100],
                                      shadowColor: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser!.supplements.isNotEmpty || isSelected
                ? () async {
                    String id = FirebaseAuth.instance.currentUser!.uid;
                    setState(() {
                      _isLoading = true;
                    });
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(id)
                        .update({
                      'addedSupplementsByUser': userSupplements
                    }).catchError((e) {
                      print(e);
                    });
                    setState(() {
                      _isLoading = false;
                    });
                    widget.onClick();
                  }
                : () {},
            bgColor: activeUser.supplements.isNotEmpty || isSelected
                ? primaryColor
                : Colors.grey.shade400,
            isLoading: _isLoading,
          )
        ],
      ),
    );
  }
}

//TODO: what about giving the user his real id when making it preimum instead of numbers to fast access to the files || make a binary search to get the id fastly
