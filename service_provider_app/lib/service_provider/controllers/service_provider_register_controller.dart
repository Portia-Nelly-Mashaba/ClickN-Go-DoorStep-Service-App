import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ServiceProviderController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
//FUNCTION TO STORE IMAGE IN FIREBASE STORAGE
  _uploadServiceProviderImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storeImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

//FUNCTION TO STORE IMAGE IN FIREBASE STORAGE ENDS HERE

  //FUNCTION TO PICK BUSINESS IMAGE
  pickBusinessImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  //FUNCTION TO PICK BUSINESS IMAGE ENDS HERE

  //FUNCTION TO SAVE SERVICE PROVIDER DATA

  Future<String> registerServiceProvider(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegistered,
    String taxNumber,
    Uint8List? image,
  ) async {
    String results = 'some error occured';

    try {
      String storeImage = await _uploadServiceProviderImageToStorage(image);
      //SAVE DATA TO CLOUD FIRESTORE

      await _firestore
          .collection('serviceProviders')
          .doc(_auth.currentUser!.uid)
          .set({
        'businessName': businessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'country': countryValue,
        'state': stateValue,
        'city': cityValue,
        'taxRegistered': taxRegistered,
        'taxNumber': taxNumber,
        'storeImage': storeImage,
        'approved': false,
      });
    } catch (e) {
      results = e.toString();
    }

    return results;
  }
  //FUNCTION TO SAVE SERVICE PROVIDER DATA ENDS HERE
}
