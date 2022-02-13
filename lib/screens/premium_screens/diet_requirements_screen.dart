import 'package:flutter/material.dart';
import 'package:informa/models/meal.dart';

class DietRequirementsScreen extends StatefulWidget {
  static String id = 'diet requirements';
  const DietRequirementsScreen({Key? key}) : super(key: key);

  @override
  _DietRequirementsScreenState createState() => _DietRequirementsScreenState();
}

class _DietRequirementsScreenState extends State<DietRequirementsScreen> {
  List<Meal> _meals = [
    Meal(name: 'فراخ'),
    Meal(name: 'فراخ'),
    Meal(name: 'فراخ'),
    Meal(name: 'فراخ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('متطلبات الدايت'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: _meals.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _meals[index].image != null ? Image.asset(
                          _meals[index].image!,
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                        ) : Container(
                          width: 130,
                          height: 130,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        _meals[index].name!,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30,),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
