import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../firebaseServices.dart';
import '../widgets/category_list_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  static const String id = 'sub-category';
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  FirebaseService _service = FirebaseService();
  final _key = GlobalKey<FormState>();
  dynamic image;
  String? fileName;
  final TextEditingController _subCatName = TextEditingController();
  Object? _selectedValue;
  final TextEditingController _mainCat = TextEditingController();
  bool _noCategorySelected = false;
  QuerySnapshot? snapshot;

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

  pickImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,allowMultiple: false
    );
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    } else {
      print("Canceled");
    }
  }

  saveImageToDb() async{
    EasyLoading.show();
    var ref =  _service.storage.ref('subCategoryImage/$fileName');
    try {
      await ref.putData(image);
      await ref.getDownloadURL().then((value){
        if(value.isNotEmpty){
          _service.saveCategory(
              data: {
                'mainCategory':_selectedValue,
                'subCatName':_subCatName.text,
                'image':value,
                'active':true
              },
              reference: _service.subCat,
              docName: _subCatName.text
          ).then((value){
            clear();
            EasyLoading.dismiss();
          });
        }
      });

    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  clear(){
    setState(() {
      _subCatName.clear();
      image = null;
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
    return Form(
      key: _key,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sub Categories',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade800)
                    ),
                    child: Center(child: image == null ?Text('Category Image'):Image.memory(image)),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    pickImage();
                  }, child: Text("Upload Image"))
                ],
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (snapshot == null) ? Text("Loading...") :
                  _dropDownButton(),
                  const SizedBox(height: 8,),
                  if(_noCategorySelected == true)
                    const Text("No Main category Selected", style: TextStyle(
                      color: Colors.red,
                    ),),
                  Container(
                    width: 200,
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Enter Sub Category Name';
                        }
                        return null;
                      },
                      controller: _subCatName,
                      decoration: InputDecoration(
                          label: Text("Enter Sub Category Name"),
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
                      image == null ? Container():
                      ElevatedButton(
                        onPressed: (){
                          if(_selectedValue == null){
                            setState(() {
                              _noCategorySelected = true;
                            });
                            return;
                          }
                          if(_key.currentState!.validate()){
                            saveImageToDb();
                          }
                        },
                        child:Text('Save',
                          style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const Divider(color: Colors.grey,),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sub Category List',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          CategoryListWidget(
            reference: _service.subCat,
          ),
        ],
      ),
    );
  }
}
