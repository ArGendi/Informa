import 'package:flutter/material.dart';

class SettingCard extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClick;
  final Color? iconColor;
  const SettingCard({Key? key, required this.icon, required this.text, required this.onClick, this.iconColor}) : super(key: key);

  @override
  _SettingCardState createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
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
                Icon(
                  widget.icon,
                  color: widget.iconColor != null ? widget.iconColor : Colors.grey[400],
                ),
                SizedBox(width: 10,),
                Text(
                  widget.text,
                  style: TextStyle(
                    //color: Colors.grey[400]
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
