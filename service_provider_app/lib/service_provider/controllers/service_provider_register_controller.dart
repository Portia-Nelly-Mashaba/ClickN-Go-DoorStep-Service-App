import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ServiceProviderController {
//FUNCTION TO STORE IMAGE IN FIREBASE STORE

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

  String registerServiceProvider(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxOption,
    String taxNumber,
    Uint8List? image,
  ) {
    String results = 'some error occured';

    try {
      if (businessName.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          countryValue.isNotEmpty &&
          stateValue.isNotEmpty &&
          cityValue.isNotEmpty &&
          taxOption.isNotEmpty &&
          taxNumber.isNotEmpty &&
          image != null) {
        //SAVE DATA TO CLOUD FIRESTORE
      } else {
        results = 'Fields must not be empty';
      }
      ;
    } catch (e) {
      results = e.toString();
    }

    return results;
  }
}
