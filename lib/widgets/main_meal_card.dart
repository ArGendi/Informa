import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/single_meal_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class MainMealCard extends StatefulWidget {
  final String text;
  final String? description;
  final String? image;
  final VoidCallback onClick;
  final int? mealNumber;
  final bool? isDone;
  const MainMealCard({Key? key, required this.text, this.description, this.image, required this.onClick, this.mealNumber, this.isDone}) : super(key: key);

  @override
  _MainMealCardState createState() => _MainMealCardState();
}

class _MainMealCardState extends State<MainMealCard> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: widget.onClick,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: widget.image != null ? Image.asset(
                    widget.image!,
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                  ) : Container(
                    width: 130,
                    height: 130,
                    color: Colors.grey[300],
                  ),
                ),
                if(widget.isDone != null && widget.isDone!)
                Opacity(
                  opacity: 0.7,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.text,
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1
                              ),
                            ),
                            SizedBox(width: 5,),
                            if(widget.mealNumber != null)
                              Text(
                                '(الوجبة ' + widget.mealNumber!.toString() + ')',
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                        if(widget.description != null)
                          Text(
                            widget.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600]
                            ),
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
