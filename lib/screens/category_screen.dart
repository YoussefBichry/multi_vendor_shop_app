import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:multi_vendor_shop_app/widgets/category/main_category_widget.dart';

import '../model/category_model.dart';



class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _title = 'Categories';
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(selectedCategory == null? _title : selectedCategory!,style: TextStyle(color:Colors.grey.shade900,fontSize: 18),),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black54
          ),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(IconlyLight.search)),
            IconButton(onPressed: (){}, icon: Icon(IconlyLight.buy)),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
          ],
        ),
        body: Row(
          children: [
            Container(
              width: 80,
              color: Colors.grey.shade400,
              child: FirestoreListView<Category>(
                query: categoriesCollection,
                itemBuilder: (context, snapshot) {
                  Category category = snapshot.data();
                  return InkWell(
                    onTap: (){
                      setState(() {
                        _title = category.CatName!;
                        selectedCategory = category.CatName;
                      });
                    },
                    child: Container(
                      height: 70,
                      color: selectedCategory == category.CatName ? Colors.white : Colors.grey.shade300,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height:30,
                                  child: CachedNetworkImage(
                                      imageUrl: category.image!,
                                      color: selectedCategory == category.CatName? Theme.of(context).primaryColor : Colors.grey.shade700,
                                  )
                              ),
                              Text(category.CatName!,style: TextStyle(fontSize: 12,
                                  color: selectedCategory == category.CatName? Theme.of(context).primaryColor :Colors.grey.shade700),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ),
            MainCategoryWidget(
              selectedCat: selectedCategory,
            )
          ],
        ),
    );
  }
}
