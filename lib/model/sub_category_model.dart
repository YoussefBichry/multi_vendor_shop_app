

import 'package:multi_vendor_shop_app/firebase_service.dart';

class SubCategory {
  SubCategory({this.subCatName, this.mainCategory,this.image});

  SubCategory.fromJson(Map<String, Object?> json)
      : this(subCatName: json['subCatName']! as String, mainCategory: json['mainCategory']! as String,
  image: json['image'] as String);

  final String? mainCategory;
  final String? subCatName;
  final String? image;

  Map<String, Object?> toJson() {
    return {
      'subCatName': subCatName,
      'mainCategory': mainCategory,
      'image':image
    };
  }
  
}

FirebaseService _service = FirebaseService();

subCategoriesCollection({selectedSubCat}){
  return _service.subCategories.where('active', isEqualTo: true).where("mainCategory", isEqualTo: selectedSubCat).withConverter<SubCategory>(
    fromFirestore: (snapshot, _) => SubCategory.fromJson(snapshot.data()!),
    toFirestore: (category, _) => category.toJson(),
  );

}


