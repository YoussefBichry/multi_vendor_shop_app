import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_shop_app/model/sub_category_model.dart';
import '../../model/main_category_model.dart';



class SubCategoryWidget extends StatelessWidget {
  final String? selectedSubCat;
  const SubCategoryWidget({Key? key, this.selectedSubCat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<SubCategory>(
      query: subCategoriesCollection(
          selectedSubCat: selectedSubCat
      ),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
 const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: snapshot.docs.length==0 ? 1/ .1 : 1/1.1
          ),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            // if you have more names use the following lines
            // if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
            //   // Tell FirestoreQueryBuilder to try to obtain more items.
            //   // It is safe to call this function from within the build method.
            //   snapshot.fetchMore();
            // }

            SubCategory subCat = snapshot.docs[index].data();
            return InkWell(
              onTap: (){
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: FittedBox(
                        child: CachedNetworkImage(
                          imageUrl: subCat.image!,
                          placeholder: (context,_){
                            return Container(
                              height: 60,
                              width: 60,
                              color: Colors.grey.shade300
                            );
                          },
                        ),
                        fit: BoxFit.contain,
                    ),
                  ),
                  Text(subCat.subCatName!, style: TextStyle(
                    fontSize: 12
                  ),
                  textAlign: TextAlign.center,),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
