import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multivendor_shop_admin/firebase_service.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'category';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final FirebaseService service = FirebaseService();
  final TextEditingController _catName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  dynamic image;
  late String fileName;


  pickImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,allowMultiple: false
    );
    if(result!=null)
      {
        setState(() {
          image = result.files.first.bytes;
          fileName = result.files.first.name;
        });
      }
    else
    {
        print('Failed or Canceled');
    }
  }

  saveImageToDb() async{
    var  storageRef = FirebaseStorage.instance.ref('Categories/$fileName');
   EasyLoading.show();
   try{
     await storageRef.putData(image);
     String downloadUrl = await storageRef.getDownloadURL().then((value)
      {
        if(value.isNotEmpty){
          service.saveCategory(
            {
              'catName':_catName.text,
              'image': value,
              'active':true
            }
          ).then((value){
            clear();
            EasyLoading.dismiss();
          });
        }
        return value;
      });
   } on FirebaseException catch(e){
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
      key: _formKey,
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
                      child: Center(child: image == null ? const Text('Category Image'):Image.memory(image),)
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      pickImage();
                    }, child: const Text("Upload Image"))
                  ],
                ),
                const SizedBox(width: 20,),
                Container(
                  width: 200,
                  child:  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Category Name';
                      }
                    },
                    controller: _catName,
                    decoration: const InputDecoration(
                      label: Text("Enter Category Name"),
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                TextButton(
                  onPressed: clear,
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
                image == null ? Container() : ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate())
                      {
                        saveImageToDb();
                      }

                  },
                  child: Text('Save',
                    style: TextStyle(color: Colors.white,)),
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
        ],
      ),
    );
  }
}
