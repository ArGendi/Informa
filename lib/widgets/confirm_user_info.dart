import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/prepare_program_screen.dart';
import 'package:informa/services/dictionary.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ConfirmUserInfo extends StatefulWidget {
  final VoidCallback onBack;
  const ConfirmUserInfo({Key? key, required this.onBack}) : super(key: key);

  @override
  _ConfirmUserInfoState createState() => _ConfirmUserInfoState();
}

class _ConfirmUserInfoState extends State<ConfirmUserInfo> {
  Dictionary _dictionary = Dictionary();
  bool _isLoading = false;
  FirestoreService _firestoreService = new FirestoreService();

  onConfirm(BuildContext context) async{
    bool done = true;
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    setState(() { _isLoading = true; });
    await _firestoreService.saveNewAccountWithFullInfo(activeUser!).catchError((e){
      setState(() { _isLoading = false; });
      done = false;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ'))
      );
    });
    if(done) {
      await activeUser.saveInSharedPreference();
      setState(() { _isLoading = false; });
      Navigator.pushNamed(context, PrepareProgramScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 40,
          ),
          SizedBox(height: 10,),
          Text(
            'ملخص معلوماتك',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'CairoBold',
            ),
          ),
          Text(
            'تأكد من صحة معلوماتك قبل الأستمرار',
            style: TextStyle(
              color: Colors.grey[600]
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'العمر',
                      style: TextStyle(),
                    ),
                    Text(
                      activeUser!.age.toString() + ' سنة',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الطول',
                      style: TextStyle(),
                    ),
                    Text(
                      activeUser.tall.toString() + ' سم',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الوزن',
                      style: TextStyle(),
                    ),
                    Text(
                      activeUser.weight.toString() + ' كجم',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'نسبة الدهون',
                      style: TextStyle(),
                    ),
                    Text(
                      activeUser.fatsPercent.toString() + ' %',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المستوي',
                      style: TextStyle(),
                    ),
                    Text(
                      _dictionary.convertLevelToString(activeUser.fitnessLevel),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'وقت التمرين',
                      style: TextStyle(),
                    ),
                    Text(
                      _dictionary.convertTrainingPeriodToString(activeUser.trainingPeriodLevel),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if(activeUser.workoutPlace == 1)
                  Column(
                    children: [
                      Divider(
                        height: 30,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'أدوات التمرين',
                            style: TextStyle(),
                          ),
                          Text(
                            _dictionary.convertTrainingToolsToString(activeUser.trainingTools),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'عدد ايام التمرين',
                      style: TextStyle(),
                    ),
                    Text(
                      activeUser.iTrainingDays.toString() + ' ايام',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          CustomButton(
            text: 'تأكيد',
            onClick: (){
              onConfirm(context);
            },
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
