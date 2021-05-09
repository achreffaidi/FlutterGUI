// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

import '../WindowListener.dart';




class CrashedApp extends Application {

  late double height;
  late double width;
  late Uint8List image;
  CrashedApp( { Key? key,GlobalKey? appKey, required this.width,required this.height, required this.image,  String? title,  WindowListener? listener }) : super(key: key,appKey: appKey ,title: title,listener: listener);

  @override
  double getHeight() {
    return height;
  }

  @override
  double getWidth() {
    return width;
  }

  @override
  FileType getFileType() {
    //TODO FIX THIS, This should be the same icon as the crashed app.
    return FileType.APP_IMAGE_PREVIEW;
  }



  @override
  _CrashedAppState createState() => _CrashedAppState();
}

class _CrashedAppState extends State<CrashedApp> {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        child: Card(
            elevation: 8,
            child: Image.memory(widget.image))
    );
  }


}