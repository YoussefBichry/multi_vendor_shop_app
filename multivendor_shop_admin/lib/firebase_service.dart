
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{

CollectionReference categories = FirebaseFirestore.instance.collection('categories');

saveCategory(Map<String,dynamic> data){
  return categories.doc(data['catName']).set(data);

}

}