


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference categories = firestore.collection('categories');
  final storage = FirebaseStorage.instance;

  Future<void> saveCategory(Map<String,dynamic> data)async {

    categories.doc(data['catName']).set(data);
  }

}