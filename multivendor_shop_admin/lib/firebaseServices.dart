


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference categories = firestore.collection('categories');
  late CollectionReference mainCat = firestore.collection('mainCategories');
  final storage = FirebaseStorage.instance;

  Future<void> saveCategory({CollectionReference? reference,Map<String,dynamic>? data,String? docName})async {

    return reference!.doc(docName).set(data);
  }

}