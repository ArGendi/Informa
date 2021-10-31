import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/screens/free_workout_screen.dart';
import 'package:informa/widgets/custom_button.dart';

class MuscleSelectionScreen extends StatefulWidget {
  static String id = 'muscle selection';

  const MuscleSelectionScreen({Key? key}) : super(key: key);

  @override
  _MuscleSelectionScreenState createState() => _MuscleSelectionScreenState();
}

class _MuscleSelectionScreenState extends State<MuscleSelectionScreen> {
  bool _isFront = true;
  String _image = 'assets/images/unselected_body.png';
  String _selectedMuscle = 'لا يوجد عضلة مستهدفة';
  bool _isMuscleSelected = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تمارين أنفورما'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'حدد العضل المستهدف',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isFront = true;
                        _image = 'assets/images/unselected_body.png';
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: _isFront ? primaryColor : Colors.white,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              'الأمام',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isFront = false;
                        _image = 'assets/images/unselected_body_back.png';
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: !_isFront ? primaryColor : Colors.white,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              'الخلفي',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 400,
                height: 500,
                child: Stack(
                  children: [
                    Image.asset(
                      _image,
                      width: 400,//screenSize.width * .8,
                    ),
                    if(_isFront)
                      Positioned(
                        top: 115,
                        right: 140,
                        child: InkWell(
                          onTap: (){
                            print('Chest');
                            setState(() {
                              _image = 'assets/images/selected_body_chest.png';
                              _isMuscleSelected = true;
                              _selectedMuscle = 'العضلة المستهدفة هي الصدر';
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 38,
                            //color: Colors.black,
                          ),
                        ),
                      ),
                    if(_isFront)
                      Positioned(
                        top: 160,
                        right: 150,
                        child: InkWell(
                          onTap: (){
                            print('Abs');
                            setState(() {
                              _image = 'assets/images/selected_body_abs.png';
                              _isMuscleSelected = true;
                              _selectedMuscle = 'العضلة المستهدفة هي البطن';
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 75,
                            //color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                _selectedMuscle,
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 10,),
              CustomButton(
                text: 'تصفح التمارين',
                bgColor: _isMuscleSelected ? primaryColor : Colors.grey.shade400,
                onClick: (){
                  if(_isMuscleSelected)
                    Navigator.pushNamed(context, FreeWorkoutScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
