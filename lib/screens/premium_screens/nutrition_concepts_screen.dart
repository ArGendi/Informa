import 'package:flutter/material.dart';
import 'package:informa/widgets/text_video_banner.dart';

class NutritionConceptsScreen extends StatefulWidget {
  static String id = 'nutrition concepts';
  const NutritionConceptsScreen({Key? key}) : super(key: key);

  @override
  _NutritionConceptsScreenState createState() =>
      _NutritionConceptsScreenState();
}

class _NutritionConceptsScreenState extends State<NutritionConceptsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شرح المفاهيم'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              TextVideoBanner(
                text: 'شاهد شرح التطبيق',
                videoLink: 'https://www.youtube.com/watch?v=sLgz57tguKo',
              ),
              Divider(
                height: 30,
              ),
              TextVideoBanner(
                text: 'شاهد شرح التطبيق',
                videoLink: 'https://www.youtube.com/watch?v=sLgz57tguKo',
              ),
              Divider(
                height: 30,
              ),
              TextVideoBanner(
                text: 'شاهد شرح التطبيق',
                videoLink: 'https://www.youtube.com/watch?v=sLgz57tguKo',
              ),
              Divider(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
