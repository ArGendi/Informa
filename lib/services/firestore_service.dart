import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/user.dart';

class FirestoreService{

  Future<void> saveNewAccountWithFullInfo(AppUser user) async{
    print(user.id);
    print(user.toJson());
    await FirebaseFirestore.instance.collection('users')
        .doc(user.id!.toString())
        .set(user.toJson())
        .catchError((e){
      print(e);
    });
    print('Account added');
  }

  Future<void> saveNewAccount(AppUser user) async{
    await FirebaseFirestore.instance.collection('users')
        .doc(user.id!.toString())
        .set({
          'email': user.email,
          'name': user.name,
          'fromSocialMedia': user.fromSocialMedia,
        })
        .catchError((e){
          print(e);
        });
    print('Account added');
  }

  Future<AppUser?> isEmailExist(String id) async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print('ID: ' + id);
    DocumentSnapshot response = await users.doc(id).get();
    if(response.exists) {
      AppUser user = loadDataOfUser(response);
      return user;
    }
      return null;
  }

  AppUser loadDataOfUser(DocumentSnapshot snapshot){
    var data = snapshot.data() as Map<String, dynamic>;
    AppUser user = new AppUser();
    user.fromJson(data);
    return user;
  }

  Future<AppUser?> getUserById(String id) async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get();
    if(documentSnapshot.exists){
      print('Document exist on the database');
      AppUser user = new AppUser();
      var data = documentSnapshot.data() as Map<String, dynamic>;
      user.fromJson(data);
      return user;
    }
    else {
      print('Document does not exist on the database');
      return null;
    }
  }

  Future<List<Challenge>> getAllChallenges() async{
    List<Challenge> challenges = [];
    DateTime now = DateTime.now();
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('challenges').where('deadline', isGreaterThan: Timestamp.fromDate(now)).orderBy('deadline').get();
    var docs = documentSnapshot.docs;
    for(var doc in docs){
      Challenge challenge = new Challenge();
      challenge.id = doc.id;
      bool valid = challenge.fromJson(doc.data());
      if(valid)
        challenges.add(challenge);
    }
    return challenges;
  }

  Future submitChallenge(Challenge challenge) async{
    await FirebaseFirestore.instance.collection('challenges')
        .doc(challenge.id)
        .update({'submits': challenge.submits})
        .catchError((e){
      print(e);
    });
    print('challenge submitted');
  }

  Future<String?> getUserActivateCode(String id) async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('activation')
        .doc(id)
        .get();
    if(documentSnapshot.exists){
      print('Document exist on the database');
      var data = documentSnapshot.data() as Map<String, dynamic>;
      String code = data['code'];
      return code;
    }
    else {
      print('Document does not exist on the database');
      return null;
    }
  }

  Future<bool> updateUserData(String id, Map<String, dynamic> data) async{
    bool updated = true;
    await FirebaseFirestore.instance.collection('users')
        .doc(id)
        .update(data)
        .catchError((e){
      print(e);
      updated = false;
    });
    if(updated){
      print('user data updated');
      return true;
    }
    return false;
  }

  Future<bool> saveNutritionMeals(
      String id,
      List<FullMeal> breakfast,
      List<FullMeal> lunch,
      List<FullMeal> dinner,
      bool snacks,
      ) async{
    bool uploaded = true;
    Map<String, dynamic> data = new Map();
    List<Map> breakfastList = [];
    List<Map> lunchList = [];
    List<Map> dinnerList = [];
    for(var fullMeal in breakfast)
      breakfastList.add(fullMeal.toJson());
    for(var fullMeal in lunch)
      lunchList.add(fullMeal.toJson());
    for(var fullMeal in dinner)
      dinnerList.add(fullMeal.toJson());

    data['breakfast'] = breakfastList;
    data['lunch'] = lunchList;
    data['dinner'] = dinnerList;
    data['snacks'] = snacks;

    await FirebaseFirestore.instance.collection('nutrition')
        .doc(id)
        .set(data)
        .catchError((e){
      print(e);
      uploaded = false;
    });
    if(uploaded){
      print('Nutrition data set');
      return true;
    }
    return false;
  }

  Future<List<dynamic>?> getNutritionMeals(String id) async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('nutrition')
        .doc(id)
        .get();
    if(documentSnapshot.exists){
      print('Document exist on the database');
      var data = documentSnapshot.data() as Map<String, dynamic>;
      List<FullMeal> breakfast = [];
      List<FullMeal> lunch = [];
      List<FullMeal> dinner = [];
      var breakfastMap = data['breakfast'];
      var lunchMap = data['lunch'];
      var dinnerMap = data['dinner'];
      if(breakfastMap != null){
        for(int i=0; i<breakfastMap.length; i++){
          FullMeal fullMeal = new FullMeal();
          fullMeal.id = i.toString();
          fullMeal.fromJson(breakfastMap[i]);
          breakfast.add(fullMeal);
        }
      } else print('breakfast = null !!!!!');
      if(lunchMap != null){
        for(int i=0; i<lunchMap.length; i++){
          FullMeal fullMeal = new FullMeal();
          fullMeal.id = i.toString();
          fullMeal.fromJson(lunchMap[i]);
          lunch.add(fullMeal);
        }
      } else print('lunch = null !!!!!');
      if(dinnerMap != null){
        for(int i=0; i<dinnerMap.length; i++){
          FullMeal fullMeal = new FullMeal();
          fullMeal.id = i.toString();
          fullMeal.fromJson(dinnerMap[i]);
          dinner.add(fullMeal);
        }
      } else print('dinner = null !!!!!');
      return [breakfast, lunch, dinner, data['snacks']];
    }
    else {
      print('Document does not exist on the database');
      return null;
    }
  }

}