import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:multi_vendor_shop_app/screens/main_screen.dart';

import '../../model/category_model.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  final List<String> _categoryLabel=<String> [
    'Picked For You',
    'Mobiles',
    'Fashion',
    'Groceries'
  ];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(
          children:[
            const SizedBox(
              height: 18,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Stores For You',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,0,8,8),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child:
                      FirestoreListView<Category>(
                        scrollDirection: Axis.horizontal,
                        query: categoriesCollection,
                        itemBuilder: (context, snapshot) {
                          Category category = snapshot.data();
                          return Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: ActionChip(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2)
                                      ),
                                      backgroundColor: _selectedCategory == category.CatName ? Colors.blue.shade900 : Colors.grey,
                                      label: Text(category.CatName!,style:TextStyle(
                                          fontSize: 12,
                                          color: _selectedCategory==category.CatName ? Colors.white :Colors.white
                                      ),),
                                      onPressed: (){
                                        setState(() {
                                          _selectedCategory = category.CatName;
                                        });
                                      },
                                    ),
                                  );
                        },
                      )
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey.shade500,
                          )
                        )
                      ),
                      child: IconButton(
                        onPressed: (){
                          Navigator.push (
                            context,
                            MaterialPageRoute (
                              builder: (BuildContext context) => const MainScreen(index: 1,)
                            ),
                          );
                        },
                        icon: const Icon (IconlyLight.arrowDown),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]
      ),

    );
  }
}
