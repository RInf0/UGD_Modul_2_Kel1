import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugd_modul_2_kel1/pdf/pdf_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String id = const Uuid().v1();
  File? image;

  List<Product> products = [
    Product('Membership', 50000),
    Product('Books', 30000),
    Product('Pen', 5000),
    Product('Snacks', 10000),
    Product('Hamburger', 25000),
  ];

  int number = 0;

  getTotal() => products
      .fold(0.0,
          (double prev, element) => prev + (element.price * element.amount))
      .toStringAsFixed(2);

  getPPN() => products
      .fold(
          0.0,
          (double prev, element) =>
              prev +
              (element.price / 100 * element.ppnInPercent * element.amount))
      .toStringAsFixed(2);

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        'Modul 8 Library',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  SingleChildScrollView inputSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          inputPersonalData(),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              'Buy Product',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          inputProduct(),
          buttonCreatePDF(context),
        ],
      ),
    );
  }

  Container inputPersonalData() {
    return Container(
      margin: EdgeInsets.all(3.h),
      child: Column(
        children: [
          Center(
            child: Text(
              'Fill This Form',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  onPressed: () => pickImageC(),
                  child: const Text('Pick Image from Camera'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  onPressed: () => pickImage(),
                  child: const Text('Pick Image from Gallery'),
                ),
              ),
              SizedBox(
                width: 10.w,
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          if (image != null)
            Column(
              children: [
                kIsWeb ? Image.network(image!.path) : Image.file(image!),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: IconButton(
                    color: Colors.red,
                    iconSize: 5.h,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        image = null;
                      });
                    },
                  ),
                ),
              ],
            )
          else
            const Text('No image selected'),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Enter Your Name',
              labelText: 'Nama',
            ),
          ),
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              hintText: 'Enter Your Phone Number',
              labelText: 'Phone Number',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              hintText: 'Enter Your Address',
              labelText: 'Address',
            ),
          ),
        ],
      ),
    );
  }

  Padding inputProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final currentProduct = products[index];
                return Row(
                  children: [
                    Expanded(
                      child: Text(currentProduct.name),
                    ),
                    Expanded(
                      child: Text(
                        'Price: Rp ${currentProduct.price.toStringAsFixed(2)}',
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  currentProduct.amount++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              currentProduct.amount.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  currentProduct.amount--;
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: products.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('PPN(11%)'),
              Text('Rp ${getPPN()}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text('Rp ${getTotal()}'),
            ],
          ),
        ],
      ),
    );
  }

  Container buttonCreatePDF(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: ElevatedButton(
        onPressed: () {
          if (image == null ||
              nameController.text.isEmpty ||
              phoneController.text.isEmpty ||
              addressController.text.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Warning'),
                content: const Text(
                  'Please fill in all the fields.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return;
          } else {
            createPdf(nameController, phoneController, addressController, id,
                image!, context, products);
            setState(() {
              const uuid = Uuid();
              id = uuid.v1();
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: inputSection(context),
    );
  }
}
