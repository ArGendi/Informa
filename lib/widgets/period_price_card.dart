import 'dart:async';

import 'package:flutter/material.dart';

import '../constants.dart';

class PeriodPriceCard extends StatefulWidget {
  final int id;
  final int selected;
  final String period;
  final String price;
  final VoidCallback onClick;
  const PeriodPriceCard({Key? key, required this.period, required this.price, required this.onClick, required this.id, required this.selected}) : super(key: key);

  @override
  _PeriodPriceCardState createState() => _PeriodPriceCardState();
}

class _PeriodPriceCardState extends State<PeriodPriceCard>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: widget.onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: widget.id == widget.selected ? primaryColor : Colors.grey.shade300,
            width: widget.id == widget.selected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Text(
                widget.period,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: boldFont,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.price,
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'جنية',
                    style: TextStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
