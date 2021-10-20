import 'package:flutter/material.dart';
import 'package:informa/models/meal.dart';

class BottomShadedCard extends StatelessWidget {
  final Meal meal;

  const BottomShadedCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            meal.image!,
            fit: BoxFit.cover,
            width: 200,
            height: 150,
          ),
        ),
        Container(
          width: 200,
          height: 150,
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.black,
                ],
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1
                  ),
                ),
                Text(
                  meal.category!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
