

import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/AnalyticsService.dart';
import 'package:flutterOs/Util/fileManager/consts/colors.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../WindowListener.dart';




class HtmlReaderApp extends Application {


   String path;
   HtmlReaderApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener, required this.path }) : super(key: key,appKey: appKey,title: title,listener: listener);
   @override
   double getHeight() {
     return 500;
   }

   @override
   double getWidth() {
     return 600;
   }
   @override
   FileType getFileType() {
     return FileType.APP_HTML_READER;
   }

  @override
  _HtmlReaderAppState createState() => _HtmlReaderAppState(path);
}

class _HtmlReaderAppState extends ApplicationState {
  
  late String path;
  _HtmlReaderAppState(this.path);

  @override
  Widget getApp(){
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      color: Resources.WINDOW_BODY_COLOR,
      child: SingleChildScrollView(
        child: FutureBuilder(future: getFileData(path),builder: _builder,),
      ),
    );
  }

  void _launchURL(String url) async {
    GetIt.instance.get<AnalyticsService>().sendOpenUrl(url);
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }


  Widget _builder(BuildContext context, AsyncSnapshot<String> snapshot) {
    if(!snapshot.hasData|| snapshot.data == null) return Center(child: CircularProgressIndicator());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HtmlWidget(
        // the first parameter (`html`) is required
        snapshot.data!,

        // all other parameters are optional, a few notable params:

        // specify custom styling for an element
        // see supported inline styling below
        customStylesBuilder: (element) {
          if (element.classes.contains('foo')) {
            return {'color': 'red'};
          }

          return null;
        },

        // render a custom widget
        customWidgetBuilder: (element) {

          return null;
        },

        // this callback will be triggered when user taps a link
        onTapUrl: _launchURL,

        // set the default styling for text
        textStyle: TextStyle(fontSize: 14),
      ),
    );
  }

}