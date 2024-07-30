import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String name = 'John Doe';
  String email = 'johndoe@example.com';
  String phone = '123-456-7890';
  String address = '123 Main Street, City, Country';
  File? _profileImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the updated information to your backend or local storage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage('assets/default_avatar.png')
                          as ImageProvider,
                  child: _profileImage == null
                      ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                      : null,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                initialValue: name,
                decoration:
                    InputDecoration(labelText: 'Name', fillColor: Colors.white),
                onSaved: (value) {
                  name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                initialValue: email,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  email = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                initialValue: phone,
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) {
                  phone = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                initialValue: address,
                decoration: InputDecoration(labelText: 'Address'),
                onSaved: (value) {
                  address = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.orange, // Set the background color to orange
                  foregroundColor: Colors.white, // Set the text color to white
                  minimumSize: Size(double.infinity,
                      50), // Set the button to take maximum width with a fixed height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Optional: Add rounded corners
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
