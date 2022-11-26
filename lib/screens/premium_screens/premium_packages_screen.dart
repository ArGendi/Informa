import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/models/plans.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/payment_bottom_sheet.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/plans_provider.dart';
import '../../widgets/period_price_card.dart';

class PremiumPackagesScreen extends StatefulWidget {
  static String id = 'premium packages';
  const PremiumPackagesScreen({Key? key}) : super(key: key);

  @override
  _PremiumPackagesScreenState createState() => _PremiumPackagesScreenState();
}

class _PremiumPackagesScreenState extends State<PremiumPackagesScreen> {
  int _selectedPackage = 0;
  String uISelected = '';
  String _selectedPlan = '';
  double _opacity = 1;
  bool _isLoading = false;
  FirestoreService _firestoreService = new FirestoreService();

  changePackage(int package) {
    setState(() {
      _selectedPackage = package;
      _opacity = _opacity == 0.0 ? 1.0 : 0.0;
    });
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = _opacity == 0.0 ? 1.0 : 0.0;
      });
    });
  }

  showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return PaymentBottomSheet();
      },
    );
  }

  onNext(BuildContext context) async {
    var activeUser =
        Provider.of<ActiveUserProvider>(context, listen: false).user;
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setPackage(_selectedPackage);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setPlan(_selectedPlan);
    String id = FirebaseAuth.instance.currentUser!.uid;
    setState(() {
      _isLoading = true;
    });
    await _firestoreService.updateUserData(id, {
      'package': _selectedPackage,
      'plan': _selectedPlan,
      'program': activeUser!.program,
    });
    setState(() {
      _isLoading = false;
    });
    showPaymentBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Plans> plans =
        Provider.of<ActiveUserProvider>(context).user!.program == 1
            ? Provider.of<PlansProvider>(context, listen: false).trainingPlans
            : Provider.of<ActiveUserProvider>(context).user!.program == 2
                ? Provider.of<PlansProvider>(context, listen: false)
                    .dietAndTrainingPlans
                : Provider.of<PlansProvider>(context, listen: false).dietPlans;
    return Scaffold(
      appBar: AppBar(
        title: Text('خطط الأشتراك'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: splashRadius,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
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
              Text(
                'طريقة المتابعة',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: boldFont,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ...plans
                  .asMap()
                  .map((i, e) {
                    return MapEntry(
                      i,
                      Column(
                        children: [
                          ProgramSelectCard(
                            mainText: e.name,
                            subText: e.description,
                            onClick: () {
                              print(i);
                              setState(() {
                                changePackage(i);
                                _selectedPlan = '';
                              });
                            },
                            userChoice: _selectedPackage,
                            number: i,
                            borderColor: Colors.grey.shade300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  })
                  .values
                  .toList(),
              Text(
                'حدد الفترة',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: boldFont,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      children: plans[_selectedPackage].planDuration.map(
                        (e) {
                          return PeriodPriceCard(
                            id: e.id,
                            selected: _selectedPlan,
                            period: e.name,
                            price: e.price.toString(),
                            onClick: () {
                              setState(() {
                                _selectedPlan = e.id;
                                print(_selectedPlan);
                                //TODO figure out how to select a plan from the list and add it to firestore with its unique ID and then use it to get the plan details in either in admin or here in the app

                                // _selectedPlan = e.daysNumber;
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'المتابعة',
                bgColor:
                    _selectedPlan != '' ? primaryColor : Colors.grey.shade400,
                isLoading: _isLoading,
                onClick: () {
                  onNext(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
