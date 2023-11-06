import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  TextEditingController caption = TextEditingController();

  File? imagepath;
  String? imagename;
  String? imagedata;

  ImagePicker imagePicker = new ImagePicker();

  Future<void> uploadImage() async {
  try {
    if (imagepath == null) {
      print("Please choose an image.");
      return;
    }

    String url = "http://172.25.112.1/database/uploadimage.php";

    List<int> imageBytes = imagepath!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    var response = await http.post(Uri.parse(url), body: {
      "caption": caption.text,
      "data": base64Image,
      "name": imagepath?.path.split('/').last,
      "user_id": "id",
    });

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData["success"] == "true") {
        print("Image uploaded successfully.");
      } else {
        print("Image upload failed.");
        print("Message: ${responseData["message"]}");
      }
    } else {
      print("HTTP request failed with status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}


  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagepath = File(getimage!.path);
      imagename = getimage.path.split('/').last;
      imagedata = base64Encode(imagepath!.readAsBytesSync());
      print(imagepath);
      print(imagename);
      print(imagedata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: caption,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter the Caption",
              ),
            ),
            SizedBox(height: 20),
            imagepath != null
                ? Image.file(imagepath!)
                : Text("Image Not Choose"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: Text("Choose Image"),
            ),
            ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
