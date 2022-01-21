import 'package:flutter/cupertino.dart';
import 'package:informa/models/user.dart';
import 'package:informa/services/firestore_service.dart';

class ActiveUserProvider extends ChangeNotifier{
  AppUser? _user;
  FirestoreService _firestoreService = new FirestoreService();

  ActiveUserProvider(){
    _user = new AppUser();
  }

  AppUser? get user => _user;

  setUser(AppUser user){
    _user = user;
    notifyListeners();
  }

  initializeUser(){
    _user = new AppUser();
    notifyListeners();
  }

  setId(String id){
    _user!.id = id;
    notifyListeners();
  }

  setName(String name){
    _user!.name = name;
    notifyListeners();
  }

  setEmail(String email){
    _user!.email = email;
    notifyListeners();
  }

  setPassword(String pass){
    _user!.password = pass;
    notifyListeners();
  }

  Future setPremium(bool value, String id) async{
    _user!.premium = value;
    notifyListeners();
    await _firestoreService.updateUserData(id, {
      'premium': value,
    });
  }

  premiumFormFilled(){
    _user!.fillPremiumForm = true;
    notifyListeners();
  }

  setFromSocialMedia(bool value){
    _user!.fromSocialMedia = value;
    notifyListeners();
  }

  setPhoneNumber(String phone){
    _user!.phone = phone;
    notifyListeners();
  }

  setGender(int gender){
    _user!.gender = gender;
    notifyListeners();
  }

  setProgram(int program){
    _user!.program = program;
    notifyListeners();
  }

  setGoal(int goal){
    _user!.goal = goal;
    notifyListeners();
  }

  setInBody(bool value){
    _user!.inBody = value;
    notifyListeners();
  }

  setGoalDescription(String value){
    _user!.goalDescription = value;
    notifyListeners();
  }

  setMyProtein(int value){
    _user!.myProtein = value;
    notifyListeners();
  }

  setMyCarb(int value){
    _user!.myCarb = value;
    notifyListeners();
  }

  setMyFats(int value){
    _user!.myFats = value;
    notifyListeners();
  }

  setMyCalories(int value){
    _user!.myCalories = value;
    notifyListeners();
  }

  setWorkoutPlace(int place){
    _user!.workoutPlace = place;
    notifyListeners();
  }

  setAge(int age){
    _user!.age = age;
    notifyListeners();
  }

  setWeight(int weight){
    _user!.weight = weight;
    notifyListeners();
  }

  setTall(int tall){
    _user!.tall = tall;
    notifyListeners();
  }

  setFitnessLevel(int level){
    _user!.fitnessLevel = level;
    notifyListeners();
  }

  setTrainingPeriodLevel(int value){
    _user!.trainingPeriodLevel = value;
    notifyListeners();
  }

  addTrainingTool(int tool){
    if(!_user!.trainingTools.contains(tool))
      _user!.trainingTools.add(tool);
    notifyListeners();
  }

  removeTrainingTool(int tool){
    if(_user!.trainingTools.contains(tool))
      _user!.trainingTools.remove(tool);
    notifyListeners();
  }

  addUnWantedMeal(String id){
    _user!.unWantedMeals.add(id);
    notifyListeners();
  }

  setTrainingTime(DateTime value){
    _user!.trainingTime = value;
    notifyListeners();
  }

  setWhichTwoMeals(int value){
    _user!.whichTwoMeals = value;
    notifyListeners();
  }

  setFatPercent(int percent){
    _user!.fatsPercent = percent;
    notifyListeners();
  }

  setWheyProtein(int value){
    _user!.wheyProtein = value;
    notifyListeners();
  }

  setHaveSupplements(int value){
    _user!.haveSupplements = value;
    notifyListeners();
  }

  setMilkProblem(int value){
    _user!.milkProblem = value;
    notifyListeners();
  }

  setDisease(int value){
    _user!.disease = value;
    notifyListeners();
  }

  setPackage(int value){
    _user!.package = value;
    notifyListeners();
  }

  setPlan(int value){
    _user!.plan = value;
    notifyListeners();
  }

  setSupplements(String value){
    _user!.supplements = value;
    notifyListeners();
  }

  setDiseaseDescription(String value){
    _user!.diseaseDescription = value;
    notifyListeners();
  }

  setNumberOfMeals(int value){
    _user!.numberOfMeals = value;
    notifyListeners();
  }

  changeMealStateUnWantedMeal(int index){
    _user!.allMeals[index].isSelected = !_user!.allMeals[index].isSelected;
    notifyListeners();
  }

  changeMealToUnWantedInAllMeals(int index){
    _user!.allMeals[index].isSelected = true;
    notifyListeners();
  }

  addMealDateInIndex(DateTime date, int index){
    if(_user!.datesOfMeals.length <= index)
      _user!.datesOfMeals.add(date);
    else _user!.datesOfMeals[index] = date;
    notifyListeners();
  }

  setNumberOfTrainingDays(int days){
    print("Entered with: " + days.toString());
    _user!.iTrainingDays = days;
    if(_user!.trainingDays.length > days){
      print(_user!.trainingDays);
      for(int i=_user!.trainingDays.length-1; i >= days; i--) {
        _user!.trainingDays.removeAt(i);
        print(_user!.trainingDays);
      }
      print("Length: " + _user!.trainingDays.length.toString());
    }
    notifyListeners();
  }

  addTrainingDay(int day){
    int trainingDays = _user!.iTrainingDays;
    if(!_user!.trainingDays.contains(day) && _user!.trainingDays.length < trainingDays)
      _user!.trainingDays.add(day);
    notifyListeners();
  }

  removeTrainingDay(int day){
    if(_user!.trainingDays.contains(day))
      _user!.trainingDays.remove(day);
    notifyListeners();
  }

  removeAllUnwantedMeals(){
    List onlyWantedMeals = [];
    for(var meal in _user!.allMeals){
      if(meal.isSelected) onlyWantedMeals.add(meal);
    }
    _user!.allMeals = onlyWantedMeals;
    notifyListeners();
  }

}