import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyFilePickerScreen(),
    );
  }
}

class MyFilePickerScreen extends StatefulWidget {
  @override
  _MyFilePickerScreenState createState() => _MyFilePickerScreenState();
}

class _MyFilePickerScreenState extends State<MyFilePickerScreen> {
  String _filePath = 'Tidak ada file yang dipilih';

  Future<void> _pickFile() async {
    String filePath = await FilePicker.getFilePath(type: FileType.any);
    if (filePath != null) {
      setState(() {
        _filePath = filePath;
      });
    }
  }

  File _selectedFile;
  img.Image _selectedImage;

  Future<void> _pickFile2() async {
    String filePath = await FilePicker.getFilePath(type: FileType.image);
    if (filePath != null) {
      File file = File(filePath);
      img.Image image = img.decodeImage(file.readAsBytesSync());

      setState(() {
        _selectedFile = file;
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile2,
              child: Text('Pilih File'),
            ),
            SizedBox(height: 20),
            Text('File terpilih: $_filePath'),
            if (_selectedImage != null)
              Image.memory(Uint8List.fromList(img.encodeJpg(_selectedImage))),
          ],
        ),
      ),
    );
  }
}
