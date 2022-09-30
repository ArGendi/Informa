import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import '../models/muscle.dart';
import '../models/muscles_list.dart';

class WorkoutServices{

  Future<List<List<dynamic>>> loadAsset(String fileName) async{
    var data = await rootBundle.loadString(fileName);
    return CsvToListConverter().convert(data);
  }

  Future getMuscles() async{
    List<List<dynamic>> muscles = await loadAsset('assets/files/muscles.csv');
    for(int i=1; i<muscles.length; i++){
      MusclesList.allMuscles.add(
        new Muscle(
          id: i.toString(),
          name: muscles[i][1].toString(),
          image: 'assets/images/muscles/' + muscles[i][0].toString() + '.jpg',
        ),
      );
    }
  }

}