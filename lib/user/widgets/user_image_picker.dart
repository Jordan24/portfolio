import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage, this.imageUrl});

  final void Function(XFile pickedImage) onPickImage;
  final String? imageUrl;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: kIsWeb ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = pickedImage;
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    ImageProvider? imageProvider;
    if (_pickedImageFile != null) {
      if (kIsWeb) {
        imageProvider = NetworkImage(_pickedImageFile!.path);
      } else {
        imageProvider = FileImage(File(_pickedImageFile!.path));
      }
    } else if (widget.imageUrl != null) {
      imageProvider = NetworkImage(widget.imageUrl!);
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 76,
          backgroundColor: theme.colorScheme.primaryContainer,
          foregroundImage: imageProvider,
          child:
              imageProvider == null
                  ? Icon(
                    Icons.person,
                    size: 96,
                    color: theme.colorScheme.onPrimary,
                  )
                  : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
