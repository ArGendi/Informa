import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/single_meal_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:provider/provider.dart';

class WideMealCard extends StatefulWidget {
  final Meal meal;
  const WideMealCard({Key? key, required this.meal}) : super(key: key);

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleMealScreen(meal: widget.meal)),
        );
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: widget.meal.id!,
                child: Image.asset(
                  widget.meal.image!,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
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
    );
  }
}
