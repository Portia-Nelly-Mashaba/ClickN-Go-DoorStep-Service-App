import 'dart:typed_data';

import 'package:doorstep_service_app/controllers/auth_controller.dart';
import 'package:doorstep_service_app/utils/show_snack_bar.dart';
import 'package:doorstep_service_app/views/users/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUsers(email, fullName, phoneNumber, password, _image)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });
      return showSnack(context, 'Account Has Been Created Successfully!');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Please Fields must not be empty');
    }
  }

  selectGalleryImage() async {
    Uint8List _im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = _im;
    });
  }

  selectCameraImage() async {
    Uint8List _im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = _im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Customer\'s Account',
                style: TextStyle(fontSize: 20),
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          backgroundImage: NetworkImage(
                              'https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg'),
                        ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: IconButton(
                      onPressed: () {
                        selectGalleryImage();
                      },
                      icon: Icon(
                        CupertinoIcons.photo,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Email must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Full Name must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    fullName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Full Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Phone Number must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Phone Number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Password must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _signUpUsers();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                              ),
                            )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have An Account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Text('Login'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
