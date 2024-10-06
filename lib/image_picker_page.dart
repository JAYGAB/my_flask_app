import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Authentication
import 'package:smartappli/FeedbackPage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'login_page.dart';
import 'disease_description_page.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _image;
  String _diseaseName = '';
  String _confidencePercentage = '';

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage(_image!);
    }
  }

  // Function to capture an image using the camera
  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage(_image!);
    }
  }

  // Function to upload an image to the server
  Future<void> _uploadImage(File image) async {
    final uri = Uri.parse('http://192.168.100.103:5000/predict');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseJson = json.decode(responseBody);

        setState(() {
          _diseaseName = responseJson['class'] ?? 'Unknown';
          _confidencePercentage =
              responseJson['confidence'] != null
                  ? responseJson['confidence'].toStringAsFixed(2) + '%'
                  : 'Unknown';
        });
      } else {
        setState(() {
          _diseaseName = 'Failed to get result';
          _confidencePercentage = 'Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _diseaseName = 'Error uploading image: $e';
        _confidencePercentage = '';
      });
    }
  }

  // Function to log out the user
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // Function to navigate to the disease description page
  void _navigateToDescriptionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DiseaseDescriptionPage(diseaseName: _diseaseName)),
    );
  }

  // Function to navigate to the feedback page
  void _navigateToFeedbackPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current Firebase user
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: ClipPath(
          clipper: CustomAppBarClipper(),
          child: AppBar(
            title: Text('AgriSmart', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 38, 83, 40),
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/background_image.jpg',
            fit: BoxFit.cover,
          ),
          // Lightened gradient overlay (adjust opacity to make image brighter)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.1), // Lighter overlay
                  Colors.black.withOpacity(0.1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Upload or Capture an Image',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  _image == null
                      ? Text(
                          'No image selected.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 38, 83, 40)
                                    .withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 300,
                            ),
                          ),
                        ),
                  SizedBox(height: 20),
                  Text(
                    'Disease Name: $_diseaseName',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Confidence: $_confidencePercentage',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 38, 83, 40),
    image: DecorationImage(
      image: AssetImage('assets/background_image.jpg'),
      fit: BoxFit.cover,
    ),
  ),
  child: Stack(
    children: <Widget>[
      Positioned(
        bottom: 16.0,
        left: 16.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to AgriSmart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), // Space between the two lines
            if (user != null && user.email != null)
              Text(
                '(${user.email})',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    ],
  ),
),
            ListTile(
              leading: Icon(Icons.feedback,
                  color: const Color.fromARGB(255, 38, 83, 40)),
              title: Text('Feedback',
                  style: TextStyle(color: const Color.fromARGB(255, 38, 83, 40))),
              onTap: _navigateToFeedbackPage,
            ),
            ListTile(
              leading: Icon(Icons.logout,
                  color: const Color.fromARGB(255, 38, 83, 40)),
              title: Text('Logout',
                  style: TextStyle(color: const Color.fromARGB(255, 38, 83, 40))),
              onTap: _logout,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color.fromARGB(255, 38, 83, 40),
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.image, title: 'Upload'),
          TabItem(icon: Icons.camera_alt, title: 'Capture'),
          TabItem(icon: Icons.info_outline, title: 'Description'),
        ],
        initialActiveIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              _pickImage();
              break;
            case 1:
              _captureImage();
              break;
            case 2:
              _navigateToDescriptionPage();
              break;
          }
        },
      ),
    );
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20); 
    path.quadraticBezierTo(size.width / 4, size.height, size.width,
        size.height - 20); 
    path.lineTo(size.width, 0); 
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
