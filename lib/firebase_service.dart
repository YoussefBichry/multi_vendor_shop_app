

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{

  CollectionReference homebanner = FirebaseFirestore.instance.collection('HomeBanner');
  CollectionReference brandAd = FirebaseFirestore.instance.collection('brandAd');
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCategories = FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories = FirebaseFirestore.instance.collection('subCategories');


}