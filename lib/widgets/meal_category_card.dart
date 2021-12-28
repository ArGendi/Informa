import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/screens/meal_category_screen.dart';

class MealCategoryCard extends StatefulWidget {
  final MealCategory mealCategory;
  const MealCategoryCard({Key? key, required this.mealCategory}) : super(key: key);

  @override
  _MealCategoryCardState createState() => _MealCategoryCardState();
}

class _MealCategoryCardState extends State<MealCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealCategoryScreen(
            initialIndex: widget.mealCategory.index,
          )),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.mealCategory.image!,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.mealCategory.name!,
                      style: TextStyle(
                          fontSize: 16,
                      ),
                    ),
                    Text(
                      'الكثر من وجبات ' + widget.mealCategory.name! + ' اللزيزة الصحية تصفحها الأن',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                      ),
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
