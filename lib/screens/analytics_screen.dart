import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/progress.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Progress> chartData = [
      Progress(date: DateTime.now(), wieght: 80),
      Progress(date: DateTime(2019), wieght: 50),
      Progress(date: DateTime(2020), wieght: 70),
      Progress(date: DateTime(2021), wieght: 60),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('التقدم'),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/appBg.png'))),
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 2),
                        blurRadius: 1),
                  ],
                ),
                child: Column(children: [
                  ListTile(
                    trailing: Icon(Icons.arrow_back_ios_new),
                    leading: Container(
                      width: 35,
                      height: 35,
                      child: SvgPicture.asset('assets/icons/weight.svg'),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: primaryColor,
                      ),
                    ),
                    title: Text(
                      'تقدم الوزن',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'تقدر تشوف وزنك على مدار الفترات الزمنية',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Divider(),
                  Container(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'التقدم الحالي'),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        LineSeries<Progress, String>(
                            dataSource: chartData,
                            xValueMapper: (Progress progress, _) =>
                                DateFormat.yMd().format(progress.date),
                            yValueMapper: (Progress progress, _) =>
                                progress.wieght,
                            name: 'الوزن',
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true)
                            // Enable data label
                            ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 2),
                        blurRadius: 1),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      trailing: Icon(Icons.arrow_back_ios_new),
                      leading: Container(
                        width: 35,
                        height: 35,
                        child: SvgPicture.asset(
                          'assets/icons/human.svg',
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: primaryColor,
                        ),
                      ),
                      title: Text(
                        'نسبة الدهون',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'تقدر تشوف نسبة دهونك على مدار الفترات الزمنية',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Divider(),
                    Container(
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          LineSeries<Progress, String>(
                              dataSource: chartData,
                              xValueMapper: (Progress progress, _) =>
                                  DateFormat.yMd().format(progress.date),
                              yValueMapper: (Progress progress, _) =>
                                  progress.wieght,
                              name: 'الدهون',
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)
                              // Enable data label
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 2),
                        blurRadius: 1),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      trailing: Icon(Icons.arrow_back_ios_new),
                      leading: Container(
                        width: 35,
                        height: 35,
                        child: SvgPicture.asset(
                          'assets/icons/body_mesurements.svg',
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: primaryColor,
                        ),
                      ),
                      title: Text(
                        'قياسات الجسم',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'تقدر تشوف قياسات الجسم على مدار الفترات الزمنية',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Spacer(flex: 1),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 8,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateFormat.yMMMMd().format(DateTime(2021)),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Spacer(flex: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 8,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateFormat.yMMMMd().format(DateTime.now()),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            BodyLabel(bodyOrgan: 'الرقبة', bodyOrganValue: 13),
                          ],
                        ),
                        Expanded(
                            child:
                                Image.asset('assets/images/body_measure.JPG')),
                        Column(
                          children: [
                            BodyLabel(bodyOrgan: 'الرقبة', bodyOrganValue: 13),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyLabel extends StatelessWidget {
  const BodyLabel({
    Key? key,
    required this.bodyOrganValue,
    required this.bodyOrgan,
  }) : super(key: key);
  final String bodyOrgan;
  final int bodyOrganValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(bodyOrgan),
        SizedBox(
          width: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.brown,
            ),
          ),
          child: Text(
            '$bodyOrganValue CM',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
