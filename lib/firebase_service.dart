

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{

  CollectionReference homebanner = FirebaseFirestore.instance.collection('HomeBanner');
  CollectionReference brandAd = FirebaseFirestore.instance.collection('brandAd');



}