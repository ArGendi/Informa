import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SelectGender extends StatefulWidget {
  final VoidCallback onClick;
  const SelectGender({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectGenderState createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _helloOffset;
  late Animation<Offset> _btnOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _helloOffset = Tween<Offset>(
      begin: Offset(0, -1.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    _btnOffset = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    Timer(Duration(milliseconds: 800), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SlideTransition(
                  position: _helloOffset,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/ahlan.png',
                        width: 90,
                      ),
                      Text(
                        'دعنا نتعرف عليك',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      Divider(
                        color: primaryColor,
                        indent: screenSize.width * .3,
                        endIndent: screenSize.width * .3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'أختار النوع',
                  style: TextStyle(fontSize: 22, fontFamily: 'CairoBold'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          Provider.of<ActiveUserProvider>(context,
                                  listen: false)
                              .setUser(
                            new AppUser(
                              gender: 1,
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          height: 200,
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: activeUser!.gender == 1
                                      ? primaryColor
                                      : Colors.white,
                                  width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/icons/male.svg'),
                                    ),
                                  ),
                                ),
                                Text(
                                  'ذكر',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          Provider.of<ActiveUserProvider>(context,
                                  listen: false)
                              .setUser(
                            new AppUser(
                              gender: 2,
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          height: 200,
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: activeUser.gender == 2
                                      ? primaryColor
                                      : Colors.white,
                                  width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/icons/female.svg'),
                                    ),
                                  ),
                                ),
                                Text(
                                  'انثى',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          SlideTransition(
            position: _btnOffset,
            child: CustomButton(
              text: 'التالي',
              onClick: activeUser.gender == 0 ? () {} : widget.onClick,
              bgColor:
                  activeUser.gender == 0 ? Colors.grey.shade400 : primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
