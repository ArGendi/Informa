import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  String? id;
  String? name;
  String? description;
  DateTime? deadline;
  String? url;
  Map<String, dynamic>? submits;
  //0 = free, 1 = payed, 2 = premium
  int status = 0;

  Challenge({this.id, this.name, this.url, this.deadline, this.description});

  fromJson(Map<String, dynamic> json){
    name = json['name'];
    description = json['description'];
    var tsDeadline = json['deadline'] as Timestamp;
    deadline = tsDeadline.toDate();
    url = json['url'];
    submits = json['submits'];
    status = json['status'] != null ? json['status'] : 0;
  }
}