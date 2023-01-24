import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference categories = firestore.collection('categories');
  late CollectionReference mainCat = firestore.collection('mainCategories');
  late CollectionReference subCat = firestore.collection('subCategories');
  final storage = FirebaseStorage.instance;
  late CollectionReference vendors = firestore.collection('vendor');

  Future<void> saveCategory({CollectionReference? reference,Map<String,dynamic>? data,String? docName})async {

    return reference!.doc(docName).set(data);
  }

  Future<void> updateData({CollectionReference? reference,Map<String,dynamic>? data,String? docName})async {

    return reference!.doc(docName).update(data!);
  }

}