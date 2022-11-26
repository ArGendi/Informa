import 'package:flutter/material.dart';

import '../constants.dart';

class MainMealCard extends StatefulWidget {
  final String text;
  final String? description;
  final String? image;
  final VoidCallback onClick;
  final int? mealNumber;
  final bool? isDone;
  final DateTime? time;
  const MainMealCard(
      {Key? key,
      required this.text,
      this.description,
      this.image,
      required this.onClick,
      this.mealNumber,
      this.isDone,
      this.time})
      : super(key: key);

  @override
  _MainMealCardState createState() => _MainMealCardState();
}

class _MainMealCardState extends State<MainMealCard> {
  String convertDateTimeToString(DateTime date) {
    String time = '';
    bool am = true;
    if (date.hour > 12) {
      time += (date.hour - 12).toString() + ':';
      am = false;
    } else
      time += date.hour.toString() + ':';
    if (date.minute < 10)
      time += '0' + date.minute.toString();
    else
      time += date.minute.toString();
    if (am)
      time += ' ص';
    else
      time += ' م';
    return time;
  }

  @override
  Widget build(BuildContext context) {
    // var activeUser = Provider.of<ActiveUserProvider>(context).user;
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
                  child: widget.image != null
                      ? Image.asset(
                          widget.image!,
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 130,
                          height: 130,
                          color: Colors.grey[300],
                        ),
                ),
                if (widget.isDone != null && widget.isDone!)
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
                              style: TextStyle(fontSize: 16, height: 1),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            if (widget.mealNumber != null)
                              Text(
                                '(الوجبة ' +
                                    widget.mealNumber!.toString() +
                                    ')',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                        if (widget.description != null)
                          Text(
                            widget.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                      ],
                    ),
                    if (widget.time != null)
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later,
                            color: Colors.grey,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            convertDateTimeToString(widget.time!),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
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
