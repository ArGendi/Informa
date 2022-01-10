import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SelectLevelCard extends StatefulWidget {
  final String text;
  final int level;
  final int id;
  const SelectLevelCard({Key? key, required this.text, required this.level, required this.id}) : super(key: key);

  @override
  _SelectLevelCardState createState() => _SelectLevelCardState();
}

class _SelectLevelCardState extends State<SelectLevelCard> {
  Widget cardLevel(int level){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i=0; i<5; i++)
          Row(
            children: [
              Container(
                width: 15,
                height: 2,
                color: i < level ? primaryColor : Colors.grey[300],
              ),
              SizedBox(width: 5,),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
    return InkWell(
      onTap: (){
        Provider.of<ActiveUserProvider>(context, listen: false).setFitnessLevel(widget.id);
      },
      borderRadius: BorderRadius.circular(borderRadius),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
              color: activeUserProvider.user!.fitnessLevel == widget.id ? primaryColor : Colors.white,
              width: 2
          ),
        ),
        duration: Duration(milliseconds: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10,),
              cardLevel(widget.level),
            ],
          ),
        ),
      ),
    );
  }
}
