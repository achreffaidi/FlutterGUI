// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/consts/colors.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

import '../WindowListener.dart';




class PdfReaderApp extends Application {
  PdfReaderApp( { Key? key,GlobalKey? appKey, String? title,  WindowListener? listener, required this.path }) : super(key: key,appKey: appKey ,title: title,listener: listener);

  String path;

  @override
  double getHeight() {
    return 600;
  }

  @override
  double getWidth() {
    return 400;
  }

  @override
  FileType getFileType() {
    return FileType.APP_PDF_READER;
  }


  @override
  _PdfReaderAppState createState() => _PdfReaderAppState(path);
}

class _PdfReaderAppState extends ApplicationState {
  String path;
  late PdfController pdfController;
  _PdfReaderAppState(this.path){
     pdfController = PdfController(
      viewportFraction: 1,
      document: PdfDocument.openAsset(path),
    );
  }

  @override
  Widget getApp(){
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      color: Resources.WINDOW_BODY_COLOR,
      child: PdfView(
        controller: pdfController,
        scrollDirection: Axis.vertical,
      )
    );
  }

}