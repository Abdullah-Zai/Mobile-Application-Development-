import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _validationMessage = '';

  @override
  Widget build(BuildContext context) {

    String orientation =
    MediaQuery.of(context).orientation == Orientation.portrait
        ? "Portrait"
        : "Landscape";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Screen",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),


      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image / Icon
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.teal[100],
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.teal[700],
                ),
              ),

              SizedBox(height: 16),


              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Abdullah Zubair\n",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: "abdullah@example.com",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Edit Profile Pressed")),
                      );
                    },
                    child: Text("Edit Profile"),
                  ),
                  SizedBox(width: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.teal),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("View Profile Pressed")),
                      );
                    },
                    child: Text(
                      "View Profile",
                      style: TextStyle(color: Colors.teal[700]),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              // Container for description
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Text(
                  "This simple Profile App demonstrates Flutter basics such as Column, Row, Buttons, TextField, and MediaQuery for orientation handling.",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 25),


              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Enter username",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Validation button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                onPressed: () {
                  setState(() {
                    if (_nameController.text.isEmpty) {
                      _validationMessage = "Username cannot be empty!";
                    } else {
                      _validationMessage =
                      "Welcome, ${_nameController.text.trim()}!";
                    }
                  });
                },
                child: Text("Validate"),
              ),

              SizedBox(height: 8),


              Text(
                _validationMessage,
                style: TextStyle(
                  color: _validationMessage.contains('empty')
                      ? Colors.red
                      : Colors.teal[700],
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 25),

              // Orientation info
              Text(
                "Current Orientation: $orientation",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
