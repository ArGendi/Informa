import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountdownCard extends StatefulWidget {
  final DateTime deadline;
  const CountdownCard({Key? key, required this.deadline}) : super(key: key);

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
        child: Directionality(
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
          ),
        ),
      ),
    );
  }
}
