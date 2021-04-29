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

import '../WindowListener.dart';




class CalculatorApp extends WindowBody {
  CalculatorApp( { Key? key, String? title,  WindowListener? listener }) : super(key: key,title: title,listener: listener);



  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends WindowBodyState {





  @override
  Widget getApp(){
    return Container(
      height: windowHeight,
      width: windowWidth,
      child: SimpleCalculator(

        theme: const CalculatorThemeData(
          displayColor: Colors.black,
          displayStyle: const TextStyle(fontSize: 80, color: Colors.yellow),
        ),
      ),
    );
  }

  @override
  double getHeight() {
    return 250;
  }

  @override
  double getWidth() {
    return 400;
  }

}