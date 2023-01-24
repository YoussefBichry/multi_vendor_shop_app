import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_shop_admin/firebaseServices.dart';

class CategoryListWidget extends StatefulWidget {
  final CollectionReference? reference;
  const CategoryListWidget({ this.reference,Key? key}) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {

  FirebaseService _service = FirebaseService();
  Object? _selectedValue;
  final TextEditingController _mainCat = TextEditingController();
  QuerySnapshot? snapshot;


  Widget categoryWidget(data){
    return Card(
        color: Colors.grey.shade400,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20,),
            SizedBox(
                child: Image.network(data['image'])),
            Text(widget.reference == _service.categories ? data['CatName']:data['subCatName']),
          ],
        )
    );
  }

  Widget _dropDownButton(){
    return DropdownButton(
        value: _selectedValue,
        hint: const Text("Select Main Category"),
        items: snapshot!.docs.map((e){
          return DropdownMenuItem<String>(
            value:e['mainCategory'] ,
            child:Text(e['mainCategory']),);
        }).toList(),
        onChanged: (selectedCat){
          setState(() {
            _selectedValue = selectedCat;
          });
        });
  }


  getMainCatList(){
    return _service.mainCat.get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }

  @override
  void initState() {
    getMainCatList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if(widget.reference == _service.subCat && snapshot!=null)
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
          SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
            stream: widget.reference!.where('mainCategory',isEqualTo: _selectedValue).snapshots(),
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
          ),
        ],
      ),
    );
  }

}
