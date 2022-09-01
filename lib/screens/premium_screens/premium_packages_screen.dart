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
//TODO: there is a wired action I think it will happen when the user select a duration for its plan , that we identify each duration by its days, so I think if the user choose a
//TODO: duration maybe a conflict will happen if the user choosed a duration that in other package have the same days
// TODO: so I think to solve it we must identify each duartion with a specific id that is uniqe from each duartion in each "tarekka motab3a"

class _PremiumPackagesScreenState extends State<PremiumPackagesScreen> {
  int _selectedPackage = 1;
  int _selectedPlan = 0;
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

  // String getPrice(int period) {
  //   if (_selectedPackage == 1) {
  //     if (period == 1)
  //       return '200';
  //     else if (period == 3)
  //       return '500';
  //     else if (period == 6)
  //       return '800';
  //     else if (period == 12) return '1500';
  //   } else if (_selectedPackage == 2) {
  //     if (period == 1)
  //       return '300';
  //     else if (period == 3)
  //       return '800';
  //     else if (period == 6)
  //       return '1500';
  //     else if (period == 12) return '2000';
  //   } else if (_selectedPackage == 3) {
  //     if (period == 1)
  //       return '500';
  //     else if (period == 3)
  //       return '1000';
  //     else if (period == 6)
  //       return '1800';
  //     else if (period == 12) return '3000';
  //   }
  //   return null.toString();
  // }

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
        Provider.of<PlansProvider>(context, listen: false).plans;

    var activeUser = Provider.of<ActiveUserProvider>(context).user;
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
                              setState(() {
                                changePackage(i);
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
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 1.5,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      children: plans[_selectedPackage].planDuration.map(
                        (e) {
                          return PeriodPriceCard(
                            id: e.daysNumber,
                            selected: _selectedPlan,
                            period: e.name,
                            price: e.price.toString(),
                            onClick: () {
                              setState(() {
                                _selectedPlan = e.daysNumber;
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
                    _selectedPlan != 0 ? primaryColor : Colors.grey.shade400,
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
// ProgramSelectCard(
//   mainText: 'سيلفر',
//   subText: 'متابعة عبر التطبيق فقط',
//   onClick: (){
//     setState(() {
//       changePackage(1);
//     });
//   },
//   userChoice: _selectedPackage,
//   number: 1,
//   borderColor: Colors.grey.shade300,
// ),
// SizedBox(height: 10,),
// ProgramSelectCard(
//   mainText: 'جولد',
//   subText:
//       'متابعة عبر التطبيق + متابعة يوم ويوم عبر الواتساب مع كابتن معتمد من فريق انفورما',
//   onClick: () {
//     setState(() {
//       changePackage(2);
//     });
//   },
//   userChoice: _selectedPackage,
//   number: 2,
//   borderColor: Colors.grey.shade300,
// ),
// SizedBox(height: 10,),
// if(activeUser!.program == 2)
//   ProgramSelectCard(
//     mainText: 'ميجا',
//     subText: 'متابعة عبر التطبيق + متابعة كل يوم عبر الواتساب (من السبت للخميس) مع كابتن معتمد من فريق انفورما + متباعة مرة أسبوعياً مع كابتن حسين شخصياً (كابتن انفورما)',
//     onClick: (){
//       setState(() {
//         changePackage(3);
//       });
//     },
//     userChoice: _selectedPackage,
//     number: 3,
//     borderColor: Colors.grey.shade300,
//   ),

// child: Column(
//   children: [
//     Row(
//       children: [
//         Expanded(
//           child: PeriodPriceCard(
//             id: 1,
//             selected: _selectedPlan,
//             period: 'شهر واحد',
//             price: getPrice(1),
//             onClick: () {
//               setState(() {
//                 _selectedPlan = 1;
//               });
//             },
//           ),
//         ),
//         SizedBox(
//           width: 5,
//         ),
//         Expanded(
//           child: PeriodPriceCard(
//             id: 3,
//             selected: _selectedPlan,
//             period: 'ثلاث اشهر',
//             price: getPrice(3),
//             onClick: () {
//               setState(() {
//                 _selectedPlan = 3;
//               });
//             },
//           ),
//         ),
//       ],
//     ),
//     SizedBox(
//       height: 5,
//     ),
//     Row(
//       children: [
//         Expanded(
//           child: PeriodPriceCard(
//             id: 6,
//             selected: _selectedPlan,
//             period: 'نص سنة',
//             price: getPrice(6),
//             onClick: () {
//               setState(() {
//                 _selectedPlan = 6;
//               });
//             },
//           ),
//         ),
//         SizedBox(
//           width: 5,
//         ),
//         Expanded(
//           child: PeriodPriceCard(
//             id: 12,
//             selected: _selectedPlan,
//             period: 'سنة كاملة',
//             price: getPrice(12),
//             onClick: () {
//               setState(() {
//                 _selectedPlan = 12;
//               });
//             },
//           ),
//         ),
//       ],
//     ),
//   ],
// ),
