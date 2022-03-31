import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';

class CountdownCard extends StatefulWidget {
  final DateTime deadline;
  final VoidCallback? onEnd;
  final Color color;
  final bool withoutText;
  final String? endText;
  const CountdownCard({Key? key, required this.deadline, this.onEnd, this.color = Colors.orange, this.withoutText = false, this.endText}) : super(key: key);

  @override
  _CountdownCardState createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    return Card(
      elevation: 0,
      color: widget.color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: widget.withoutText ? 6: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(!widget.withoutText)
            Text(
              localization!.translate('متبقي علي نهاية التحدي').toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            if(!widget.withoutText)
            SizedBox(width: 5,),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CountdownTimer(
                endTime: widget.deadline.millisecondsSinceEpoch,
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                ),
                endWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    widget.endText == null? 'أنتهى التحدي' : widget.endText.toString(),
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
