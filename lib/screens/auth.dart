import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  var enteredEmail = '';
  var enterdUserName = '';
  var enteredPassword = '';
  final form = GlobalKey<FormState>();
  var isLogin = true;
  File? selectedImage;
  var isAuthenticating = false;

  void submit() async {
    final isValid = form.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (!isLogin && selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter Valid Data'),
        ),
      );
      return;
    }

    form.currentState!.save();
    try {
      setState(() {
        isAuthenticating = true;
      });
      if (isLogin) {
        final userCredential = await firebase.signInWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);
      } else {
        final userCredentials = await firebase.createUserWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        if (mounted) {
          setState(() {
            isAuthenticating = false;
          });
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set(
          {
            'username': enterdUserName,
            'email': enteredEmail,
            'image_url': imageUrl,
          },
        );
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        setState(() {
          isAuthenticating = false;
        });
      }
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                width: double.infinity,
                height: 110,
                child: Text('Chidiya-General',
                    style: GoogleFonts.merriweatherSans(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 35)),
              ),
              Container(
                width: 200,
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, left: 20, right: 20),
                child: Image.asset('assets/images/zuck.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isLogin)
                            UserImagePicker(onPickImage: (pickedImage) {
                              selectedImage = pickedImage;
                            }),
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'please enter correct email';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              enteredEmail = value!;
                            },
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                            ),
                          ),
                          if (!isLogin)
                            TextFormField(
                              enableSuggestions: false,
                              decoration: const InputDecoration(
                                label: Text('User Name'),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please Enter atleast 4 characters or You can Fuckoff';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                enterdUserName = value!;
                              },
                            ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'password must be 6 characters long';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredPassword = value!;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('password'),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (isAuthenticating) CircularProgressIndicator(),
                          if (!isAuthenticating)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              onPressed: submit,
                              child: Text(isLogin ? 'Login' : 'Sign up'),
                            ),
                          if (!isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(isLogin
                                  ? 'create an Account'
                                  : 'Already have an Account'),
                            ),
                        ],
                      )),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
