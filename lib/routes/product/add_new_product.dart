import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhino_pizzeria_challenge/models/product_model.dart';
import 'package:rhino_pizzeria_challenge/routes/builders/build_input.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({Key? key}) : super(key: key);

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final _formKey = GlobalKey<FormState>();
  final ProductModel _productModel = ProductModel();
  final controllers = <TextEditingController>[
    for (var i = 0; i < 5; i++) TextEditingController(),
  ];
  File? image;
  int num = 1;
  List<String> spicy = [];
  List<String> size = [];
  List<String> drink = [];

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final path = File(image.path);
      setState(() {
        this.image = path;
      });
    } catch (e) {
      Exception(e);
    }
  }

  uploadProduct(ProductModel productModel) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('products');
    productModel.image = image!.path;
    productModel.title = controllers[0].text;
    productModel.description = controllers[1].text;
    productModel.type = spicy;
    productModel.size = size;
    productModel.drink = drink;

    await reference.add(productModel.toMap());
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            uploadProduct(_productModel);
            Navigator.pushNamed(context, 'Home');
          }
        },
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: _size.height * 0.05,
            horizontal: _size.width * 0.1,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: _size.height * 0.25,
                    width: _size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                      ),
                    ),
                    child: image != null
                        ? ClipOval(
                            child: Image.file(image!),
                          )
                        : IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                builder: (context) {
                                  return SizedBox(
                                    height: _size.height * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            await pickImage(ImageSource.camera);
                                          },
                                          child: Text(
                                            'Camera',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: _size.width * 0.075,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await pickImage(
                                                ImageSource.gallery);
                                          },
                                          child: Text(
                                            'Gallary',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: _size.width * 0.075,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              size: _size.width * 0.15,
                            ),
                          ),
                  ),
                  buildInput('Title', _size, controllers[0]),
                  buildInput('Description', _size, controllers[1]),
                  Divider(
                    thickness: _size.height * 0.005,
                    color: Colors.black54,
                  ),
                  buildInput(
                    'Category',
                    _size,
                    controllers[2],
                    icon: IconButton(
                      onPressed: () {
                        setState(() {
                          num = 1;
                        });
                        controllers[2].clear();
                        controllers[3].clear();
                        controllers[4].clear();
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: buildInput('Option$num', _size, controllers[3]),
                      ),
                      SizedBox(
                        width: _size.width * 0.025,
                      ),
                      Expanded(
                        flex: 2,
                        child: buildInput('Price', _size, controllers[4]),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  num++;
                                });
                                if (controllers[2].text.contains('spicy')) {
                                  spicy.add(controllers[3].text);
                                } else if (controllers[2]
                                    .text
                                    .contains('size')) {
                                  size.add(controllers[3].text);
                                } else {
                                  drink.add(controllers[3].text);
                                }
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: controllers[2].text.contains('spicy')
                        ? spicy
                            .map(
                              (e) => Card(
                                color: Colors.grey,
                                child: Center(
                                  child: Text(e),
                                ),
                              ),
                            )
                            .toList()
                        : controllers[2].text.contains('size')
                            ? size
                                .map((e) => Card(
                                      color: Colors.grey,
                                      child: Center(
                                        child: Text(e),
                                      ),
                                    ))
                                .toList()
                            : drink
                                .map(
                                  (e) => Card(
                                    color: Colors.grey,
                                    child: Center(
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
