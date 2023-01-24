import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_shop_app/widgets/category/sub_category_widget.dart';
import '../../model/main_category_model.dart';



class MainCategoryWidget extends StatefulWidget {
  final String? selectedCat;
  const MainCategoryWidget({Key? key, this.selectedCat}) : super(key: key);

  @override
  State<MainCategoryWidget> createState() => _MainCategoryWidgetState();
}

class _MainCategoryWidgetState extends State<MainCategoryWidget> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<MainCategory>(
        query: MaincategoriesCollection(widget.selectedCat),
        itemBuilder: (context, snapshot) {
          MainCategory mainCategory = snapshot.data();
          return ExpansionTile(
              title: Text(mainCategory.mainCategory!),
            children: [
              SubCategoryWidget(
                selectedSubCat: mainCategory.mainCategory,
              )
            ],
          );
        },
      ),
    );
  }
}
