import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/single_meal_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:provider/provider.dart';

class WideMealCard extends StatefulWidget {
  final Meal meal;
  final int? mealDoneNumber;
  final VoidCallback? onClick;
  final bool? isDone;
  const WideMealCard({Key? key, required this.meal, this.onClick, this.mealDoneNumber, this.isDone}) : super(key: key);

  @override
  _WideMealCardState createState() => _WideMealCardState();
}

class _WideMealCardState extends State<WideMealCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: (){
        if(widget.mealDoneNumber != null && widget.mealDoneNumber.toString() != widget.meal.id)
          return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleMealScreen(
            meal: widget.meal,
            otherId: int.parse(widget.meal.id!),
            mealDoneNumber: widget.mealDoneNumber,
            onClick: widget.onClick,
            isDone: widget.isDone,
          )),
        );
      },
      child: Opacity(
        opacity: widget.mealDoneNumber != null && widget.mealDoneNumber.toString() != widget.meal.id?
        0.4 : 1,
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
                    child: Hero(
                      tag: widget.meal.id!,
                      child: widget.meal.image != null? Image.asset(
                        widget.meal.image!,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ) : Container(
                        width: 130,
                        height: 130,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  if((widget.mealDoneNumber != null)
                      && widget.meal.id == widget.mealDoneNumber.toString()
                      || (widget.isDone != null && widget.isDone!))
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
                          Text(
                            widget.meal.name!,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1
                            ),
                          ),
                          if(widget.meal.description != null)
                            Text(
                              widget.meal.description!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600]
                              ),
                            ),
                        ],
                      ),
                      //SizedBox(height: 5,),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.watch_later,
                      //       color: Colors.grey[600],
                      //       size: 15,
                      //     ),
                      //     SizedBox(width: 5,),
                      //     Text(
                      //       widget.meal.period! + ' دقيقة',
                      //       style: TextStyle(
                      //         color: Colors.grey[600],
                      //         fontSize: 12
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: (){
                  if(!activeUser!.premium){
                    Navigator.pushNamed(context, PlansScreen.id);
                  }
                  else{
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  }
                },
                splashRadius: 5,
                icon: Icon(
                  _isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
