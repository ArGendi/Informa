import 'package:flutter/material.dart';

class BodyModel extends StatefulWidget {
  final String image;
  final bool isFront;
  final VoidCallback? onChest;
  final VoidCallback? onAbs;
  final VoidCallback? onShoulder;
  final VoidCallback? onBack;
  final VoidCallback? onGlutes;
  final VoidCallback? onBiceps;
  final VoidCallback? onTriceps;
  final VoidCallback? onForearms;
  final VoidCallback? onUpperLegs;
  final VoidCallback? onLowerLegs;

  const BodyModel(
      {Key? key,
      required this.image,
      required this.isFront,
      this.onChest,
      this.onAbs,
      this.onShoulder,
      this.onBack,
      this.onGlutes,
      this.onBiceps,
      this.onForearms,
      this.onUpperLegs,
      this.onLowerLegs,
      this.onTriceps})
      : super(key: key);

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
          if (widget.isFront)
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
          if (widget.isFront)
            Positioned(
              top: 150,
              right: 135,
              child: InkWell(
                onTap: widget.onAbs,
                child: Container(
                  width: 50,
                  height: 75,
                  // color: Colors.red,
                ),
              ),
            ),
          if (!widget.isFront)
            Positioned(
              top: 100,
              left: 120,
              child: InkWell(
                onTap: widget.onBack,
                child: Container(
                  width: 80,
                  height: 100,
                  // color: Colors.red,
                ),
              ),
            ),
          if (!widget.isFront)
            Positioned(
              bottom: 120,
              left: 110,
              child: InkWell(
                onTap: widget.onLowerLegs,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.red,
                ),
              ),
            ),
          if (!widget.isFront)
            Positioned(
              bottom: 120,
              right: 110,
              child: InkWell(
                onTap: widget.onLowerLegs,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.red,
                ),
              ),
            ),
          if (!widget.isFront)
            Positioned(
              top: 106 + 106 / 2 - 35 / 2,
              left: 70,
              child: InkWell(
                onTap: widget.onTriceps,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.red,
                ),
              ),
            ),
          if (!widget.isFront)
            Positioned(
              top: 106 + 106 / 2 - 35 / 2,
              right: 70,
              child: InkWell(
                onTap: widget.onTriceps,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.red,
                ),
              ),
            ),
          Positioned(
            top: 106,
            right: 85,
            child: InkWell(
              onTap: widget.onShoulder,
              child: Container(
                width: 40,
                height: 35,
                // color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 106,
            left: 85,
            child: InkWell(
              onTap: widget.onShoulder,
              child: Container(
                width: 40,
                height: 35,
                // color: Colors.black,
              ),
            ),
          ),
          if (widget.isFront)
            Positioned(
              top: 106 + 106 / 2 - 35 / 2,
              left: 70,
              child: InkWell(
                onTap: widget.onBiceps,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.black,
                ),
              ),
            ),
          if (widget.isFront)
            Positioned(
              top: 106 + 106 / 2 - 35 / 2,
              right: 70,
              child: InkWell(
                onTap: widget.onBiceps,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.black,
                ),
              ),
            ),
          if (widget.isFront)
            Positioned(
              top: 106 + 106 / 2 + 35 / 2 + 10,
              right: 70,
              child: InkWell(
                onTap: widget.onForearms,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.black,
                ),
              ),
            ),
          if (widget.isFront)
            Positioned(
              top: 106 + 106 / 2 + 35 / 2 + 10,
              left: 70,
              child: InkWell(
                onTap: widget.onForearms,
                child: Container(
                  width: 40,
                  height: 35,
                  // color: Colors.black,
                ),
              ),
            ),
          if (widget.isFront)
            Positioned(
              bottom: 212 - 35,
              left: 106,
              child: InkWell(
                onTap: widget.onUpperLegs,
                child: Container(
                  width: 40,
                  height: 70,
                  // color: Colors.black,
                ),
              ),
            ),
          if (widget.isFront)
            Positioned(
              right: 106,
              bottom: 212 - 35,
              child: InkWell(
                onTap: widget.onUpperLegs,
                child: Container(
                  width: 40,
                  height: 70,
                  // color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
