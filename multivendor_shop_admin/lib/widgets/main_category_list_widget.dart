import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_shop_admin/firebaseServices.dart';

class MainCategoryListWidget extends StatefulWidget {
  const MainCategoryListWidget({Key? key}) : super(key: key);

  @override
  State<MainCategoryListWidget> createState() => _MainCategoryListWidgetState();
}

class _MainCategoryListWidgetState extends State<MainCategoryListWidget> {

  FirebaseService _service = FirebaseService();
  Object? _selectedValue;
  final TextEditingController _mainCat = TextEditingController();
  bool _noCategorySelected = false;
  QuerySnapshot? snapshot;


  Widget _dropDownButton(){
    return DropdownButton(
        value: _selectedValue,
        hint: const Text("Select Category"),
        items: snapshot!.docs.map((e){
          return DropdownMenuItem<String>(
            value:e['CatName'] ,
            child:Text(e['CatName']),);
        }).toList(),
        onChanged: (selectedCat){
          setState(() {
            _selectedValue = selectedCat;
            _noCategorySelected = false;
          });
        });
  }


  Widget categoryWidget(data){
    return Card(
        color: Colors.grey.shade400,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20,),
            Center(child: Text(data['mainCategory'])),
          ],
        )
    );
  }

  getCatList(){
    return _service.categories.get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }


  @override
  void initState() {
    getCatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        snapshot == null? Text("Loading...") :
        Row(
          children: [
            _dropDownButton(),
            const SizedBox(width: 10,),
            ElevatedButton(onPressed:(){
              setState(() {
                _selectedValue = null;
              });
            }, child: Text("Show all"))
          ],
        ),
        const SizedBox(height: 10,),
        StreamBuilder<QuerySnapshot>(
          stream: _service.mainCat.where('category', isEqualTo:_selectedValue).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }

            if(snapshot.data!.size == 0){
              return const Text('No Main categories Added');
            }

            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 6/2 ,
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
        ),
      ],
    );
  }
}
