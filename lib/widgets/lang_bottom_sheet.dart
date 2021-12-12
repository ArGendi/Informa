import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class LangBottomSheet extends StatefulWidget {
  final String lang;
  const LangBottomSheet({Key? key, required this.lang}) : super(key: key);

  @override
  _LangBottomSheetState createState() => _LangBottomSheetState(lang);
}

class _LangBottomSheetState extends State<LangBottomSheet> {
  late String _lang;
  _LangBottomSheetState(String lang){
    _lang = lang;
  }

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
              'أعدادات اللغة',
              style: TextStyle(
                fontFamily: 'CairoBold',
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: (){
              setState(() {
                _lang = 'ar';
              });
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: _lang == 'ar' ? primaryColor : Colors.white,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'العربية',
                      style: TextStyle(),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 12,
                      child: _lang == 'ar' ? CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 6,
                      ) : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: (){
              setState(() {
                _lang = 'en';
              });
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: _lang == 'en' ? primaryColor : Colors.white,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الأنجليزية',
                      style: TextStyle(),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 12,
                      child: _lang == 'en' ? CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 6,
                      ) : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            text: 'حفظ الأعدادات',
            onClick: () async{
              await HelpFunction.saveUserLanguage(_lang);
              Provider.of<AppLanguageProvider>(context, listen: false).
                  changeLang(_lang);
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
