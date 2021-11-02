import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          radius: 25,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activeUserProvider.user!.name.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'CairoBold',
                              ),
                            ),
                            Text(
                              'المستوي الأول - ' + activeUserProvider.user!.points.toString() + ' نقطة',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: SvgPicture.asset('assets/icons/settings.svg'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الأنجازات',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Row(
                            children: [
                              Text(
                                'المزيد',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600]
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 6,//activeUserProvider.user!.achievements!.length,
                        itemBuilder: (context, index){
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 25,
                              ),
                              SizedBox(width: 10,),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'معلومات شخصية',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Row(
                            children: [
                              Text(
                                'المزيد',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600]
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '70 كيلو جرام'
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
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '70 كيلو جرام'
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
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '70 كيلو جرام'
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
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '70 كيلو جرام'
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
