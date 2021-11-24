import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectTrainingDays extends StatefulWidget {
  final VoidCallback onClick;
  const SelectTrainingDays({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectTrainingDaysState createState() => _SelectTrainingDaysState();
}

class _SelectTrainingDaysState extends State<SelectTrainingDays> {
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
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'دلوقتي محتاجين نعرف ايام التمرين',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'اختار عدد الايام وحدد الايام',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(3);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser!.iTrainingDays == 3 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: activeUser.iTrainingDays == 3 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(4);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 4 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '4',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 4 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(5);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 5 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '5',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 5 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(6);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 6 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '6',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 6 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius)
                        ),
                        elevation: 0,
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(
                            'السبت',
                            style: TextStyle(
                              color: Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.trainingTools.isNotEmpty ? widget.onClick : (){},
            bgColor: activeUser.trainingTools.isNotEmpty ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
