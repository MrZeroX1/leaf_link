import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart'; // Import the tflite package

class PlantIdentifierScreen extends StatefulWidget {
  @override
  _PlantIdentifierScreenState createState() => _PlantIdentifierScreenState();
}

class _PlantIdentifierScreenState extends State<PlantIdentifierScreen> {
  File? _image;
  String _identifiedPlantName = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load the TensorFlow Lite model when the screen initializes
    loadModel();
  }

  void loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite", // Path to your model.tflite file
    );
  }

  void _identifyPlant(File imageFile) async {
    // Run inference on the TensorFlow Lite model
    var recognitions = await Tflite.runModelOnImage(
      path: imageFile.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 2, // Number of results to get
      threshold: 0.5, // Confidence threshold
      asynch: true,
    );

    // Extract the plant name from the recognition results
    String identifiedPlantName = recognitions![0]['label'];

    setState(() {
      _isLoading = false;
      _identifiedPlantName = identifiedPlantName;
    });
  }

  Future<void> _selectAndIdentifyImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
        _image = File(pickedFile.path);
      });

      _identifyPlant(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Identifier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : _image != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.file(
                              _image!,
                              height: 200,
                            ),
                            SizedBox(height: 16),
                            Text(
                              _identifiedPlantName.isNotEmpty
                                  ? 'Plant Name: $_identifiedPlantName'
                                  : 'Sorry, plant not identified.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text('No image selected'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate back to the main screen
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _selectAndIdentifyImage(ImageSource.camera);
              },
              icon: Icon(Icons.camera),
            ),
            IconButton(
              onPressed: () {
                _selectAndIdentifyImage(ImageSource.gallery);
              },
              icon: Icon(Icons.picture_in_picture),
            ),
          ],
        ),
      ),
    );
  }
}
