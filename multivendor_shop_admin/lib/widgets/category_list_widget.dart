import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_shop_admin/firebaseServices.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();

    Widget categoryWidget(data){
     return Card(
          color: Colors.grey.shade400,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 20,),
              SizedBox(
                  child: Image.network(data['image'])),
              Text(data['CatName']),
            ],
          )
      );

    }

    return StreamBuilder<QuerySnapshot>(
      stream: _service.categories.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        if(snapshot.data!.size == 0){
          return const Text('No categories Added');
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 3,
            mainAxisSpacing: 3
          ),
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index){
            var data = snapshot.data!.docs[index];
            return categoryWidget(data);
          }
          // children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          //   return ListTile(
          //     title: Text(data['CatName']),
          //   );
          // }).toList(),
        );
      },
    );
  }
}
