import 'dart:io';
import 'dart:math';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionWidget extends StatefulWidget {
  final String existingUrl;
  final Function(String base64Result) onUserImageSet;
  ImageSelectionWidget({
    this.existingUrl,
    this.onUserImageSet,
  });

  @override
  _ImageSelectionWidgetState createState() => _ImageSelectionWidgetState();
}

class _ImageSelectionWidgetState extends State<ImageSelectionWidget> {
  bool isImageSet = false;
  bool isBusy = false;
  String inventoryImgUrl = '';

  pickImageFromGallery(ImageSource source) {
    return ImagePicker.pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.existingUrl != null) {
      isImageSet = true;
    }
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: PRIMARY_COLOR.withOpacity(0.1), width: 1.3)),
            child: !isImageSet
                ? Image.network(
                    inventoryImgUrl,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    '${widget.existingUrl}',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Container(
          height: 10,
        ),
        SizedBox(
          height: 34,
          child: !isBusy
              ? OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  onPressed: handleNewImage,
                  child: Text(
                    !isImageSet ? 'ADD IMAGE' : 'CHANGE IMAGE',
                    style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : CupertinoActivityIndicator(),
        )
      ],
    );
  }

  void handleNewImage() async {
    setState(() {
      isBusy = true;
    });
    String imgUrl = generateRandomNumber();
    File item = await pickImageFromGallery(ImageSource.gallery);
    FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://electronic-mart.appspot.com/');
    StorageReference storageReference = storage.ref();
    StorageReference imageReference =
        storageReference.child('item$imgUrl/image.jpg');
    StorageUploadTask storageUploadTask = imageReference.putFile(item);
    String url = await (await storageUploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((url) {
      setState(() {
        inventoryImgUrl = url;
        isImageSet = true;
        isBusy = false;
      });
    });
    widget.onUserImageSet(inventoryImgUrl);
  }

  String generateRandomNumber() {
    var random = Random();
    String imgUrl = '';
    for (int i = 0; i < 10; i++) {
      imgUrl = imgUrl + random.nextInt(100).toString();
    }
    return imgUrl;
  }
}
