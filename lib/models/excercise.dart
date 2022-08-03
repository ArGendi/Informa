import 'package:informa/models/tool.dart';
import 'package:informa/models/tools_list.dart';

import 'muscle.dart';
import 'muscles_list.dart';

class Exercise{
  String? id;
  String? name;
  String? description;
  String? image;
  String? video;
  int? category;
  //1= gym, 2= home, 3= both
  int? place;
  List<Tool>? tools = [];
  List<Muscle>? targetMuscles = [];
  List<Muscle>? helpersMuscles = [];
  List<Muscle>? settlersMuscles = [];

  Exercise({this.name, this.id, this.description, this.image, this.video, this.category,
    this.place, this.tools, this.targetMuscles, this.helpersMuscles, this.settlersMuscles,
  });

  List<int> convertToolsIntoListOfIds(){
    List<int> ids = [];
    for(var tool in tools!){
      ids.add(tool.id!);
    }
    return ids;
  }

  List<Tool> convertListOfIdsIntoTools(List ids){
    List<Tool> tools = [];
    for(var id in ids){
      tools.add(ToolsList.allTools[id-1]);
    }
    return tools;
  }

  List<String> convertMusclesIntoListOfIds(List<Muscle> list){
    List<String> ids = [];
    for(var item in list){
      ids.add(item.id!);
    }
    return ids;
  }

  List<Muscle> convertListOfIdsIntoMuscles(List ids){
    List<Muscle> muscles = [];
    for(var id in ids){
      int iId = int.parse(id.trim());
      muscles.add(MusclesList.allMuscles[iId-1]);
    }
    return muscles;
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'description': description,
      'image': image,
      'video': video,
      'category': category,
      'place': place,
      'tools': convertToolsIntoListOfIds(),
      'targetMuscles': convertMusclesIntoListOfIds(targetMuscles!),
      'helpersMuscles': convertMusclesIntoListOfIds(helpersMuscles!),
      'settlersMuscles': convertMusclesIntoListOfIds(settlersMuscles!),
    };
  }

  fromJson(Map<String, dynamic> json){
    name = json['name'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    category = json['category'];
    place = json['place'];
    tools = json['tools'] != null? convertListOfIdsIntoTools(json['tools']) : null;
    targetMuscles = json['targetMuscles'] != null?
    convertListOfIdsIntoMuscles(json['targetMuscles']) : null;
    helpersMuscles = json['helpersMuscles'] != null?
    convertListOfIdsIntoMuscles(json['helpersMuscles']) : null;
    settlersMuscles = json['settlersMuscles'] != null?
    convertListOfIdsIntoMuscles(json['settlersMuscles']) : null;
  }
}