import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

class BodyFatCard extends StatefulWidget {
  final String imagePath;
  final int percent;
  const BodyFatCard({Key? key, required this.imagePath, required this.percent,}) : super(key: key);

  @override
  _BodyFatCardState createState() => _BodyFatCardState();
}

class _BodyFatCardState extends State<BodyFatCard> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return InkWell(
      onTap: (){
        Provider.of<ActiveUserProvider>(context, listen: false).setFatPercent(widget.percent);
      },
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: widget.percent == activeUser!.fatsPercent ? primaryColor : Colors.white,
            width: 2,
          )
        ),
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.imagePath,),
                )
              ),
            ),
            SizedBox(height: 5,),
            Text(
              widget.percent.toString() + '%',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
