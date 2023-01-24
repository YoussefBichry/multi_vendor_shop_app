

import 'package:multi_vendor_shop_app/firebase_service.dart';

class Category {
  Category({this.CatName, this.image});

  Category.fromJson(Map<String, Object?> json)
      : this(CatName: json['CatName']! as String, image: json['image']! as String,);

  final String? CatName;
  final String? image;

  Map<String, Object?> toJson() {
    return {
      'CatName': CatName,
      'image': image,
    };
  }
  
}

FirebaseService _service = FirebaseService();

final categoriesCollection = _service.categories.where('active', isEqualTo: true).withConverter<Category>(
  fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
  toFirestore: (category, _) => category.toJson(),
);

