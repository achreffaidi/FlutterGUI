import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/windows/WindowListener.dart';

abstract class Application extends StatefulWidget {


        String? title;
        WindowListener? listener;
        GlobalKey? appKey;
        Application({Key? key,this.appKey, this.title, this.listener}) : super(key: key);

        Function(double,double)? callback;


        void setListener(WindowListener listener){
    this.listener = listener;
  }


}


abstract class ApplicationState extends State<Application> {

  late double? windowWidth ;
  late double? windowHeight ;


  @override
  void initState() {
    super.initState();
     windowWidth = getWidth();
     windowHeight = getHeight();
  }



  @override
  Widget build(BuildContext context) {

   

    return Container(
      key: widget.appKey,
      child: Container(
        decoration: BoxDecoration(
          //Here goes the same radius, u can put into a var or function
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x54000000),
              spreadRadius:4,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            _getHeader(),
            _getBody(),
          ],
        ),
      ),
    );
  }

  _getHeader() {
    return GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            widget.callback!(tapInfo.delta.dx,tapInfo.delta.dy);

          });},
      child: Container(
        width: windowWidth,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [

            Positioned(

              left: 10,
              top: 10,
              bottom: 10,

              child: Row(
                children: [
                  _getCircleButton(Colors.red, Icons.close,callback: (){
                    widget.listener!.onWindowClose(widget);
                  }),
                  _getCircleButton(Colors.orangeAccent, Icons.remove),
                  _getCircleButton(Colors.green, Icons.fullscreen)
                ],
              ),
            ),
            Center(child: Title(color: Colors.white, child: Text(widget.title!))),
            Container()
          ],
        )
      ),
    );

  }

  _getBody() {
    return GestureDetector(
      onVerticalDragDown: (offset) {

      },
      onHorizontalDragDown: (_) {

      },

      child: Container(

          child: ClipRRect(

              borderRadius:
              BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              child: getApp())),
    );
  }

  double? getWidth();
  double? getHeight();
  Widget getApp();


  

  _getCircleButton(Color color, IconData iconData, {VoidCallback? callback}){

    return InkResponse(
      onTap: callback,
      child: new Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: 12,
        height: 12,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          size: 10,
          color: Color.lerp(Colors.black, Colors.transparent, 0.5),
        ),
      ),
    );

  }

}
