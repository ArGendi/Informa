import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:informa/models/cardio.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/excercise.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/models/meal_category_list.dart';
import 'package:informa/models/user.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/models/workout_day.dart';
import 'package:informa/models/workout_preset.dart';

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
    print(challenge.id);
    await FirebaseFirestore.instance.collection('challenges')
        .doc(challenge.id)
        .set(challenge.toJson())
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
      List<Meal> breakfast,
      List<Meal> lunch,
      List<Meal> dinner,
      List<Meal> otherBreakfast,
      List<Meal> otherLunch,
      List<Meal> otherDinner,
      bool snacks,
      int? breakfastDone,
      int? lunchDone,
      int? lunch2Done,
      int? dinnerDone,
      int? snacksDone,
      ) async{
    bool uploaded = true;
    Map<String, dynamic> data = new Map();
    List<Map> breakfastList = [];
    List<Map> lunchList = [];
    List<Map> dinnerList = [];
    List<Map> otherBreakfastList = [];
    List<Map> otherLunchList = [];
    List<Map> otherDinnerList = [];

    for(var fullMeal in breakfast)
      breakfastList.add(fullMeal.toJson());
    for(var fullMeal in lunch)
      lunchList.add(fullMeal.toJson());
    for(var fullMeal in dinner)
      dinnerList.add(fullMeal.toJson());

    for(var fullMeal in otherBreakfast)
      otherBreakfastList.add(fullMeal.toJson());
    for(var fullMeal in otherLunch)
      otherLunchList.add(fullMeal.toJson());
    for(var fullMeal in otherDinner)
      otherDinnerList.add(fullMeal.toJson());

    data['breakfast'] = breakfastList;
    data['lunch'] = lunchList;
    data['dinner'] = dinnerList;
    data['otherBreakfast'] = otherBreakfastList;
    data['otherLunch'] = otherLunchList;
    data['otherDinner'] = otherDinnerList;
    data['snacks'] = snacks;

    data['breakfastDone'] = breakfastDone;
    data['lunchDone'] = lunchDone;
    data['lunch2Done'] = lunch2Done;
    data['dinnerDone'] = dinnerDone;
    data['snacksDone'] = snacksDone;
    data['mainSnacksDone'] = [];
    data['supplementsDone'] = [];
    data['additionalMeals'] = [];

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

  Future<List<dynamic>?> getNutritionMeals(String id, AppUser user) async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('nutrition')
        .doc(id)
        .get();
    if(documentSnapshot.exists){
      print('Getting nutrition');
      var data = documentSnapshot.data() as Map<String, dynamic>;
      List<Meal> breakfast = [];
      List<Meal> lunch = [];
      List<Meal> dinner = [];
      var breakfastMap;
      var lunchMap;
      var dinnerMap;

      if(user.dietType != 2){
        breakfastMap = data['breakfast'];
        lunchMap = data['lunch'];
        dinnerMap = data['dinner'];
      }
      else{
        DateTime now = DateTime.now();
        print('carbCycleStartDate: ' + user.carbCycleStartDate!.day.toString());
        print('now: ' + now.day.toString());
        print('Carb cycle time diff: ' +((now.difference(user.carbCycleStartDate!).inDays) % 7).toString() );
        if(((now.difference(user.carbCycleStartDate!).inHours/24).floor() % 7) < 4){
          print('getting low carb.......');
          breakfastMap = data['breakfast'];
          lunchMap = data['lunch'];
          dinnerMap = data['dinner'];
        }
        else{
          print('getting high carb.......');
          breakfastMap = data['otherBreakfast'];
          lunchMap = data['otherLunch'];
          dinnerMap = data['otherDinner'];
        }
      }

      if(breakfastMap != null){
        for(int i=0; i<breakfastMap.length; i++){
          Meal meal = new Meal();
          meal.id = i.toString();
          meal.fromJson(breakfastMap[i]);
          breakfast.add(meal);
        }
      } else print('breakfast = null !!!!!');
      if(lunchMap != null){
        for(int i=0; i<lunchMap.length; i++){
          Meal meal = new Meal();
          meal.id = i.toString();
          meal.fromJson(lunchMap[i]);
          lunch.add(meal);
        }
      } else print('lunch = null !!!!!');
      if(dinnerMap != null){
        for(int i=0; i<dinnerMap.length; i++){
          Meal meal = new Meal();
          meal.id = i.toString();
          meal.fromJson(dinnerMap[i]);
          dinner.add(meal);
        }
      } else print('dinner = null !!!!!');
      return [breakfast, lunch, dinner, data['snacks'], data['breakfastDone'],
        data['lunchDone'], data['lunch2Done'], data['dinnerDone'], data['snacksDone'],
        data['mainSnacksDone'], data['supplementsDone'], data['additionalMeals']];
    }
    else {
      print('Document does not exist on the database');
      return null;
    }
  }

  Future<bool> checkAndUpdateNewDayData(String id, AppUser user) async{
    DateTime now = DateTime.now();
    DateTime threeAmToday = DateTime(now.year, now.month, now.day, 3);
    int? carb;
    if(user.dietType == 2){
      DateTime now = DateTime.now();
      if(((user.carbCycleStartDate!.difference(now).inHours/24).floor() % 7) < 4)
        carb = user.lowAndHighCarb![0];
      else carb = user.lowAndHighCarb![1];
    }
    if(user.lastDataUpdatedDate != null){
      int diff = (now.difference(user.lastDataUpdatedDate!).inHours / 24).floor();
      print('lastDataUpdatedDate: ' + user.lastDataUpdatedDate.toString());
      print(now.difference(user.lastDataUpdatedDate!).inHours);
      print('diff: ' + diff.toString());
      if(diff >= 1){
        await FirebaseFirestore.instance.collection('users')
            .doc(id)
            .update({
          'dailyCalories': user.myCalories,
          'dailyProtein': user.myProtein,
          'dailyCarb': user.myCarb,
          'dailyFats': user.myFats,
          'dailyCarbCycle': carb,
          'lastDataUpdatedDate': Timestamp.fromDate(threeAmToday),
        }).catchError((e){
          print(e);
        });
        await updateNutrition(id, {
          'breakfastDone': null,
          'lunchDone': null,
          'lunch2Done': null,
          'dinnerDone': null,
          'snacksDone': null,
          'mainSnacksDone': [],
          'supplementsDone': [],
          'additionalMeals': [],
        });
        print('New day data updated');
        return true;
      }
    }
    else{
      await FirebaseFirestore.instance.collection('users')
          .doc(id)
          .update({
        'dailyCalories': user.myCalories,
        'dailyProtein': user.myProtein,
        'dailyCarb': user.myCarb,
        'dailyFats': user.myFats,
        'dailyCarbCycle': carb,
        'lastDataUpdatedDate': Timestamp.fromDate(threeAmToday),
      }).catchError((e){
        print(e);
      });
      await updateNutrition(id, {
        'breakfastDone': null,
        'lunchDone': null,
        'lunch2Done': null,
        'dinnerDone': null,
        'snacksDone': null,
        'mainSnacksDone': [],
        'supplementsDone': [],
        'additionalMeals': [],
      });
      print('New day data updated from null');
      return true;
    }
    return false;
  }

  Future updateNutrition(String id, Map<String, dynamic> data) async{
    await FirebaseFirestore.instance.collection('nutrition')
        .doc(id)
        .update(data)
        .catchError((e){
      print(e);
    });
    print('Nutrition data updated');
  }

  Future getMainMeals() async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('mainMeals').get();
    var docs = documentSnapshot.docs;
    for(var doc in docs){
      MealCategory mealCategory = new MealCategory(id: doc.id);
      mealCategory.fromJson(doc.data());
      List<int> type = doc.data()['type'].cast<int>();
      if(type.contains(1)) MealCategoryList.breakfast.add(mealCategory);
      if(type.contains(2)) MealCategoryList.lunch.add(mealCategory);
      if(type.contains(3)) MealCategoryList.dinner.add(mealCategory);
    }
  }

  Future<List<Exercise>> getExercises() async{
    List<Exercise> exercises = [];
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('exercises').get();
    for(var doc in documentSnapshot.docs){
      var data = doc.data();
      Exercise exercise = new Exercise();
      exercise.id = doc.id;
      exercise.fromJson(data);
      exercises.add(exercise);
    }
    return exercises;
  }

  Future<List<Cardio>> getCardio(List<Exercise> allExercises) async{
    List<Cardio> allCardio = [];
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('cardio').get();
    for(var doc in documentSnapshot.docs){
      var data = doc.data();
      Cardio cardio = new Cardio();
      cardio.id = doc.id;
      cardio.fromCardioJson(data, allExercises);
      allCardio.add(cardio);
    }
    return allCardio;
  }

  Future<List<Workout>> getWorkouts(List<Exercise> allExercises) async{
    List<Workout> workouts = [];
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('workouts').get();
    for(var doc in documentSnapshot.docs){
      var data = doc.data();
      Workout workout = new Workout();
      workout.id = doc.id;
      workout.fromJson(data, allExercises);
      workouts.add(workout);
    }
    return workouts;
  }

  Future<WorkoutPreset?> getWorkoutPresetById(String id, List<Workout> workouts, List<Cardio> cardio) async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('workoutPresets')
        .doc(id)
        .get();
    if(documentSnapshot.exists){
      print('Document exist on the database');
      WorkoutPreset workoutPreset = new WorkoutPreset();
      var data = documentSnapshot.data() as Map<String, dynamic>;
      workoutPreset.fromJson(data, workouts, cardio);
      return workoutPreset;
    }
    else {
      print('Document does not exist on the database');
      return null;
    }
  }

  Future<Map?> getWorkoutHistoryById(String id) async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('workoutHistory')
        .doc(id)
        .get();
    if(documentSnapshot.exists) {
      print('Document exist on the database');
      WorkoutPreset workoutPreset = new WorkoutPreset();
      var data = documentSnapshot.data() as Map<String, dynamic>;
      return data;
    }
    else {
      print('Document does not exist on the database');
      return null;
    }
  }

  Future saveWorkoutInfoInHistory(String id, int week, int day, WorkoutDay workoutDay) async{
    workoutDay.isDone = true;
    await FirebaseFirestore.instance.collection('workoutHistory')
        .doc(id)
        .set({
      'week$week,day$day': workoutDay.toWorkoutHistoryJson(),
    })
        .catchError((e){
      print(e);
    });
  }

}