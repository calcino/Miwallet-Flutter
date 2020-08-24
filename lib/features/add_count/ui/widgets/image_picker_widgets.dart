import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButtonWidget extends StatefulWidget {
  final Function(PickedFile) onSelectFile;

  const ImagePickerButtonWidget({Key key, this.onSelectFile}) : super(key: key);

  @override
  _ImagePickerButtonWidgetState createState() =>
      _ImagePickerButtonWidgetState();
}

class _ImagePickerButtonWidgetState extends State<ImagePickerButtonWidget> {
  ImagePicker _pickedFile = ImagePicker();
  bool _isPicked = false;
  PickedFile _imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(283),
        height: ScreenUtil().setHeight(113),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _isPicked ? ColorRes.hintColor : Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          bottom: ScreenUtil().setHeight(64),
          right: ScreenUtil().setWidth(18),
          left: ScreenUtil().setWidth(18),
        ),
        child: _setImageView());
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    PickedFile _picture =
        await _pickedFile.getImage(source: ImageSource.gallery);

    if (_picture != null) {
      this.setState(() {
        _isPicked = true;
        _imageFile = _picture;
        widget.onSelectFile(_imageFile);
      });
    }
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    PickedFile _img = await _pickedFile.getImage(source: ImageSource.camera);
    if (_img != null) {
      this.setState(() {
        _isPicked = true;
        _imageFile = _img;
        widget.onSelectFile(_imageFile);
      });
    }
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile.path),
        alignment: Alignment.center,
        fit: BoxFit.cover,
      );
    } else {
      return InkWell(
        onTap: () {
          _showSelectionDialog(context);
        },
        child: Image(
          image: AssetImage(
            "assets/images/image_picker.png",
          ),
          fit: BoxFit.cover,
          width: ScreenUtil().setWidth(92),
          height: ScreenUtil().setHeight(75),
        ),
      );
    }
  }
}
