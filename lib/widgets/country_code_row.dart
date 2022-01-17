import 'dart:convert';

import 'package:flutter/material.dart';

class CountryCodeRow extends StatefulWidget {
  final List<dynamic> data;
  final int index;
  final VoidCallback onClick;
  const CountryCodeRow({Key? key, required this.data, required this.index, required this.onClick}) : super(key: key);

  @override
  _CountryCodeRowState createState() => _CountryCodeRowState();
}

class _CountryCodeRowState extends State<CountryCodeRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  widget.data[widget.index]['flags']['png'],
                  width: 40.0,
                ),
                SizedBox(width: 10,),
                Text('+' + widget.data[widget.index]['callingCodes'][0]),
              ],
            ),
            Expanded(
              child: Text(
                utf8.decode(widget.data[widget.index]['nativeName'].toString().codeUnits),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
