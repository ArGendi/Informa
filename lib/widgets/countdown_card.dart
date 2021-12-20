import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountdownCard extends StatefulWidget {
  final DateTime deadline;
  final VoidCallback? onEnd;
  const CountdownCard({Key? key, required this.deadline, this.onEnd}) : super(key: key);

  @override
  _CountdownCardState createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'متبقي علي نهاية التحدي',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            SizedBox(width: 5,),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CountdownTimer(
                endTime: widget.deadline.millisecondsSinceEpoch,
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),
                endWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'أنتهى التحدي',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),
                  ),
                ),
                onEnd: widget.onEnd != null ? widget.onEnd : (){},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
