import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

class RemovableCircleMeal extends StatefulWidget {
  final int id;
  final String text;
  const RemovableCircleMeal({Key? key, required this.text, required this.id}) : super(key: key);

  @override
  _RemovableCircleMealState createState() => _RemovableCircleMealState();
}

class _RemovableCircleMealState extends State<RemovableCircleMeal> {
  late String _text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var textList = widget.text.split(' ');
    if(textList.length > 1)
      _text = textList[0] + '\n' + textList[1];
    else _text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return GestureDetector(
      onTap: (){
        Provider.of<ActiveUserProvider>(context, listen: false).changeMealStateUnWantedMeal(widget.id);
      },
      child: AnimatedOpacity(
        opacity: activeUser!.wantedMeals[widget.id].isSelected? 1 : 0.4,
        duration: Duration(milliseconds: 350),
        child: Stack(
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(
                child: Text(
                  _text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontFamily: boldFont,
                    fontSize: 12
                  ),
                ),
              ),
            ),
            if(activeUser.wantedMeals[widget.id].isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                Icons.cancel,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
