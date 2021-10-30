import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore? _firestore;

  FirestoreService(){
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> saveNewAccount() async{
    await FirebaseFirestore.instance.collection('users').add({
      'email': '',
      'password': '',
      'name': '',
      'createdAt': '',
      'thirdPartyAccount': '',
      'phoneNumber': '',
    }).catchError((e){
      print(e);
    });
  }

}