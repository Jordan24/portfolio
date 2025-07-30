import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/user/models/user.dart' as model;
import 'package:portfolio/user/providers/auth_provider.dart';
import 'package:portfolio/user/validators/email_validator.dart';
import 'package:portfolio/user/validators/username_validator.dart';
import 'package:portfolio/user/widgets/user_image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _form = GlobalKey<FormState>();
  String? _enteredUsername;
  String? _enteredEmail;
  XFile? _selectedImage;
  var _isSaving = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    setState(() {
      _isSaving = true;
    });

    final user = ref.read(authProvider)!;
    String? imageUrl = user.imageUrl;

    if (_selectedImage != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${user.id}.jpg');
      if (kIsWeb) {
        await storageRef.putData(await _selectedImage!.readAsBytes());
      } else {
        await storageRef.putFile(File(_selectedImage!.path));
      }
      imageUrl = await storageRef.getDownloadURL();
    }

    final updatedUser = model.User(
      id: user.id,
      username: _enteredUsername,
      email: _enteredEmail ?? user.email,
      imageUrl: imageUrl,
    );

    try {
      await ref.read(authProvider.notifier).updateUserData(updatedUser);
    } catch (error) {
      if (mounted) ScaffoldMessenger.of(context).clearSnackBars();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }

    setState(() {
      _isSaving = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
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
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                )
              : TextButton.icon(
                  onPressed: _submit,
                  icon: Icon(Icons.save, color: theme.colorScheme.onPrimary),
                  label: Text(
                    'Save',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 20,
                    ),
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
                  imageUrl: user?.imageUrl,
                ),
                TextFormField(
                  initialValue: user?.email,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => isValidEmail(value),
                  onSaved: (value) {
                    _enteredEmail = value?.trim();
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: user?.username,
                  decoration: const InputDecoration(labelText: 'Username'),
                  enableSuggestions: false,
                  validator: (value) => validateUsername(value),
                  onSaved: (value) {
                    _enteredUsername = value?.trim();
                  },
                ),
                Expanded(child: SizedBox(height: 12)),
                ElevatedButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).signOut();
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                  ),
                  child: Text('Log Out'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
