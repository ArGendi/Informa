import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:informa/models/user.dart';

class FirestoreService{

  Future<void> saveNewAccountWithFullInfo(AppUser user) async{
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

}