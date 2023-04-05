import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/widget/banner_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:file_picker/file_picker.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '\UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //final FirebaseStorage _firestore = FirebaseStorage.instance;

  dynamic _image;

  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;

        fileName = result.files.first.name;
      });
    }
  }

  _uploadbBannersToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;

    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  // uploadToFireStore() async {
  //   if (_image != null) {
  //     String imageUrl = await _uploadbBannersToStorage(_image);

  //     await _firestore
  //         .collection('banner')
  //         .doc(fileName)
  //         .set({'image': imageUrl});
  //   }
  // }

  Future<void> uploadToFirestore() async {
    EasyLoading.show();
    if (_image != null) {
      // Upload the image to Firebase Storage and retrieve the download URL
      String imageUrl = await _uploadbBannersToStorage(_image);

      // Store the image URL in Firestore
      await FirebaseFirestore.instance.collection('Banners').doc(fileName).set({
        'image': imageUrl,
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
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
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        border: Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: _image != null
                            ? Image.memory(_image, fit: BoxFit.cover)
                            : Text('Banners'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amberAccent.shade700),
                        onPressed: () {
                          pickImage();
                        },
                        child: Text('Upload Image'))
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.amberAccent.shade700),
                onPressed: () {
                  uploadToFirestore();
                },
                child: Text('Save'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Banners",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BannerWidget(),
        ],
      ),
    );
  }
}
