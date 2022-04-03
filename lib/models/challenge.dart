import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  String? id;
  String? name;
  String? description;
  DateTime? deadline;
  String? video;
  String? image;
  Map<String, dynamic>? submits;
  //0 = free, 1 = payed, 2 = premium
  int status = 0;
  String? first;
  String? second;

  Challenge({this.id, this.name, this.image, this.deadline, this.description, this.video});

  bool fromJson(Map<String, dynamic> json){
    try{
      name = json['name'];
      description = json['description'];
      var tsDeadline = json['deadline'] as Timestamp;
      deadline = tsDeadline.toDate();
      image = json['image'];
      video = json['video'];
      submits = json['submits'];
      status = json['status'] != null ? json['status'] : 0;
      first = json['first'];
      second = json['second'];
      return true;
    }
    catch(e){
      print('Challenge error: ' + e.toString());
      return false;
    }
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'description': description,
      'image': image,
      'video': video,
      'status': status,
      'submits': submits,
      'first': first,
      'second': second,
      'deadline': Timestamp.fromDate(deadline!),
    };
  }
}