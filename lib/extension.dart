import 'package:flutter/material.dart';
import 'dart:html' as html;

extension HoverExtensions on Widget {



  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      // When the mouse enters the widget set the cursor to pointer
      onHover: (event) {

      },
      // When it exits set it back to default
      onExit: (event) {

      },
    );
  }
}