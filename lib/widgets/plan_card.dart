import 'package:flutter/material.dart';
import 'package:informa/constants.dart';

class PlanCard extends StatefulWidget {
  final int id;
  final int selected;
  final String name;
  final String? freePeriod;
  final int amountPerWeek;
  final int price;
  final int? oldPrice;
  final VoidCallback onClick;

  const PlanCard(
      {Key? key,
      required this.name,
      this.freePeriod,
      required this.amountPerWeek,
      required this.price,
      this.oldPrice,
      required this.id,
      required this.selected,
      required this.onClick})
      : super(key: key);

  @override
  _PlanCardState createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  // bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: widget.id == widget.selected ? Colors.orange[50] : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: widget.id == widget.selected
                  ? primaryColor
                  : Colors.grey.shade400)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onClick,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'خطة ال6 أشهر',
                style: TextStyle(),
              ),
              if (widget.freePeriod != null)
                Text(
                  '+' + widget.freePeriod.toString() + ' مجانا',
                  style:
                      TextStyle(color: primaryColor, fontSize: 16, height: 1.5),
                ),
              Text(
                widget.amountPerWeek.toString() + ' جنية / الأسبوع',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              Text(
                widget.price.toString() + ' جنية',
                style: TextStyle(
                    color: primaryColor,
                    fontFamily: 'CairoBold',
                    fontSize: 22,
                    height: 1.5),
              ),
              if (widget.oldPrice != null)
                Text(
                  widget.oldPrice.toString() + ' جنية',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16,
                      height: 1.5),
                ),
              SizedBox(
                height: 5,
              ),
              if (widget.oldPrice != null)
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          'خصم ' +
                              (100 - (widget.price / widget.oldPrice!) * 100)
                                  .toStringAsFixed(0) +
                              '% الافضل قيمة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
