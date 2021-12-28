import 'package:flutter/material.dart';
import 'package:informa/models/muscle.dart';
import 'package:informa/models/muscles_list.dart';

class BodyModel extends StatefulWidget {
  final String image;
  final bool isFront;
  final VoidCallback? onChest;
  final VoidCallback? onAbs;
  const BodyModel({Key? key, required this.image, required this.isFront, this.onChest, this.onAbs}) : super(key: key);

  @override
  _BodyModelState createState() => _BodyModelState();
}

class _BodyModelState extends State<BodyModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      child: Stack(
        children: [
          Image.asset(
            widget.image,
            width: 400,
          ),
          if(widget.isFront)
            Positioned(
              top: 115,
              right: 140,
              child: InkWell(
                onTap: widget.onChest,
                child: Container(
                  width: 70,
                  height: 38,
                  //color: Colors.black,
                ),
              ),
            ),
          if(widget.isFront)
            Positioned(
              top: 160,
              right: 150,
              child: InkWell(
                onTap: widget.onAbs,
                child: Container(
                  width: 50,
                  height: 75,
                  //color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
