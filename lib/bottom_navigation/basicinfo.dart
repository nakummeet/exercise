import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicinfoScreen extends StatefulWidget {
  const BasicinfoScreen ({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<BasicinfoScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _birthdayController.text = prefs.getString('birthday') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _instagramController.text = prefs.getString('instagram') ?? '';

    });
  }

  _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('birthday', _birthdayController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('instagram', _instagramController.text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(
                icon: Icon(Icons.cake),
                labelText: 'Birthday',
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Phone',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _instagramController,
              decoration: InputDecoration(
                icon: Icon(Icons.health_and_safety_outlined),
                labelText: 'BMI',

              ),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfileData,
              child: Text('Save Profile'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Padding
              ),

            ),
          ],
        ),
      ),
    );
  }
}




