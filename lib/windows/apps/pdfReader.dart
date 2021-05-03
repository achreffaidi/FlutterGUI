// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:mywebsite/windows/window.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

import '../WindowListener.dart';




class PdfReaderApp extends Application {
  PdfReaderApp( { Key? key,GlobalKey? appKey, String? title,  WindowListener? listener }) : super(key: key,appKey: appKey ,title: title,listener: listener);


  @override
  double getHeight() {
    return 800;
  }

  @override
  double getWidth() {
    return 550;
  }

  @override
  _PdfReaderAppState createState() => _PdfReaderAppState();
}

class _PdfReaderAppState extends ApplicationState {





  @override
  Widget getApp(){
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child: PdfView(
        controller: pdfController,
        scrollDirection: Axis.vertical,
      )
    );
  }

  final pdfController = PdfController(
    viewportFraction: 1,
    document: PdfDocument.openAsset("assets/resume.pdf"),
  );


  


}