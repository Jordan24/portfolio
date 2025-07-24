import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/user/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userCredentials = _firebase.currentUser;
  final _form = GlobalKey<FormState>();
  var _enteredUsername = '';
  var _enteredEmail = '';
  var _imageUrl = '';
  File? _selectedImage;
  var _isSaving = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    try {
      setState(() {
        _isSaving = true;
      });

      // Handle signup logic
      if (_selectedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials!.uid}.jpg');
        await storageRef.putFile(_selectedImage!);
        _imageUrl = await storageRef.getDownloadURL();
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials!.uid)
          .set({
            'username': _enteredUsername,
            'email': _enteredEmail,
            'image_url': _imageUrl,
          });
    } on FirebaseAuthException catch (error) {
      if (mounted) ScaffoldMessenger.of(context).clearSnackBars();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed.')),
        );
      }
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Profile',
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        actions: [
          _isSaving
              ? CircularProgressIndicator(
                color: theme.colorScheme.onPrimary,
                constraints: BoxConstraints(minWidth: 24, minHeight: 24),
              )
              : TextButton.icon(
                onPressed: _submit,
                icon: Icon(Icons.save, color: theme.colorScheme.onPrimary),
                label: Text(
                  'Save',
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 20),
                ),
              ),
          const SizedBox(width: 12),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 300,
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                UserImagePicker(
                  onPickImage: (pickedImage) {
                    _selectedImage = pickedImage;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator:
                      (value) =>
                          value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')
                              ? 'Please enter a valid email address.'
                              : null,
                  onSaved: (value) {
                    _enteredEmail = value!.trim();
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  enableSuggestions: false,
                  validator:
                      (value) =>
                          value == null || value.trim().length < 2
                              ? 'Password must be at least 2 characters long.'
                              : null,
                  onSaved: (value) {
                    _enteredUsername = value!.trim();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
