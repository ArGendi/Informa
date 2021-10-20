import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal.dart';

class WideCard extends StatefulWidget {
  final Meal meal;
  const WideCard({Key? key, required this.meal}) : super(key: key);

  @override
  _WideCardState createState() => _WideCardState();
}

class _WideCardState extends State<WideCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
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
              widget.meal.image!,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
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
                        'برجر دايت بشرائح لحم وفراخ اللزيزة والجبنة والخضار',
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
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: Colors.grey[600],
                        size: 15,
                      ),
                      SizedBox(width: 5,),
                      Text(
                        '10 دقائق',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: (){
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            splashRadius: 5,
            icon: Icon(
              _isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
