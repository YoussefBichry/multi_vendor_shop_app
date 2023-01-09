import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multivendor_shop_admin/firebaseServices.dart';
import 'package:multivendor_shop_admin/widgets/main_category_list_widget.dart';

class MainCategoryScreen extends StatefulWidget {
  static const String id = 'main-category';
  const MainCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MainCategoryScreen> createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {

  final _key = GlobalKey<FormState>();
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

  clear(){
    setState(() {
      _selectedValue = null;
      _mainCat.clear();
    });
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
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,8,8,8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Main Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            const Divider(color: Colors.grey,),
            (snapshot == null) ? Text("Loading..."):
            _dropDownButton(),
            SizedBox(height: 8,),
            if(_noCategorySelected == true)
            Text("No category Selected", style: TextStyle(
              color: Colors.red,
            ),),
            Container(
              width: 200,
              child: TextFormField(
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return 'Enter Main Category Name';
                  }
                  return null;
                },
                controller: _mainCat,
                decoration: InputDecoration(
                    label: Text("Enter Category Name"),
                    contentPadding: EdgeInsets.zero
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(BorderSide(
                          color:Theme.of(context).primaryColor
                      ))
                  ) ,
                  child: Text('Cancel',
                    style: TextStyle(color: Theme.of(context).primaryColor),),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: (){
                    if(_selectedValue == null){
                      setState(() {
                        _noCategorySelected = true;
                      });
                      return;
                    }
                    if(_key.currentState!.validate()){
                      EasyLoading.show();
                      _service.saveCategory(
                          data:{
                          'category':_selectedValue,
                           'mainCategory':_mainCat.text,
                           'approved':true,
                          },
                        reference: _service.mainCat,
                        docName: _mainCat.text
                      ).then((value){
                         EasyLoading.dismiss();
                      });
                    };
                  },
                  child:Text('Save',
                    style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
            const Divider(color: Colors.grey,),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                ' Main Category List',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const MainCategoryListWidget(),
          ],
        ),
      ),
    );
  }
}
