import 'package:flutter/material.dart';

import '../constants.dart';

class PickImageBottomSheet extends StatefulWidget {
  final VoidCallback onCamera;
  final VoidCallback onPhotos;
  final bool? isSupplement;
  const PickImageBottomSheet(
      {Key? key,
      required this.onCamera,
      required this.onPhotos,
      this.isSupplement})
      : super(key: key);

  @override
  _PickImageBottomSheetState createState() => _PickImageBottomSheetState();
}

class _PickImageBottomSheetState extends State<PickImageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadius),
              topLeft: Radius.circular(borderRadius),
            ),
          ),
          child: Center(
            child: Text(
              widget.isSupplement == true
                  ? 'اضف صورة المكمل الغذائي'
                  : 'ورينا صورة الأختبار',
              style: TextStyle(
                fontFamily: 'CairoBold',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () {
            widget.onCamera();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'أفتح الكاميرا',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () {
            widget.onPhotos();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'أفتح الصور',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
