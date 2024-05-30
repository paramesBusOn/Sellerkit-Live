// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; 
import 'package:permission_handler/permission_handler.dart'; 

// To save the file in the device 
class FileStorage { 
static Future<String> getExternalDocumentPath() async { 
	// To check whether permission is given for this app or not. 
	var status = await Permission.storage.status; 
	if (!status.isGranted) { 
	// If not we will ask for permission first 
	await Permission.storage.request(); 
	} 
	Directory _directory = Directory(""); 
	if (Platform.isAndroid) { 
	// Redirects it to download folder in android 
	_directory = Directory("/storage/emulated/0/Download"); 
	} else { 
	_directory = await getApplicationDocumentsDirectory(); 
	} 

	final exPath = _directory.path; 
	print("Saved Path2: $exPath"); 
	await Directory(exPath).create(recursive: true); 
  	print("Saved Path3: $exPath"); 

	return exPath; 
} 

  
static Future<String> get _localPath async { 
	// final directory = await getApplicationDocumentsDirectory(); 
	// return directory.path; 
	// To get the external path from device of download folder 
	final String directory = await getExternalDocumentPath(); 
	return directory; 
} 

static Future<File> writeCounter(String name,XFile photoCompressedFile) async { 
List<int> imageBytes = await  photoCompressedFile.readAsBytes();
    String?   base64Image =  base64Encode(imageBytes);
final path = await _localPath; 
  	log(base64Image.toString()); 
  	print("Save file name::"+name.toString()); 
await Future.delayed(Duration(seconds: 3));
	// Create a file for the path of 
	// device and file name with extension 
	File file= File('$path/$name');
	print("Save file"); 
	
	// Write the data in the file you have created 
	return file.writeAsString(base64Image); 
} 

static Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }
}
