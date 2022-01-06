import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/settings_screen.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.grey.shade300
                  )
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    bottom: 20,
                    left: 20
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 25,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            activeUser!.name.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              //fontFamily: 'CairoBold',
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, SettingsScreen.id);
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/settings.svg',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 5,),
              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       side: BorderSide(
              //           color: Colors.grey.shade300
              //       )
              //   ),
              //   elevation: 0,
              //   color: Colors.white,
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'الأنجازات',
              //               style: TextStyle(
              //                 fontSize: 16,
              //               ),
              //             ),
              //             InkWell(
              //               onTap: (){},
              //               child: Row(
              //                 children: [
              //                   Text(
              //                     'المزيد',
              //                     style: TextStyle(
              //                       fontSize: 14,
              //                       color: Colors.grey[600]
              //                     ),
              //                   ),
              //                   Icon(
              //                     Icons.arrow_forward_ios,
              //                     color: Colors.grey[600],
              //                     size: 18,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 10,),
              //         Container(
              //           height: 80,
              //           child: ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             shrinkWrap: true,
              //             itemCount: 6,//activeUserProvider.user!.achievements!.length,
              //             itemBuilder: (context, index){
              //               return Row(
              //                 children: [
              //                   CircleAvatar(
              //                     backgroundColor: Colors.grey[300],
              //                     radius: 25,
              //                   ),
              //                   SizedBox(width: 10,),
              //                 ],
              //               );
              //             },
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 5,),
              if(activeUser.premium && !activeUser.fillPremiumForm)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey.shade300
                      )
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.format_list_bulleted,
                            color: primaryColor,
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'أبدأ الأسئلة',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: Colors.grey.shade300
                    )
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          if(!activeUser.premium)
                            Navigator.pushNamed(context, PlansScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/gym.svg',
                                semanticsLabel: 'gym',
                                color: Colors.black,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 15,),
                              Text(
                                'التمارين المفضلة',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          if(!activeUser.premium)
                            Navigator.pushNamed(context, PlansScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/fish.svg',
                                semanticsLabel: 'gym',
                                color: Colors.black,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 15,),
                              Text(
                                'الوجبات المفضلة',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: Colors.grey.shade300
                    )
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'معلومات شخصية',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  activeUser.weight.toString() + ' كجم'
                              ),
                              Text(
                                  'وزن الجسم الحالي',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600]
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  activeUser.tall.toString() + ' سم'
                              ),
                              Text(
                                'طول الجسم',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600]
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  activeUser.fatsPercent.toString() + '%'
                              ),
                              Text(
                                'نسبة الدهون',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600]
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  activeUser.age.toString() + ' سنة'
                              ),
                              Text(
                                'العمر',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600]
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 5,),
              if(!activeUser.premium)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey.shade300
                      )
                  ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'أنفورما',
                            style: TextStyle(
                              fontFamily: 'CairoBold',
                            ),
                          ),
                          Column(
                            children: [
                              Card(
                                elevation: 0,
                                color: primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'بريميم',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'أنضم الي عائلة أنفورما',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك بالأضافة الي مميزات غير محدودة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(borderRadius),
                        onTap: (){
                          Navigator.pushNamed(context, PlansScreen.id);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(borderRadius)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'أنضم الأن',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 75,),
            ],
          ),
        ),
      ),
    );
  }
}
