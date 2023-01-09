import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multivendor_shop_admin/firebaseServices.dart';
import 'package:multivendor_shop_admin/widgets/category_list_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'category';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  FirebaseService _service = FirebaseService();
  final _key = GlobalKey<FormState>();
  dynamic image;
  String? fileName;
  final TextEditingController _catName = TextEditingController();

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
    var ref =  _service.storage.ref('categories/$fileName');
    try {
      await ref.putData(image);
      await ref.getDownloadURL().then((value){
        if(value.isNotEmpty){
          _service.saveCategory(
            data: {
              'CatName':_catName.text,
              'image':value,
              'active':true
            },
            reference: _service.categories,
            docName: _catName.text
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
      _catName.clear();
      image = null;
    });
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
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
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
                const SizedBox(width: 20,),
                Container(
                  width: 200,
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty)
                        {
                          return 'Enter Category Name';
                        }
                      return null;
                    },
                    controller: _catName,
                    decoration: InputDecoration(
                      label: Text("Enter Category Name"),
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
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
                    if(_key.currentState!.validate()){
                      saveImageToDb();
                    };
                  },
                  child:Text('Save',
                    style: TextStyle(color: Colors.white),),
                ),
              ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Category List',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const CategoryListWidget(),
        ],
      ),
    );
  }
}
