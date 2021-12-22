import 'package:flutter/material.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/screens/single_challenge_screen.dart';
import 'package:informa/widgets/countdown_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ChallengeCard extends StatefulWidget {
  final Challenge challenge;
  const ChallengeCard({Key? key, required this.challenge}) : super(key: key);

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleChallengeScreen(
            challenge: widget.challenge,
          )),
        );
      },
      child: Container(
        width: screenSize.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.challenge.isFree ? Colors.green : primaryColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.challenge.isFree ? 'ببلاش' : 'مدفوع',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                widget.challenge.name!,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'CairoBold',
                ),
              ),
              Text(
                widget.challenge.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 5,),
              CountdownCard(
                deadline: widget.challenge.deadline!,
                onEnd: (){
                  Provider.of<ChallengesProvider>(context, listen: false)
                      .removeChallenge(widget.challenge);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
